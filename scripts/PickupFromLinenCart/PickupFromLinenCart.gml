// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PickupFromLinenCart(linenCart){
	
	if(linenCart.itemCount > 0)
	{
		var item = instance_create_layer(x, y-10,"Instances", linen_obj, { image_index : linenCart.linenColorIndex });
		LinenPickup(item);
		with(linenCart)
		{
			linenColorList[linenColorIndex]--;
			itemCount--;
			
			if(linenColorList[linenColorIndex] == 0)
			{
				ToggleLinenColor(self, 1);
			}
		}
	}
}