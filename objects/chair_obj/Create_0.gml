depth = -y;

grabbed = 0;

cartCollision = false;

itemCount = chairStartAmount;

stackItems = [id];

chairTable = noone;

onCart = noone;

withPlayer = false;

chairCover = false;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

x = (x div TILE_SIZE) * TILE_SIZE + 8;

y = (y div TILE_SIZE) * TILE_SIZE + 8;


if(itemCount > 0)
{
	var xx = x;
	var yy = y;
	var newStackItems = [id];
	var newDepth = depth;
	for(var i = 1; i <= itemCount; i++)
	{
		newStackItems[i] = instance_create_layer(0,0,layer,chair_obj);
		with(newStackItems[i])
		{
			x = xx;
			y = yy - 2*i;
			depth = newDepth - i;
			persistent = true;
			entityCollision = false;
			entityActive = false;
			entityStackable = true;
		}
	}
	stackItems = newStackItems;
}


