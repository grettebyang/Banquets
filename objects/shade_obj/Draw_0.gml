
	
	draw_set_color(c_black);
	draw_set_alpha(1);
	draw_rectangle(
		camera_obj.x - camera_obj.viewWidthHalf,
		camera_obj.y - camera_obj.viewHeightHalf,
		camera_obj.x + camera_obj.viewWidthHalf,
		camera_obj.y + camera_obj.viewHeightHalf,
		0
	);