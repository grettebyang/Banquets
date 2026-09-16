lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1,x1Target,lerpProgress);
x2 = lerp(x2,x2Target,lerpProgress);

//Cycle through responses
keyUp = keyboard_check_pressed(ord("W"));
keyDown = keyboard_check_pressed(ord("S"));
responseSelected += (keyDown - keyUp);
responseSelected = abs(responseSelected % array_length(responses));

if(keyboard_check_pressed(ord("E")))
{
	var messageLength = string_length(mess);
	if(textProgress >= messageLength)
	{
		if(responses[0] != -1)
		{
			with(originInstance)
			{
				script_execute_ext(other.dialogueResponseScript, [other.responseScripts[other.responseSelected]]);
				//DialogueResponses(other.responseScripts[other.responseSelected]);
			}
		}
		else if(dialogueResponseScript != -1)
		{
			script_execute(dialogueResponseScript);
		}
		
		instance_destroy();
		if(instance_exists(textQueued_obj))
		{
			with(textQueued_obj)
			{
				ticket--;
			}
		}
		else
		{
			with(player_obj)
			{
				state = lastState;
			}
		}
	}
	else
	{
		if(textProgress > 2)
		{
			textProgress = messageLength;
		}
	}
}
keyboard_clear(ord("E"));






