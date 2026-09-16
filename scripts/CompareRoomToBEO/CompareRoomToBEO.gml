// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CompareRoomToBEO(beoIndex, beoRoom){ // Takes in the beo index of scheduledata.sav
	var ready = false;
	var matchingItems = 0;
	
	if(file_exists(room_get_name(beoRoom) + "savedroom.sav"))
	{		
		var beoData = array_create(0);
		for(var i = 0; i < array_length(global.dailyBEOs[beoIndex]); i++)
		{
			array_push(beoData, global.dailyBEOs[beoIndex][i]);
		}
		
		var _buffer = buffer_load(room_get_name(beoRoom) + "savedroom.sav");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		var loadData = json_parse(_string);
		
		// Parse the original array into multiple arrays based on each objects x,y position
		// Then loop through each array and compare it to the BEO's corresponding array
		// For each object in room, loop through the beo data to find a matching entity and remove it from both arrays
		// If there is no match, return ready = false
		// If all entities have a match and there are no extraneous items in either array, return true
		
		// Parse loadData into smaller arrays based on section of the room
		/*while(array_length(loadData) > 0)
		{
			var loadEntity = array_pop(loadData);
			var newObj = instance_create_layer(0,0,layer,asset_get_index(loadEntity.obj));
			with(newObj)
			{
				//Check x,y position of each object
				
			}
			
		}	*/	
		var totalBEOItems = array_length(beoData) - 1;
		var totalRoomItems = array_length(loadData);
		
		while(array_length(loadData) > 0)
		{
			var matched = false;
			var loadEntity = array_pop(loadData);
			with(loadEntity)
			{
				// ready should only be false if it has looped through every item and not found a match
				for(var i = 1; i < array_length(beoData); i++)
				{
					var beoEntity = beoData[i];
					
					//Compare loadEntity to beoEntity
					if( // Check that item in the same section as the beoEntity
						obj == beoEntity.obj &&
						x > beoEntity.section[0] &&
						x < beoEntity.section[1] &&
						y > beoEntity.section[2] &&
						y < beoEntity.section[3]						
					)
					{
						if(obj == "recTable_obj")
						{
							if(
								steamed == beoEntity.steamed &&
								tableLinen == beoEntity.tableLinen &&
								chairCount == beoEntity.chairCount &&
								rotateIndex == beoEntity.rotateIndex &&
								tableFluff == beoEntity.tableFluff &&
								image_index == beoEntity.linenColor &&
								rounds == beoEntity.rounds
							)
							{ // Object is a match, so remove it from the beo list
								matched = true;	
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);
							}						
						}
						else if(obj == "roundTable_obj")
						{
							if(
								steamed == beoEntity.steamed &&
								tableLinen == beoEntity.tableLinen &&
								chairCount == beoEntity.chairCount &&
								image_index == beoEntity.linenColor &&
								rounds == beoEntity.rounds
							)
							{
								matched = true;	
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);
							}							
						}
						else if(obj == "hitopTable_obj")
						{
							if(
								steamed == beoEntity.steamed &&
								tableLinen == beoEntity.tableLinen &&
								image_index == beoEntity.linenColor
							)
							{
								matched = true;
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);
							}										
						}
						else if(obj == "chair_obj")
						{
							if(
								itemCount == beoEntity.itemCount &&
								image_index == beoEntity.image_index &&
								onCart == beoEntity.onCart &&
								chairCover == beoEntity.chairCover
							)
							{
								matched = true;
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);
							}								
						}
						else if(obj == "recFoodChafer_obj")
						{
							if(
								onTable == beoEntity.onTable
							)
							{
								matched = true;
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);								
							}
						}
						else if(obj == "roundFoodChafer_obj")
						{
							if(
								onTable == beoEntity.onTable
							)
							{
								matched = true;
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);								
							}
						}
						else if(obj == "soupFoodChafer_obj")
						{
							if(
								onTable == beoEntity.onTable
							)
							{
								matched = true;
								matchingItems++;
								array_delete(beoData, i, 1);
								i = array_length(beoData);								
							}
						}
					}
						
				}

			}
			// If match has not been found after every iteration, room is not ready
			/*if(!matched)
			{
				ready = false;
			}
			else
			{
				ready = true;
			}		*/	
			
		}
		if(matchingItems == totalBEOItems && totalBEOItems == totalRoomItems) // If the number of matching items equals the number of items on the BEO, the room is ready
		{
			ready = true;
			global.dailyBEOs[beoIndex][0].ready = true;
			// Save current save file for room with fixed assets
			CreateEventLoadState(beoRoom);
			array_push(global.lockedRooms, beoRoom);
		}
		NewTextBox("Matching items: " + string(matchingItems) + "/" + string(totalBEOItems));		
	}

	return ready;
}