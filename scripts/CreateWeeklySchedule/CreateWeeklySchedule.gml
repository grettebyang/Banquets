// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateWeeklySchedule(){


		var scheduleData = array_create(0);
		var roomData = array_create(0); // contains structs of rooms and the day they will be in use
		// and the schedule for next week is created on the same day
		// Here will determine next week's wedding spaces
		
		// Also add cleanups, meeting room setups, ready rooms, etc. to each daily list
		
		// Overwrite scheduledata.sav with the new weekly BEOs
	
		// List of wedding spaces, choose 1-2 for the next weekend
		var weddingCount = irandom_range(1,2);
		var weddingSpaces = array_filter([rEbony, rPoplar, rMaple, rSpruce], function(element, index) { //if room is already in use (in global.roomData) don't include it in the options
				for(var i = 0; i < array_length(global.roomData); i++)
				{
					if(global.roomData[i].eventRoom == element)
					{
						return false;
					}
				}
				return true;
			});
		while(weddingCount > array_length(weddingSpaces))
		{
			weddingCount--;
		}
		var weekendWeddings = array_create(weddingCount);
	
		for(var i = 0; i < weddingCount; i++)
		{
			var randIndex = irandom_range(0,array_length(weddingSpaces)-1);
			weekendWeddings[i] = weddingSpaces[randIndex];
			array_delete(weddingSpaces, randIndex, 1);
		
		}	
	
		// Make the BEOs according to which rooms were selected
		// Add them to the BEO arrays
		for(var i = 0; i < array_length(weekendWeddings); i++)
		{
			var weddingBEOs = array_create(0);
			switch weekendWeddings[i]
			{
				case rEbony : weddingBEOs = PlanEbonyWedding(); break;
				case rPoplar : weddingBEOs = PlanPoplarWedding(); break;
				case rMaple : weddingBEOs = PlanMapleWedding(); break;
				case rSpruce : weddingBEOs = PlanSpruceWedding(); break;
				default : break;
			}
			for(var j = 0; j < array_length(weddingBEOs); j++)
			{
				with(weddingBEOs[j][0])
				{
					array_push(global.roomData, { eventRoom : roomToCheck , dayOfEvent : dayOfEvent , weekOfEvent : global.week + 1 });
				}
				array_push(scheduleData, weddingBEOs[j]);
			}
		}
		
		//turn all the data into a JSON string and save it via a buffer
		var _string = json_stringify(scheduleData);
		var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
		buffer_write(_buffer, buffer_string, _string);
		buffer_save(_buffer, "scheduledata.sav");
		buffer_delete(_buffer);
		
		var _string = json_stringify(roomData);
		var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
		buffer_write(_buffer, buffer_string, _string);
		buffer_save(_buffer, "eventDays.sav");
		buffer_delete(_buffer);		
	
}