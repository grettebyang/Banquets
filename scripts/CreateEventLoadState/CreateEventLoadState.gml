// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateEventLoadState(curRoom){

	var saveData = array_create(0);
	if(file_exists(room_get_name(curRoom) + "savedroom.sav"))
	{
	
		var _buffer = buffer_load(room_get_name(curRoom) + "savedroom.sav");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		var loadData = json_parse(_string);
			
		while(array_length(loadData) > 0)
		{
			var loadEntity = array_pop(loadData);
			with(loadEntity)
			{
				//Make everything inactive
				entityActive = false;
				entityActivatable = false;
				
				if(object_get_parent(asset_get_index(obj)) == table_obj)
				{
					//Make sure all table chairs are deactivated
					for(var i = 0; i < array_length(chairs); i++)
					{
						var chairEntity = chairs[i];
						with(chairEntity)
						{
							entityActive = false;
						}
					}
				}
			}
				
			array_push(saveData, loadEntity);
				
		}
			
		var _string = json_stringify(saveData);
		var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
		buffer_write(_buffer, buffer_string, _string);
		buffer_save(_buffer, room_get_name(curRoom) + "savedroom.sav");
		buffer_delete(_buffer);
	}

}