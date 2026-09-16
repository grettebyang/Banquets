if(onCart != noone) {
	x = onCart.x;
	y = onCart.y;
	depth = -y;
	var xx = x;
	var yy = y;
	var imageIndex = image_index;
	var newDepth = depth;
	for(var i = 0; i < itemCount+1; i++) {
		with(stackItems[i]) {
			x = xx;
			y = yy - 2*i;
			image_index = imageIndex;
			depth = newDepth - 1*i;
		}
		if(onCart.grabbed)
		{
			stackItems[i].withPlayer = true;
			persistent = true;
		}
		else
		{
			stackItems[i].withPlayer = false;
			persistent = false;
		}
	}
}
else if(!persistent)
{
	for(var i = 0; i < itemCount+1; i++) {
		stackItems[i].withPlayer = false;
	}
}




