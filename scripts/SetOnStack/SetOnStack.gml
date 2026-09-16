// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetOnStack(argument0, argument1){ // argument0 is the item to stack, argument1 is the stack
	var holding = argument0;
	var stack = argument1;
	
	var xx = stack.x;
	var yy = stack.y - 2 * (stack.itemCount + 1);
	
	var rotation = stack.image_index;
	var newDepth = 0;
	var count = 0;
		
	with(stack) {
		itemCount++;
		stackItems[itemCount] = holding;
		newDepth = depth - itemCount;
		count = itemCount;
		show_debug_message("itemCount: " + string(itemCount));
		show_debug_message("stackItem: " + string(stackItems[itemCount]));
	}
		
	with(holding) {
		x = xx;
		y = yy;
		
		if(holding.entityRotateScript != -1)
		{
			image_index = rotation;
		}
		depth = newDepth;
		grabbed = false;
		persistent = true;
		entityCollision = false;
		entityActive = false;
		entityStackable = true;
		chairTable = noone;
		global.iHolding = noone;
	}
}