// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateSteamingCart(){

var steamingRadius = STEAMING_HOSE_LEN;
var cableLength = STEAMING_CART_CABLE_LEN;

inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);
	
//Movement

hsp = lengthdir_x(inputMagnitude * walkspd, inputDirection);
vsp = lengthdir_y(inputMagnitude * walkspd, inputDirection);

PlayerRadius(global.iCart.cartOutlet, cableLength);

PlayerCollision();

//Update Sprite Index
depth = -y;
var oldSprite = sprite_index;
if(inputMagnitude != 0 && abs(hsp) + abs(vsp) > 0) {
	direction = inputDirection;
	sprite_index = spriteRun;
	
	//update follow path
	for(var i = pathSize; i > 0; i--) {
		pos_x[i] = pos_x[i-1];
		pos_y[i] = pos_y[i-1];
	}
	pos_x[0] = x;
	pos_y[0] = y;
}
else {
	sprite_index = spriteIdle;
}
if(oldSprite != sprite_index) {
	localFrame = 0;
}

//Update Image index
PlayerAnimateSprite();

if(keySteam && steamingIron_obj.inRadius && global.iCart.waterLevel > 0) {
	global.steaming = true;
}
else if(keySetDown) {
	global.steaming = false;
	var activateX = mouse_x;
	var activateY = mouse_y;
	activate = noone;
	var entityList = ds_list_create();
	instance_position_list(activateX, activateY, entity_obj, entityList, false);
	for(var i = 0; i < ds_list_size(entityList); i++) {
		var curItem = entityList[| i];
		if(abs(curItem.x - x) <= 2*TILE_SIZE + sprite_get_width(curItem.sprite_index)/2 && abs(curItem.y - y) <= 2*TILE_SIZE + sprite_get_height(curItem.sprite_index)/2 && entityList[| i].entityActive) {
			activate = entityList[| i];
			break;
		}
	}
	ds_list_destroy(entityList);
	
	if(activate == global.iCart.cartOutlet) {
		global.iCart.pluggedIn = false;
		global.iCart.cartOutlet.image_index = 0;
		global.iCart.cartOutlet = noone;
		with(steamingIron_obj)
		{
			instance_destroy();
		}
		state = PlayerStateFree;
	}
}
else if(keyActivate) { // Exit state
	global.steaming = false;
	state = PlayerStateFree;
	LetGo();
	show_debug_message("steaming cart let go");
}
else {
	global.steaming = false;
}

}