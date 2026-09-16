if(viewing)
{
	viewing = false;
	pageNum = 0;
	player_obj.state = player_obj.lastState;
	with(pageTurnButton_obj)
	{
		instance_destroy();
	}
	with(beoCheckBox_obj)
	{
		instance_destroy();
	}
	keyboard_clear(ord("E"));
}

