// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DanceFloorScript(){

instance_create_layer(player_obj.x, player_obj.y, "Instances", battleEngage_obj, { enemy : global.enemies.danceFloor });

}