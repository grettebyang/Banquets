// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ClockOut(){
	
	// Check if all rooms are set up
	if(CheckTasksCompleted() || global.devBypassTasks)
	{
		NewTextBox("Clock out for the day?", 0, ["1:Yes", "0:No"], ClockOutDR);
	}
	else
	{
		NewTextBox("I'd better finish all the tasks on the list before I clock out.", 0);
	}

}

function ResetDay(){
	// Advance the day, reset daily BEOs
	global.day = (global.day + 1) % 3;
	global.shiftPoint = 0;
		
	// All the rooms in global.dailyInUse will need cleaning on the next day
	global.roomData = array_filter(global.roomData, function(element, index) {
		for(var i = 0; i < array_length(global.dailyInUse); i++)
		{
			if(element.eventRoom == global.dailyInUse[i])
			{
				return false;
			}
		}
		return true;
	});
	array_delete(global.dailyCleaning, 0, array_length(global.dailyCleaning));
	for(var i = 0; i < array_length(global.dailyInUse); i++)
	{
		array_push(global.dailyCleaning, { room : global.dailyInUse[i] , ready : false });
	}
	MakeRoomsDirty();
		
	if(global.day == 0)
	{
		global.week++;
		// Create new schedule for week
		CreateWeeklySchedule();
	}
	
	// global.dailyInUse will be replaced with all the rooms whose events are the next day
	array_delete(global.dailyInUse, 0, array_length(global.dailyInUse));
	DailyRoomsInUse();
	
	array_delete(global.dailyBEOs, 0, array_length(global.dailyBEOs));
	MakeDailyTasks();
		
	// Make global.dailyShiftMeal the option you chose for the next day
	global.dailyShiftMeal = global.nextShiftMeal[0];
	global.nextShiftMeal = ShiftMealChoices();
	global.gotLeftovers = false;
	global.gotDessert = false;
		
	global.devBypassTasks = false;	
	
	SaveRoom();
}