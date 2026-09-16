// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DrawBEO(beoInst){ // This function will run in the draw event of taskList_obj every frame as long as the BEO is being viewed

	// Takes in a beo_obj and draws the beo on the page
	
	// Set font, etc. for drawing text
	draw_set_font(beoText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	
	// Draw the outline of the room
	olx = 120;
	oly = 40;
	draw_sprite(beoInst.roomSprite, 0, olx, oly);
	
	//roomSections = [buffetSection, roundTableSection, recTableSection, gbSection, archSection, upperSeatingSection, lowerSeatingSection, hitopSection, partySection];
	
	// Draw buffet section
	if(beoInst.roomSections[0] != -1)
	{
		var buffetSection = beoInst.roomSections[0];
		// Get width and height of section
		var bsWidth = buffetSection[5] - buffetSection[4];
		var bsHeight = buffetSection[7] - buffetSection[6];
		for(var i = 1; i <= beoInst.buffetTables; i++)
		{
			var yy = oly + buffetSection[6] + i*bsHeight/(buffetSection[8] + 1);
			var xx = olx + buffetSection[4] + bsWidth/(buffetSection[9] + 1);
			draw_sprite(beoRecTable_spr, 0, xx, yy);		
		}
	}
	
	// Draw round table section
	if(beoInst.roomSections[1] != -1)
	{	
		DrawTables(beoInst.roomSections[1], beoInst.tableCount, beoInst.tableSeatCounts, beoRoundTable_spr, DrawRoundChairArrangementRound);
	}
	
	// Draw rec table section
	if(beoInst.roomSections[2] != -1)
	{	
		DrawTables(beoInst.roomSections[2], beoInst.recTableCount, beoInst.recTableSeatCounts, beoRecTable_spr, DrawRecChairArrangementRound);
	}

	// Draw guestbook section
	if(beoInst.roomSections[3] != -1)
	{
		var gbSection = beoInst.roomSections[3];
		// Get width and height of section
		var gsWidth = gbSection[5] - gbSection[4];
		var gsHeight = gbSection[7] - gbSection[6];

		var yy = oly + gbSection[6] + gsHeight/(gbSection[8] + 1);
		var xx = olx + gbSection[4] + gsWidth/(gbSection[9] + 1);
		draw_sprite(beoHitop_spr, 0, xx, yy);	
	}
	
	// Draw arch section
	if(beoInst.roomSections[4] != -1)
	{
		var archSection = beoInst.roomSections[4];
		// Get width and height of section
		var asWidth = archSection[5] - archSection[4];
		var asHeight = archSection[7] - archSection[6];
		for(var i = 0; i < 2; i++)
		{
			var yy = oly + archSection[6] + i*asHeight/(archSection[8] + 1);
			var xx = olx + archSection[4] + asWidth/(archSection[9] + 1);
			draw_sprite(beoChair_spr, 0, xx, yy);		
		}
		draw_sprite(beoHitop_spr, 0, olx + archSection[4] + asWidth/(archSection[9] + 1), oly + archSection[6] + 3*asHeight/(archSection[8] + 1));	
	}
	
	// Draw first seating section
	if(beoInst.roomSections[5] != -1)
	{	
		var seatingSection = beoInst.roomSections[5];
		// Get width and height of section
		var tsWidth = seatingSection[5] - seatingSection[4];
		var tsHeight = seatingSection[7] - seatingSection[6];
		var count = 0;
		for(var colInd = 1; colInd <= seatingSection[9]; colInd++)
		{
			for(var rowInd = 1; rowInd <= seatingSection[8]; rowInd++)
			{
				if(count < beoInst.upperSeats)
				{
					var yy = oly + seatingSection[6] + rowInd * tsHeight/(seatingSection[8] + 1);
					var xx = olx + seatingSection[4] + colInd * tsWidth/(seatingSection[9] + 1);
					draw_sprite(beoChair_spr, 0, xx, yy);
				}
				else
				{
					break;
				}
				count++;
			}

		}
	}
	
	// Draw second seating section
	if(beoInst.roomSections[6] != -1)
	{	
		var seatingSection = beoInst.roomSections[6];
		// Get width and height of section
		var tsWidth = seatingSection[5] - seatingSection[4];
		var tsHeight = seatingSection[7] - seatingSection[6];
		var count = 0;
		for(var colInd = 1; colInd <= seatingSection[9]; colInd++)
		{
			for(var rowInd = 1; rowInd <= seatingSection[8]; rowInd++)
			{
				if(count < beoInst.lowerSeats)
				{
					var yy = oly + seatingSection[6] + rowInd * tsHeight/(seatingSection[8] + 1);
					var xx = olx + seatingSection[4] + colInd * tsWidth/(seatingSection[9] + 1);
					draw_sprite(beoChair_spr, 0, xx, yy);
				}
				else
				{
					break;
				}
				count++;
			}

		}
	}
	
	// Draw hitop section
	if(beoInst.roomSections[7] != -1)
	{
		var buffetSection = beoInst.roomSections[7];
		// Get width and height of section
		var bsWidth = buffetSection[5] - buffetSection[4];
		var bsHeight = buffetSection[7] - buffetSection[6];
		var maxCol = buffetSection[9];
		var maxRow = buffetSection[8];
		var rowDiv = maxRow;
		var colDiv = maxCol;
		var count = 0;
		var hitopCount = 3;
		for(var colInd = 0; colInd < maxCol; colInd++)
		{
			if(ceil(hitopCount/2) < maxRow)
			{
				maxRow = ceil(hitopCount/2);
				rowDiv = maxRow;
			}
			else if((hitopCount - count) < maxRow)
			{
				rowDiv = hitopCount - count;
			}
			for(var rowInd = 0; rowInd < maxRow; rowInd++)
			{
				if(count < hitopCount)
				{
					var yy = oly + buffetSection[6] + rowInd * bsHeight/rowDiv + (bsHeight/rowDiv * 1/2);
					var xx = olx + buffetSection[4] + colInd * bsWidth/colDiv + (bsWidth/colDiv * 1/2);
					draw_sprite(beoHitop_spr, 0, xx, yy);
					count++;
				}
				else
				{
					break;
				}
			}
		}
	}
	
	// Draw party section
	if(beoInst.roomSections[8] != -1)
	{	
		DrawTables(beoInst.roomSections[8], beoInst.partyTableCount, beoInst.partyTableSeatCounts, beoRecTable_spr, DrawRecChairArrangementNorth);
	}	
	
	// Draw specifications text
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	var linenColor = "";
	if(beoInst.linenRoomColor == 1)
	{
		linenColor = "Ivory";
	}
	else if(beoInst.linenRoomColor == 2)
	{
		linenColor = "White";
	}
	draw_text(115, 112, "Linen Color: " + linenColor);
	draw_text(115, 120, "Number of Seats: " + string(beoInst.seatCount));
	var seatArr = "";
	if(beoInst.rounds == 0)
	{
		seatArr = "Rounds";
	}
	else
	{
		seatArr = "Crescents";
	}
	
	if(beoInst.buffetTables > 0)
	{
		draw_text(115, 128, seatArr + " of " + string(beoInst.seatsPerTable));
		draw_text(115, 136, "Number of Buffet Tables: " + string(beoInst.buffetTables));
		var soupChafers = 0;
		var recChafers = 0;
		var roundChafers = 0;
		for(var i = 0; i < array_length(beoInst.chafers); i++)
		{
			if(beoInst.chafers[i] == "recFoodChafer_obj")
			{
				recChafers++;
			}
			else if(beoInst.chafers[i] == "roundFoodChafer_obj")
			{
				roundChafers++;
			}
			else if(beoInst.chafers[i] == "soupFoodChafer_obj")
			{
				soupChafers++;
			}
		}
		draw_text(115, 144, "Food Chafers: " + string(recChafers) + " Rectangle Chafers, \n" + string(roundChafers) + " Round Chafers, \n" + string(soupChafers) + " Soup Chafers");
	}
	
}

