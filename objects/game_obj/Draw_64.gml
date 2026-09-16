display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

draw_set_font(beoText);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
//draw_text(0,0,"Day: " + string(global.day));

if(global.iHolding != noone)
{
	draw_text(0,0, "Right click to set down");
}

//Draw notification text
if(global.notificationText != "")
{
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	draw_set_alpha(notifAlpha);
	if(global.notificationTime > 0)
	{
		global.notificationTime--;
	}
	else if(notifAlpha > 0)
	{
		notifAlpha -= .1;	
	}
	else
	{
		global.notificationText = "";
		notifAlpha = 1;		
	}
	draw_text(camera_get_view_width(view_camera[0])/2, camera_get_view_height(view_camera[0])-8, global.notificationText);
}
draw_set_alpha(1);
