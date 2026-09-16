// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TakeItemFromSpawner(objectToTake, imageIndex){
	
	var newItem = instance_create_layer(-100,-100,"Instances", objectToTake, { image_index : imageIndex });
	if(!script_execute_ext(newItem.entityPickupScript, [newItem]))
	{
		instance_destroy(newItem);
	}
}