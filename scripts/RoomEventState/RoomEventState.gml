// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function RoomEventState(){

	for(var j = 0; j < array_length(global.dailyInUse); j++) //If the room is in use for the day
	{
		if(global.dailyInUse[j] == room)
		{
			//Make the room an active wedding event
				
			//Put guests in chairs
			//This should happen once and then save them to the room's save file 
			//so that they are only randomized once, just like the MakeRoomsDirty script
			if(!instance_exists(weddingGuest_obj))
			{
				with(chair_obj)
				{
					// Randomize skin color
					var skinHueRange = 13;
					var skinSat = irandom_range(50,180);
					var skinVal = 255;
					if(skinSat > 130)
					{
						skinVal = irandom_range(75, 380 - skinSat);
						skinHueRange = 16;
					}
					var skinHue = irandom_range(skinHueRange, 20);
						
					//Randomize hair color
					var hairHue = irandom_range(15,30);
					var hairSat = irandom_range(50,255);
					var hairValRange = 255;
					if(skinVal < 200)
					{
						hairValRange = skinVal - 50;
					}
					var hairVal = irandom_range(25,hairValRange);
						
					instance_create_layer(x,y,"Instances", weddingGuest_obj, { 
							image_index : image_index, 
							depth : depth - 1 ,
							hairColor : make_color_hsv(hairHue,hairSat,hairVal),
							skinColor : make_color_hsv(skinHue,skinSat,skinVal),
							dressColor : make_color_hsv(irandom_range(0,255),irandom_range(50,255),irandom_range(50,255)),
							spriteSet : global.weddingGuestSittingSpriteSets[irandom_range(0, array_length(global.weddingGuestSittingSpriteSets)-1)]
						}
					);
				}
				SaveRoom();
			}
				
			//Set Tables
			with(table_obj)
			{
				ArrangePlates(id);
			}
				
			//Put centerpiece
		}
	}

}