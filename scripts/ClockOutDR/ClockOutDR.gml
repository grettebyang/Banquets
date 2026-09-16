function ClockOutDR(response){
	
	switch(response)
	{
		case 0 : break;
		case 1 : ResetDay(); room_goto(rDayTransition); break;
		default : break;
	}
}