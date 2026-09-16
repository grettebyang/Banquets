// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TablePickup(argument0){ //argument0 is the active table

var pickedUp = true;

if(argument0.tableEmpty)
{
	if(!argument0.tableLinen && argument0.chairCount == 0) { // no linen on table, no chairs at table
		//if not with a cart
		if(global.iCart == noone) {
			if(argument0.object_index == recTable_obj) { // If picking up a rectangle table
				// engage in battle
				if(global.recsPickUp == 0 && choose(0,1) == 0) {
					instance_create_layer(player_obj.x, player_obj.y, "Instances", battleEngage_obj, { enemy : global.enemies.rectangleTable });
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
				if(object_get_parent(argument0.object_index) == cartItem && itemCount < cartAmount) { // If cart is table cart
					tableList[argument0.tableTypeIndex]++; 
					itemCount++;
					instance_destroy(argument0);
				}
				else
				{
					pickedUp = false;
				}
			
				ToggleTableType(self, 0);
			}
		}
	}
	else if(argument0.tableLinen) { // linen on table
		if(global.iCart == noone) {
			global.iHolding = instance_create_layer(x,y,"Instances",linen_obj);
			if(argument0.tableFluff > -1)
			{
				with(global.iHolding) {
					sprite_index = entityCarrySprite;
					grabbed = true;
					persistent = true;
					entityCollision = false;  //Turn off collision
					entityActive = false;
					linenColor = argument0.tableFluff;
					image_index = linenColor;
				}
				argument0.tableFluff = -1;
			}
			else
			{
				with(global.iHolding) {
					sprite_index = entityCarrySprite;
					grabbed = true;
					persistent = true;
					entityCollision = false;  //Turn off collision
					entityActive = false;
					linenColor = argument0.image_index - 1;
					image_index = linenColor;
				}
				argument0.tableLinen = false;
				argument0.image_index = 0;
			}
		}
		else if(argument0.image_index < 3){ //if with a cart and if linen is clean
			with(global.iCart) {
				if(cartItem == linen_obj && itemCount < cartAmount) {
					if(argument0.tableFluff > -1)
					{
						linenColorIndex = argument0.tableFluff
						linenColorList[linenColorIndex]++;
						itemCount++;
						argument0.tableFluff = -1;
					}
					else
					{
						linenColorIndex = argument0.image_index - 1;
						linenColorList[linenColorIndex]++;
						itemCount++;
						argument0.tableLinen = false;
						argument0.image_index = 0;
					}
				}
				else
				{
					pickedUp = false;
				}
			}
			
		}	
		else if(global.iCart.object_index == laundryBin_obj)
		{
			with(global.iCart) {
				if(cartItem == linen_obj && itemCount < cartAmount) {
					if(argument0.tableFluff > -1)
					{
						itemCount++;
						argument0.tableFluff = -1;
					}
					else
					{
						itemCount++;
						argument0.tableLinen = false;
						argument0.image_index = 0;
					}
				}
				else
				{
					pickedUp = false;
				}
			}
		}
		else
		{
			NewTextBox("Dirty linens must go in the laundry", 0);
		}

	}
	else
	{
		pickedUp = false;
	}
}
else
{
	pickedUp = false;
}

return pickedUp;

}