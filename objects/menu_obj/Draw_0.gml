//draw_sprite_stretched(textBox_spr, 0, x, y, widthFull, heightFull);
draw_set_color(c_white);
draw_set_font(beoText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var desc = description != -1;
var scrollPush = max(0, hover - (visibleOptionsMax-1));

for(var l = 0; l < (visibleOptionsMax + desc); l++)
{
	if(l >= array_length(options)) break;
	draw_set_color(c_white);
	if(l == 0) && (desc)
	{
		draw_text(x + xmargin, y + ymargin, description);
	}
	else
	{
		var optionToShow = l - desc + scrollPush;
		var str = options[optionToShow][0];
		if(hover == optionToShow - desc)
		{
			draw_set_color(c_yellow);
		}
		if(options[optionToShow][3] == false) draw_set_color(c_gray);
		draw_text(x + xmargin, y + ymargin + l * heightLine, str);
	}
}

if(visibleOptionsMax < array_length(options)) && (hover < array_length(options)-1)
{
	draw_sprite(downArrow_spr, 0, x + widthFull * .5, y + heightFull - 7);
}

