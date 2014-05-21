
//	@file Version: 1.0
//	@file Name: buyGuns.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy
//	@file Created: 20/11/2012 05:13
//	@file Args: [int (0 = buy to player 1 = buy to crate)]

#include "dialog\gunstoreDefines.sqf";
disableSerialization;
if(gunStoreCart > (player getVariable "cmoney")) exitWith {hint "You do not have enough money"};

// Check if mutex lock is active.
if(mutexScriptInProgress) exitWith {
	player globalChat "ERROR: ALREADY PERFORMING ANOTHER ACTION!";
};	

// Check if player is alive.
if(!(alive player)) exitWith {
	player globalChat "ERROR: YOU ARE CURRENTLY DEAD.";
    closeDialog 0;
};	
dropweapon = "WeaponHolder" createVehicle getPos player; 
dropweapon setPos [getPos player select 0,getPos player select 1,getPos player select 2];
mutexScriptInProgress = true;
//delete switch weapon
fnc_drop_weapon = {
	_weapon = _this select 0;
	_weaponCfg = (configFile >> "cfgWeapons" >> _weapon);
	_type = getNumber(_weaponCfg >> "type");
	if (_type in [1,2,4,5]) then {
		{_cWepType = [getNumber(configFile >> "cfgWeapons" >> _x >> "type")];
		if (_cWepType select 0 in [1,5]) then {_cWepType = [1,5];};
		if (_type in _cWepType) then {
			player removeWeapon _x;
                         dropweapon addWeaponCargo [_x,1];
			_current_magazines = magazines player;
			_compatible_magazines = getArray(configFile >> "cfgWeapons" >> _x >> "magazines");
			{if (_x in _compatible_magazines) then {
				player removeMagazine _x;
                                 dropweapon addMagazineCargo [_x,1];
			};} forEach _current_magazines;
		};} forEach (weapons player);
	};
	player addWeapon _weapon;
	player selectWeapon _weapon;
	
};
private ["_name"];

//Initialize Values
_switch = _this select 0;
_playerMoney = player getVariable "cmoney";
_size = 0;
_price = 0;
// Grab access to the controls
_dialog = findDisplay gunshop_DIALOG;
_cartlist = _dialog displayCtrl gunshop_cart;
_totalText = _dialog displayCtrl gunshop_total;
_playerMoneyText = _Dialog displayCtrl gunshop_money;
_size = lbSize _cartlist;
_pos = getposatl player;

