// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LinenPickup(argument0){ //argument0 is the active item being picked up
	
	var pickedUp = true;
	
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
	}
	else { //if with a cart
		with(global.iCart) {
			if(argument0.image_index < 2 || global.iCart.object_index == laundryBin_obj)
			{
				if(argument0.object_index == cartItem && itemCount < cartAmount) {
					linenColorIndex = argument0.stackItems[argument0.itemCount].image_index;
					linenColorList[linenColorIndex]++; 
					itemCount++;
					if(argument0.itemCount > 0) { // only decrease itemCount if there's more than one linen on the stack
						instance_destroy(argument0.stackItems[argument0.itemCount]);
						argument0.stackItems[argument0.itemCount] = noone;
						argument0.itemCount--;
					}
					else
					{
						instance_destroy(argument0);
					}
				}
				else
				{
					pickedUp = false;
				}
			
				if(linenColorList[linenColorIndex] == 0)
				{
					ToggleLinenColor(self, 1);
				}
			}
			else
			{
				pickedUp = false;
			}
		}
	}
	
	return pickedUp;
}