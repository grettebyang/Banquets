// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MakePoplarCeremony(seatCount, linenRoomColor){
	
	//make the array that will store all the objects on the BEO
	var beoData = array_create(0);
	
	//randomized room data
	var buffetTables = 0;
	var seatsPerTable = 0;
	var tableCount = 0;
	var remainder = 0;
	var upperSeats = (seatCount-2) div 2;
	var lowerSeats = seatCount - upperSeats - 2;
	
	//section coordinates: [x1, x2, y1, y2, beox1, beox2, beoy1, beoy2, max rows, max columns]
	var upperSeatingSection = [128,336, 80, 144, 15, 61, 9, 25, 4, 6];
	var lowerSeatingSection = [32,336, 176, 240, 15, 61, 35, 50, 4, 6];
	var archSection = [32,112, 80, 192, 1, 10, 23, 36, 3, 3];
	var gbSection = [336,416, 224, 304, 61, 77, 50, 62, 1, 1];
	
	var roomSections = [-1, -1, -1, gbSection, archSection, upperSeatingSection, lowerSeatingSection, -1, -1];
	
	//Add BEO object to array
	var beoObject =
	{
		seatCount : seatCount,
		upperSeats : upperSeats,
		lowerSeats : lowerSeats,
		linenRoomColor : linenRoomColor,
		buffetTables : buffetTables,
		seatsPerTable : seatsPerTable,
		tableCount : tableCount,
		remainder : remainder,
		roomSections : roomSections,
		roomSprite : beoPoplar_spr,
		taskName : "Set up for wedding in Poplar",
		rounds : 0,
		roomToCheck : rPoplar,
		ready : false,
		dayOfEvent : 1,
		weekOfEvent : global.week + 1
	}
	array_push(beoData, beoObject);
	
	//Upper Seating Section
	for(var i = 0; i < upperSeats; i++)
	{
		var beoItem =
		{
			section : upperSeatingSection,
			obj : "chair_obj",
			image_index : 4,
			itemCount : 0,
			onCart : false,
			chairCover : false
		}
		array_push(beoData, beoItem);
	}
	
	//Upper Seating Section
	for(var i = 0; i < lowerSeats; i++)
	{
		var beoItem =
		{
			section : lowerSeatingSection,
			obj : "chair_obj",
			image_index : 4,
			itemCount : 0,
			onCart : false,
			chairCover : false
		}
		array_push(beoData, beoItem);
	}
	
	//Arch Section
	for(var i = 0; i < 2; i++)
	{
		var beoItem =
		{
			section : archSection,
			obj : "chair_obj",
			image_index : 4,
			itemCount : 0,
			onCart : false,
			chairCover : false
		}
		array_push(beoData, beoItem);
	}
	var beoItem =
	{
		section : archSection,
		obj : "hitopTable_obj",
		steamed : true,
		tableLinen : true,
		linenColor : linenRoomColor
	}
	array_push(beoData, beoItem);
	
	
	//Guestbook Section
	var beoItem =
	{
		section : gbSection,
		obj : "hitopTable_obj",
		steamed : true,
		tableLinen : true,
		linenColor : linenRoomColor
	}
	array_push(beoData, beoItem);
	
	return beoData;
	
}