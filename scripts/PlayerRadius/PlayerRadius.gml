// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerRadius(argument, argument0){ // argument is the origin object, argument0 is the radius
	
	var origin = argument;
	var radius = argument0;
	
	if(point_distance(x + hsp, y, origin.x, origin.y) >= radius) {
		hsp = 0;
	}
	
	if(point_distance(x, y + vsp, origin.x, origin.y) >= radius) {
		vsp = 0;
	}
	
}