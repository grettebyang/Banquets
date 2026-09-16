// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ElevatorButton(){
	global.targetRoom = targetRoom;
	global.targetX = targetX;
	global.targetY = targetY;
	global.targetDirection = 270;
	
	global.previousRoom = room;
	SaveRoom();
	room_goto(targetRoom);
	
	global.gamePaused = false;
	
	instance_destroy();
}