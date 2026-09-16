// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TableDragScript(argument0){ //argument0 is the active table
	if(argument0.tableEmpty && player_obj.direction % 2 == 0)
	{
		walkspd = 1.0;
		state = PlayerStateDragging;
		global.activatePrompt = noone;
	}
}