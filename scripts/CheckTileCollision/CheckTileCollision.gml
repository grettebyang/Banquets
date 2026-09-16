// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckTileCollision(){
	
	var clear;
	var colMap = player_obj.collisionMap;
	if(!tilemap_get_at_pixel(colMap, x, y) && !tilemap_get_at_pixel(colMap, bbox_left, bbox_top) && !tilemap_get_at_pixel(colMap, bbox_right, bbox_bottom) && !tilemap_get_at_pixel(colMap, bbox_left, bbox_bottom) && !tilemap_get_at_pixel(colMap, bbox_right, bbox_top))
	{
		clear = true;
	}
	else
	{
		clear = false;
	}
	
	return clear;
}