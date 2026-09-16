if(!global.gamePaused) {
	
	if(tableInstance.tableFluff == -1)
	{
		depth = tableInstance.depth - 1;
	
		if(global.steaming && place_meeting(x, y, steamingIron_obj) && !place_meeting(x, y, foodChafer_obj)) {
			over = true;
			//decrease water level by one in steamer
		}
	}
	else
	{
		depth = tableInstance.depth;
	}
	
	if(over) {
	image_alpha -= .05;
	}

	if(image_alpha <= 0 || !tableInstance.tableLinen) {
		instance_destroy();
	}

}






