// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PickupShiftMeal(){

	if(global.dailyShiftMeal != 0)
	{
		global.iHolding = instance_create_layer(x,y,"Instances", food_obj, { foodName : global.dailyShiftMeal, entityGiveArgs : [global.dailyShiftMeal] });
		with(global.iHolding) {
			sprite_index = entityCarrySprite;
			grabbed = true;
			persistent = true;
			entityCollision = false;  //Turn off collision
			entityActive = false;
		}
		NewTextBox("Got " + global.dailyShiftMeal, 0);
		global.dailyShiftMeal = 0;
	}
	else
	{
		NewTextBox("I don't see my name on any of the boxes here.", 0);
	}

}