// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function KitchenLeftoverChoices(){

	var leftovers = array_create(0);
	array_push(leftovers, "Potroast");
	array_push(leftovers, "Chicken brie");
	array_push(leftovers, "Salmon");
	array_push(leftovers, "Pulled pork sandwich");
	
	var foodChoices = array_create(0);
	array_push(foodChoices, 0);
	var choice1 = irandom_range(0,3);
	array_push(foodChoices, leftovers[choice1]);
	array_delete(leftovers, choice1, 1);
	
	var choice2 = irandom_range(0,2);
	array_push(foodChoices, leftovers[choice2]);
	
	return foodChoices;

}