if(shakeLength > 0 && shakeMagnitude > 0 && shakeRemain > 0)
{
	camera_obj.shakeLength = shakeLength;
	camera_obj.shakeMagnitude = shakeMagnitude;
	camera_obj.shakeRemain = shakeRemain;
	shakeRemain = 0;
	shakeLength = 0;
	shakeMagnitude = 0;
}

