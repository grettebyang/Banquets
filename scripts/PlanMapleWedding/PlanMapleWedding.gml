// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlanMapleWedding(){

	var mapleBEOs = array_create(0);
	var seatCount = irandom_range(30, 56);
	var linenRoomColor = irandom_range(1,2);
	// For Friday
	// Choose either dinner, ceremony, or social hour
	
	// For Sunday
	// Cleanup post-wedding
	
	// Create the BEOs
	// Return an array of BEOs
	array_push(mapleBEOs, MakeMapleDinner(seatCount, linenRoomColor));
	
	return mapleBEOs;
}