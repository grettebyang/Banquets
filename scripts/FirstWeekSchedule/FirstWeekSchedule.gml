// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FirstWeekSchedule(){
	
	var scheduleData = array_create(0);
	var seatCount = irandom_range(16, 48);
	var linenRoomColor = irandom_range(1,2);
	
	var firstBEO = MakePoplarDinner(seatCount, linenRoomColor);
	
	array_push(scheduleData, firstBEO);
	with(firstBEO[0])
	{
		array_push(global.roomData, { eventRoom : roomToCheck , dayOfEvent : 1 , weekOfEvent : global.week + 1 });
	}
	
	//turn all the data into a JSON string and save it via a buffer
	var _string = json_stringify(scheduleData);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "scheduledata.sav");
	buffer_delete(_buffer);		
		
}