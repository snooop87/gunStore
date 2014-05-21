
//_loadout = player getvariable"chocoload";
_loadout = player getvariable"cmoney";
_price = 0;
xx=0;

{xx= _x;
        { if(xx == _x select 2 and xx != "") then { _price =_price+( _x select 3);}; }forEach weaponsArray;
	{ if(xx == _x select 1 and xx != "") then { _price = _price+(_x select 2); }; }forEach ammoArray;
	{ if(xx == _x select 1 and xx != "") then { _price =_price+ (_x select 2); }; }forEach accessoriesArray;

 }foreach _loadout;
 geld =_price;
 
 