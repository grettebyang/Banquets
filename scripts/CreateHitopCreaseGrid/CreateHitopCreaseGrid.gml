// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateHitopCreaseGrid(){
	
	var index = 0;
	var gridWidth = 5;
	var gridHeight = 3;
	
	var xx = x - sprite_get_width(sprite_index)/2;
	var yy = y - sprite_get_height(sprite_index)/2;
	var creaseDepth = depth - 1;
	
	var colorIndex = (image_index - 1) * (gridWidth * gridHeight);
	
	for(var i = 0; i < gridHeight; i++) {
		for(var j = 0; j < gridWidth; j++) {
			instance_create_layer(xx + 3 + j*5, yy + 6 + i*5, "Instances", creaseSection_obj, { sprite_index : hitopCreaseSections_spr , image_index : index + colorIndex , tableInstance : id , depth : creaseDepth});
			index++;
		}
	}
}