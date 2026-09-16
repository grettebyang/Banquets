draw_self();

if(instance_exists(player_obj))
{
	var width = 16;
	var height = 16;
	
	var radius = TILE_SIZE*2;
	
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);

	var color = c_white;

	if(grabbed)
	{
		if(abs(xx - px) > width/2 + radius || abs(yy - py) > height/2 + radius) {
			xx = x;
			yy = y;
		}
		else {
			sprite_index = entitySprite;
			x = xx;
			y = yy;
			var placeTable = instance_position(x, y, recTable_obj);
			if(instance_exists(placeTable))
			{
				if(placeTable.rotateIndex == 0)
				{
					yy = placeTable.y - 8;
				}
				else
				{
					if(point_in_rectangle(mouse_x, mouse_y, placeTable.x - 8, placeTable.y - 27, placeTable.x + 8, placeTable.y + 12))
					{
						yy = ((mouse_y - (placeTable.y - 27)) div 10) * 10 + (placeTable.y - 27) + 2;
					}
					else
					{
						color = c_red;
					}
				}
				depth = placeTable.depth - 1;
			}
			else if(place_meeting(x,y,entity_obj) || place_meeting(x,y,player_obj) || !CheckTileCollision()) {
				color = c_red;
			}
			draw_sprite_ext(entitySprite,image_index,xx,yy,1,1,0,color,.5);
		}
		sprite_index = entityCarrySprite;
	}
}








