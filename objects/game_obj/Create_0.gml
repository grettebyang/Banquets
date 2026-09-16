// Initialize & Globals
randomize();

DeleteRoomSaveFiles();

global.gameSaveSlot = 0;
global.day = 0; // 0 : Friday, 1 : Saturday, 2 : Sunday
global.week = -1;

global.dailyBEOs = array_create(0);
global.dailyInUse = array_create(0); // Will contain all the rooms that are in use for that day
global.dailyCleaning = array_create(0); // Will contain all the rooms that need cleaning for that day
global.roomData = array_create(0);
global.lockedRooms = array_create(0); //Contains rooms that are ready for event, cannot be changed
global.dailyShiftMeal = "Tater tot hotdish";
global.nextShiftMeal = ShiftMealChoices();
global.bobbyPins = 0;
global.enemyIndex = 0;
global.shiftPoint = 0;
global.gotLeftovers = false;
global.gotDessert = false;

global.gamePaused = false;
global.steaming = false;
global.iHolding = noone;
global.iCart = noone;
global.targetRoom = -1;
global.targetX = -1;
global.targetY = -1;
global.targetDirection = 0;
global.textSpeed = .75;

Quests();

WeddingAssets();

ListOfFoods();

//global battle variables
BattleStats();
global.battleWon = false;
global.battleCooldown = 0;
global.battleEnemies = array_create(0);
global.previousRoom = noone;
global.previousCoord = [x,y];
global.recsPickUp = 0;

global.iCamera = instance_create_layer(0,0,layer,camera_obj);

roomWidth = room_width;
roomHeight = room_height;

display_set_gui_size(RESOLUTION_W, RESOLUTION_H);

room_goto(ROOM_START);

FirstWeekSchedule();
global.week = 0;

MakeDailyTasks();
CreateWeeklySchedule();

global.devBypassTasks = false;

cursor_sprite = cursor_spr;
window_set_cursor(cr_none);
global.activatePrompt = noone;

global.notificationText = "";
global.notificationTime = 0;
notifAlpha = 1;

depth = -9999;
