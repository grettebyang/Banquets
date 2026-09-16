if(position_meeting(player_obj.x, player_obj.y, self) && player_obj.depth > depth)
{
	if(image_alpha > .3)
	{
		image_alpha -= .05;
	}
}
else
{
	if(image_alpha < 1)
	{
		image_alpha += .05;
	}
}










