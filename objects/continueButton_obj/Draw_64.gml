display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

draw_sprite(sprite_index, 0, x, y);

draw_set_font(fText);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_text(x+64,y+32, "Continue");

