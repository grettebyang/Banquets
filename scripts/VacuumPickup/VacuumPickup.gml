// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function VacuumPickup(argument0){
	//if not with a cart
	if(global.iCart == noone) {
		global.iHolding = argument0;
		with(global.iHolding) {
			sprite_index = entityCarrySprite;
			grabbed = true;
			persistent = true;
			entityCollision = false;  //Turn off collision
			entityActive = false;
		}
		if(global.iHolding.pluggedIn)
		{
			state = PlayerStateVacuum;
		}
	}
}