// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ArrangePlates(argument){ //argument is the table
	
	var tableDepth = argument.depth;
	
	with(argument) {
			
		if(object_index == roundTable_obj)
		{
			var xx = x;
			var yy = y;
			if(rounds == 0) {// rounds can only change to crescents if there are 5 or fewer chairs set at the table, or 4 or fewer if rec
				var split = 360/chairCount;
				var startAngle = 270;
				var startPos = 0;
			}
			else { // Crescents
				var split = 180/(chairCount + 1);
				var startAngle = 180;
				var startPos = 1;
			}
		}
		else if(object_index == recTable_obj)
		{
			if(rotateIndex == 0)
			{
				var xx = x - (sprite_get_width(sprite_index) * .5);
				var yy = y;
			
				switch(rounds){
					case 0 : 
						var southChairs = ceil(chairCount * .5); 
						var northChairs = floor(chairCount * .5); 
						var split = sprite_get_width(sprite_index)/(southChairs); 
						break;
					case 1 : 
						southChairs = chairCount; 
						northChairs = 0; 
						split = sprite_get_width(sprite_index)/(southChairs); 
						break;
					case 2 : 
						southChairs = 0; 
						northChairs = chairCount; 
						break;
					default :
						southChairs = 0;
						northChairs = 0;
						split = 0;
						break;
				}
			}
			else if(rotateIndex == 1)
			{
				var xx = x;
				var yy = y - (sprite_get_height(sprite_index)/3) + 2;
			
				switch(rounds){
					case 0 : 
						var westChairs = ceil(chairCount * .5); 
						var eastChairs = floor(chairCount * .5); 
						var split = (sprite_get_height(sprite_index) * (2/3))/westChairs; 
						break;
					case 1 : 
						westChairs = chairCount; 
						eastChairs = 0; 
						split = (sprite_get_height(sprite_index) * (2/3))/westChairs; 
						break;
					case 2 : 
						westChairs = 0; 
						eastChairs = chairCount; 
						break;
					default :
						westChairs = 0;
						eastChairs = 0;
						split = 0;
						break;
				}				
			}
		}
	}

if(argument.object_index == roundTable_obj)
{
	for(var i = 0; i < array_length(argument.chairList); i++) {
		with(instance_create_layer(x,y,"Instances", plate_obj)) {
			var phi = startAngle + split*(startPos + i);
			var radius = 18;
			x = xx + lengthdir_x(radius, phi);
			y = yy + lengthdir_y((3/5)*radius, phi) - 7;
			depth = tableDepth - 1;
			image_index = irandom_range(0, image_number-1);
		}
	}
}
else if(argument.object_index == recTable_obj)
{
	if(argument.rotateIndex == 0)
	{
		for(var i = 0; i < southChairs; i++)
		{
			with(instance_create_layer(x,y,"Instances", plate_obj))
			{
				x = xx + split * (i + 1) - (split * .5);
				y = yy - 1;
				depth = tableDepth - 1;
				image_index = irandom_range(0, image_number-1);
			}
		}
		for(var k = 0; k < northChairs; k++)
		{
			with(instance_create_layer(x,y,"Instances", plate_obj))
			{
				split = sprite_get_width(argument.sprite_index)/(northChairs);
				x = xx + split * (k + 1) - (split * .5);
				y = yy - 9;
				depth = tableDepth - 1;
				image_index = irandom_range(0, image_number-1);
			}
		}
	}
	else if(argument.rotateIndex == 1)
	{
		for(var i = 0; i < westChairs; i++)
		{
			with(instance_create_layer(x,y,"Instances", plate_obj))
			{
				x = xx - TILE_SIZE/2;
				y = yy + split * (i + 1) - (split * .5);
				depth = tableDepth - 1;
				image_index = irandom_range(0, image_number-1);
			}
		}
		for(var k = 0; k < eastChairs; k++)
		{
			with(instance_create_layer(x,y,"Instances", plate_obj))
			{
				split = (sprite_get_height(argument.sprite_index) * (2/3))/eastChairs;
				x = xx + TILE_SIZE/2;
				y = yy + split * (k + 1) - (split * .5);
				depth = tableDepth - 1;
				image_index = irandom_range(0, image_number-1);
			}
		}		
	}
}

}