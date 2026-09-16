// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ItemSetDown(){
	if(global.iHolding != noone) {
		SetDown();
	}
	else if(global.iCart != noone && global.iCart.itemCount > 0) {
		SetDownFromCart();
	}
}