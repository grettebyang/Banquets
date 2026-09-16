// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TableSet(){
	
	if(global.iHolding != noone) { // if holding item
		var setItem = global.iHolding;
		
		if(setItem.object_index == linen_obj && !activate.tableLinen) {
			SpreadLinen();
			instance_destroy(global.iHolding);
			global.iHolding = noone;
		}
		else if(setItem.object_index == chair_obj && activate.chairCount < 8) {
			SetChairs(setItem);
			global.iHolding = noone;	
		}
		

	}
	else if(global.iCart != noone && global.iCart.itemCount > 0) { // if cart has item
		var setItem = global.iCart.cartItem;
		
		if(setItem.object_index == linen_obj && !activate.tableLinen) {
			SpreadLinen();
			global.iCart.itemCount--;
		}
		else if(setItem.object_index == chair_obj && activate.chairCount < 8) {
			SetChairs(instance_create_layer(x,y,"Instances",chair_obj));
			global.iCart.itemCount--;
		}
		
	}
	

}