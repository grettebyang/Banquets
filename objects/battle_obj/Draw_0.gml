var unitWithCurrentTurn = unitTurnOrder[turn].id;

//Draw ui boxes
draw_sprite_stretched(textBox_spr, 0, x+75, y+120, 245, 60);
draw_sprite_stretched(textBox_spr, 0, x, y+120, 74, 60);

//Positions
#macro COLUMN_ENEMY 10
#macro COLUMN_NAME 10
#macro COLUMN_HP 160

//Draw headings
draw_set_font(beoText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
var drawLimit = 3;
var drawn = 0;

//Draw party info
for(var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var char = partyUnits[i];
	if(char.id == unitWithCurrentTurn) draw_set_color(c_yellow);
	if(char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME,y+140+(i*15),char.name);
	
	draw_set_color(c_white);
	if(char.hp < (char.hpMax * .5)) draw_set_color(c_orange);
	if(char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME,y+155+(i*15),"HP: " + string(char.hp) + "/" + string(char.hpMax));
	
	draw_set_color(c_white);
}

//Draw target cursor
if(cursor.active)
{
	with(cursor)
	{
		imageIndex += sprite_get_speed(downArrow_spr) / FRAME_RATE;
		if(activeTarget != noone)
		{
			if(!is_array(activeTarget))
			{
				draw_sprite(downArrow_spr, imageIndex, activeTarget.x, activeTarget.y-16);
			}
			else
			{
				//draw_set_alpha(sin(get_timer()/50000)+1);
				for(var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(downArrow_spr, imageIndex, activeTarget[i].x, activeTarget[i].y-16);
				}
				draw_set_alpha(1);
			}
		}
	}
}

//Draw battle text
if(battleText != "")
{
	var w = string_width(battleText)+20;
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text(x+85,y+128,battleText);
}
