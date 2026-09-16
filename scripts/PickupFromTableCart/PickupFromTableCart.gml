// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PickupFromTableCart(tableCart){
	
	switch(tableCart.tableIndex)
	{
		case 0 : var newTable = roundTable_obj; break;
		case 1 : var newTable = recTable_obj; break;
		case 2 : var newTable = hitopTable_obj; break;
		default : var newTable = roundTable_obj; break;
	}

	if(tableCart.itemCount > 0)
	{
		var item = instance_create_layer(x, y-10,"Instances", newTable);
		TablePickup(item);
		with(tableCart)
		{
			tableList[tableIndex]--;
			itemCount--;
			
			if(tableList[tableIndex] == 0)
			{
				ToggleTableType(self, 1);
			}
		}
		show_debug_message("picked up " + string(object_get_name(newTable)));
	}

}