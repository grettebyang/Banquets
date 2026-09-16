// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetDownFromChairDolly(){
	
	var radius = TILE_SIZE*2;
	
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	
	var topChair = noone;
	with(global.iCart.cartStackItem) {
		topChair = stackItems[itemCount];
	}

if(activate == global.iCart) { // when the chair dolly is right clicked on, the entire chair stack will be dropped
	with(global.iCart.cartStackItem) {
		entityActive = true;
		entityCollision = true;
		persistent = false;
		onCart = noone;
	}
	global.iCart.cartStackItem = noone;
}
else if(topChair != noone) {
	
	if(activate == noone) { // set down normally
		with(global.iCart.cartStackItem) {
			if(abs(xx - px) <= (TILE_SIZE * .5) + radius && abs(yy - py) <= (TILE_SIZE * .5) + radius && !place_meeting(xx,yy,entity_obj) && !place_meeting(xx,yy,player_obj) && CheckTileCollision()) {
				with(stackItems[itemCount]) {
					x = xx;
					y = yy;
					entityCollision = true;
					entityActive = true;
					grabbed = false;
					persistent = false;
					depth =  -y;
				}
				if(itemCount > 0) {
					stackItems[itemCount] = noone;
					itemCount--;
				}
				else {
					global.iCart.cartStackItem = noone;
					topChair.onCart = noone;
				}
			}
		}
	}
	else if(activate.object_index == roundTable_obj || activate.object_index == recTable_obj) { // if placing chair at a table
		if(activate.chairCount < 8) {
			if(SetChairs(topChair)) {
				with(global.iCart.cartStackItem) {
					if(itemCount > 0) {
						stackItems[itemCount] = noone;
						itemCount--;
					}
					else {
						global.iCart.cartStackItem = noone;
						topChair.onCart = noone;
					}
				}
			}
		}
	}
	else if(activate.object_index == chairDolly_obj) { // if active item is an empty cart WIP
		activate.cartStackItem = topChair;
		topChair.onCart = activate;
		with(topChair) {
			entityCollision = true;
			entityActive = true;
			grabbed = false;
			persistent = false;
			depth = -y;
			global.iHolding = noone;
		}
		with(global.iCart.cartStackItem) {
			if(itemCount > 0) {
				stackItems[itemCount] = noone;
				itemCount--;
			}
			else {
				global.iCart.cartStackItem = noone;
			}
		}
	}
	else if(activate.object_index == chair_obj && activate.entityStackable) { //if active item is another chair stack
		if(activate.itemCount < 7) {
			SetOnStack(topChair, activate);
			with(global.iCart.cartStackItem) {
				if(itemCount > 0) {
					stackItems[itemCount] = noone;
					itemCount--;
				}
				else {
					global.iCart.cartStackItem = noone;
					topChair.onCart = noone;
				}
			}
		}
	}
	else if(activate.entityActivateArgs[0] == chair_obj) // if placing a chair back into a chair spawner
	{
		with(global.iCart.cartStackItem) {
			instance_destroy(stackItems[itemCount]);
			if(itemCount > 0) {
				stackItems[itemCount] = noone;
				itemCount--;
			}
			else {
				global.iCart.cartStackItem = noone;
				topChair = noone;
			}
		}
	}
}
}