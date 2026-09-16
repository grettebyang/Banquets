// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveRoom(){
	
	//make save array
	var saveData = array_create(0);
	
	//for every instance, create a struct and add it to the array
	//Won't save anything that you're holding or is a True Object (an object that stays in the room permanently)
	with(table_obj)
	{
		if(!grabbed && !entityTrueObject)
		{
			//save table chairs
			var tableChairList = array_create(0);
			if(chairCount > 0)
			{
				for(var i = 0; i < chairCount; i++)
				{
					with(chairList[i])
					{
						var tableChair =
						{
							obj : object_get_name(object_index),
							x : x,
							y : y,
							sprite_index : sprite_index,
							image_index : image_index,
							depth : depth,
							itemCount : itemCount,
							onCart : onCart,
							chairCover : chairCover,
							entityPickup : entityPickup,
							entityStackable : entityStackable,
							entityActive : entityActive,
							entityCollision : entityCollision
						}
						array_push(tableChairList, tableChair);
					}
				}
				
			}
			
			//save crease sections
			var tableCreases = array_create(0);
			if(!steamed)
			{
				var creaseList = ds_list_create();
				instance_place_list(x, y, creaseSection_obj, creaseList, true);
				for(var i = 0; i < ds_list_size(creaseList); i++)
				{
					with(creaseList[| i])
					{
						var tableCrease = 
						{
							obj : object_get_name(object_index),
							x : x,
							y : y,
							sprite_index : sprite_index,
							image_index : image_index,
							depth : depth
						}
						array_push(tableCreases, tableCrease);
					}
				}
				ds_list_destroy(creaseList);
			}
			
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				steamed : steamed,
				tableLinen : tableLinen,
				chairCount : chairCount,
				rounds : rounds,
				entityActive : entityActive,
				entityActivatable : entityActivatable,
				entityPickup : entityPickup,
				entitySprite : entitySprite,
				rotateIndex : rotateIndex,
				tableFluff : tableFluff,
				doneIndex : doneIndex,
				
				chairs : tableChairList,
				creases : tableCreases
			}
			array_push(saveData, saveEntity);
		}
	}
	with(chair_obj)
	{
		if(!grabbed && chairTable == noone && !persistent && !withPlayer && !entityTrueObject)
		{
			var cartEntity = {};
			if(onCart != noone)
			{
				with(onCart)
				{
					cartEntity =
					{
						obj : object_get_name(object_index),
						y : y,
						x : x,
						image_index : image_index,
						sprite_index : sprite_index,
						depth : depth,
						itemCount : itemCount,
						stackItems : stackItems,
						entityActive : entityActive,
						entityActivatable : entityActivatable
					}
				}
			}
			
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				itemCount : itemCount,
				onCart : onCart,
				chairCover : chairCover,
				entityPickup : entityPickup,
				entityStackable : entityStackable,
				entityActive : entityActive,
				entityActivatable : entityActivatable,
				entityCollision : entityCollision,
				chairCart : cartEntity
			}
			array_push(saveData, saveEntity);
		}
	}
	with(genCart_obj)
	{
		if(!grabbed && cartStackItem == noone && !entityTrueObject)
		{
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				itemCount : itemCount,
				stackItems : stackItems,
				entityActive : entityActive,
				entityActivatable : entityActivatable,
				linenColorList : linenColorList,
				linenColorIndex : linenColorIndex,
				tableIndex : tableIndex,
				tableList : tableList
			}
			array_push(saveData, saveEntity);
		}
	}
	with(linen_obj)
	{
		if(!grabbed && !persistent && !entityTrueObject)
		{
			//save stack linens
			var linenList = array_create(0);
			if(itemCount > 0)
			{
				for(var i = 1; i <= itemCount; i++)
				{
					with(stackItems[i])
					{
						var stackLinen =
						{
							obj : object_get_name(object_index),
							image_index : image_index,
							linenColor : linenColor
						}
						array_push(linenList, stackLinen);
					}
				}
				
			}
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				itemCount : itemCount,
				entityPickup : entityPickup,
				entityStackable : entityStackable,
				entityActive : entityActive,
				entityActivatable : entityActivatable,
				entityCollision : entityCollision,
				linenColor : linenColor,
				
				stackLinens : linenList
			}
			array_push(saveData, saveEntity);			
		}
	}
	with(foodChafer_obj)
	{
		if(!grabbed && !entityTrueObject)
		{
			var saveEntity = 
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				onTable : onTable,
				entityActive : entityActive,
				entityActivatable : entityActivatable
			}
			array_push(saveData, saveEntity);
		}
	}
	with(food_obj)
	{
		if(!grabbed && !entityTrueObject)
		{
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				foodName : foodName,
				entityActive : entityActive,
				entityActivatable : entityActivatable
			}
			array_push(saveData, saveEntity);
		}
	}
	with(wasp_obj)
	{
		if(engaged)
		{
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				engaged : engaged
			}
			array_push(saveData, saveEntity);
		}
	}
	with(vacuum_obj)
	{
		if(!grabbed && !entityTrueObject)
		{
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth,
				vacuumOn : vacuumOn,
				pluggedIn : pluggedIn,
				vacuumOutlet : vacuumOutlet,
				entityActive : entityActive,
				entityActivatable : entityActivatable
			}
			array_push(saveData, saveEntity);
		}		
	}
	with(vacuumDirt_obj)
	{
		var saveEntity =
		{
			obj : object_get_name(object_index),
			y : y,
			x : x,
			image_index : image_index,
			sprite_index : sprite_index,
			depth : depth
		}
		array_push(saveData, saveEntity);		
	}
	with(weddingGuest_obj)
	{
		var saveEntity =
		{
			obj : object_get_name(object_index),
			y : y,
			x : x,
			image_index : image_index,
			sprite_index : sprite_index,
			depth : depth,
			skinColor : skinColor,
			hairColor : hairColor,
			dressColor : dressColor,
			gender : gender,
			spriteSet : spriteSet
		}
		array_push(saveData, saveEntity);			
	}
	with(kitchenLeftovers_obj)
	{
		var saveEntity =
		{
			obj : object_get_name(object_index),
			y : y,
			x : x,
			image_index : image_index,
			sprite_index : sprite_index,
			depth : depth,
			foodName : foodName
		}
		array_push(saveData, saveEntity);		
	}
	with(kitchenDessert_obj)
	{
		var saveEntity =
		{
			obj : object_get_name(object_index),
			y : y,
			x : x,
			image_index : image_index,
			sprite_index : sprite_index,
			depth : depth,
			foodName : foodName
		}
		array_push(saveData, saveEntity);		
	}
	with(danceFloor_obj)
	{
		if(!grabbed && !entityTrueObject)
		{
			var saveEntity =
			{
				obj : object_get_name(object_index),
				y : y,
				x : x,
				image_index : image_index,
				sprite_index : sprite_index,
				depth : depth
			}
			array_push(saveData, saveEntity);		
		}
	}
	
	//turn all the data into a JSON string and save it via a buffer
	var _string = json_stringify(saveData);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, string(room_get_name(room)) + "savedroom.sav");
	buffer_delete(_buffer);
	
	show_debug_message("Room saved! " + _string);
}