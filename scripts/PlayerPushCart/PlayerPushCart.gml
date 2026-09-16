// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerPushCart(argument0){
	
	global.iCart = argument0;
	with(global.iCart) {
		grabbed = true;
		entityCollision = false;
		persistent = true;
	}
	
	for(var i = pathSize; i > 0; i--) {
		pos_x[i] = global.iCart.x + ((x - global.iCart.x)/pathSize) * (pathSize-i);
		pos_y[i] = global.iCart.y + ((y - global.iCart.y)/pathSize) * (pathSize-i);
	}
	
	if(global.iCart.object_index == steamingCart_obj && global.iCart.pluggedIn) {
		state = PlayerStateSteamingCart;
	}
}