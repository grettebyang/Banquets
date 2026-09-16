function DialogueResponses(response){
	
	switch(response)
	{
		case 0 : break;
		case 1 : NewTextBox("Hey", 0); break;
		case 2 : NewTextBox("Hi. Did you check the BEO?", 0, ["3:Yes", "0:No"]); break;
		case 3 : NewTextBox("Okay.", 0); break;
		case 4 : global.nextShiftMeal = [global.nextShiftMeal[1]]; NewTextBox("Signed up for " + global.nextShiftMeal[0]); break;
		case 5 : global.nextShiftMeal = [global.nextShiftMeal[2]]; NewTextBox("Signed up for " + global.nextShiftMeal[0]); break;
		case 6 : ResetDay(); room_goto(rDayTransition); break;
		default : break;
	}
}