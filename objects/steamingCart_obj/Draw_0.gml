draw_self();

if(pluggedIn && point_distance(cartOutlet.x, cartOutlet.y, x, y) > 24)
{
	draw_set_color(c_black);
	
	//draw cable
	var xx = cartOutlet.x;
	var yy = cartOutlet.y;
	var xn = cartOutlet.x;
	var yn = cartOutlet.y;
	var len = point_distance(cartOutlet.x, cartOutlet.y, x, y);
	var k = STEAMING_CART_CABLE_LEN/len;
	var c = 8; //constant loop interval length
	var p = .75; //constant loop size
	var tx = lengthdir_x(len, point_direction(xx, yy, x, y));
	var ty = lengthdir_y(len, point_direction(xx, yy, x, y));
	for(var t = 0; t < k; t += .1)
	{
		draw_line_width(xn, yn, xx + cos(c*t) * p*k + tx*t/k, yy + sin(c*t) * p*k + ty*t/k, 1);
		xn = xx + cos(c*t) * p*k + tx*t/k;
		yn = yy + sin(c*t) * p*k + ty*t/k;
	}
}

if(position_meeting(mouse_x, mouse_y, self) && itemCount > 0)
{
	draw_sprite(linen_spr, linenColorIndex, x, y - 16);
	//show the number of linens of current color
}








