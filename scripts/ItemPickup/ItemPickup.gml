// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ItemPickup(argument0){
	//if not with a cart
	if(global.iCart == noone) {
		if(argument0.object_index == recFoodChafer_obj) {
			// engage in battle
			if(global.recsPickUp == 0 && choose(0,1) == 0) {
				instance_create_layer(player_obj.x, player_obj.y, "Instances", battleEngage_obj, { enemy : global.enemies.rectangleFoodChafer });
				exit;
			}
			else {
				global.recsPickUp = max(global.recsPickUp-1, 0);
			}			
		}
		global.iHolding = argument0;
		with(global.iHolding) {
			sprite_index = entityCarrySprite;
			grabbed = true;
			persistent = true;
			entityCollision = false;  //Turn off collision
			entityActive = false;
		}
	}
	else { //if with a cart
		with(global.iCart) {
			if(argument0.object_index == cartItem && itemCount < cartAmount) {
				itemCount++;
				instance_destroy(argument0);
			}
		}
	}
}