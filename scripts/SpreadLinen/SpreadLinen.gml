// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpreadLinen(argument){ //argument is the linen color
	with(activate) {
		if(!tableLinen)
		{
			tableLinen = true;
			image_index = argument + 1;
			script_execute(tableCreaseScript);
		}
		else if(canFluff && tableFluff == -1) // Place fluff linen
		{
			tableFluff = argument;
		}
	}

}