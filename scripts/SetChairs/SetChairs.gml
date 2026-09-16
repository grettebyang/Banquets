// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetChairs(argument0){ //argument0 is the active chair
	
	var activeTable = activate;
	var activeChair = argument0;
	var canSet = true;
	
	with(activeTable) {
		chairList[chairCount] = activeChair;
		chairCount++;
	}
	//Arrange/rearrange chairs around table
	if(ArrangeChairs(activeTable, true)) {	
		with(activeChair) {
			entityCollision = true;
			entityActive = true;
			grabbed = false;
			persistent = false;
			entityStackable = false;
			chairTable = activeTable;
		}
	}
	else {
		with(activeTable) {
			chairCount--;
			array_delete(chairList, chairCount, 1);
		}
		ArrangeChairs(activeTable, true);
		show_debug_message("rounds : " + string(activeTable.rounds));
		canSet = false;
		
		//Give the player feedback
		global.notificationText = "There is not enough room to place that chair!";
		global.notificationTime = 30;
		with(activeChair)
		{
			shakeLength = 5;
			shakeMagnitude = 5;
			shakeRemain = 10;
		}
	}
	
	return canSet;
}