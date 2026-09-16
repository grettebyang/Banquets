// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LetGo(){
	with(global.iCart) {
		if(!place_meeting(x,y,player_obj)) {
			grabbed = false;
			entityCollision = true;		
			persistent = false;
			global.iCart = noone;
		}
	}
}