// Shake
x += random_range(-shakeRemain, shakeRemain);
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));
draw_self();

var radius = TILE_SIZE*2;
	
if(instance_exists(player_obj))
{
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5);

	var color = c_white;

	if(abs(xx - px) > (TILE_SIZE * .5) + radius || abs(yy - py) > (TILE_SIZE * .5) + radius) {
		xx = x;
		yy = y;
	}
	else if(grabbed) {
		sprite_index = entitySprite;
		x = xx;
		y = yy;
		
		if(place_meeting(x,y,entity_obj) || place_meeting(x,y,player_obj)) {
			color = c_red;
		}
		sprite_index = entityCarrySprite;
		draw_sprite_ext(entitySprite,image_index,xx,yy,1,1,0,color,.5);
	}
}








