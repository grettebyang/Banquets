// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ToggleLinenColor(argument0, argument1){ //argument0 is linen cart, argument1 is up or down
	
	var newIndex = abs((argument0.linenColorIndex + 1*argument1) % 2);
	if(argument0.linenColorList[newIndex] > 0)
	{
		argument0.linenColorIndex = newIndex;
		show_debug_message("Toggled : " + string(newIndex));
	}
	show_debug_message("Ivory Linens : " + string(argument0.linenColorList[0]));
	show_debug_message("White Linens : " + string(argument0.linenColorList[1]));
}