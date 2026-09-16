// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EatFood(){

	FoodDescription(global.iHolding);
	NewTextBox("Eat " + global.iHolding.foodName + "?", 1, ["1:Yes", "0:No"], EatFoodDR);
}

function EatFoodDR(response){
	
	switch(response)
	{
		case 0 : break;
		case 1 : instance_destroy(global.iHolding); global.iHolding = noone; global.party[0].hp = 100; NewTextBox("HP restored");
		default : break;
	}	
}