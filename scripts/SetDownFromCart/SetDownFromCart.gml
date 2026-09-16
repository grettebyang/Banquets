// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetDownFromCart(){
	
	var width = sprite_get_width(global.iCart.cartItem.entitySprite);
	var height = sprite_get_height(global.iCart.cartItem.entitySprite);
	
	var radius = TILE_SIZE*2;
	
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);

	
	if(activate == noone) {
		with(global.iCart) {
			if(abs(xx - px) <= width/2 + radius && abs(yy - py) <= height/2 + radius && !place_meeting(xx,yy,entity_obj) && !place_meeting(xx,yy,player_obj) && CheckTileCollision()) {
				instance_create_layer(xx, yy, "Instances", cartItem, { depth : -y });
				itemCount--;
			}
		}
	}
	else if(object_get_parent(activate.object_index) == genCart_obj) { // if active item is a cart
		with(activate) {
			if(cartItem == global.iCart.cartItem && itemCount < cartAmount) {
				itemCount++;
				global.iCart.itemCount--;
			}
		}
	}
	else if(activate.entityStackable && activate.itemCount < activate.entityStackCount - 1 && global.iCart.cartItem == activate.object_index) { //if stackable, stack onto same object
		var newItem = instance_create_layer(xx, yy, "Instances", global.iCart.cartItem);
		newItem.entityCollision = false;
		SetOnStack(newItem, activate);
		global.iCart.itemCount--;
	}
}