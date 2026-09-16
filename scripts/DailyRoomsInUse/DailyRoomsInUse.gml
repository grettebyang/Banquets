// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DailyRoomsInUse(){

	for(var i = 0; i < array_length(global.roomData); i++)
	{
		var event = global.roomData[i];
		if(event.dayOfEvent == global.day && event.weekOfEvent == global.week)
		{
			array_push(global.dailyInUse, event.eventRoom);
			array_delete(global.roomData, i, 1);
		}
	}

}