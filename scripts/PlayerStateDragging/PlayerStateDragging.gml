// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateDragging(){
	
var spriteXOffset = (TILE_SIZE * .5)*((sprite_get_width(activate.entitySprite)/TILE_SIZE) mod 2);
var spriteYOffset = (TILE_SIZE * .5)*((sprite_get_height(activate.entitySprite)/TILE_SIZE) mod 2);
	
var moveDir = (direction + 180) % 360;
var colBoxX1 = activate.x + lengthdir_x(sprite_get_width(activate.entitySprite)/2, moveDir) + lengthdir_y(sprite_get_width(activate.entitySprite)/2, moveDir);
var colBoxY1 = activate.y + lengthdir_y(sprite_get_height(activate.entitySprite)/2, moveDir) + lengthdir_x(sprite_get_height(activate.entitySprite)/2, moveDir);
var colBoxX2 = colBoxX1 + lengthdir_x(TILE_SIZE, moveDir) - lengthdir_y(sprite_get_width(activate.entitySprite), moveDir);
var colBoxY2 = colBoxY1 + lengthdir_y(TILE_SIZE, moveDir) - lengthdir_x(sprite_get_height(activate.entitySprite), moveDir);

var colBoxPlayerX1 = ((x + lengthdir_x(TILE_SIZE, moveDir)) div TILE_SIZE) * TILE_SIZE;
var colBoxPlayerY1 = ((y + lengthdir_y(TILE_SIZE, moveDir)) div TILE_SIZE) * TILE_SIZE;
var colBoxPlayerX2 = colBoxPlayerX1 + TILE_SIZE;
var colBoxPlayerY2 = colBoxPlayerY1 + TILE_SIZE;

if(activate.x % TILE_SIZE == spriteXOffset && activate.y % TILE_SIZE == spriteYOffset) { // Move by tile
	
	inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
	
	//Check for collision
	if(
		inputDirection == moveDir && 
		!collision_rectangle(colBoxX1, colBoxY1, colBoxX2, colBoxY2, entity_obj, false, true) && 
		!collision_rectangle(colBoxPlayerX1, colBoxPlayerY1, colBoxPlayerX2, colBoxPlayerY2, entity_obj, false, true) &&
		!tilemap_get_at_pixel(collisionMap, colBoxPlayerX1, colBoxPlayerY1) &&
		(!tilemap_get_at_pixel(collisionMap, colBoxX1, colBoxY1) ||
		!tilemap_get_at_pixel(collisionMap, colBoxX2, colBoxY2))
	) {
		inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);	
		
		// Sever Chairs
		with(activate) {
			for(var i = 0; i < array_length(chairList); i++) {
				chairList[i].chairTable = noone;
				chairList[i].entityStackable = true;
				array_delete(chairList, i, 1);
			}
			chairCount = 0;
		}
	}
	else {
		inputMagnitude = 0;
	}
	
	if(keyActivate) {
		walkspd = 2.0;
		state = PlayerStateFree;
	}
}
else {
	inputMagnitude = 1;
}

	
//Movement

hsp = lengthdir_x(inputMagnitude * walkspd, inputDirection);
vsp = lengthdir_y(inputMagnitude * walkspd, inputDirection);

PlayerCollision();

//Dragged object movement
with(activate) {
	x += player_obj.hsp;
	y += player_obj.vsp;
	
	var creaseList = ds_list_create();
	instance_place_list(x, y, creaseSection_obj, creaseList, false);
	for(var i = 0; i < ds_list_size(creaseList); i++) {
		var curItem = creaseList[| i];
		with(curItem) {
			x += player_obj.hsp;
			y += player_obj.vsp;
		}
	}
	ds_list_destroy(creaseList);
}

//Update Sprite Index
depth = -y;
var oldSprite = sprite_index;
if(inputMagnitude != 0 && abs(hsp) + abs(vsp) > 0) {
	//direction = inputDirection;
	sprite_index = playerDragTable_spr;
	
	//update follow path
	for(var i = pathSize; i > 0; i--) {
		pos_x[i] = pos_x[i-1];
		pos_y[i] = pos_y[i-1];
	}
	pos_x[0] = x;
	pos_y[0] = y;
}
else {
	sprite_index = playerIdleDrag_spr;
}
if(oldSprite != sprite_index) {
	localFrame = 0;
}

//Update Image index
PlayerAnimateSprite();



}