// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BattleStats(){

function Action(_name, _description, _subMenu, _targetRequired, _targetEnemyByDefault, _targetAll, _userAnimation, _effectSprite, _effectOnTarget, _func) constructor{
	name = _name;
	description = _description;
	subMenu = _subMenu;
	targetRequired = _targetRequired;
	targetEnemyByDefault = _targetEnemyByDefault;
	targetAll = _targetAll;
	userAnimation = _userAnimation;
	effectSprite = _effectSprite;
	effectOnTarget = _effectOnTarget;	
	func = _func;
	itemStats = {};
}

//Instead, create constructors of each action
global.actionLibrary = 
{
	attack : new Action(
		"Attack",
		"{0} attacks!",
		-1,
		true,
		true,
		MODE.NEVER,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets, item)
		{
			var damage = ceil(user.strength + random_range(user.strength * .25, user.strength * .25))/targets[0].defense;
			with(targets[0]) 
			{
				hp = max(0, hp - damage);
				shakeRemain = 5;
				shakeLength = 10;
				shakeMagnitude = 5;
			}
			if(targets[0].name == "wasp")
			{
				with(user) hp = max(0, hp - 5);
			}
		}
	),
	whack : new Action(
		"Whack",
		"{0} whacks the enemy",
		-1,
		true,
		true,
		MODE.VARIES,
		noone,
		noone,
		MODE.VARIES,
		function(user, targets, item)
		{
			if(item.range >= targets[0].distance)
			{
				var prob = irandom(60 + item.weight);
				if(prob <= 60)
				{
					var damage = ceil(item.strength + random_range(item.strength * .25, item.strength * .25));
					with(targets[0]) 
					{
						hp = max(0, hp - damage);
						shakeRemain = 5;
						shakeLength = 10;
						shakeMagnitude = 5;					
					}
				}
				else
				{
					battle_obj.battleText = "Missed!";
				}
			}
			else
			{
				battle_obj.battleText = "But the enemy is out of range!";
			}
		}
	),
	toss : new Action(
		"Throw",
		"{0} throws the item at the enemy",
		-1,
		true,
		true,
		MODE.VARIES,
		noone,
		noone,
		MODE.VARIES,
		function(user, targets, item)
		{
			var prob = irandom(30 + item.weight);
			if(prob <= 30)
			{
				var damage = ceil(item.strength + random_range(item.strength * .25, item.strength * .25));
				with(targets[0]) 
				{
					hp = max(0, hp - damage);
					shakeRemain = 5;
					shakeLength = 10;
					shakeMagnitude = 5;					
				}
			}
			else
			{
				battle_obj.battleText = "Missed!";
			}
			with(item) count--;
		}
	),
	shield : new Action(
		"Shield",
		"{0} blocks the attack",
		-1,
		false,
		false,
		MODE.NEVER,
		noone,
		noone,
		MODE.NEVER,
		function(user, targets, item)
		{
			user.defense = item.defense;
		}
	),
	ram : new Action(
		"Ram",
		"{0} rams into the enemy",
		-1,
		true,
		true,
		MODE.VARIES,
		noone,
		noone,
		MODE.VARIES,
		function(user, targets, item)
		{
			var prob = irandom(60 + item.weight);
			if(prob <= 60)
			{
				var damage = ceil(item.strength + random_range(item.strength * .25, item.strength * .25));
				with(targets[0]) 
				{
					hp = max(0, hp - damage);
					shakeRemain = 5;
					shakeLength = 10;
					shakeMagnitude = 5;					
				}
			}
			else
			{
				battle_obj.battleText = "Missed!";
			}
		}		
	),
	vacuum : new Action(
		"Vacuum",
		"{0} vacuums up the enemy",
		-1,
		true,
		true,
		MODE.VARIES,
		noone,
		noone,
		MODE.VARIES,
		function(user, targets, item)
		{
			var prob = irandom(10 + item.weight);
			if(prob <= 10)
			{
				with(targets[0]) 
				{
					hp = 0;
					shakeRemain = 5;
					shakeLength = 10;
					shakeMagnitude = 5;					
				}
			}
			else
			{
				battle_obj.battleText = "Missed!";
			}
		}
	),
	iron : new Action(
		"Iron",
		"{0} smashes the enemy with the iron!",
		-1,
		true,
		true,
		MODE.NEVER,
		noone,
		noone,
		MODE.VARIES,
		function(user, targets, item)
		{
			var prob = irandom(40 + item.weight);
			if(prob <= 40)
			{
				var damage = ceil(item.strength + random_range(item.strength * .25, item.strength * .25));
				with(targets[0]) 
				{
					hp = max(0, hp - damage);
					shakeRemain = 5;
					shakeLength = 10;
					shakeMagnitude = 5;					
				}
			}
			else
			{
				battle_obj.battleText = "Missed!";
			}
		}		
	),
	run : new Action(
		"Run",
		"{0} tries to get away...",
		-1,
		false,
		false,
		MODE.NEVER,
		noone,
		noone,
		MODE.VARIES,
		function(user, targets, item)
		{
			var prob = irandom(100);
			if(prob <= 40)
			{
				battle_obj.ExitBattle();
			}
			else
			{
				battle_obj.battleText = "But her legs are paralyzed in fear";
			}
		}		
	),
	intimidate : new Action(
		"Intimidate",
		"{0} stands up tall and intimidating.",
		-1,
		true,
		true,
		MODE.ALWAYS,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets)
		{
			with(targets[0]) 
			{
				defense -= 10;
			}
		}		
	),
	screech : new Action(
		"Screech",
		"{0} unfolds its legs, making an\near-piercing screech.\nGrette covers her ears.",
		-1,
		true,
		true,
		MODE.ALWAYS,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets)
		{
			with(targets[0]) 
			{
				paralysisTurns = 1;
			}
		}		
	),
	splash : new Action(
		"Splash",
		"{0} splashes leftover chafing water onto Grette.\nIt loosens her grip.",
		-1,
		true,
		true,
		MODE.ALWAYS,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets)
		{
			with(user)
			{
				hp += 2;
			}
		}
	),
	reflect : new Action(
		"Reflect",
		"{0} reflects light into Grette's eyes.\nIt lowers her defense.",
		-1,
		true,
		true,
		MODE.ALWAYS,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets)
		{
			with(targets[0])
			{
				defense -= .5;
			}
		}
	),
	dance : new Action(
		"Dance",
		"{0} dances around. Grette's impressed. Her defense is lowered.",
		-1,
		true,
		true,
		MODE.ALWAYS,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets)
		{
			with(targets[0])
			{
				defense -= .5;
			}
		}
	),
	fall : new Action(
		"Fall",
		"{0} falls on top of Grette, flattening her.",
		-1,
		true,
		true,
		MODE.ALWAYS,
		noone,
		noone,
		MODE.ALWAYS,
		function(user, targets)
		{
			with(targets[0])
			{
				strength -= 2;
			}
		}
	)
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

