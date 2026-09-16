global.activatePrompt = noone;
LoadRoom();
with(dog_obj)
{
	if(global.questStatus[? object_index] >= 4)
	{
		instance_destroy();
	}
}
//SpawnEnemies();
instance_create_layer(x,y,"Instances",roomFade_obj);


