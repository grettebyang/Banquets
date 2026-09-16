// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ActivateAndreaQuest(foodName, npcName, giveFood, giveLinen){
	
	var hasFood = (global.iHolding != noone) && (global.iHolding.object_index == food_obj) && (global.iHolding.foodName == foodName);
	var hasLinen = (global.iHolding != noone) && (global.iHolding.object_index == linen_obj);
	switch (global.questStatus[? andrea_obj])
	{
		case 0: //not started
		{
			//player already has the food
			if(giveFood)
			{
				instance_destroy(global.iHolding);
				global.iHolding = noone;
				global.questStatus[? andrea_obj] = 2;
				NewTextBox("You found " + foodName + "?", 0);
				NewTextBox("How did you know this is my favorite?", 0);
				NewTextBox("Everyone is going to love this.", 0);
				NewTextBox("I'm Andrea by the way.", 0);
			}
			else if (hasFood)
			{
				// The dog asks you to give it the food
				NewTextBox("I smell " + foodName + ".", 0);
				global.questStatus[? andrea_obj] = 1;
			
			}
			else
			{
				//offer quest
				NewTextBox("Hello there, I'm Andrea.");
				NewTextBox("You must be the new houseman.");
				NewTextBox("I don't really know what that is, but I hear people talk about it.");
				NewTextBox("Do you know of a dish called " + foodName + "?");
				NewTextBox("It's my absolute favorite and I want to bring some to Dogsgiving.");
				NewTextBox("If you happen to come by any, let me know.");
				global.questStatus[? andrea_obj] = 1;
			}
		}break;
		
		case 1: //quest in progress
		{
			if(giveFood)
			{
				instance_destroy(global.iHolding);
				global.iHolding = noone;
				global.questStatus[? andrea_obj] = 2;
				NewTextBox("I can really have this? Thank you!", 0);
				NewTextBox("There's something very homey and autumnal about this dish.", 0);				
			}
			else if (hasFood)
			{
				NewTextBox("You found " + foodName + "!", 0);
			}
			else
			{
				//clue reminder
				NewTextBox("I can usually smell " + foodName + "from the third floor, but only sometimes.", 0);
			}
			
		}break;
		case 2: // dog introduces linen quest
		{
			if(giveLinen)
			{
				activate.sprite_index = dogLinen_spr;
				activate.image_index = global.iHolding.image_index;
				instance_destroy(global.iHolding);	
				global.iHolding = noone;
				NewTextBox("Ah, now I am free to roam. Thank you for everything.", 0);
				global.questStatus[? andrea_obj] = 4;
				
			}
			else if (hasLinen)
			{
				// advance quest
				NewTextBox("If I could wear that, people won't suspect that I'm a dog.", 0);
				global.questStatus[? andrea_obj] = 3;
			}
			else
			{
				//clue reminder
				NewTextBox("I won't be able to make my way back like this... Dogs aren't actually allowed here in the hotel.", 0);
				global.questStatus[? andrea_obj] = 3;
			}
			
		} break; 
		case 3: //linen quest already started
		{
			if(giveLinen)
			{
				activate.sprite_index = dogLinen_spr;
				activate.image_index = global.iHolding.image_index;
				instance_destroy(global.iHolding);	
				global.iHolding = noone;
				NewTextBox("You sure know how to pick out a linen!", 0);
				global.dogsFound++;
				if(global.dogsFound % 3 == 0)
				{
					GetKeyFromDog();
					NewTextBox("Wow, you've found " + string(global.dogsFound) + " of us so far? That's amazing! I want you to have this key.", 0);
					NewTextBox("Please find the others!", 0);
				}	
				global.questStatus[? andrea_obj] = 4;
				
			}
			else if (hasLinen)
			{
				// advance quest
				NewTextBox("That linen you're holding will work perfectly if you're not using it.", 0);
			}
			else
			{
				//clue reminder
				NewTextBox("I won't be able to make my way back like this... Dogs aren't actually allowed here in the hotel.", 0);
			}			
		} break;
		case 4: //quest already completed
		{
			NewTextBox("I'll be off now. Come visit me sometime!",0,[],ReloadRoom);	
		} break;
		default: break;
	}
}