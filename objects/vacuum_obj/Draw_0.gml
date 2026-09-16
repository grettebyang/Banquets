draw_self();

if(pluggedIn && point_distance(vacuumOutlet.x, vacuumOutlet.y, x, y) > 24)
{
	draw_set_color(c_black);
	
	//draw cable
	var xx = vacuumOutlet.x;
	var yy = vacuumOutlet.y;
	var xn = vacuumOutlet.x;
	var yn = vacuumOutlet.y;
	var len = point_distance(xx, yy, x, y);
	var k = VACUUM_CABLE_LEN/len;
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










