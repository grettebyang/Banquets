// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveGame(){
	
	//Create save map
	var map = ds_map_create();
	
	map[? "room"] = room;
	
	var _string = json_encode(map);
	SaveStringToFile("save" + string(global.gameSaveSlot) + ".sav", _string);
	show_debug_message(_string);
	
	ds_map_destroy(map);
	show_debug_message("Game saved!");
	
}

function SaveStringToFile(_filename, _string)
{
	var buffer = buffer_create( string_byte_length( _string ) + 1, buffer_fixed, 1 );
	buffer_write( buffer, buffer_string, _string );
	buffer_save( buffer, _filename);
	buffer_delete( buffer);
	
	
	
}