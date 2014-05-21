if(!isnil"loadout")then{
player globalchat"you Loadout has been saved! (Press 2 x L to buy your Loadout)";
//player setvariable ["chocoload",loadout,true];
execVM"client\systems\gunStore\loadout_1.sqf";
}else {hintsilent" you have nothing in your Loadout";};