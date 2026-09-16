// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpruceKitchenEventDay(){ // This will create the state of the kitchen on event days in the Spruce room
	
	if(room == rKitchen && array_contains(global.dailyInUse, rSpruce))
	{
		//Spawn cooks, servers, stewards, other employees
		
		//Spawn guests?
		
		//Spawn food (partway through shift)
		if(global.shiftPoint == 1 && !instance_exists(kitchenLeftovers_obj))
		{
			var entreeOptions = KitchenLeftoverChoices();
			instance_create_layer(376, 240, "Instances", kitchenLeftovers_obj, { foodName : entreeOptions[0] });
			instance_create_layer(376, 256, "Instances", kitchenLeftovers_obj, { foodName : entreeOptions[1] });
		}
		//Dessert
		else if(global.shiftPoint == 2 && !instance_exists(kitchenDessert_obj))
		{
			with(kitchenLeftovers_obj)
			{
				instance_destroy();
			}
			var dessertOption = DessertChoices();
			instance_create_layer(376, 240, "Instances", kitchenDessert_obj, { foodName : dessertOption });
		}
	}

}