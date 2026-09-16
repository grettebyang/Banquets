// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FoodDescription(food){
	
	with(food)
	{
		var desc = global.foodList[? foodName];
		NewTextBox(foodName, 0);
		NewTextBox(desc, 0);
	}
}