function DrawTables(tableSection, tableCount, seatCounts, tableSprite, chairArrangeScript) {
	
	// Get width and height of section
	var tsWidth = tableSection[5] - tableSection[4];
	var tsHeight = tableSection[7] - tableSection[6];
	var maxCol = tableSection[9];
	var maxRow = tableSection[8];
	var rowDiv = maxRow;
	var colDiv = maxCol;
	var count = 0;
	if(maxRow >= maxCol) //if there are more rows than columns
	{
		for(var colInd = 0; colInd < maxCol; colInd++)
		{
			if(maxRow * maxCol != tableCount)
			{
				if(ceil(tableCount/2) < maxRow)
				{
					maxRow = ceil(tableCount/2);
					rowDiv = maxRow;
				}
				else if((tableCount - count) < maxRow)
				{
					rowDiv = tableCount - count;
				}
			}
			for(var rowInd = 0; rowInd < maxRow; rowInd++)
			{
				if(count < tableCount)
				{
					var yy = oly + tableSection[6] + rowInd * tsHeight/rowDiv + (tsHeight/rowDiv * .5);
					var xx = olx + tableSection[4] + colInd * tsWidth/colDiv + (tsWidth/colDiv * .5);
					draw_sprite(tableSprite, 0, xx, yy);
					var seatCount = seatCounts[count];
					// Draw seats at each table
					script_execute_ext(chairArrangeScript, [seatCount, xx, yy]);
					draw_text(xx, yy, string(seatCount));
					count++;
				}
				else
				{
					break;
				}
			}
		}
	}
	else if(maxRow < maxCol) //if there are more columns than rows
	{
		for(var rowInd = 0; rowInd < maxRow; rowInd++)
		{
			if(maxRow * maxCol != tableCount)
			{
				if(ceil(tableCount/2) < maxCol)
				{
					maxCol = ceil(tableCount/2);
					colDiv = maxCol;
				}
				else if((tableCount - count) < maxCol)
				{
					colDiv = tableCount - count;
				}
			}
			for(var colInd = 0; colInd < maxCol; colInd++)
			{
				if(count < tableCount)
				{
					var yy = oly + tableSection[6] + rowInd * tsHeight/rowDiv + (tsHeight/rowDiv * .5);
					var xx = olx + tableSection[4] + colInd * tsWidth/colDiv + (tsWidth/colDiv * .5);
					draw_sprite(tableSprite, 0, xx, yy);
					var seatCount = seatCounts[count];
					// Draw seats at each table
					script_execute_ext(chairArrangeScript, [seatCount, xx, yy]);
					draw_text(xx, yy, string(seatCount));
					count++;
				}
				else
				{
					break;
				}
			}
		}
	}	
}

