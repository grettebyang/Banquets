// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Quests(){
	
global.dogsFound = 0;

//Dog quests
global.questStatus = ds_map_create();
global.questStatus[? parmesan_obj] = 0;
global.questStatus[? gasparo_obj] = 0;
global.questStatus[? giuseppe_obj] = 0;
global.questStatus[? francesco_obj] = 0;
global.questStatus[? omobono_obj] = 0;
global.questStatus[? antonio_obj] = 0;
global.questStatus[? nicolo_obj] = 0;
global.questStatus[? giovanni_obj] = 0;
global.questStatus[? domenico_obj] = 0;
global.questStatus[? matteo_obj] = 0;
global.questStatus[? pietro_obj] = 0;
global.questStatus[? jacob_obj] = 0;
global.questStatus[? hermann_obj] = 0;
global.questStatus[? carl_obj] = 0;
global.questStatus[? andrea_obj] = 0;
global.questStatus[? hieronymus_obj] = 0;
global.questStatus[? francois_obj] = 0;
global.questStatus[? david_obj] = 0;
global.questStatus[? joseph_obj] = 0;

//Locked Doors
//When the player gets the keys, hasKey will be set to true
//When the player unlocks the door, unlocked will be set to true
global.doorsUnlocked = ds_map_create();
global.doorsUnlocked[? rStairwellFifthFloor] = { unlocked : false, hasKey : false };
global.doorsUnlocked[? rStairwellFourthFloor] = { unlocked : false, hasKey : false };
global.doorsUnlocked[? rStairwellThirdFloor] = { unlocked : false, hasKey : false };
global.doorsUnlocked[? rStairwellSecondFloor] = { unlocked : false, hasKey : false };
global.doorsUnlocked[? rStairwellMezzanine] = { unlocked : false, hasKey : false };
global.doorsUnlocked[? rStairwellFirstFloor] = { unlocked : false, hasKey : false };
global.doorsUnlocked[? rStairwellBasement] = { unlocked : false, hasKey : false };

//Bosses fought
global.bossesDefeated = ds_map_create();
global.bossesDefeated[? bigTable_obj] = false;
global.bossesDefeated[? bigChafer_obj] = false;
global.bossesDefeated[? danceFloor_obj] = false;


}