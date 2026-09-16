//Get Player Input
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));
keyLeft = keyboard_check(ord("A"));
keyRight = keyboard_check(ord("D"));
keyActivate = keyboard_check_pressed(ord("E"));
keyPickup = mouse_check_button_pressed(mb_left);
keySetDown = mouse_check_button_pressed(mb_right);
keySteam = mouse_check_button(mb_left);
toggle = mouse_wheel_up() - mouse_wheel_down();

if(!global.gamePaused){
	script_execute(state);
}
else
{
	image_speed = 0;
}

