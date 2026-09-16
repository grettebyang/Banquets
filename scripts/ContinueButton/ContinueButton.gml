// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ContinueButton(){
	global.targetRoom = rBasement;
	global.targetX = 864;
	global.targetY = 136;
	global.targetDirection = 180;
	
	room_goto(rBasement);
	
	global.gamePaused = false;
	
	instance_destroy();
}