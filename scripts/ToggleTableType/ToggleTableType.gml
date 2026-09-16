// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ToggleTableType(argument0, argument1){ //argument0 is table cart, argument1 is up or down
	
	if(itemCount == 0)
	{
		argument0.image_index = 0;
	}
	else
	{
		var newIndex = (argument0.tableIndex + 1*argument1 + 3) % 3;
		for(var i = 0; i < 3; i++)
		{
			if(argument0.tableList[newIndex] > 0)
			{
				argument0.tableIndex = newIndex;
				argument0.image_index = newIndex + 1;
				show_debug_message("Toggled : " + string(argument0.tableIndex));
				
				break;
			}
			else
			{
				var j = argument1;
				if(j == 0)
				{
					j = 1
				}
				newIndex = (newIndex + 1*j + 3) % 3;
			}
		}
	}
	show_debug_message("Rounds : " + string(argument0.tableList[0]));
	show_debug_message("Recs : " + string(argument0.tableList[1]));
	show_debug_message("Hitops : " + string(argument0.tableList[2]));
}