if(coolDown > 0)
{
	coolDown--;
}
if(coolDown <= 0)
{
	engaged = false;
}

if(distance_to_object(player_obj) < 64 && global.battleCooldown <= 0) aggro = true;
else aggro = false;

if(aggro) // Make enemy follow the player
{
	var dir = point_direction(x, y, player_obj.x, player_obj.y);
	
	hsp = lengthdir_x(walkspd, dir);
	vsp = lengthdir_y(walkspd, dir);
	
	x += hsp;
	y += vsp;
}