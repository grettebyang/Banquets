// Inherit the parent event
event_inherited();

//Draw the finished animation
if(steamed && doneIndex < sprite_get_number(tableDoneSprite))
{
	draw_sprite(tableDoneSprite, doneIndex, x, y);
	doneIndex += sprite_get_speed(tableDoneSprite)/FRAME_RATE;
}