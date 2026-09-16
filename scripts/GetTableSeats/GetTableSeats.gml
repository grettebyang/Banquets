// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetTableSeats() {
	var divisible = false;
	var change = -1;
	var count = 1;
	var i = 6;
	while(i <= 8 && i >= 4)
	{
		seatsPerTable = i;
		tableCount = seatCount div seatsPerTable;
		var tableSeatCounts = array_create(tableCount);
		if(tableCount <= maxTables)
		{
			remainder = seatCount % seatsPerTable;
			if(remainder == 0)
			{			
				divisible = true;
				for(var j = 0; j < tableCount; j++)
				{
					tableSeatCounts[j] = seatsPerTable;
				}
				break;
			}
		}		
		i += change*count;
		change *= -1;
		count++;
	}
	
	if(!divisible)
	{
		change = -1;
		count = 1;
		i = 6;
		while(i <= 8 && i >= 4)
		{
			seatsPerTable = i;
			tableCount = seatCount div seatsPerTable;
			var tableSeatCounts = array_create(tableCount);
			if(tableCount <= maxTables)
			{
				remainder = seatCount % seatsPerTable;
				if((seatsPerTable * tableCount) < seatCount && seatsPerTable < 8 && remainder <= tableCount)
				{
					for(var j = 0; j < tableCount; j++)
					{
						tableSeatCounts[j] = seatsPerTable;
					}			
					for(var k = 0; k < remainder; k++)
					{
						tableSeatCounts[k]++;
					}
					if(remainder > (tableCount div 2))
					{
						seatsPerTable++;
					}
					break;
				}
				else if((seatsPerTable * tableCount) > seatCount && seatsPerTable > 4 && ((seatsPerTable * tableCount) - seatCount) <= tableCount)
				{
					for(var j = 0; j < tableCount; j++)
					{
						tableSeatCounts[j] = seatsPerTable;
					}			
					for(var k = 0; k < ((seatsPerTable * tableCount) - seatCount); k++)
					{
						tableSeatCounts[k]--;
					}
					if(((seatsPerTable * tableCount) - seatCount) > (tableCount div 2))
					{
						seatsPerTable--;
					}
					break;
				}
			}
			i += change*count;
			change *= -1;
			count++;
		}
	}	
	return tableSeatCounts;
}