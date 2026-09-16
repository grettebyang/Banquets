if(place_meeting(x, y, player_obj))
{
	global.gamePaused = true;
	
	//Create elevator buttons
	var floorsMap = ds_map_create();
	for(var i = 0; i < array_length(floorsList); i++)
	{
		instance_create_layer(display_get_gui_width() * .5, display_get_gui_height() - (display_get_gui_height()/8)*(i+1), "Instances", elevatorButton_obj, { targetRoom : floorsList[i].toFloor, targetX : floorsList[i].px, targetY : floorsList[i].py, floorNumber : floorsList[i].floorNumber });
	}
}










