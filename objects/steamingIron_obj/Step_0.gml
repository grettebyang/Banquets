if(steamingCart.grabbed)
{
	var dist = point_distance(steamingCart.x, steamingCart.y, mouse_x, mouse_y)
	radius = clamp(dist, 0, STEAMING_HOSE_LEN);

	x = steamingCart.x + lengthdir_x(radius, point_direction(steamingCart.x, steamingCart.y, mouse_x, mouse_y));
	y = steamingCart.y + lengthdir_y(radius, point_direction(steamingCart.x, steamingCart.y, mouse_x, mouse_y));
	
	if(dist < STEAMING_HOSE_LEN)
	{
		inRadius = true;
	}
	else
	{
		inRadius = false;	
	}
}
else
{
	x = steamingCart.x;
	y = steamingCart.y;
	
	inRadius = false;
}

if(inRadius)
{
	image_alpha = 1;
}
else
{
	image_alpha = .5;
}







