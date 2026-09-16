draw_self();

if(instance_exists(player_obj))
{
	var width = sprite_get_width(entitySprite);
	var height = sprite_get_height(entitySprite);
	
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
			if(place_meeting(x,y,entity_obj) || place_meeting(x,y,player_obj)  || !CheckTileCollision()) {
				color = c_red;
			}
			draw_sprite_ext(entitySprite,image_index,xx,yy,1,1,0,color,.5);
		}
		sprite_index = entityCarrySprite;
	}
}




