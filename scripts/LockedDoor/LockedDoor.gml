// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LockedDoor(door){

	if(global.doorsUnlocked[? room].hasKey) // If the player has obtained the key
	{
		global.doorsUnlocked[? room].unlocked = true;
		with(door)
		{
			entityActivatable = false;
			entityCollision = false;
		}
	}
	else // If the door is locked
	{
		NewTextBox("It's locked.", 0);
	}

}