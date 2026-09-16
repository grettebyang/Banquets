depth = -9999;
x = 0;
y = 0;

enemies = global.battleEnemies;
units = [];
enemyUnits = array_create(array_length(enemies));
partyUnits = array_create(array_length(global.party));
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];
battleText = "";
turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 60;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;
currentItem = -1;
nextBattleState = -1;
textList = array_create(0);

//Make targetting cursor
cursor =
{
	activeUser : noone,
	activeTarget : noone,
	activeAction : -1,
	activeItem : -1,
	targetSide : -1,
	targetIndex : 0,
	targetAll : false,
	confirmDelay : 0,
	active : false,
	imageIndex : 0
}

function ActionItem(_itemStats, _subMenu, _action) constructor{ // Takes in an item's battle stats and an already existing action and creates a unique action for that item
	itemStats = _itemStats;
	subMenu = _subMenu;
	name = _action.name;
	description = _action.description;
	targetRequired = _action.targetRequired;
	targetEnemyByDefault = _action.targetEnemyByDefault;
	targetAll = _action.targetAll;
	userAnimation = _action.userAnimation;
	effectSprite = _action.effectSprite;
	effectOnTarget = _action.effectOnTarget;
	func = _action.func;
}

function Item(_name, _count, itemStats, _actions) constructor{
	name = _name;
	count = _count;
	defense = itemStats.defense;
	strength = itemStats.strength;
	range = itemStats.range;
	weight = itemStats.weight;
	actions = _actions;
}

//Make enemies
for(var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(room_width/(2+i), room_height/2, depth-10, battleUnitEnemy_obj, enemies[i]);
	with(enemyUnits[i])
	{
		//pinsDropped = irandom_range(2,20);
		//distance = irandom_range(15, 80);
	}
	array_push(units, enemyUnits[i]);
}

//Make player
for(var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x, y, depth-10, battleUnitPC_obj, global.party[i]);
	array_push(units, partyUnits[i]);
}

//Include stats from held item
items = array_create(0);
if(global.iHolding != noone)
{
	var itemActions = array_create(0);
	//add item actions to player's list of actions
	for(var i = 0; i < array_length(global.iHolding.entityBattleActions); i++)
	{
		var newAction = new ActionItem(
			global.iHolding.entityBattleStats,
			global.iHolding.entityName,
			global.iHolding.entityBattleActions[i]
		)
		array_push(itemActions, newAction);
	}
	array_push(items, new Item(global.iHolding.entityName, 1, global.iHolding.entityBattleStats, itemActions));
}
else if(global.iCart != noone)
{
	var cartActions = array_create(0);
	//add item actions to player's list of actions
	for(var i = 0; i < array_length(global.iCart.entityBattleActions); i++)
	{
		var newAction = new ActionItem(
			global.iCart.entityBattleStats,
			global.iCart.entityName,
			global.iCart.entityBattleActions[i]
		)
		array_push(cartActions, newAction);
	}
	array_push(items, new Item(global.iCart.entityName, 1, global.iCart.entityBattleStats, cartActions));
	//add cart's items' actions
	if(global.iCart.itemCount > 0 || global.iCart.cartStackItem != noone)
	{
		//table cart is the only cart that has items of differing battle stats
		var cartItem = global.iCart.cartItem;
		if(cartItem == chair_obj)
		{
			var itemActions = array_create(0);
			var newItem = instance_create_layer(-100,-100, "Instances", cartItem);
			for(var i = 0; i < array_length(newItem.entityBattleActions); i++)
			{
				var newAction = new ActionItem(
					newItem.entityBattleStats,
					newItem.entityName,
					newItem.entityBattleActions[i]
				)
				array_push(itemActions, newAction);
			}
			array_push(items, new Item(newItem.entityName, array_length(global.iCart.cartStackItem.stackItems), newItem.entityBattleStats, itemActions));	
			instance_destroy(newItem);
		}
		else if(cartItem == table_obj)//if cart is a table cart
		{
			for(var i = 0; i < array_length(global.iCart.tableList); i++)
			{
				var itemActions = array_create(0);
				if(global.iCart.tableList[i] > 0)
				{
					switch(i)
					{
						case 0 : cartItem = roundTable_obj; break;
						case 1 : cartItem = recTable_obj; break;
						case 2 : cartItem = hitopTable_obj; break;
						default : cartItem = roundTable_obj; break;
					}
					var newItem = instance_create_layer(-100,-100, "Instances", cartItem);
					for(var j = 0; j < array_length(newItem.entityBattleActions); j++)
					{
						var newAction = new ActionItem(
							newItem.entityBattleStats,
							newItem.entityName,
							newItem.entityBattleActions[j]
						)		
						array_push(itemActions, newAction);
					}
					array_push(items, new Item(newItem.entityName, global.iCart.tableList[i], newItem.entityBattleStats, itemActions));
					instance_destroy(newItem);
				}
			}
		}
		else
		{
			var newItem = instance_create_layer(-100,-100, "Instances", cartItem);
			var itemActions = array_create(0);
			for(var i = 0; i < array_length(newItem.entityBattleActions); i++)
			{
				var newAction = new ActionItem(
					newItem.entityBattleStats,
					newItem.entityName,
					newItem.entityBattleActions[i]
				)
				array_push(itemActions, newAction);
			}
			array_push(items, new Item(newItem.entityName, global.iCart.itemCount, newItem.entityBattleStats, itemActions));
			instance_destroy(newItem);
		}
	}
}

