// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ShiftMealChoices(){

	var shiftMeals = array_create(0);
	array_push(shiftMeals, "Ham sandwich");
	array_push(shiftMeals, "Spaghetti");
	array_push(shiftMeals, "Chicken enchilada");
	array_push(shiftMeals, "Tater tot hotdish");
	array_push(shiftMeals, "Chicken wild rice hotdish");
	array_push(shiftMeals, "Chef salad");
	array_push(shiftMeals, "Lasagna");
	array_push(shiftMeals, "Pasta");
	array_push(shiftMeals, "Soup");
	array_push(shiftMeals, "Tacos");
	array_push(shiftMeals, "Chicken alfredo");
	
	var mealChoices = array_create(0);
	array_push(mealChoices, 0);
	var choice1 = irandom_range(0,10);
	array_push(mealChoices, shiftMeals[choice1]);
	array_delete(shiftMeals, choice1, 1);
	
	var choice2 = irandom_range(0,9);
	array_push(mealChoices, shiftMeals[choice2]);
	
	return mealChoices;

}