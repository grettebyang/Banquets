// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ChairSetDown(){
	
	var radius = TILE_SIZE*2;
	
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	
	if(activate == noone) { // set down normally
		with(global.iHolding) {
			if(abs(xx - px) <= (TILE_SIZE * .5) + radius && abs(yy - py) <= (TILE_SIZE * .5) + radius && !place_meeting(xx,yy,entity_obj) && !place_meeting(xx,yy,player_obj) && CheckTileCollision()) {
				x = xx;
				y = yy;
				entityCollision = true;
				entityActive = true;
				grabbed = false;
				persistent = false;
				depth =  -y;
				global.iHolding = noone;
			}
		}
	}
	else if(activate.object_index == roundTable_obj || activate.object_index == recTable_obj) { // if placing chair at a table
		if(activate.chairCount < 8) {
			if(SetChairs(global.iHolding)) {
				global.iHolding = noone;
			}
		}
	}
	else if(activate.object_index == chairDolly_obj) { // if active item is an empty cart
		activate.cartStackItem = global.iHolding;
		global.iHolding.onCart = activate;
		with(global.iHolding) {
			entityCollision = true;
			entityActive = true;
			grabbed = false;
			persistent = false;
			depth = -y;
			global.iHolding = noone;
		}
	}
	else if(activate.object_index == chair_obj && activate.entityStackable && activate.itemCount < 7) { //if stackable, stack onto same object
		SetOnStack(global.iHolding, activate);
	}
	else if(activate.entityActivateArgs[0] == chair_obj) // if placing a chair back into a chair spawner
	{
		instance_destroy(global.iHolding);
		global.iHolding = noone;
	}
	
}