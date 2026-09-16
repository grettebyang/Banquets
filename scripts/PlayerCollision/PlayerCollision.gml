// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerCollision(){
	var collision = 0;
	var entityList = ds_list_create();
	
	//Horizontal Tiles
	if(sign(hsp) == -1)
	{
		var px = bbox_left;
	}
	else
	{
		var px = bbox_right;
	}
	if(tilemap_get_at_pixel(collisionMap, px + hsp, y))
	{
		hsp = 0;
		collision = true;
	}
	
	
	//Horizontal Entities
	if(place_meeting(x + hsp,y,entity_obj)) {
		var entityCollide;
		if(sign(hsp) == -1)
		{
			var entityCount = instance_position_list(bbox_left + hsp, y, entity_obj, entityList, false);
		}
		else
		{
			var entityCount = instance_position_list(bbox_right + hsp, y, entity_obj, entityList, false);
		}	
		while(entityCount > 0)
		{
			var entityCheck = entityList[| 0];
			if(entityCheck.entityCollision)
			{
				hsp = 0;
				collision = true;
				entityCount = 0;
			}
			ds_list_delete(entityList,0);
			entityCount--;	
		}
	}
	

	
	
	//Horizontal Move Commit
	x += hsp;
	
	ds_list_clear(entityList);
	
	
	//Vertical Tiles
	if(sign(vsp) == -1)
	{
		var py = bbox_top;
	}
	else
	{
		var py = bbox_bottom;
	}
	if(tilemap_get_at_pixel(collisionMap, x, py + vsp))
	{
		vsp = 0;
		collision = true;
	}

	//Vertical Entities
	if(place_meeting(x,y + vsp,entity_obj)) {
		var entityCollide;
		if(sign(vsp) == -1)
		{
			var entityCount = instance_position_list(x, bbox_top + vsp, entity_obj, entityList, false);
		}
		else
		{
			var entityCount = instance_position_list(x, bbox_bottom + vsp, entity_obj, entityList, false);
		}	
		while(entityCount > 0)
		{
			var entityCheck = entityList[| 0];
			if(entityCheck.entityCollision)
			{
				vsp = 0;
				collision = true;
				entityCount = 0;
			}
			ds_list_delete(entityList,0);
			entityCount--;	
		}
	}
	
	
	//Vertical Move Commit
	y += vsp;
	
	ds_list_destroy(entityList);
	
	return collision;
}