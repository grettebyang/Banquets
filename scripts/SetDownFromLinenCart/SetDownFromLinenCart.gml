// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetDownFromLinenCart(){
		
	var radius = TILE_SIZE*2;
	
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);

if(global.iCart.itemCount > 0) {
	
	if(activate == noone) {
		with(global.iCart) {
			if(abs(xx - px) <= (TILE_SIZE * .5) + radius && abs(yy - py) <= (TILE_SIZE * .5) + radius && !place_meeting(xx,yy,entity_obj) && !place_meeting(xx,yy,player_obj) && CheckTileCollision()) {
				var newItem = instance_create_layer(xx, yy, "Instances", cartItem, { depth : -y });
				newItem.image_index = linenColorIndex;
				linenColorList[linenColorIndex]--;
				itemCount--;
			}
		}
	}
	else if(object_get_parent(activate.object_index) == table_obj && (!activate.tableLinen || (activate.canFluff && activate.tableFluff == -1)) && activate.tableEmpty) { // place linen on table
		SpreadLinen(global.iCart.linenColorIndex);
		with(global.iCart)
		{
			linenColorList[linenColorIndex]--;
			itemCount--;
		}
	}
	else if(object_get_parent(activate.object_index) == genCart_obj) { // if active item is a cart
		with(activate) {
			if(cartItem == global.iCart.cartItem && itemCount < cartAmount) {
				linenColorList[global.iCart.linenColorIndex]++;
				itemCount++;
				global.iCart.linenColorList[global.iCart.linenColorIndex]--;
				global.iCart.itemCount--;
			}
		}
	}
	else if(global.iCart.cartItem == activate.object_index && activate.entityStackable && activate.itemCount < activate.entityStackCount - 1) { //if stackable, stack onto same object
		var newItem = instance_create_layer(xx, yy, "Instances", global.iCart.cartItem);
		newItem.entityCollision = false;
		newItem.image_index = global.iCart.linenColorIndex;
		SetOnStack(newItem, activate);
		with(global.iCart)
		{
			linenColorList[linenColorIndex]--;
			itemCount--;
		}
	}
	else if(activate.entityActivateArgs[0] == linen_obj && activate.image_index == global.iCart.linenColorIndex) // if placing a linen back into a linen spawner
	{
		with(global.iCart)
		{
			linenColorList[linenColorIndex]--;
			itemCount--;
		}
	}
	
	//toggle linen color if necessary
	with(global.iCart)
	{
		if(linenColorList[linenColorIndex] == 0)
		{
			ToggleLinenColor(self, 1);
		}
	}
}
}