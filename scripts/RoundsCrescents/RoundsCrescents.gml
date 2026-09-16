// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function RoundsCrescents(argument0){ //argument0 is active table
	
	var roundsPrev = argument0.rounds;
	argument0.rounds = (argument0.rounds + 1) % argument0.roundsPositions;
	
	if(!ArrangeChairs(argument0, true)) {
		argument0.rounds = roundsPrev;
		ArrangeChairs(argument0, true);
		global.notificationText = "Not enough room to rearrange chairs";
		global.notificationTime = 30;
	}
	
}