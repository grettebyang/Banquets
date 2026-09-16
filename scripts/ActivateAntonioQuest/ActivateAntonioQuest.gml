// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ActivateAntonioQuest(foodName, npcName, giveFood, giveLinen){
	
	var hasFood = (global.iHolding != noone) && (global.iHolding.object_index == food_obj) && (global.iHolding.foodName == foodName);
	var hasLinen = (global.iHolding != noone) && (global.iHolding.object_index == linen_obj);
	switch (global.questStatus[? antonio_obj])
	{
		case 0: //not started
		{
			//player already has the food
			if(giveFood)
			{
				instance_destroy(global.iHolding);
				global.iHolding = noone;
				global.questStatus[? antonio_obj] = 2;
				NewTextBox("This is exactly what I've been looking for!", 0);
			}
			else if (hasFood)
			{
				// The dog asks you to give it the food
				NewTextBox("You've got something tasty, don't you?", 0);
				global.questStatus[? antonio_obj] = 1;
			
			}
			else
			{
				//offer quest
				NewTextBox("Hey, I'm Antonio. I'm looking for something to eat. But not just anything.");
				NewTextBox("I need " + foodName + ". But not just any pasta.", 0);
				NewTextBox("The kind with sauteed onions and bell peppers and peas.");
				NewTextBox("Have you seen anything like that around here?");
				NewTextBox("I'd go looking for it myself, but I can't have people seeing me. It'd be over for us.");
				NewTextBox("So if you find any " + foodName + ", will you please bring it to me?");
				global.questStatus[? antonio_obj] = 1;
			}
		}break;
		
		case 1: //quest in progress
		{
			if(giveFood)
			{
				instance_destroy(global.iHolding);
				global.iHolding = noone;
				global.questStatus[? antonio_obj] = 2;
				NewTextBox("You found the pasta I was after!", 0);				
			}
			else if (hasFood)
			{
				NewTextBox("You've got something tasty, don't you?", 0);
			}
			else
			{
				//clue reminder
				NewTextBox(foodName + " always comes in a brown box with black scribbles on it.", 0);
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
				global.questStatus[? antonio_obj] = 4;
				
			}
			else if (hasLinen)
			{
				// advance quest
				NewTextBox("That is just what I need. Will you please give it to me?", 0);
				global.questStatus[? antonio_obj] = 3;
			}
			else
			{
				//clue reminder
				NewTextBox("I need to get back to the others, but I can't go around like this.", 0);
				global.questStatus[? antonio_obj] = 3;
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
				global.questStatus[? antonio_obj] = 4;
				
			}
			else if (hasLinen)
			{
				// advance quest
				NewTextBox("That is the perfect disguise. Will you please give it to me?", 0);
			}
			else
			{
				//clue reminder
				NewTextBox("I need to stay hidden from the humans, but I also need to get back to everyone.", 0);
			}			
		} break;
		case 4: //quest already completed
		{
			NewTextBox("Thanks for everything! I'm going to head back with the food now.",0,[],ReloadRoom);	
		} break;
		default: break;
	}
}