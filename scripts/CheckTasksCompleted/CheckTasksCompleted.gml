// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckTasksCompleted(){
	var tasksCompleted = true;
	for(var i = 0; i < array_length(global.dailyBEOs); i++)
	{
		if(!global.dailyBEOs[i][0].ready)
		{
			tasksCompleted = false;
			//return tasksCompleted;
		}
	}
	for(var j = 0; j < array_length(global.dailyCleaning); j++)
	{
		if(!global.dailyCleaning[j].ready)
		{
			tasksCompleted = false;
		}
	}
	return tasksCompleted;
}