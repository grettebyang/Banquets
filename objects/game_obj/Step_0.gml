if(global.battleCooldown > 0)
{
	global.battleCooldown--;
}

cursor_sprite = cursor_spr;
var entityList = ds_list_create();
var entityCount = instance_position_list(mouse_x, mouse_y, genItem_obj, entityList, false);
while(entityCount > 0)
{
	var entityCheck = entityList[| 0];
	if(entityCheck.entityActive)
	{
		cursor_sprite = cursorActivate_spr;
	}
	ds_list_delete(entityList,0);
	entityCount--;	
}
ds_list_destroy(entityList);
