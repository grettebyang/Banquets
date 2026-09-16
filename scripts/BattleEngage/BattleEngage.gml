// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BattleEngage(enemy){

//fade into room
var a = 0;
var fade = 1;
a = clamp(a + (fade * .05), 0, 1);
	
if(a == 1)
{
	global.targetRoom = rBattle;
	global.targetX = -10;
	global.targetY = -10;
	global.targetDirection = player_obj.direction;
			
	engaged = true;
	SaveRoom();
	global.previousRoom = room;
	global.previousCoord = [player_obj.x, player_obj.y];
	//get the battle enemies
	array_push(global.battleEnemies, enemy);
	room_goto(rBattle);
	
	instance_destroy();
}
	
draw_set_color(c_black);
draw_set_alpha(a);
draw_rectangle(
	camera_obj.x - camera_obj.viewWidthHalf,
	camera_obj.y - camera_obj.viewHeightHalf,
	camera_obj.x + camera_obj.viewWidthHalf,
	camera_obj.y + camera_obj.viewHeightHalf,
	0
);
draw_set_alpha(1);
}