// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetDownFromTableCart(){
	
	switch(global.iCart.tableIndex)
	{
		case 0 : var newTable = roundTable_obj; break;
		case 1 : var newTable = recTable_obj; break;
		case 2 : var newTable = hitopTable_obj; break;
		default : var newTable = roundTable_obj; break;
	}
		

	
if(global.iCart.itemCount > 0) {
	
	if(activate == noone) {
		with(global.iCart) {
			var newItem = instance_create_layer(-10, -10, "Instances", newTable, { depth : -y });
			
			var width = sprite_get_width(newItem.entitySprite);
			var height = sprite_get_height(newItem.entitySprite);
	
			var radius = TILE_SIZE*2;
	
			var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
			var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);
			var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
			var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);
			
			if(abs(xx - px) <= (TILE_SIZE * .5) + radius && abs(yy - py) <= (TILE_SIZE * .5) + radius && !place_meeting(xx,yy,entity_obj) && !place_meeting(xx,yy,player_obj) && CheckTileCollision()) {	
				newItem.x = xx;
				newItem.y = yy;
				tableList[tableIndex]--;
				itemCount--;
			}
			else
			{
				instance_destroy(newItem);
			}
		}
	}
	else if(object_get_parent(activate.object_index) == genCart_obj) { // if active item is a cart
		with(activate) {
			if(cartItem == global.iCart.cartItem && itemCount < cartAmount) {
				tableList[global.iCart.tableIndex]++;
				itemCount++;
				global.iCart.tableList[global.iCart.tableIndex]--;
				global.iCart.itemCount--;
			}
		}
	}
	else if(activate.entityActivateArgs[0] == newTable) // if placing a chair back into a chair spawner
	{
		with(global.iCart)
		{
			tableList[tableIndex]--;
			itemCount--;			
		}
	}
	
	//toggle table type if necessary
	with(global.iCart)
	{
		if(tableList[tableIndex] == 0)
		{
			ToggleTableType(self, 1);
		}	
	}
}
}