if(global.battleCooldown > 0) 
{
	draw_set_alpha(sin(get_timer()/50000)+1);
}
draw_sprite(sprite_index, image_index, x, y);
draw_set_alpha(1);