switch(_switch) do 
{
	//Buy To Player
	case 0: 
	{
		for [{_x=0},{_x<=_size},{_x=_x+1}] do
		{
			_itemText = _cartlist lbText _x;
			//0 = Primary, 1 = SideArm, 2= Secondary, 3= HandGun Mags, 4= MainGun Mags, 5= Binocular, 7=Compass Slots
			_playerSlots = [player] call BIS_fnc_invSlotsEmpty;
			
			{
				if(_itemText == _x select 1) then
				{
					_class = _x select 2;
					_weapon = (configFile >> "cfgWeapons" >> _class);
					_type = getNumber(_weapon >> "type");
					
                    switch (_type) do {
                    
                    	case 1: { //Main Rifle
                         diag_log_server = parsetext format["player:%1 buyed %2 for %3 and have now %4 MoneyLeft",name player,_x select 1, _x select 3, (player getVariable"cmoney")];
                         publicvariableserver "diag_log_server";
                        	if((_playerSlots select 0) >= 1) then { 
								player addWeapon _class;
                                                                player selectWeapon _class;
							} else {  [_class]call fnc_drop_weapon;};
                        };
                        
                        case 2: { //Side Arm
                        	 diag_log_server = parsetext format["player:%1 buyed %2 for %3 and have now %4 MoneyLeft",name player,_x select 1, _x select 3, (player getVariable"cmoney")];
publicvariableserver "diag_log_server";
                            if((_playerSlots select 1) >= 1) then {
								player addWeapon _class;
                                                                player selectWeapon _class;
							} else {[_class]call fnc_drop_weapon;};
                        };
                        
                        case 4: { //Rocket launcher
                        	 diag_log_server = parsetext format["player:%1 buyed %2 for %3 and have now %4 MoneyLeft",name player,_x select 1, _x select 3, (player getVariable"cmoney")];
publicvariableserver "diag_log_server";
                            if((_playerSlots select 2) >= 1) then {
								player addWeapon _class;
                                                                player selectWeapon _class;
							} else {[_class]call fnc_drop_weapon;};
                        };
                        
                        case 5: { //Machinegun
                        	 diag_log_server = parsetext format["player:%1 buyed %2 for %3 and have now %4 MoneyLeft",name player,_x select 1, _x select 3, (player getVariable"cmoney")];
publicvariableserver "diag_log_server";
                            if(((_playerSlots select 2) >= 1) AND ((_playerSlots select 0) >= 1)) then {
								player addWeapon _class;
                                                                player selectWeapon _class;
                                                                
							} else {[_class]call fnc_drop_weapon;};
                        };
                    };          
				};   
                                 		
			}forEach weaponsArray;

			{
				if(_itemText == _x select 0) then {
					_class = _x select 1;
					_mag = (configFile >> "cfgMagazines" >> _class);
					_type = (getNumber(_mag >> "type"));
					
					//Check how many main mags you have
                    
                    switch (_type) do {
                    
                    	case 256: {
                        	if((_playerSlots select 4) >= 1) then
							{
								player addMagazine _class;
							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                        
                        case 512: {
                        	if((_playerSlots select 4) >= 2) then {
								player addMagazine _class;
							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                        
                        case 768: {
                        	if((_playerSlots select 4) >= 3) then {
								player addMagazine _class;
							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                        
                        case 1024: {
                        	if((_playerSlots select 4) >= 4) then {
								player addMagazine _class;
							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                        
                        case 1280: {
                        	if((_playerSlots select 4) >= 5) then {
								player addMagazine _class;
							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                        
                        case 1536: {
                        	if((_playerSlots select 4) >= 6) then {
								player addMagazine _class;
							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                        
                        case 16: {
                        	if((_playerSlots select 3) >= 1) then {
								player addMagazine _class;

							} else {dropweapon addMagazineCargo [_class,1];};
                        };
                    };
				};
			}forEach ammoArray;

			{
	            if(_itemText == _x select 0) then {
					_class = _x select 1;
					if(_class == "Binocular_Vector" OR _class== "NVGoggles") then {
						if((_playerSlots select 5) >= 1) then {
							player addWeapon _class;
                                                        diag_log_server = parsetext format["player:%1 buyed %2 for %3 and have now %4 MoneyLeft",name player,_x select 1, _x select 2, (player getVariable"cmoney")];
publicvariableserver "diag_log_server";
						} else {
							{
                            	if(_x select 1 == _class) then { _price = _x select 2; _name = _x select 0; };
                            }forEach accessoriesArray;
                            
							gunStoreCart = gunStoreCart - _price;
							hint format["You do not have space for this item %1",_name];
						};
					} else {
						player addWeapon _class;
                                                diag_log_server = parsetext format["player:%1 buyed %2 for %3 and have now %4 MoneyLeft",name player,_x select 1, _x select 2, (player getVariable"cmoney")];
publicvariableserver "diag_log_server";
					};
				};
            }forEach accessoriesArray;
		};

		player setVariable["cmoney",_playerMoney - gunStoreCart,true];
		_playerMoneyText CtrlsetText format["Cash: $%1", player getVariable "cmoney"];
		gunStoreCart = 0;
		_totalText CtrlsetText format["Total: $%1", gunStoreCart];
		lbClear _cartlist;
	};
};

mutexScriptInProgress = false;