draw_self();

if(radius > 12 && steamingCart.grabbed)
{
	draw_set_color(c_black);
	
	//draw cable
	var xx = steamingCart.x;
	var yy = steamingCart.y;
	var xn = steamingCart.x;
	var yn = steamingCart.y;

	var k = STEAMING_HOSE_LEN/radius;
	var c = 8; //constant loop interval length
	var p = .75; //constant loop size
	var tx = lengthdir_x(radius, point_direction(xx, yy, x, y));
	var ty = lengthdir_y(radius, point_direction(xx, yy, x, y));
	for(var t = 0; t < k; t += .1)
	{
		draw_line_width(xn, yn, xx + cos(c*t) * p*k + tx*t/k, yy + sin(c*t) * p*k + ty*t/k, 1);
		xn = xx + cos(c*t) * p*k + tx*t/k;
		yn = yy + sin(c*t) * p*k + ty*t/k;
	}
}

if(global.steaming)
{	
	image_index = 1;
	draw_sprite(steam_spr, steamIndex, x, y);
	steamIndex += (sprite_get_speed(steam_spr) / FRAME_RATE);
	if(steamIndex >= 9)
	{
		steamIndex -= 6;
	}
}
else if(steamIndex > 0)
{
	draw_sprite(steam_spr, steamIndex, x, y);
	steamIndex += (sprite_get_speed(steam_spr) / FRAME_RATE);	
	image_index = 0;
	if(steamIndex > 2 && steamIndex < 7)
	{
		steamIndex += 7;
	}
	else if(steamIndex >= sprite_get_number(steam_spr))
	{
		steamIndex -= sprite_get_number(steam_spr);
	}
}
else
{
	image_index = 0;
}











