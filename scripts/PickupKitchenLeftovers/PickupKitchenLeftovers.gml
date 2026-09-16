// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PickupKitchenLeftovers(food){

	if(!global.gotLeftovers)
	{
		global.iHolding = instance_create_layer(x,y,"Instances", food_obj, { foodName : food.foodName });
		with(global.iHolding) {
			sprite_index = entityCarrySprite;
			grabbed = true;
			persistent = true;
			entityCollision = false;  //Turn off collision
			entityActive = false;
		}
		NewTextBox("Got " + food.foodName, 0);		
		global.gotLeftovers = true;
	}
	else
	{
		NewTextBox("I already got some food, I'd better save enough for others.", 0);
	}

}