// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CompareSaveFiles(roomToCheck){ //Returns true if the same, false if not the same

	var filesMatch = true;
	
	if(file_exists(room_get_name(roomToCheck) + "savedroom.sav"))
	{	
		// Get the previous save data
		var set_buffer = buffer_load(room_get_name(roomToCheck) + "savedroom.sav");
		var set_string = buffer_read(set_buffer, buffer_string);
		
		var setLoadData = json_parse(set_string);
	
		// Get current save data to compare
		SaveRoom();
	
		var cur_buffer = buffer_load(room_get_name(roomToCheck) + "savedroom.sav");
		var cur_string = buffer_read(cur_buffer, buffer_string);
		
		var curLoadData = json_parse(cur_string);
		
		buffer_delete(cur_buffer);
	
		if(array_length(setLoadData) == array_length(curLoadData))
		{
			filesMatch = true;
		}
		else
		{
			filesMatch = false;
		}
		
		buffer_write(set_buffer, buffer_string, set_string);
		buffer_save(set_buffer, string(room_get_name(roomToCheck)) + "savedroom.sav");
		buffer_delete(set_buffer);
	}
	
	return filesMatch;

}