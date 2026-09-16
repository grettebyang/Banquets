// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ArrangeChairs(argument0, argument1){ //argument is the table, argument1 is the boolean whether or not you want to check for collision
	
	var chairSpaceFree = true;
	var change = argument0.rounds;
	var checkForCollision = argument1;
	
	with(argument0) {
		
		if(chairCount > maxCresc && rounds > 0) {
			rounds = 0;
		}
			
		if(object_index == roundTable_obj)
		{
			var xx = x;
			var yy = y;
			if(rounds == 0) {// rounds can only change to crescents if there are 5 or fewer chairs set at the table, or 4 or fewer if rec
				var split = 360/chairCount;
				var startAngle = 270;
				var startPos = 0;
			}
			else { // Crescents
				var split = 180/(chairCount + 1);
				var startAngle = 180;
				var startPos = 1;
			}
		}
		else if(object_index == recTable_obj)
		{
			if(rotateIndex == 0)
			{
				var xx = x - (sprite_get_width(sprite_index) * .5);
				var yy = y;
			
				switch(rounds){
					case 0 : 
						var southChairs = ceil(chairCount * .5); 
						var northChairs = floor(chairCount * .5); 
						var split = sprite_get_width(sprite_index)/(southChairs); 
						break;
					case 1 : 
						southChairs = chairCount; 
						northChairs = 0; 
						split = sprite_get_width(sprite_index)/(southChairs); 
						break;
					case 2 : 
						southChairs = 0; 
						northChairs = chairCount; 
						break;
					default :
						southChairs = 0;
						northChairs = 0;
						split = 0;
						break;
				}
			}
			else if(rotateIndex == 1)
			{
				var xx = x;
				var yy = y - (sprite_get_height(sprite_index)/3) + 2;
			
				switch(rounds){
					case 0 : 
						var westChairs = ceil(chairCount * .5); 
						var eastChairs = floor(chairCount * .5); 
						var split = (sprite_get_height(sprite_index) * (2/3))/westChairs; 
						break;
					case 1 : 
						westChairs = chairCount; 
						eastChairs = 0; 
						split = (sprite_get_height(sprite_index) * (2/3))/westChairs; 
						break;
					case 2 : 
						westChairs = 0; 
						eastChairs = chairCount; 
						break;
					default :
						westChairs = 0;
						eastChairs = 0;
						split = 0;
						break;
				}				
			}
		}
	}

if(argument0.object_index == roundTable_obj)
{
	for(var i = 0; i < array_length(argument0.chairList); i++) {
		with(argument0.chairList[i]) {
			var phi = startAngle + split*(startPos + i);
			var radius = 23;
			x = xx + lengthdir_x(radius + 8, phi);
			y = yy + lengthdir_y((2/3)*radius + 8, phi);
			image_index = round(point_direction(x,y,xx,yy)/45);
			depth = -y;
			
			//Check for collision at new chair spots
			if(checkForCollision)
			{
				chairSpaceFree = CheckChairCollision(argument0, change);
				if(!chairSpaceFree){
					return chairSpaceFree;
				}
			}
		}
	}
}
else if(argument0.object_index == recTable_obj)
{
	if(argument0.rotateIndex == 0)
	{
		for(var i = 0; i < southChairs; i++)
		{
			with(argument0.chairList[i])
			{
				x = xx + split * (i + 1) - (split * .5);
				y = yy + TILE_SIZE;
				image_index = 2;
				depth = -y;
			
				//Check for collision at new chair spots
				if(checkForCollision)
				{
					chairSpaceFree = CheckChairCollision(argument0, change);
					if(!chairSpaceFree){
						return chairSpaceFree;
					}
				}
			}
		}
		for(var k = 0; k < northChairs; k++)
		{
			with(argument0.chairList[k + southChairs])
			{
				split = sprite_get_width(argument0.sprite_index)/(northChairs);
				x = xx + split * (k + 1) - (split * .5);
				y = yy - TILE_SIZE;
				image_index = 6;
				depth = -y;
			
				//Check for collision at new chair spots
				if(checkForCollision)
				{
					chairSpaceFree = CheckChairCollision(argument0, change);
					if(!chairSpaceFree){
						return chairSpaceFree;
					}
				}
			}
		}
	}
	else if(argument0.rotateIndex == 1)
	{
		for(var i = 0; i < westChairs; i++)
		{
			with(argument0.chairList[i])
			{
				x = xx - TILE_SIZE;
				y = yy + split * (i + 1) - (split * .5);
				image_index = 0;
				depth = -y;
			
				//Check for collision at new chair spots
				if(checkForCollision)
				{
					chairSpaceFree = CheckChairCollision(argument0, change);
					if(!chairSpaceFree){
						return chairSpaceFree;
					}
				}
			}
		}
		for(var k = 0; k < eastChairs; k++)
		{
			with(argument0.chairList[k + westChairs])
			{
				split = (sprite_get_height(argument0.sprite_index) * (2/3))/eastChairs;
				x = xx + TILE_SIZE;
				y = yy + split * (k + 1) - (split * .5);
				image_index = 4;
				depth = -y;
			
				//Check for collision at new chair spots
				if(checkForCollision)
				{
					chairSpaceFree = CheckChairCollision(argument0, change);
					if(!chairSpaceFree){
						return chairSpaceFree;
					}
				}
			}
		}		
	}
}
	
	return chairSpaceFree;
}

function CheckChairCollision(table, change) { // Takes in the table, returns an array [whether there is collision, whether to change rounds]
	
	var changeRounds = change;
	var colList = ds_list_create();
	instance_place_list(x,y,all,colList,false)
	for(var j = 0; j < ds_list_size(colList); j++) {
		var curObj = colList[| j];
		if((object_get_parent(curObj.object_index) != entity_obj || curObj.entityCollision)
			&& curObj != table 
			&& (curObj.object_index != chair_obj || (curObj.chairTable != table && curObj != global.iHolding)) 
			&& curObj.object_index != weddingGuest_obj 
			&& curObj.object_index != plate_obj
		) { // Excludes collision of the table itself, the chairs already set at table, entity objects that don't have collision, wedding guests, and plates
			if(changeRounds != table.rounds) {
				table.rounds = changeRounds;
			}
			ds_list_destroy(colList);
			return false;
		}
	}
	ds_list_destroy(colList);
	return true;
	
}