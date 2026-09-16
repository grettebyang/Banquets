// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UseVacuum(argument){ //argument is the id of the vacuum
	var vacuum = argument;
	with(vacuum)
	{
		if(!vacuumOn)
		{
			vacuumOn = true;
			show_debug_message("vacuum on");
		}
		else
		{
			vacuumOn = false;
			show_debug_message("vacuum off");
		}
	}
}