depth = -y;

grabbed = 0;

pushpull = 1;

prevDirection = player_obj.direction;

cartCollision = false;

itemCount = 0;

stackItems = [id];

cartStackItem = noone;

withPlayer = false;

beoArray = array_create(0); // The array that will contain the beo_objs, size will be the number of beos today

pageNum = 0;

viewing = false;

pageCount = array_length(global.dailyBEOs);

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;