//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(_1, _2)
	{
		return _1.y - _2.y;
	});
}
RefreshRenderOrder();

function BattleStateSelectAction()
{
	battleText = "";
	if(!instance_exists(menu_obj))
	{
		//Get current unit
		var unit = unitTurnOrder[turn];
	
		//is the unit dead or unable to act?
		if(!instance_exists(unit)) || (unit.hp <= 0)
		{
			battleState = BattleStateVictoryCheck;
			exit;
		}
		else if(unit.paralysisTurns > 0) //if unit is paralyzed
		{
			unit.paralysisTurns--;
			battleText = string(unit.name) + " is paralyzed!";
			nextBattleState = BattleStateTurnProgression; //advance to the next turn
			battleState = BattleDialogue;
			exit;			
		}
	
		//Select an action to perform
		//BeginAction(unit.id, global.actionLibrary.attack, unit.id);
	
		//if unit is player controlled
		if(unit.object_index == battleUnitPC_obj)
		{
			//Compile the action menu
			var menuOptions = [];
			var subMenus = {};
			
			var actionList = unit.actions;
			for(var i = 0; i < array_length(actionList); i++)
			{					
				var action = actionList[i];
				var available = true;
				var nameAndCount = action.name;
				if(action.subMenu == -1)
				{
					array_push(menuOptions, [nameAndCount, MenuSelectAction, [unit, action, -1], available]);
				}
				else
				{
					//create or add to a submenu
					if(is_undefined(subMenus[$ action.subMenu]))
					{
						variable_struct_set(subMenus, action.subMenu, [[nameAndCount, MenuSelectAction, [unit, action, -1], available]]);
					}
					else
					{
						array_push(subMenus[$ action.subMenu], [nameAndCount, MenuSelectAction, [unit, action, -1], available]);
					}
				}
			}
			for(var j = 0; j < array_length(items); j++)
			{
				var curItem = items[j];
				if(curItem.count > 0)
				{
					for(var i = 0; i < array_length(curItem.actions); i++)
					{					
						var action = curItem.actions[i];
						var available = true;
						var nameAndCount = action.name;
						if(action.subMenu == -1)
						{
							array_push(menuOptions, [nameAndCount, MenuSelectAction, [unit, action, curItem], available]);
						}
						else
						{
							//create or add to a submenu
							if(is_undefined(subMenus[$ action.subMenu]))
							{
								variable_struct_set(subMenus, action.subMenu, [[nameAndCount, MenuSelectAction, [unit, action, curItem], available]]);
							}
							else
							{
								array_push(subMenus[$ action.subMenu], [nameAndCount, MenuSelectAction, [unit, action, curItem], available]);
							}
						}
					}
				}
			}
				
			//turn sub menus into an array
			var subMenusArray = variable_struct_get_names(subMenus);
			for(var i = 0; i < array_length(subMenusArray); i++)
			{
				//sort submenu if needed
				//(here)
					
				//add back option at the end of each submenu
				array_push(subMenus[$subMenusArray[i]], ["Back", MenuGoBack, -1, true]);
				//add submenu into main menu
				array_push(menuOptions, [subMenusArray[i], SubMenu, [subMenus[$ subMenusArray[i]]], true]);
			}
			
			Menu(x + 75, y + 120, menuOptions, , , 60);
		}
		else
		{
			//if unit is AI controlled:
			var enemyAction = unit.AIscript();
			if(enemyAction != -1) BeginAction(unit.id, enemyAction[0], enemyAction[1], -1);
		}
	}
}

