// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ReloadRoom(){

	with(player_obj)
	{
		instance_create_layer(x, y, "Instances", roomExit_obj, { targetX : x, targetY : y, targetRoom : room });
	}

}