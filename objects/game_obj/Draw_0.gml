if(!instance_exists(global.activatePrompt))
{
	global.activatePrompt = noone;
}
if(global.iCart == noone && global.activatePrompt != noone)
{
	draw_set_font(beoText);
	draw_set_color(c_white);
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	draw_text(global.activatePrompt.x, global.activatePrompt.y-32, global.activatePrompt.entityPromptText);
	draw_sprite(ePrompt_spr, 0, global.activatePrompt.x, global.activatePrompt.y-16);
}


