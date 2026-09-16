if(viewing)
{
	display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
	draw_sprite(beo_spr, pageNum, 0, 0);
	
	if(pageNum <= pageCount && pageNum > 0)
	{
		DrawBEO(global.dailyBEOs[pageNum - 1][0]);
	}
	
}
