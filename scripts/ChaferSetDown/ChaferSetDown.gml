// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ChaferSetDown(){
	
	var width = 16;
	var height = 16;
	
	var radius = TILE_SIZE*2;
	
	var xx = (mouse_x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
	var yy = (mouse_y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);
	var px = (player_obj.x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((width/TILE_SIZE) mod 2);
	var py = (player_obj.y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((height/TILE_SIZE) mod 2);
	
	if(activate == noone) {
		with(global.iHolding) {
			sprite_index = entitySprite;
			x = xx;
			y = yy;
			if(abs(xx - px) <= width/2 + radius && abs(yy - py) <= height/2 + radius && !place_meeting(x,y,entity_obj) && !place_meeting(x,y,player_obj) && CheckTileCollision()) {
				entityCollision = true;
				entityActive = true;
				grabbed = false;
				persistent = false;
				depth =  -y;
				global.iHolding = noone;
			}
			else {
				sprite_index = entityCarrySprite;
			}
		}
	}
	else if(activate.object_index == recTable_obj) //if active item is a rec table
	{
		var placeTable = activate;
		var canPlace = false;
		with(global.iHolding)
		{
			sprite_index = entitySprite;
			if(placeTable.rotateIndex == 0)
			{
				x = xx;
				y = placeTable.y - 8;
				canPlace = true;
			}
			else
			{
				x = xx;
				if(point_in_rectangle(mouse_x, mouse_y, placeTable.x - 8, placeTable.y - 27, placeTable.x + 8, placeTable.y + 12))
				{
					y = ((mouse_y - (placeTable.y - 27)) div 10) * 10 + (placeTable.y - 27) + 2;
					canPlace = true;
				}
			}
			
			if(abs(xx - px) <= width/2 + radius && abs(yy - py) <= height/2 + radius && !place_meeting(x,y,foodChafer_obj) && canPlace)
			{
				entityCollision = false;
				entityActive = true;
				grabbed = false;
				persistent = false;
				depth = -y - 16 * (placeTable.rotateIndex + 1);
				global.iHolding = noone;
			}
			else
			{
				sprite_index = entityCarrySprite;
			}
		}
	}
	else if(object_get_parent(activate.object_index) == genCart_obj) { // if active item is a cart
		with(activate) {
			if(global.iHolding.entityPickup && cartItem == global.iHolding.object_index && itemCount < cartAmount) {
				itemCount++;
				instance_destroy(global.iHolding);	
				global.iHolding = noone;
			}
		}
	}
}