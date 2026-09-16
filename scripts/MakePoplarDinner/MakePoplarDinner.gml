// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MakePoplarDinner(_seatCount, _linenRoomColor){ // Returns a beo
	
	//make the array that will store all the objects on the BEO
	var beoData = array_create(0);
	
	//randomized room data
	buffetTables = irandom_range(1,2);
	chafers = irandom_range(0,4);
	chafersArray = array_create(chafers);
	for(var i = 0; i < chafers; i++)
	{
		chafersArray[i] = choose("recFoodChafer_obj", "roundFoodChafer_obj", "soupFoodChafer_obj");
	}
	seatsPerTable = 0;
	tableCount = 0;
	remainder = 0;
	maxTables = 6;
	seatCount = _seatCount;
	linenRoomColor = _linenRoomColor
	
	//calculate number of seats per table
	//find the number that is divisible if possible
	//if the number of tables given the calculated seat number is more than 6, increase the seats per table
	//create a list of the of the seats per table values, including the remainder value
	tableSeatCounts = GetTableSeats();
	
	//section coordinates: [x1, x2, y1, y2, beox1, beox2, beoy1, beoy2, max rows, max columns]
	var buffetSection = [32,112, 144, 240, 0, 15, 23, 50, 2, 1];
	var tableSection = [96,416, 80, 240, 15, 77, 9, 50, 2, 3];
	var gbSection = [336,416, 224, 304, 61, 77, 50, 62, 1, 1];
	
	var roomSections = [buffetSection, tableSection, -1, gbSection, -1, -1, -1, -1, -1];
	
	//Create BEO Object
	//instance_create_layer(0,0,"Instances",beo_obj, { seatCount : seatCount , linenRoomColor : linenRoomColor , buffetTables : buffetTables , seatsPerTable : seatsPerTable , tableCount : tableCount , remainder : remainder , tableSeatCounts : tableSeatCounts , roomSections : roomSections , roomSprite : beoPoplar_spr , rounds : 0 });
	
	//Add BEO object to array
	var beoObject =
	{
		seatCount : seatCount,
		linenRoomColor : linenRoomColor,
		buffetTables : buffetTables,
		seatsPerTable : seatsPerTable,
		tableCount : tableCount,
		remainder : remainder,
		tableSeatCounts : tableSeatCounts,
		roomSections : roomSections,
		chafers : chafersArray,
		roomSprite : beoPoplar_spr,
		taskName : "Set up for wedding in Poplar",
		rounds : 0,
		roomToCheck : rPoplar,
		ready : false,
		dayOfEvent : choose(0, 1),
		weekOfEvent : global.week + 1
	}
	array_push(beoData, beoObject);
	
	//Buffet Section
	for(var i = 0; i < buffetTables; i++)
	{
		var beoItem = 
		{
			section : buffetSection,
			obj : "recTable_obj",
			steamed : true,
			tableLinen : true,
			chairCount : 0,
			rotateIndex : 0,
			tableFluff : linenRoomColor - 1,
			linenColor : linenRoomColor,
			rounds : 0
		}
		array_push(beoData, beoItem);
	}
	for(var i = 0; i < chafers; i++)
	{
		var beoItem = 
		{
			section : buffetSection,
			obj : chafersArray[i],
			onTable : true
		}
		array_push(beoData, beoItem);
	}
	
	//Table Section
	for(var i = 0; i < tableCount; i++)
	{
		var beoItem = 
		{
			section : tableSection,
			obj : "roundTable_obj",
			steamed : true,
			tableLinen : true,
			chairCount : tableSeatCounts[i],
			linenColor : linenRoomColor,
			rounds : 0
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