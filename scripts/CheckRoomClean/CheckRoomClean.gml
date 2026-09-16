// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckRoomClean(roomIndex){

	// All linens taken out
	// All chairs stacked
	// Vacuumed/no dirt on ground
	var ready = false;
	var roomToCheck = global.dailyCleaning[roomIndex].room;
	
	if(file_exists(room_get_name(roomToCheck) + "savedroom.sav"))
	{				
		var _buffer = buffer_load(room_get_name(roomToCheck) + "savedroom.sav");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		var loadData = json_parse(_string);
		
		while(array_length(loadData) > 0)
		{
			var loadEntity = array_pop(loadData);
			with(loadEntity)
			{
				if(obj == "linen_obj")
				{
					return false;
				}
				else if(obj == "chair_obj" && itemCount == 0)
				{
					return false;
				}
				else if(obj == "roundTable_obj" && (chairCount > 0 || tableLinen))
				{
					return false;
				}
				else if(obj == "recTable_obj" && (chairCount > 0 || tableLinen))
				{
					return false;
				}
				else if(obj == "hitopTable_obj" && tableLinen)
				{
					return false;
				}
				else if(obj == "vacuumDirt_obj")
				{
					return false;
				}
			}
			ready = true;
			global.dailyCleaning[roomIndex].ready = true;
		}
		
	}

	return ready;
}