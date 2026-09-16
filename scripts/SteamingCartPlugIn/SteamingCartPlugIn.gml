// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SteamingCartPlugIn(){
	
	var cart = global.iCart;
	
	cart.pluggedIn = true;
	cart.cartOutlet = activate;
	cart.cartOutlet.image_index = 1;
	state = PlayerStateSteamingCart;
	
	instance_create_layer(mouse_x,mouse_y, "Instances", steamingIron_obj, { steamingCart : global.iCart });
}