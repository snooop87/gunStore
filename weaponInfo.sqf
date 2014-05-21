
//	@file Version: 1.0
//	@file Name: weaponInfo.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy
//	@file Created: 20/11/2012 05:13
//	@file Args:

#include "dialog\gunstoreDefines.sqf";

disableSerialization;

//Initialize Values
_weap_type = "";
_picture = "";
_price = 0;

// Grab access to the controls
_dialog = findDisplay gunshop_DIALOG;
_gunlist = _dialog displayCtrl gunshop_gun_list;
_gunpicture = _dialog displayCtrl gunshop_gun_pic;
_gunlisttext = _dialog displayCtrl gunshop_gun_TEXT;
_gunInfo = _dialog displayCtrl gunshop_gun_Info;

//Get Selected Item
_selectedItem = lbCurSel _gunlist;
_itemText = _gunlist lbText _selectedItem;
_gunpicture ctrlSettext _picture;

//_selectedItem2 = lbCurSel _ammoselect;
//_itemText2 = _ammoselect lbText _selectedItem2;
_gunlisttext ctrlSetText format [""];	
_gunlistammo = _dialog displayCtrl gunshop_ammo_list;
//Check Items Price
{
	if(_itemText == _x select 1) then {
		_weap_type = _x select 2; 
		_price = _x select 3;
	    
		_weapon = (configFile >> "cfgWeapons" >> _weap_type);
	    _gunInfo ctrlSetStructuredText parseText (format ["%1<br/>%2",getText(_weapon >> "displayName"),getText(_weapon >> "descriptionShort")]);
	    _picture = getText(_weapon >> "picture");
		_gunpicture ctrlSettext _picture;
                _com_magazines = getArray(configFile >> "cfgWeapons" >> _weap_type>> "magazines");
lbClear _gunlistammo;
_gunlistammo lbSetCurSel -1;
magazine1=[];
	   {_displayName = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
       _gunlistIndex = _gunlistammo lbAdd format["%1",_displayName];magazine1=magazine1+ [_x]
           }foreach _com_magazines;
		_gunlisttext ctrlSetText format ["Price: $%1", _price];	
                
               
	}
}forEach weaponsArray;

{
	if(_itemText == _x select 0) then {
		_weap_type = _x select 1; 
		_price = _x select 2;
	    
	    _weapon = (configFile >> "cfgMagazines" >> _weap_type);
	    _gunInfo ctrlSetStructuredText parseText (format ["%1<br/>%2",getText(_weapon >> "displayName"),getText(_weapon >> "descriptionShort")]);
	    
	    _picture = getText(_weapon >> "picture");
		_gunpicture ctrlSettext _picture;
	    
	    
		_gunlisttext ctrlSetText format ["Price: $%1", _price];	
	}
}forEach ammoArray;

{
	if(_itemText == _x select 0) then {
		_weap_type = _x select 1; 
		_price = _x select 2;
	    
		_weapon = (configFile >> "cfgWeapons" >> _weap_type);
	    _gunInfo ctrlSetStructuredText parseText (format ["%1<br/>%2",getText(_weapon >> "displayName"),getText(_weapon >> "descriptionShort")]);
	    	
	    _picture = getText(_weapon >> "picture");
		_gunpicture ctrlSettext _picture;
	    
	    
		_gunlisttext ctrlSetText format ["Price: $%1", _price];	
	}
}forEach accessoriesArray;