// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckTaskList(){
	
	// If the beo_obj do not exist yet
	with(taskList_obj)
	{
		if(array_length(global.dailyBEOs) == 0) // If the beo_obj hasn't been created, load in the save file and create them
		{
			var _buffer = buffer_load("scheduledata.sav");
			var _string = buffer_read(_buffer, buffer_string);
			buffer_delete(_buffer);
		
			var scheduleData = json_parse(_string); //scheduleData is an array of beos
			
			while(array_length(scheduleData) > 0) // for each beo, take the first object in the array and create a beo_obj with its variables and assign the instance to the variable in taskList_obj
			{
				var nextBEO = array_pop(scheduleData);
				array_push(global.dailyBEOs, nextBEO);
				pageCount++;
				// create the object
				//var beoObject = nextBEO[0];
				//array_push(beoArray, instance_create_layer(0,0,"Instances",beo_obj, { seatCount : beoObject.seatCount , linenRoomColor : beoObject.linenRoomColor , buffetTables : beoObject.buffetTables , seatsPerTable : beoObject.seatsPerTable , tableCount : beoObject.tableCount , remainder : beoObject.remainder , tablesSeatCounts : beoObject.tableSeatCounts , roomSections : beoObject.roomSections , roomSprite : beoObject.roomSprite , rounds : beoObject.rounds , roomToCheck : beoObject.roomToCheck }));
			}
		}
	
		// Objects exist, use them to draw beo pages:
		// Player enters a pause state
		player_obj.state = PlayerStateLocked;
		// Draw clipboard GUI
		viewing = true;
		// Create buttons with the text from the object
		var topx = 134;
		var topy = 48;
		var vertSpacing = 8;
		for(var i = 0; i < array_length(global.dailyBEOs); i++)
		{
			instance_create_layer(topx,topy + vertSpacing*(i+1),"Instances",pageTurnButton_obj, { targetPage : i+1 , taskText : global.dailyBEOs[i][0].taskName , mainPage : true });
			instance_create_layer(118,topy + vertSpacing*(i+1),"Instances",beoCheckBox_obj, { checkScript : CompareRoomToBEO , checkArgs : [i, global.dailyBEOs[i][0].roomToCheck] , check : global.dailyBEOs[i][0].ready});
		}
		for(var j = 0; j < array_length(global.dailyCleaning); j++)
		{
			instance_create_layer(topx,topy + vertSpacing*(i+j+1),"Instances",pageTurnButton_obj, { targetPage : 0 , taskText : "Clean out " + string_copy(room_get_name(global.dailyCleaning[j].room), 2, string_length(room_get_name(global.dailyCleaning[j].room))-1) + " post event", mainPage : true });
			instance_create_layer(118,topy + vertSpacing*(i+j+1),"Instances",beoCheckBox_obj, { checkScript : CheckRoomClean , checkArgs : [j] , check : global.dailyCleaning[j].ready });			
		}
		// Page turn buttons
		instance_create_layer(184,144,"Instances",pageTurnButton_obj, { targetPage : 1 });
		instance_create_layer(109,2,"Instances",pageTurnButton_obj, { targetPage : -1 });
		
	}
	
}