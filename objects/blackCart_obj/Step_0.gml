//Toggle linen color
var toggle = mouse_wheel_up() - mouse_wheel_down();

if((position_meeting(mouse_x, mouse_y, self) || grabbed) && toggle != 0)
{
	ToggleLinenColor(self, toggle);
}









