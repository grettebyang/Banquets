// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ChooseNextShiftMeal(){

	if(array_length(global.nextShiftMeal) > 1)
	{
		var choice1 = global.nextShiftMeal[1];
		var choice2 = global.nextShiftMeal[2];
		NewTextBox("Sign up for a meal for my next shift?", 1);
		NewTextBox("", 1, ["1:" + choice1, "2:" + choice2, "0:No need"], ShiftMealDR);
	}
	else
	{
		NewTextBox("Already signed up for " + global.nextShiftMeal[0] + " for my next shift.");
	}

}