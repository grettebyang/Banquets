// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpawnDogs(){
	
	// Iterate through global.questStatus and create each dog with a value of at least 4
	var dogArray = ds_map_keys_to_array(global.questStatus);
	
	for(var i = 0; i < array_length(dogArray); i++)
	{
		var dogObj = dogArray[i];
		if(global.questStatus[? dogObj] >= 4)
		{
			with(instance_create_layer(0, 0, "Instances", dogObj))
			{
				x = dogObj.CDScoord[0];
				y = dogObj.CDScoord[1];
			}
		}
	}
	
}