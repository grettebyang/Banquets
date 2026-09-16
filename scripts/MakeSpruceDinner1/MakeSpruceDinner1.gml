// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MakeSpruceDinner1(_seatCount, _linenRoomColor){
	
	//make the array that will store all the objects on the BEO
	var beoData = array_create(0);
	
	//randomized room data
	seatsPerTable = 0;
	tableCount = 0;
	recTableCount = 4;
	partyTableCount = 2;
	remainder = 0;
	maxTables = 15;
	partySize = 8;
	seatCount = _seatCount - partySize;
	linenRoomColor = _linenRoomColor;
	
	//calculate number of seats per table
	//find the number that is divisible if possible
	//if the number of tables given the calculated seat number is more than 6, increase the seats per table
	//create a list of the of the seats per table values, including the remainder value
	tableSeatCounts = GetTableSeats();
	var recTableSeatCounts = array_create(0);
	var partyTableSeatCounts = array_create(0);
	for(var i = tableCount - recTableCount; i < tableCount; i++)
	{
		array_push(recTableSeatCounts, tableSeatCounts[i]);
	}	
	tableCount = tableCount - recTableCount;
	array_delete(tableSeatCounts, tableCount, recTableCount);
	
	for(var i = 0; i < partySize; i++)
	{
		array_push(partyTableSeatCounts, 4);
	}	
	
	//section coordinates: [x1, x2, y1, y2, beox1, beox2, beoy1, beoy2, max rows, max columns]
	var roundTableSection = [128, 704, 160, 288, 11, 67, 10, 32, 2, 6];
	var recTableSection = [368, 704, 272, 384, 40, 60, 32, 50, 2, 2];
	var hitopSection = [32, 368, 272, 384, 13, 40, 32, 50, 2, 2];
	var partySection = [272, 480, 128, 160, 30, 50, 6, 10, 1, 2];
	var gbSection = [608, 704, 320, 448, 72, 77, 42, 50, 1, 1];
	
	var roomSections = [-1, roundTableSection, recTableSection, gbSection, -1, -1, -1, hitopSection, partySection];
	
	//Create BEO Object
	//instance_create_layer(0,0,"Instances",beo_obj, { seatCount : seatCount , linenRoomColor : linenRoomColor , buffetTables : buffetTables , seatsPerTable : seatsPerTable , tableCount : tableCount , remainder : remainder , tableSeatCounts : tableSeatCounts , roomSections : roomSections , roomSprite : beoPoplar_spr , rounds : 0 });
	
	//Add BEO object to array
	var beoObject =
	{
		seatCount : seatCount + partySize,
		linenRoomColor : linenRoomColor,
		buffetTables : -1,
		seatsPerTable : seatsPerTable,
		tableCount : tableCount,
		recTableCount : recTableCount,
		partyTableCount : partyTableCount,
		remainder : remainder,
		tableSeatCounts : tableSeatCounts,
		recTableSeatCounts : recTableSeatCounts,
		partyTableSeatCounts : partyTableSeatCounts,
		roomSections : roomSections,
		chafers : -1,
		roomSprite : beoSpruce_spr,
		taskName : "Set up for wedding in Spruce",
		rounds : 0,
		roomToCheck : rSpruce,
		ready : false,
		dayOfEvent : choose(0,1),
		weekOfEvent : global.week + 1
	}
	array_push(beoData, beoObject);
	
	//Round Table Section
	for(var i = 0; i < tableCount; i++)
	{
		var beoItem = 
		{
			section : roundTableSection,
			obj : "roundTable_obj",
			steamed : true,
			tableLinen : true,
			chairCount : tableSeatCounts[i],
			linenColor : linenRoomColor,
			rounds : 0
		}
		array_push(beoData, beoItem);
	}
	
	//Rec Table Section
	for(var i = 0; i < recTableCount; i++)
	{
		var beoItem = 
		{
			section : recTableSection,
			obj : "recTable_obj",
			steamed : true,
			tableLinen : true,
			chairCount : recTableSeatCounts[i],
			linenColor : linenRoomColor,
			rounds : 0,
			rotateIndex : 0,
			tableFluff : -1
		}
		array_push(beoData, beoItem);
	}
	
	//Party Section
	for(var i = 0; i < partyTableCount; i++)
	{
		var beoItem = 
		{
			section : partySection,
			obj : "recTable_obj",
			steamed : true,
			tableLinen : true,
			chairCount : partyTableSeatCounts[i],
			linenColor : linenRoomColor,
			rounds : 2,
			rotateIndex : 0,
			tableFluff : -1
		}
		array_push(beoData, beoItem);
	}
	
	//Hitop Table Section
	for(var i = 0; i < 3; i++)
	{
		var beoItem = 
		{
			section : hitopSection,
			obj : "hitopTable_obj",
			steamed : true,
			tableLinen : true,
			linenColor : linenRoomColor
		}
		array_push(beoData, beoItem);
	}
	
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

