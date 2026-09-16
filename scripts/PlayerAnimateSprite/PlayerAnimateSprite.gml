// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerAnimateSprite(){
	
	var totalFrames = sprite_get_number(sprite_index) / 8;
	image_index = localFrame + (CARDINAL_DIR * totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;
	
	//If animation would loop on next game step
	if(localFrame >= totalFrames) {
		animationEnd = true;
		localFrame -= totalFrames;
	}
	else {
		animationEnd = false;
	}
}