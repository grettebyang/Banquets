// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewTextBox(){ //argument[0] is the message, argument[1] is the image_index of the textbox sprite, argument[2] is the array of responses, argument[3] is the script that contains the responses
	var obj;
	if(instance_exists(text_obj))
	{
		obj = textQueued_obj;
	}
	else
	{
		obj = text_obj;
	}
	
	with(instance_create_layer(0,0,"Instances", obj))
	{
		mess = argument[0];
		if(instance_exists(other))
		{
			originInstance = other.id;
		}
		else
		{
			originInstance = noone;
		}
		
		if(argument_count > 1) 
		{
			background = argument[1];
		}
		else 
		{
			background = 1;
		}
		
		if(argument_count > 2 && array_length(argument[2]) > 0)
		{
			//trim markers from responses
			dialogueResponseScript = argument[3];
			responses = [];
			array_copy(responses, 0, argument[2], 0, array_length(argument[2]));
			for(var i = 0; i < array_length(responses); i++)
			{
				var markerPosition = string_pos(":", responses[i]);
				responseScripts[i] = string_copy(responses[i],1,markerPosition-1);
				responseScripts[i] = real(responseScripts[i]);
				responses[i] = string_delete(responses[i],1,markerPosition);
				breakpoint = 10;
			}
		}
		else if(argument_count > 2 && array_length(argument[2]) == 0)
		{
			responses = [-1];
			responseScripts = [-1];
			dialogueResponseScript = argument[3];
		}
		else
		{
			responses = [-1];
			responseScripts = [-1];
			dialogueResponseScript = -1;
		}
		
		// Make new lines when text is too wide for text box
		for(var k = 45; k < string_length(mess); k += 45)
		{
			var newLine = 0;
			for(var j = 0; j < k; j++)
			{
				if(string_char_at(mess, j) == " ")
				{
					newLine = j;
				}
			}
			mess = string_copy(mess, 1, newLine) + "\n" + string_copy(mess, newLine + 1, string_length(mess) - newLine);
		}		
	}
	
	with(player_obj)
	{
		if(state != PlayerStateLocked)
		{
			lastState = state;
			state = PlayerStateLocked;
		}
	}
}