if(!global.gamePaused) {
	if(grabbed && instance_exists(player_obj) && !cartCollision) {
		//push/pull mechanic
		//if the cart is in front of the player/ in the direction the player is moving
		/*if(round(point_direction(player_obj.x, player_obj.y, x, y)/45)*45 == player_obj.direction) {
			pushpull = 1;
		}
		else {
			pushpull = -1;
		}*/
		//it is being pushed
		//if the player's direction changes by more than 90 degrees from the previous direction
		//push/pull gets swapped
		
		/*if(abs(angle_difference(player_obj.direction,prevDirection))>90) {
			pushpull *= -1;
		}
		
		x = player_obj.x + lengthdir_x(-24, player_obj.direction);
		y = player_obj.y + lengthdir_y(-24, player_obj.direction);
		
		prevDirection = player_obj.direction;*/
		
		
		x = player_obj.pos_x[10];
		y = player_obj.pos_y[10];
	}
}







