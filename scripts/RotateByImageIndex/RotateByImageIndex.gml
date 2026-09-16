// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function RotateByImageIndex(){
	var rotDir = toggle;
	with(global.iHolding)
	{
		image_index = (image_index + rotDir) % image_number;
	}
}