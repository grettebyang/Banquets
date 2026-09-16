// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateRoomGrid(){
	var roomWidth = room_width/TILE_SIZE;
	var roomHeight = room_height/TILE_SIZE;
	
	var roomGrid = ds_grid_create(roomWidth,roomHeight);
	
	for(var ix = 0; ix < roomWidth; ix++)
	{
		for(var iy = 0; iy < roomHeight; iy++)
		{
			var tileInstances = ds_list_create();
			instance_position_list(ix * TILE_SIZE, iy * TILE_SIZE, all, tileInstances, false);
		}
	}
}