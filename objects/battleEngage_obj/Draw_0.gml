if(instance_exists(player_obj) && position_meeting(player_obj.x, player_obj.y, id) && (!stairs || global.iCart == noone))
{
	if(!engaged)
	{
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
			
			engaged = true;
			SaveRoom();
			global.previousRoom = room;
			global.previousCoord = [player_obj.x, player_obj.y];
			//get the battle enemies
			array_push(global.battleEnemies, enemy);
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
	else if(global.battleWon)
	{
		global.battleWon = false;
		instance_destroy();
	}
}

