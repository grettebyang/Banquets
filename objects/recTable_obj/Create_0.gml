depth = -y;

grabbed = 0;

pushpull = 1;

//prevDirection = player_obj.direction;

cartCollision = false;

itemCount = 0;



//table specific

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

steamed = false;
hasCreases = true;

tableLinen = false;

chairCount = 0;
chairList = [];

rounds = 0;

withPlayer = false;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

doneIndex = 0;

x = (x div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((sprite_get_width(entitySprite)/TILE_SIZE) mod 2);

y = (y div TILE_SIZE) * TILE_SIZE + (TILE_SIZE * .5)*((sprite_get_height(entitySprite)/TILE_SIZE) mod 2);

sprite_index = entitySprite;