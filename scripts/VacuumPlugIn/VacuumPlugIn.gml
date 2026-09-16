// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function VacuumPlugIn(){
	
	var vacuum = global.iHolding;
	var outlet = activate;
	
	with(vacuum)
	{
		vacuum.pluggedIn = true;
		vacuum.vacuumOutlet = outlet;
	}
	state = PlayerStateVacuum;
}