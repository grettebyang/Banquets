// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateRecCreaseGrid(){
	
	var index = 0;

	var xx = x - sprite_get_width(sprite_index)/2;
	var yy = y - sprite_get_height(sprite_index)/2;
	var creaseDepth = depth - 1;
	
	if(rotateIndex == 0)
	{
		var creaseSprite = recCreaseSectionsHorizontal_spr;
		var gridWidth = 7;
		var gridHeight = 3;
		var offsetX = 4;
		var offsetY = 3;
	}
	else
	{
		var creaseSprite = recCreaseSectionsVertical_spr;
		var gridWidth = 3;
		var gridHeight = 5;
		var offsetX = 2;
		var offsetY = 5;
	}
	
	var creaseWidth = sprite_get_width(creaseSprite);
	var creaseHeight = sprite_get_height(creaseSprite);
	
	var colorIndex = (image_index - 1) * (gridWidth * gridHeight);
	
	for(var i = 0; i < gridHeight; i++) {
		for(var j = 0; j < gridWidth; j++) {
			instance_create_layer(xx + offsetX + j*creaseWidth, yy + offsetY + i*creaseHeight, "Instances", creaseSection_obj, { sprite_index : creaseSprite , image_index : index + colorIndex , tableInstance : id , depth : creaseDepth});
			index++;
		}
	}
}