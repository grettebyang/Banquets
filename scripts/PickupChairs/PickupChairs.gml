// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PickupChairs(argument0){ //argument0 is the active chair
	
var activeTable = argument0.chairTable;
var pickedUp = true;

if(activeTable == noone) { // if not set at a table
		//if not with a cart
	if(global.iCart == noone) {
		global.iHolding = argument0;
		with(global.iHolding) {
			sprite_index = entityCarrySprite;
			grabbed = true;
			persistent = true;
			entityCollision = false;  //Turn off collision
			entityActive = false;
			if(onCart != noone) {
				onCart.cartStackItem = noone;
				onCart = noone;
			}
		}
	}
	else { //if with a cart
		with(global.iCart) {
			if(argument0.object_index == cartItem) {
				if(cartStackItem == noone) { // if cart is empty
					if(argument0.onCart != noone) { // severs chair from cart if it was on one
						argument0.onCart.cartStackItem = noone;
						argument0.onCart = noone;
					}	
					cartStackItem = argument0; 
					cartStackItem.onCart = global.iCart;
					with(argument0) {
						persistent = false;
						entityCollision = false;							
					}
				}
				else if(cartStackItem.itemCount < 7){ // if there's already a chair on cart
					// takes top chair on stack and adds it to dolly stack
					SetOnStack(argument0.stackItems[argument0.itemCount], cartStackItem);
					if(argument0.itemCount > 0) { // only decrease itemCount if there's more than one chair on the stack
						argument0.stackItems[argument0.itemCount] = noone;
						argument0.itemCount--;
						if(argument0.onCart != noone) { // severs chair from cart if it was on one
							argument0.onCart.cartStackItem = noone;
							argument0.onCart = noone;
						}	
					}
				
				}
				else{
					pickedUp = false;
				}
			}
		}			
	}
}
else if(activeTable.chairCount > 0) { //if set at a table
	if(global.iCart == noone) { // if not with a cart
		global.iHolding = argument0;
		with(activeTable) {
			chairCount--;
			array_delete(chairList, array_get_index(chairList,argument0), 1);
		}
		with(global.iHolding) {
			grabbed = true;
			persistent = true;
			entityCollision = false;
			entityStackable = true;
			entityActive = false;
			chairTable = noone;
		}
	}
	else { // if with a cart
		if(global.iCart.object_index == chairDolly_obj) {
			with(global.iCart) {
				if(cartStackItem != noone) { // if there is already a chair on dolly
					if(cartStackItem.itemCount < 7) {
						SetOnStack(argument0, cartStackItem);
						with(activeTable) {
							chairCount--;
							array_delete(chairList, array_get_index(chairList,argument0), 1);
						}
					}
					else
					{
						pickedUp = false;
					}
				}
				else { // if dolly is empty
					cartStackItem = argument0;
					cartStackItem.onCart = global.iCart
					with(argument0) {
						entityCollision = false;
						entityActive = false;
						entityStackable = true;
						persistent = true;
						depth = -y;
						chairTable = noone;
					}
					with(activeTable) {
						chairCount--;
						array_delete(chairList, array_get_index(chairList,argument0), 1);
					}
				}
			}

		}
		else
		{
			pickedUp = false;
		}
	}
	ArrangeChairs(activeTable, false);
}
else
{
	pickedUp = false;
}

return pickedUp;

}