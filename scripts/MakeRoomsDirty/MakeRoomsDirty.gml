// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MakeRoomsDirty(){
	
	for(var i = 0; i < array_length(global.dailyCleaning); i++)
	{
		// Unlock the room by removing from the global.lockedRooms array
		for(var j = 0; j < array_length(global.lockedRooms); j++)
		{
			if(global.lockedRooms[j] == global.dailyCleaning[i].room)
			{
				array_delete(global.lockedRooms, j, 1);
			}
		}
		
		var saveData = array_create(0);
		var curRoom = global.dailyCleaning[i].room;
		if(file_exists(room_get_name(curRoom) + "savedroom.sav"))
		{
	
			var _buffer = buffer_load(room_get_name(curRoom) + "savedroom.sav");
			var _string = buffer_read(_buffer, buffer_string);
			buffer_delete(_buffer);
		
			var loadData = json_parse(_string);
			
			while(array_length(loadData) > 0)
			{
				var loadEntity = array_pop(loadData);
				
				// Unlock all assets, make them active, make activatable objects activatable again
				with(loadEntity)
				{
					entityActive = true;
					if(object_get_parent(asset_get_index(obj)) == table_obj)
					{
						if(tableLinen)
						{
							image_index += 2; // Make table linens dirty
						}
						if(tableFluff > 0)
						{
							tableFluff += 2; // Make table fluffs dirty
						}
						
						entityActivatable = true;
						
						//Make sure all table chairs are deactivated
						for(var k = 0; k < array_length(chairs); k++)
						{
							var chairEntity = chairs[k];
							with(chairEntity)
							{
								entityActive = true;
							}
						}
					}
					else if(object_get_parent(asset_get_index(obj)) == genCart_obj)
					{
						entityActivatable = true;
					}
				}
				
				if(asset_get_index(loadEntity.obj) != weddingGuest_obj) // Make sure to remove all wedding guests from the room
				{
					array_push(saveData, loadEntity);
				}
				
			}
			
			// Add dirt to room
			var dirtAmount = irandom_range(5,20);
			for(var j = 0; j < dirtAmount; j++)
			{
				var dirtEntity =
				{
					obj : "vacuumDirt_obj",
					x : -1,
					y : -1,
					image_index : 0,
					sprite_index : vacuumDirt_spr,
					depth : -y
				}
				array_push(saveData, dirtEntity);
			}
			
			var _string = json_stringify(saveData);
			var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
			buffer_write(_buffer, buffer_string, _string);
			buffer_save(_buffer, room_get_name(curRoom) + "savedroom.sav");
			buffer_delete(_buffer);
		}
	}
	
}