draw_set_font(fText);
draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_text(0,0, string(day));
draw_text(0,15, "Week " + string(global.week));