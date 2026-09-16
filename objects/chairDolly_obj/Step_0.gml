if(!grabbed) {
	if(cartStackItem == noone) {
		entityActive = true;
	}
	else {
		entityActive = false;
		with(cartStackItem) {
			entityActive = true;
			entityCollision = true;
		}
	}
}
else {
	with(cartStackItem) {
		entityActive = false;
		entityCollision = false;
	}
	entityActive = true;
}