function DrawRecChairArrangementRound(seatCount, xx, yy) {
	var nSeats = floor(seatCount * .5);
	var sSeats = ceil(seatCount * .5);
	var split = sprite_get_width(beoRecTable_spr)/(nSeats)
	for(var j = 0; j < nSeats; j++)
	{
		draw_sprite(beoChair_spr, 0, xx + split * (j + 1) - (split * .5) - (sprite_get_width(beoRecTable_spr) * .5), yy - 3);
	}
	split = sprite_get_width(beoRecTable_spr)/(sSeats)
	for(var j = 0; j < sSeats; j++)
	{
		draw_sprite(beoChair_spr, 0, xx + split * (j + 1) - (split * .5) - (sprite_get_width(beoRecTable_spr) * .5), yy + 3);
	}	
}

function DrawRecChairArrangementNorth(seatCount, xx, yy) {
	var split = sprite_get_width(beoRecTable_spr)/seatCount;
	for(var j = 0; j < seatCount; j++)
	{
		draw_sprite(beoChair_spr, 0, xx + split * (j + 1) - (split * .5) - (sprite_get_width(beoRecTable_spr) * .5), yy - 3);
	}	
}

function DrawRecChairArrangementSouth(seatCount, xx, yy) {
	var split = sprite_get_width(beoRecTable_spr)/seatCount;
	for(var j = 0; j < seatCount; j++)
	{
		draw_sprite(beoChair_spr, 0, xx + split * (j + 1) - (split * .5) - (sprite_get_width(beoRecTable_spr) * .5), yy + 3);
	}	
}

function DrawRoundChairArrangementRound(seatCount, xx, yy) {
	for(var j = 0; j < seatCount; j++)
	{
		var phi = 270 + (360/seatCount)*j;
		draw_sprite(beoChair_spr, 0, xx + lengthdir_x(6, phi), yy + lengthdir_y(6, phi));
	}	
}