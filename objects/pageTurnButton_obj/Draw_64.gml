display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
draw_set_font(beoText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);

if(mainPage)
{
	draw_text(x, y, taskText);
}
