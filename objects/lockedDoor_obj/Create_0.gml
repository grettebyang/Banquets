

// Inherit the parent event
event_inherited();

if(global.doorsUnlocked[? room].unlocked)
{
	entityActivatable = false;
	entityCollision = false;
}

