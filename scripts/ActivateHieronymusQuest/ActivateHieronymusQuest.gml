// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ActivateHieronymusQuest(foodName, npcName, giveFood, giveLinen){
	
	var hasFood = (global.iHolding != noone) && (global.iHolding.object_index == food_obj) && (global.iHolding.foodName == foodName);
	var hasLinen = (global.iHolding != noone) && (global.iHolding.object_index == linen_obj);
	switch (global.questStatus[? hieronymus_obj])
	{
		case 0: //not started
		{
			//player already has the food
			if(giveFood)
			{
				instance_destroy(global.iHolding);
				global.iHolding = noone;
				global.questStatus[? hieronymus_obj] = 2;
				NewTextBox("Thank you, this is my FAVORITE!", 0);
				NewTextBox("You are a good human. I love you!", 0);
			}
			else if (hasFood)
			{
				// The dog asks you to give it the food
				NewTextBox("Oh! Will you please give me that " + foodName + "???\n It's my faaaaavorite!", 0);
				global.questStatus[? hieronymus_obj] = 1;
			
			}
			else
			{
				//offer quest
				NewTextBox("I'm Hieronymus.");
				NewTextBox("I would do anything for " + foodName, 0);
				global.questStatus[? hieronymus_obj] = 1;
			}
		}break;
		
		case 1: //quest in progress
		{
			if(giveFood)
			{
				instance_destroy(global.iHolding);
				global.iHolding = noone;
				global.questStatus[? hieronymus_obj] = 2;
				NewTextBox("Thank you, this is my FAVORITE!", 0);
				NewTextBox("You are a good human. I love you!", 0);				
			}
			else if (hasFood)
			{
				NewTextBox("*Sniff* *sniff* *sniff*\n*sniff* *sniff* *sniff*\nDid you bring that for me?", 0);
			}
			else
			{
				//clue reminder
				NewTextBox("The humans only make " + foodName + " some days.", 0);
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
				NewTextBox("This is perfect! Thanks!", 0);
				global.questStatus[? hieronymus_obj] = 4;
				
			}
			else if (hasLinen)
			{
				// advance quest
				NewTextBox("That is just what I need. Will you please give it to me?", 0);
				global.questStatus[? hieronymus_obj] = 3;
			}
			else
			{
				//clue reminder
				NewTextBox("I wish I could go see the others, but I'm too exposed.", 0);
				global.questStatus[? hieronymus_obj] = 3;
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
				NewTextBox("This is perfect! Thanks!", 0);
				global.dogsFound++;
				if(global.dogsFound % 3 == 0)
				{
					GetKeyFromDog();
					NewTextBox("Wow, you've found " + string(global.dogsFound) + " of us so far? That's amazing! I want you to have this key.", 0);
					NewTextBox("Please find the others!", 0);
				}	
				global.questStatus[? hieronymus_obj] = 4;
				
			}
			else if (hasLinen)
			{
				// advance quest
				NewTextBox("That is the perfect disguise. Will you please give it to me?", 0);
			}
			else
			{
				//clue reminder
				NewTextBox("I can't let the other humans see me. Us dogs aren't allowed here. What I need is something that will cover me up.", 0);
			}			
		} break;
		case 4: //quest already completed
		{
			NewTextBox("Thanks! I'm off to find everyone!\nGoodbye!",0,[],ReloadRoom);
			instance_destroy(activate);
		} break;
		default: break;
	}
}