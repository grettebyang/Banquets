// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateCreaseGrid(){	
	
	var index = 0;
	var gridWidth = 5;
	var gridHeight = 4;
	
	var topLeft = 0;
	var topRight = gridWidth - 1;
	var bottomLeft = gridWidth * (gridHeight - 1);
	var bottomRight = gridWidth * gridHeight - 1;
	
	var xx = x - sprite_get_width(sprite_index)/2;
	var yy = y - sprite_get_height(sprite_index)/2;
	var creaseDepth = depth - 1;
	
	var colorIndex = (image_index - 1) * (gridWidth * gridHeight);
	
	for(var i = 0; i < gridHeight; i++) {
		for(var j = 0; j < gridWidth; j++) {
			if(index != topLeft && index != topRight && index != bottomLeft && index != bottomRight) {
				instance_create_layer(xx + 5 + j*8, yy + i*8, "Instances", creaseSection_obj, { sprite_index : creaseSections_spr , image_index : index + colorIndex , tableInstance : id , depth : creaseDepth });
			}
			index++;
		}
	}
	
}