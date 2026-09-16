// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetKeyFromDog(){

	var keyArray = ds_map_keys_to_array(global.doorsUnlocked)
	
	for(var i = 0; i < array_length(keyArray); i++)
	{
		var door = keyArray[i];
		if(!global.doorsUnlocked[? door].hasKey)
		{
			global.doorsUnlocked[? door].hasKey = true;
			exit;
		}
	}

}