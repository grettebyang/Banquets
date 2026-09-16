// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function RotateRecTable(){
	var rotDir = toggle;
	with(global.iHolding)
	{
		rotateIndex = abs((rotateIndex + rotDir) % 2);
		entitySprite = RecSpriteArray[rotateIndex];
	}
}