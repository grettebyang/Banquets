battleState();

//Cursor control
if(cursor.active)
{
	with(cursor)
	{
		//input
		var keyUp = keyboard_check_pressed(ord("W"));
		var keyDown = keyboard_check_pressed(ord("S"));
		var keyLeft = keyboard_check_pressed(ord("A"));
		var keyRight = keyboard_check_pressed(ord("D"));
		var keyToggle = false;
		var keyConfirm = false;
		var keyCancel = false;
		confirmDelay++
		if(confirmDelay > 1)
		{
			keyConfirm = keyboard_check_pressed(ord("E"));
			keyCancel = keyboard_check_pressed(vk_tab);
			keyToggle = keyboard_check_pressed(vk_shift);
		}
		var moveH = keyRight - keyLeft;
		var moveV = keyDown - keyUp;
		
		if(moveH == -1) targetSide = battle_obj.enemyUnits;
		if(moveV == 1) targetSide = battle_obj.enemyUnits;
		
		//verify target list
		if(targetSide == battle_obj.enemyUnits)
		{
			targetSide = array_filter(targetSide, function(element, index)
			{
				return element.hp > 0;
			});
		}
		
		//move between targets
		if(targetAll == false) //Single target mode
		{
			if(moveH == 1) targetIndex++;
			if(moveH == -1) targetIndex--;
			
			//wrap
			var targets = array_length(targetSide);
			if(targetIndex < 0) targetIndex = targets - 1;
			if(targetIndex > (targets - 1)) targetIndex = 0;
			
			//identify target
			activeTarget =  targetSide[targetIndex];
			
			//toggle all mode
			if(activeAction.targetAll == MODE.VARIES) && (keyToggle) //switch to all mode
			{
				targetAll = true;
			}
		}		
		else //target all mode
		{
			activeTarget = targetSide;
			if(activeAction.targetAll == MODE.VARIES) && (keyToggle) //switch to single mode
			{
				targetAll = false;
			}
		}
		
		//Confirm action
		if(keyConfirm)
		{
			with(battle_obj) BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget, cursor.activeItem);
			with(menu_obj) instance_destroy();
			active = false;
			confirmDelay = 0;
		}
		
		//Cancel & return to menu
		if(keyCancel) && (!keyConfirm)
		{
			with(menu_obj) active = true;
			active = false;
			confirmDelay = 0;
		}
	}
}