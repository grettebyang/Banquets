// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GiveFood(foodName){

	if(activate.favoriteFood == foodName)
	{
		script_execute_ext(activate.entityActivateScript, [foodName, activate.npcName, true, false]);
	}
	else
	{
		NewTextBox("No, thank you. It's your food.", 0);
	}

}