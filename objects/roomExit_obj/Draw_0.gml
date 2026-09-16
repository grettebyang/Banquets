if(instance_exists(player_obj) && position_meeting(player_obj.x, player_obj.y, id) && (!stairs || global.iCart == noone) && (global.iCart == noone || !global.iCart.pluggedIn) && (global.iHolding == noone || global.iHolding.object_index != vacuum_obj || !global.iHolding.pluggedIn))
{
	for(var i = 0; i < array_length(global.lockedRooms); i++)
	{
		if(global.lockedRooms[i] == room && !CompareSaveFiles(room))
		{
			NewTextBox("I'd better not leave anything in this room that's not on the BEO now.", 0);
			player_obj.x = player_obj.xprevious;
			player_obj.y = player_obj.yprevious;
			exit;
		}
	}

	a = clamp(a + (fade * .05), 0, 1);
	player_obj.state = PlayerStateLocked;
	
	if(a == 1)
	{
		global.targetRoom = targetRoom;
		global.targetX = targetX;
		global.targetY = targetY;
		global.targetDirection = player_obj.direction;
		if(flip)
		{
			global.targetDirection += 180;
		}
	
		SaveRoom();
		global.previousRoom = room;
		global.previousCoord = [player_obj.x, player_obj.y];
		room_goto(targetRoom);
	
		instance_destroy();
	}
	
	draw_set_color(c_black);
	draw_set_alpha(a);
	draw_rectangle(
		camera_obj.x - camera_obj.viewWidthHalf,
		camera_obj.y - camera_obj.viewHeightHalf,
		camera_obj.x + camera_obj.viewWidthHalf,
		camera_obj.y + camera_obj.viewHeightHalf,
		0
	);
	draw_set_alpha(1);
}
