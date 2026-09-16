// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Menu(_x, _y, _options, _description = -1, width = undefined, height = undefined){
	
	with(instance_create_depth(_x, _y, -99999, menu_obj))
	{
		options = _options;
		description = _description;
		var optionsCount = array_length(options);
		visibleOptionsMax = optionsCount;
		
		//Set up size
		xmargin = 10;
		ymargin = 8;
		draw_set_font(fText);
		heightLine = 12;
		
		//Auto width
		if(width == undefined)
		{
			width = 1;
			if(description != -1) width = max(width, string_width(description));
			for(var i = 0; i < optionsCount; i++)
			{
				width = max(width, string_width(options[i][0]));	
			}
			widthFull = width + xmargin * 2;
		} else widthFull = width;
		
		//Auto height
		if(height == undefined)
		{
			height = heightLine * (optionsCount + (description != -1));
			heightFull = height + ymargin * 2;
		}
		else
		{
			heightFull = height;
			//scrolling
			if(heightLine * (optionsCount + (description != -1)) > height - (ymargin*2))
			{
				scrolling = true;
				visibleOptionsMax = (height - ymargin * 2) div heightLine;
			}
		}
		
	}
	
}

function SubMenu(_options)
{
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function MenuSelectAction(user, action, item)
{
	with(menu_obj) active = false;
	
	//Activate the targetting cursor if needed, or simply begin the action
	with(battle_obj) 
	{
		if(action.targetRequired)
		{
			with(cursor)
			{
				active = true;
				activeItem = item;
				activeAction = action;
				targetAll = action.targetAll;
				if(targetAll == MODE.VARIES) targetAll = true;
				activeUser = user;
				
				//Which side to target by default
				if(action.targetEnemyByDefault) //target enemy by default
				{
					targetIndex = 0;
					targetSide = battle_obj.enemyUnits;
					activeTarget = battle_obj.enemyUnits[targetIndex];
				}
				else //target self by default
				{
					targetSide = battle_obj.partyUnits;
					activeTarget = activeUser;
					var findSelf = function(element)
					{
						return (element == activeTarget);
					}
					targetIndex = array_find_index(battle_obj.partyUnits, findSelf);
				}
			}
		}
		else
		{
			BeginAction(user, action, -1, item);
			with(menu_obj) instance_destroy();
		}
	}
}