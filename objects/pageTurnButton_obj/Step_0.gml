if(position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), self) && mouse_check_button_pressed(mb_left))
{
	if(targetPage != 0 && taskList_obj.pageNum + targetPage >= 0 && taskList_obj.pageNum + targetPage <= taskList_obj.pageCount)
	{
		taskList_obj.pageNum += targetPage;		

		with(taskList_obj) // If the page destination is page 0, create the main page buttons again
		{
			if(pageNum == 0)
			{
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
			}
		}
		show_debug_message("Page Number: " + string(taskList_obj.pageNum));
		if(taskList_obj.pageNum != 0)
		{
			with(pageTurnButton_obj)
			{
				if(mainPage) // All buttons that are on the page only 
				{
					instance_destroy();
				}
			}
			with(beoCheckBox_obj)
			{
				instance_destroy();
			}
		}
	}
}

