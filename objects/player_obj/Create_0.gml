collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

walkspd = 2.0;
hsp = 0;
vsp = 0;

spriteRun = playerwalk_spr;
spriteIdle = playeridle_spr;
localFrame = 0;

state = PlayerStateFree;
lastState = state;

activate = noone;

cartCollision = false;

pathSize = 10;
for(var i = pathSize; i > 0; i--) {
	pos_x[i] = x;
	pos_y[i] = y;
}

if(global.targetX != -1)
{
	x = global.targetX;
	y = global.targetY;
	direction = global.targetDirection;
}

a = 0;
fade = -1;
