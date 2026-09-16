	a = clamp(a + (fade * .05), 0, 1);
	if(instance_exists(player_obj))
	{
		player_obj.state = PlayerStateLocked;
		if(a == 0)
		{
			player_obj.state = PlayerStateFree;
		}
	}
	if(a == 0)
	{
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
