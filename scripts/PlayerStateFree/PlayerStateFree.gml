// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateFree(){
	
inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);
	
//Movement

hsp = lengthdir_x(inputMagnitude * walkspd, inputDirection);
vsp = lengthdir_y(inputMagnitude * walkspd, inputDirection);

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
	if(inputMagnitude != 0){
		direction = inputDirection;
	}
}
if(oldSprite != sprite_index) {
	localFrame = 0;
}

//Update Image index
PlayerAnimateSprite();

// Activate key
var activateX = lengthdir_x(10, direction);
var activateY = lengthdir_y(10, direction);
var entityList = ds_list_create();
instance_position_list(x + activateX, y + activateY, entity_obj, entityList, false);
activate = noone;	
global.activatePrompt = noone;
for(var i = 0; i < ds_list_size(entityList); i++) {
	var curItem = entityList[| i];
	if(curItem.entityActivatable && curItem != global.iHolding) { // check if it is an item that can be activated, like a cart
		activate = entityList[| i];
		global.activatePrompt = activate;
		break;
	}
	else
	{
		global.activatePrompt = noone;
	}
}
ds_list_destroy(entityList);
if(keyActivate) 
{
		if(global.iCart != noone) {
			LetGo();
		}
		//Check item that you're holding
		else if(global.iHolding != noone && global.iHolding.entityCheckScript != -1) {
			script_execute(global.iHolding.entityCheckScript);
		}
		else if(activate != noone && activate.entityActivateScript != -1)
		{
			if(activate.entityNPC) 
			{
				with(activate) 
				{
					direction = point_direction(x,y,other.x,other.y);
					image_index = round(direction/90);
				}
			}
			script_execute_ext(activate.entityActivateScript, activate.entityActivateArgs);
		}
		
}

//Pickup
if(keyPickup) {
	var activateX = mouse_x;
	var activateY = mouse_y;
	activate = noone;
	var entityList = ds_list_create();
	instance_position_list(activateX, activateY, entity_obj, entityList, false);
	for(var i = 0; i < ds_list_size(entityList); i++) {
		var curItem = entityList[| i];
		if(abs(curItem.x - x) <= 2*TILE_SIZE + sprite_get_width(curItem.sprite_index)/2 && abs(curItem.y - y) <= 2*TILE_SIZE + sprite_get_height(curItem.sprite_index)/2 && entityList[| i].entityActive) {
			if(activate == noone || curItem.depth < activate.depth)
			{
				activate = entityList[| i];
			}
			//break;
		}
	}
	ds_list_destroy(entityList);
	
		if(global.iHolding != noone && global.iHolding.entityExtraScript != -1) {
			script_execute_ext(global.iHolding.entityExtraScript, global.iHolding.entityActivateArgs);
		}
		else if (activate != noone && global.iHolding == noone)
		{
			//if you're holding a cart, then the item will be placed on the cart
			//else the item will be held above your head
			//Pick up an item from a cart
			if(activate.entityPickup) {
				if(global.iCart == noone && activate.entityStackable && activate.itemCount > 0) //if picking up off a stack
				{
					script_execute_ext(activate.entityPickupScript, activate.stackItems[activate.itemCount].entityActivateArgs);
					activate.stackItems[activate.itemCount] = noone;
					activate.itemCount--;
				}
				else{ //not a stack
					script_execute_ext(activate.entityPickupScript, activate.entityActivateArgs);
				}
			}
			else if(object_get_parent(activate.object_index) == genCart_obj && activate.itemCount > 0) {
				var item = [instance_create_layer(x, y-10,"Instances", activate.cartItem)];
				activate.itemCount--;
				script_execute_ext(ItemPickup, item);
			}
			
		}		

}

//Set Down
if(keySetDown) {
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
	
	//show_debug_message("active item : " + string(activate));
	if(global.iHolding != noone) {
		if(global.iHolding.entityGiveNPCScript != -1 && activate != noone && activate.entityNPC) // If giving an item to an NPC
		{
			script_execute_ext(global.iHolding.entityGiveNPCScript, global.iHolding.entityGiveArgs);
		}
		else if(global.iHolding.entitySetDownScript == -1) {
			SetDown();
		}
		else {
			script_execute(global.iHolding.entitySetDownScript);
		}
	}
	else if(global.iCart != noone) {
		if(global.iCart.entitySetDownScript == -1) {
			SetDownFromCart();
		}
		else {
			script_execute(global.iCart.entitySetDownScript);
		}
	}
	else if(activate != noone && activate.entityOtherScript != -1){
		script_execute_ext(activate.entityOtherScript, activate.entityActivateArgs);
	}
	
}

//Rotate
if(toggle != 0) {
	if(global.iHolding != noone && global.iHolding.entityRotateScript != -1) {
		script_execute(global.iHolding.entityRotateScript);
		show_debug_message("rotate");
	}	
}
	

}