function ShiftMealDR(response){
	
	switch(response)
	{
		case 0 : break;
		case 1 : global.nextShiftMeal = [global.nextShiftMeal[1]]; NewTextBox("Signed up for " + global.nextShiftMeal[0]); break;
		case 2 : global.nextShiftMeal = [global.nextShiftMeal[2]]; NewTextBox("Signed up for " + global.nextShiftMeal[0]); break;
		default : break;
	}
}