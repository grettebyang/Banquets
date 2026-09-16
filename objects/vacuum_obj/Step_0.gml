// Vacuum up dirt
var dirt = instance_place(x,y,vacuumDirt_obj);
if(pluggedIn && vacuumOn && dirt != noone)
{
	instance_destroy(dirt);
}





