// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LoadRoom(){
	
	if(file_exists(room_get_name(room) + "savedroom.sav"))
	{
		//erase current room state
		with(entity_obj)
		{
			if(!grabbed && !withPlayer && !entityTrueObject)
			{
				instance_destroy();
			}
		}
		with(wasp_obj)
		{
			instance_destroy();
		}
	
		var _buffer = buffer_load(room_get_name(room) + "savedroom.sav");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		var loadData = json_parse(_string);
		
		while(array_length(loadData) > 0)
		{
			var loadEntity = array_pop(loadData);
			var newObj = instance_create_layer(0,0,"Instances",asset_get_index(loadEntity.obj));
			with(newObj)
			{
				x = loadEntity.x;
				y = loadEntity.y;
				image_index = loadEntity.image_index;
				sprite_index = loadEntity.sprite_index;
				depth = loadEntity.depth;
				
				if(object_get_parent(asset_get_index(loadEntity.obj)) == table_obj)
				{
					steamed = loadEntity.steamed;
					tableLinen = loadEntity.tableLinen;
					chairCount = loadEntity.chairCount;
					rounds = loadEntity.rounds;
					entityActive = loadEntity.entityActive;
					entityActivatable = loadEntity.entityActivatable;
					entityPickup = loadEntity.entityPickup;
					entitySprite = loadEntity.entitySprite;
					rotateIndex = loadEntity.rotateIndex;
					tableFluff = loadEntity.tableFluff;
					doneIndex = loadEntity.doneIndex;
					
					//Create the table's chairs
					if(chairCount > 0)
					{
						var tableChairs = loadEntity.chairs;
						var newChairList = array_create(0);
						
						while(array_length(tableChairs) > 0)
						{
							var chairEntity = array_pop(tableChairs);
							var newChair = instance_create_layer(0,0,"Instances",asset_get_index(chairEntity.obj));
							with(newChair)
							{
								x = chairEntity.x;
								y = chairEntity.y;
								image_index = chairEntity.image_index;
								sprite_index = chairEntity.sprite_index;
								depth = chairEntity.depth;
								itemCount = chairEntity.itemCount;
								onCart = chairEntity.onCart;
								chairCover = chairEntity.chairCover;	
								entityPickup = chairEntity.entityPickup;
								entityStackable = chairEntity.entityStackable;
								entityActive = chairEntity.entityActive;
								entityCollision = chairEntity.entityCollision;
							
								chairTable = newObj;
								
								array_push(newChairList, newChair);
							}
						}
						chairList = newChairList;
						//ArrangeChairs(newObj, false);
					}
					
					//Create the table's creases
					if(!steamed)
					{
						var tableCreases = loadEntity.creases;
						
						while(array_length(tableCreases) > 0)
						{
							var creaseEntity = array_pop(tableCreases);
							var newCrease = instance_create_layer(0,0,"Instances",asset_get_index(creaseEntity.obj));
							with(newCrease)
							{
								x = creaseEntity.x;
								y = creaseEntity.y;
								sprite_index = creaseEntity.sprite_index;
								image_index = creaseEntity.image_index;
								depth = creaseEntity.depth;
								tableInstance = newObj;
							}
						}
					}
				}
				else if(asset_get_index(loadEntity.obj) == chair_obj)
				{
					itemCount = loadEntity.itemCount;
					chairCover = loadEntity.chairCover;	
					entityPickup = loadEntity.entityPickup;
					entityStackable = loadEntity.entityStackable;
					entityActive = loadEntity.entityActive;
					entityCollision = loadEntity.entityCollision;
					
					//Create stack chairs
					if(itemCount > 0)
					{
						var xx = loadEntity.x;
						var yy = loadEntity.y;
						var newStackItems = [id];
						for(var i = 1; i <= itemCount; i++)
						{
							newStackItems[i] = instance_create_layer(0,0,"Instances",chair_obj);
							with(newStackItems[i])
							{
								x = xx;
								y = yy - 2*i;
								depth = loadEntity.depth - i;
								persistent = true;
								entityCollision = false;
								entityActive = false;
								entityStackable = true;
							}
						}
						stackItems = newStackItems;
					}
					
					//Create chair cart
					if(struct_exists(loadEntity.chairCart, "obj"))
					{
						var cart = loadEntity.chairCart;
						var newCart = instance_create_layer(0,0,"Instances",asset_get_index(cart.obj));
						with(newCart)
						{
							x = cart.x;
							y = cart.y;
							image_index = cart.image_index;
							sprite_index = cart.sprite_index;
							depth = cart.depth;
							itemCount = cart.itemCount;
							stackItems = cart.stackItems;
							entityActive = cart.entityActive;
							entityActivatable = cart.entityActivatable;
							cartStackItem = newObj;
						}
						onCart = newCart;
					}
				}
				else if(object_get_parent(asset_get_index(loadEntity.obj)) == genCart_obj)
				{
					itemCount = loadEntity.itemCount;
					stackItems = loadEntity.stackItems;
					entityActive = loadEntity.entityActive;
					entityActivatable = loadEntity.entityActivatable;
					linenColorList = loadEntity.linenColorList;
					linenColorIndex = loadEntity.linenColorIndex;
					tableIndex = loadEntity.tableIndex;
					tableList = loadEntity.tableList;
				}
				else if(asset_get_index(loadEntity.obj) == linen_obj)
				{
					itemCount = loadEntity.itemCount;
					entityPickup = loadEntity.entityPickup;
					entityStackable = loadEntity.entityStackable;
					entityActive = loadEntity.entityActive;
					entityActivatable = loadEntity.entityActivatable;
					entityCollision = loadEntity.entityCollision;
					linenColor = loadEntity.linenColor;
					
					//Create stack linens
					if(itemCount > 0)
					{
						var xx = loadEntity.x;
						var yy = loadEntity.y;
						var stackLinens = loadEntity.stackLinens;
						var newStackItems = [id];
						
						for(var i = 1; i <= itemCount; i++)
						{
							var linenEntity = stackLinens[i-1];
							newStackItems[i] = instance_create_layer(0,0,"Instances",linen_obj);
							with(newStackItems[i])
							{
								x = xx;
								y = yy - 2*i;
								depth = loadEntity.depth - i;
								persistent = true;
								image_index = linenEntity.image_index;
								entityCollision = false;
								entityActive = false;
								entityStackable = true;
								linenColor = linenEntity.linenColor;
							}
						}
						stackItems = newStackItems;
					}					
				}
				else if(asset_get_index(loadEntity.obj) == food_obj)
				{
					foodName = loadEntity.foodName;
					entityActive = loadEntity.entityActive;
					entityActivatable = loadEntity.entityActivatable;
				}
				else if(object_get_parent(asset_get_index(loadEntity.obj)) == foodChafer_obj) 
				{
					onTable = loadEntity.onTable;
					entityActive = loadEntity.entityActive;
					entityActivatable = loadEntity.entityActivatable;
				}
				else if(asset_get_index(loadEntity.obj) == wasp_obj)
				{
					engaged = loadEntity.engaged;
					coolDown = 180;
				}
				else if(asset_get_index(loadEntity.obj) == vacuum_obj)
				{
					vacuumOn = loadEntity.vacuumOn;
					pluggedIn = loadEntity.pluggedIn;
					vacuumOutlet = loadEntity.vacuumOutlet;
					entityActive = loadEntity.entityActive;
					entityActivatable = loadEntity.entityActivatable;
				}
				else if(asset_get_index(loadEntity.obj) == vacuumDirt_obj)
				{
					if(loadEntity.x < 0 && loadEntity.y < 0)
					{
						var xx = 0;
						var yy = 0;
						var spawnArea = layer_tilemap_get_id(layer_get_id("Floor"));
						xx = (irandom(room_width) div TILE_SIZE) * TILE_SIZE + 8;
						yy = (irandom(room_height) div TILE_SIZE) * TILE_SIZE + 8;
						while(!tilemap_get_at_pixel(spawnArea, xx, yy))
						{
							xx = (irandom(room_width) div TILE_SIZE) * TILE_SIZE + 8;
							yy = (irandom(room_height) div TILE_SIZE) * TILE_SIZE + 8;
						}
						x = xx;
						y = yy;		
						depth = layer_get_depth(layer_get_id("Floor"))-1;
					}
				}
				else if(asset_get_index(loadEntity.obj) == weddingGuest_obj)
				{
					skinColor = loadEntity.skinColor;
					hairColor = loadEntity.hairColor;
					dressColor = loadEntity.dressColor;
					gender = loadEntity.gender;
					spriteSet = loadEntity.spriteSet;
				}
				else if(asset_get_index(loadEntity.obj) == kitchenLeftovers_obj)
				{
					foodName = loadEntity.foodName;
				}
			}
		}
		
		//if the room is in use for the day, make the room in the event state, add guests, etc.
		RoomEventState();
		
		//If the Spruce room is in use and the current room is rKitchen
		//Could put this in room creation code for rKitchen?
		SpruceKitchenEventDay();
		
		show_debug_message("Room loaded! " );
	}
}