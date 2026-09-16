// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MakeDailyTasks(){ // Puts the next beos in the schedule into the dailytasks array
	
	if(file_exists("scheduledata.sav"))
	{
		var _buffer = buffer_load("scheduledata.sav");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		// scheduleData will be an array of beos, ordered as a queue
		// Whatever is at the end of the list will be selected for the next task
		// Whatever's left over in this array will be added to today's (Friday's) task list
		var scheduleData = json_parse(_string);
		var beoNum = array_length(scheduleData);
		/*if(global.day == 1)
		{
			beoNum /= 3;
		}
		else if(global.day == 2)
		{
			beoNum /= 2;
		}
		
		// Put the beo(s) left in scheduleData into global.dailyBEOs
		for(var i = 0; i < beoNum; i++)
		{
			array_push(global.dailyBEOs, array_pop(scheduleData));
		}*/
		if(array_length(scheduleData) > 0)
		{
			array_push(global.dailyBEOs, array_pop(scheduleData));
		}
	}
	
	//turn all the data into a JSON string and save it via a buffer
	var _string = json_stringify(scheduleData);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "scheduledata.sav");
	buffer_delete(_buffer);
	
}