global.party =
[
	{
		name : "Grette",
		hp : 100,
		hpMax : 100,
		strength : 6,
		defense : 1,
		actions : [global.actionLibrary.attack, global.actionLibrary.run]
	}
]

global.enemies =
{
	wasp :
	{
		name : "wasp",
		hp : 30,
		hpMax : 30,
		strength : 5,
		defense : 1,
		sprite_index : wasp_spr,
		actions : [global.actionLibrary.attack],
		pinsDropped : irandom_range(2,20),
		distance : irandom_range(15, 80),
		AIscript : function()
		{	
			//attack
			var action = actions[0];
			var possibleTargets = array_filter(battle_obj.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];
		},
		battleWonScript : function()
		{
			
		}
	},
	
	rectangleTable :
	{
		name : "Rectangle Table",
		hp : 5,
		hpMax : 50,
		strength : 50,
		defense : 30,
		sprite_index : recTableHorizontal_spr,
		actions : [global.actionLibrary.attack, global.actionLibrary.intimidate, global.actionLibrary.screech],
		pinsDropped : 0,
		distance : 0,
		AIscript : function()	
		{
			//attack
			var action = choose(actions[0], actions[1], actions[2]);
			var possibleTargets = array_filter(battle_obj.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];			
		},
		battleWonScript : function()
		{
			global.recsPickUp = 3;
		}
	},
	
	rectangleFoodChafer :
	{
		name : "Rectangle Food Chafer",
		hp : 5,
		hpMax : 50,
		strength : 50,
		defense : 30,
		sprite_index : recFoodChafer_spr,
		actions : [global.actionLibrary.attack, global.actionLibrary.splash, global.actionLibrary.reflect],
		pinsDropped : 0,
		distance : 0,
		AIscript : function()	
		{
			//attack
			var action = choose(actions[0], actions[1], actions[2]);
			var possibleTargets = array_filter(battle_obj.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];			
		},
		battleWonScript : function()
		{
			global.recsPickUp = 3;
		}
	},
	
	bigTable :
	{
		name : "Big Table",
		hp : 50,
		hpMax : 50,
		strength : 50,
		defense : 30,
		sprite_index : recTableHorizontal_spr,
		actions : [global.actionLibrary.attack, global.actionLibrary.intimidate, global.actionLibrary.screech],
		pinsDropped : 0,
		distance : 0,
		AIscript : function()	
		{
			//attack
			var action = choose(actions[0], actions[1], actions[2]);
			var possibleTargets = array_filter(battle_obj.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];			
		},
		battleWonScript : function()
		{
			global.bossesDefeated[? bigTable_obj] = true;
		}
	},
	
	bigChafer :
	{
		name : "Big Food Chafer",
		hp : 50,
		hpMax : 50,
		strength : 50,
		defense : 30,
		sprite_index : recFoodChafer_spr,
		actions : [global.actionLibrary.attack, global.actionLibrary.splash, global.actionLibrary.reflect],
		pinsDropped : 0,
		distance : 0,
		AIscript : function()	
		{
			//attack
			var action = choose(actions[0], actions[1], actions[2]);
			var possibleTargets = array_filter(battle_obj.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];			
		},
		battleWonScript : function()
		{
			global.bossesDefeated[? bigChafer_obj] = true;
		}
	},
	
	danceFloor :
	{
		name : "Dance Floor",
		hp : 5,
		hpMax : 50,
		strength : 50,
		defense : 30,
		sprite_index : danceFloor_spr,
		actions : [global.actionLibrary.attack, global.actionLibrary.dance, global.actionLibrary.fall],
		pinsDropped : 0,
		distance : 0,
		AIscript : function()	
		{
			//attack
			var action = choose(actions[0], actions[1], actions[2]);
			var possibleTargets = array_filter(battle_obj.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];			
		},
		battleWonScript : function()
		{
			global.bossesDefeated[? danceFloor_obj] = true;
		}
	}	
	
}



}