function BeginAction(user, action, targets, item)
{
	currentUser = user;
	currentAction = action;
	currentTargets = targets;
	currentItem = item;
	currentUser.defense = 1;
	battleText = string_ext(action.description, [user.name]);
	if(!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with(user)
	{
		acting = true;
		//play user animation
		/*if(!is_undefined(action[$ action.userAnimation])) && (!is_undefined(user.sprites[$ action.userAnimation]))
		{
			sprite_index = sprites[$ action.userAnimation];
			image_index = 0;
		}*/
	}
	ActionBreak(BattleStatePerformAction);
}

function BattleDialogue() //Takes in an array of dialogue
{
	if(keyboard_check_pressed(ord("E")))
	{
		if(array_length(textList) > 0) 
		{
			battleText = array_pop(textList);
		}
		else
		{
			battleState = nextBattleState;
		}
	}
	keyboard_clear(ord("E"));
}

function BattleStateBreak() //Expand on these so that it takes in multiple dialogues and lets the player click through the text
{
	battleWaitTimeRemaining--;
	if(battleWaitTimeRemaining == 0) 
	{
		battleWaitTimeRemaining = battleWaitTimeFrames; 
		battleState = nextBattleState;
	}
}

function ActionBreak(state)
{
	battleWaitTimeRemaining = battleWaitTimeFrames;
	nextBattleState = state;
	battleState = BattleStateBreak;
}

function BattleStatePerformAction()
{
	//If animation is still playing
	if(currentUser.acting)
	{
		//when it ends, perform action effect if it exists
		//if(currentUser.image_index >= currentUser.image_number - 1)
		//{
			with(currentUser)
			{
				//sprite_index = sprites.idle;
				//image_index = 0;
				acting = false;
			}
			
			if(variable_struct_exists(currentAction, "effectSprite"))
			{
				 if(currentAction.effectOnTarget == MODE.ALWAYS) || ((currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1))
				 {
					 /*for(var i = 0; i < array_length(currentTargets); i++)
					 {
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth-1, battleEffect_obj, { sprite_index : currentAction.effectSprite }); 
					 }*/
				 }
				else //play it at 0,0
				{
					var effectSprite = currentAction.effectSprite
					if(variable_struct_exists(currentAction, "effectSpriteNoTarget")) effectSprite = currentAction.effectSpriteNoTarget;
					//instance_create_depth(x,y,depth-100, battleEffect_obj, { sprite_index : effectSprite });
				}
			}
			currentAction.func(currentUser, currentTargets, currentItem);
		//}
	}
	else //wait for delay and then end the turn
	{
		if(!instance_exists(battleEffect_obj))
		{
			battleWaitTimeRemaining--;
			if(battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
}

function BattleStateVictoryCheck()
{
	var remaining = array_filter(enemyUnits, function(element, index){
		return element.hp > 0;
	});
	var playerLeft = array_filter(partyUnits, function(element, index){
		return element.hp > 0;
	});
	if(array_length(remaining) == 0)
	{
		global.battleWon = true;
		battleText = string(partyUnits[0].name) + " wins!";
		array_push(textList, string(enemyUnits[0].name) + " dropped " + string(enemyUnits[0].pinsDropped) + " bobby pins");
		enemyUnits[0].battleWonScript();
		nextBattleState = ExitBattle;
		battleState = BattleDialogue;
	}
	else if(array_length(playerLeft) == 0)
	{
		game_restart();
	}
	else
	{
		battleState = BattleStateTurnProgression;
	}
}

function BattleStateTurnProgression()
{
	turnCount++;
	turn++;
	//Loop turns
	if(turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	battleState = BattleStateSelectAction;
}

function ExitBattle()
{
	for(var i = 0; i < array_length(global.battleEnemies); i++)
	{
		global.bobbyPins += global.battleEnemies[i].pinsDropped;
	}
	global.party[0].hp = partyUnits[0].hp;
	room_goto(global.previousRoom);
	global.targetX = global.previousCoord[0];
	global.targetY = global.previousCoord[1];
	array_delete(global.battleEnemies, 0, array_length(global.battleEnemies));
	global.battleCooldown = 180;
}

battleText = "A " + string(enemyUnits[0].name) + " approaches from " + string(enemyUnits[0].distance) + " inches";
ActionBreak(BattleStateSelectAction);
