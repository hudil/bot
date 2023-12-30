#Persistent
#SingleInstance
DetectHiddenWindows, On
SetKeyDelay,,50

;Offsets & Addresses

IniRead, logActivities		, WQing.ini, main,logActivities

IniRead, realBaseAddress		, WQing.ini, offsets,realBaseAddress						
IniRead, baseOffset			, WQing.ini, offsets,baseOffset						
IniRead, playerOffSet			, WQing.ini, offsets,playerOffSet						
IniRead, playerNameOffset		, WQing.ini, offsets,playerNameOffset					
IniRead, nameLengthOffset		, WQing.ini, offsets,nameLengthOffset					
IniRead, playerTargetIdOffset		, WQing.ini, offsets,playerTargetIdOffset					
IniRead, playerActionStructOffset	, WQing.ini, offsets,playerActionStructOffset				
IniRead, playerCounterOffset		, WQing.ini, offsets,playerCounterOffset					
IniRead, playerIntervalOffset		, WQing.ini, offsets,playerIntervalOffset					
IniRead, playerFlyMountOffset		, WQing.ini, offsets,playerFlyMountOffset					
IniRead, playerFlySpdOffset		, WQing.ini, offsets,playerFlySpdOffset					
IniRead, playerTransportModeOffset	, WQing.ini, offsets,playerTransportModeOffset				
IniRead, playerXposOffset		, WQing.ini, offsets,playerXposOffset					
IniRead, playerYposOffset		, WQing.ini, offsets,playerYposOffset					
IniRead, playerZposOffset		, WQing.ini, offsets,playerZposOffset					
IniRead, SendPacketAddress		, WQing.ini, offsets,SendPacketAddress					
IniRead, questFunctionAddress		, WQing.ini, offsets,questFunctionAddress					
IniRead, questFunctionOffset		, WQing.ini, offsets,questFunctionOffset					
IniRead, npcIdOffset			, WQing.ini, offsets,npcIdOffset
IniRead, sortedNpcListOffset		, WQing.ini, offsets,sortedNpcListOffset
IniRead, baseListsOffset		, WQing.ini, offsets,baseListsOffset
IniRead, npcListOffset			, WQing.ini, offsets,npcListOffset





npcId8348	:=	4436
npcId8349	:=	2288
npcId8350	:=	3125
npcId8351	:=	6623
npcId8352	:=	3417
npcId8353	:=	3273
npcId8354	:=	3820
npcId8355	:=	9305
npcId8356	:=	3721
npcId8357	:=	3852
npcId8358	:=	2584
npcId8359	:=	6639
npcId8360	:=	3732
npcId8361	:=	4066
npcId8362	:=	4164
npcId8363	:=	3958
npcId8364	:=	3948
npcId8365	:=	3963
npcId8366	:=	3950
npcId8367	:=	7198
npcId8368	:=	7476
npcId8369	:=	7189
npcId8370	:=	7156
npcId8371	:=	7193
npcId8372	:=	9294
npcId8373	:=	7146
npcId8374	:=	7126
npcId8375	:=	7155
npcId8376	:=	7149
npcId8377	:=	7367
npcId8378	:=	14090
npcId8379	:=	14090
npcId8380	:=	14090
npcId8381	:=	14090
npcId8382	:=	14090
npcId8383	:=	14090
npcId8384	:=	14090
npcId8385	:=	14090
npcId8386	:=	14090
npcId8387	:=	14090
npcId8388	:=	14090
npcId8389	:=	14090
npcId8390	:=	14090
npcId8391	:=	14090
npcId8392	:=	14090
npcId8393	:=	14090
npcId8394	:=	14090
npcId8395	:=	14090
npcId8396	:=	2222
npcId8397	:=	14090
npcId8398	:=	12974



xCoord8348	:=	1150922672
xCoord8349	:=	3302385319
xCoord8350	:=	1148557837
xCoord8351	:=	3303292969
xCoord8352	:=	1142127397 
xCoord8353	:=	1156113401
xCoord8354	:=	1156110694
xCoord8355	:=	1155705131
xCoord8356	:=	1158297134
xCoord8357	:=	1159710894
xCoord8358	:=	1160108504
xCoord8359	:=	1134178481
xCoord8360	:=	3285809922
xCoord8361	:=	3290771596
xCoord8362	:=	3308040683
xCoord8363	:=	3307254531
xCoord8364	:=	3297816607
xCoord8365	:=	1135247292
xCoord8366	:=	1143076818
xCoord8367	:=	1160136679
xCoord8368	:=	1160190578
xCoord8369	:=	1152945684
xCoord8370	:=	1153034387
xCoord8371	:=	1152265176
xCoord8372	:=	1159054997
xCoord8373	:=	1159086744
xCoord8374	:=	1159662514
xCoord8375	:=	1160067557
xCoord8376	:=	1159191720
xCoord8377	:=	3305664239
xCoord8378	:=	1151616945
xCoord8379	:=	1151616945
xCoord8380	:=	1151616945
xCoord8381	:=	1151616945
xCoord8382	:=	1151616945
xCoord8383	:=	1151616945
xCoord8384	:=	1151616945
xCoord8385	:=	1151616945
xCoord8386	:=	1151616945
xCoord8387	:=	1151616945
xCoord8388	:=	1151616945
xCoord8389	:=	1151616945
xCoord8390	:=	1151616945
xCoord8391	:=	1151616945
xCoord8392	:=	1151616945
xCoord8393	:=	1151616945
xCoord8394	:=	1151616945
xCoord8395	:=	1151616945
xCoord8396	:=	1154882031
xCoord8397	:=	1151616945
xCoord8398	:=	1151749044

yCoord8348	:=	1130077739
yCoord8349	:=	1130079036
yCoord8350	:=	1130021976
yCoord8351	:=	1141044657
yCoord8352	:=	1130042464
yCoord8353	:=	1131590663
yCoord8354	:=	1131336105
yCoord8355	:=	1130076569
yCoord8356	:=	1130234513
yCoord8357	:=	1130031613
yCoord8358	:=	1132208056
yCoord8359	:=	1130168939
yCoord8360	:=	1134634916
yCoord8361	:=	1130096160
yCoord8362	:=	1141030586
yCoord8363	:=	1140993714
yCoord8364	:=	1141067583
yCoord8365	:=	1130090536
yCoord8366	:=	1132295168
yCoord8367	:=	1130628796
yCoord8368	:=	1130627738
yCoord8369	:=	1130689735
yCoord8370	:=	1130518019
yCoord8371	:=	1130027594
yCoord8372	:=	1130154748
yCoord8373	:=	1130073206
yCoord8374	:=	1130614368
yCoord8375	:=	1130092715
yCoord8376	:=	1130117314
yCoord8377	:=	1130496656
yCoord8378	:=	1130077739
yCoord8379	:=	1130077739
yCoord8380	:=	1130077739
yCoord8381	:=	1130077739
yCoord8382	:=	1130077739
yCoord8383	:=	1130077739
yCoord8384	:=	1130077739
yCoord8385	:=	1130077739
yCoord8386	:=	1130077739
yCoord8387	:=	1130077739
yCoord8388	:=	1130077739
yCoord8389	:=	1130077739
yCoord8390	:=	1130077739
yCoord8391	:=	1130077739
yCoord8392	:=	1130077739
yCoord8393	:=	1130077739
yCoord8394	:=	1130077739
yCoord8395	:=	1130077739
yCoord8396	:=	1130136969
yCoord8397	:=	1130077739
yCoord8398	:=	1130077739

zCoord8348	:=	1148590119
zCoord8349	:=	1115520494
zCoord8350	:=	1166235043
zCoord8351	:=	3298807030
zCoord8352	:=	1138268421
zCoord8353	:=	1125415571
zCoord8354	:=	1126821456
zCoord8355	:=	1151963447
zCoord8356	:=	1155092500
zCoord8357	:=	1161783713
zCoord8358	:=	1166197254
zCoord8359	:=	1156163994
zCoord8360	:=	1158984367
zCoord8361	:=	1160585847
zCoord8362	:=	1137289047
zCoord8363	:=	1147499808
zCoord8364	:=	1126624420
zCoord8365	:=	3294985570
zCoord8366	:=	3305352074
zCoord8367	:=	3303123588
zCoord8368	:=	3302758014
zCoord8369	:=	3302842554
zCoord8370	:=	3302573762
zCoord8371	:=	3299372414
zCoord8372	:=	3292082340
zCoord8373	:=	1125247490
zCoord8374	:=	1058505046
zCoord8375	:=	1142385946
zCoord8376	:=	1143040737
zCoord8377	:=	1162223519
zCoord8378	:=	1147533066
zCoord8379	:=	1147533066
zCoord8380	:=	1147533066
zCoord8381	:=	1147533066
zCoord8382	:=	1147533066
zCoord8383	:=	1147533066
zCoord8384	:=	1147533066
zCoord8385	:=	1147533066
zCoord8386	:=	1147533066
zCoord8387	:=	1147533066
zCoord8388	:=	1147533066
zCoord8389	:=	1147533066
zCoord8390	:=	1147533066
zCoord8391	:=	1147533066
zCoord8392	:=	1147533066
zCoord8393	:=	1147533066
zCoord8394	:=	1147533066
zCoord8395	:=	1147533066
zCoord8396	:=	1148540945
zCoord8397	:=	1147533066
zCoord8398	:=	1148064643

;List Variables

ActiveList =
InActiveList =
ActiveNitems := 0
InActiveNitems := 0

createGui()

	settimer, mainloop, 500

return


GuiClose:
ExitApp

showStats:
Gui Submit, nohide

selectedPlayer := Active

loop %nPWs%
{	
	tempId := PWlist%A_Index%
	if(playername%tempid% = selectedPlayer)
	{
		tempPlayer := tempid

		break
	}
}
StringSplit, statusParam, PWstatus%tempPlayer%, `,
questInfo := getQuestInfo(nextQuest%tempPlayer%)
currentStatus := statusParam1 . " [" . questInfo . "]"
GuiControl,, StatusText, %currentStatus%

return

Button>>:
gui submit, nohide
item = %InActive%
if(item <> "")
{
	removeItem("inactive", item)
	addItem("active", item)
	loop %nPWs%
	{	
		tempId := PWlist%A_Index%
		if(playername%tempid% = item)
		{
			tempPlayer := tempid
			logthis("selected player: " . tempPlayer, "main")

			break
		}
	}
	PWstatus%tempPlayer% := "Idle"
}
return

Button<<:
gui submit, nohide
item = %Active%
if(item <> "")
{
	removeItem("active", item)
	addItem("inactive", item)
	loop %nPWs%
	{	
		tempId := PWlist%A_Index%
		if(playername%tempid% = item)
		{
			tempPlayer := tempid
			logthis("selected player: " . tempPlayer, "main")

			break
		}
	}
	PWstatus%tempPlayer% := "Idle"
}
return

addItem(listBox, item)
{
	%listBox%List := %listBox%List . "`n" . item
	Sort, %listBox%List, U D`n
	if errorlevel = 0
		%listBox%Nitems := %listBox%Nitems + 1
	theList := %listBox%List
	GuiControl,, %listBox%, %theList%
	
}

removeItem(listBox, item)
{
	StringReplace, theList, %listBox%List, `n%item%
	%listBox%List := theList
	GuiControl,, %listBox%, %theList%
	%listBox%Nitems := %listBox%Nitems - 1
	if(%listBox%Nitems < 1)
	{
		createGui()

	}
}

createGui()
{
	global

	Gui, Destroy
	Gui +Delimiter`n
	Gui, Add, ListBox, vInActive x16 y44 w100 h147 %InActiveList%
	Gui, Add, Button, x126 y84 w50 h30 , >>
	Gui, Add, Button, x126 y124 w50 h30 , <<
	Gui, Add, ListBox, vActive gShowStats x186 y44 w110 h147 %ActiveList%
	Gui, Add, Text, x16 y14 w100 h20 , Inactive
	Gui, Add, Text, x186 y14 w110 h20 , Doing WQ
	Gui, Add, Text, vStatusText x316 y44 w130 h150 , Stats
	Gui, Show, x131 y91 h215 w464, Auto WQ
}


mainLoop:

;Get all clients with a char logged in


WinGet, winList ,List
PWlist =
nPWs = 0
loop %winList%
{

	windId := winList%A_Index%

	WinGet, processName ,processName , ahk_id %windId%
	if(processName = "elementclient.exe")
	{
		
		Winget, pId, PID, ahk_id %windId%
		
		theId = ahk_pid %pid%
		playerName := getPlayerName(theId)
		if(playerName <> "")
		{
			playerName%pId% = %playername%
			playername = %pId%
			nPWs := nPWs + 1
			PWlist%nPWs% = %playerName%
			PWidList%playerName% = %theId%
		}
	}
}



;Add any newly logged chars to the InActive list

addNewPlayers()

removeNonPresentPlayers()

StringSplit, activeArray, ActiveList, `n

loop %activeArray0%
{
	if(A_index > 1)
	{
		index := A_index
		playerName := activeArray%index%
		tolog = updating status: %playername%
		logThis(toLog, "main")
		loop %nPWs%
		{	
			pwId := PWlist%A_Index%
			if(playername%pwid% = playername)
			{
				playername := pwid
				break
			}
		}
		updateStatus(playerName)
		Gui Submit, nohide
		selectedPlayer := Active
		loop %nPWs%
		{	
			pwId := PWlist%A_Index%
			if(playername%pwid% = selectedPlayer)
			{
				selectedPlayer := pwid
				break
			}
		}
		StringSplit, statusParam, PWstatus%selectedPlayer%, `,

		questInfo := getQuestInfo(nextQuest%selectedPlayer%)
		currentStatus := statusParam1 . " [" . questInfo . "]"
		GuiControl,, StatusText, %currentStatus%
		


	}
}


return

getQuestInfo(questId)
{

	local returnValue := ""
	if(questId = 8348)
	{
	returnValue = Volume 1
	}
	else if(questId = 8349)
	{
	returnValue = Volume 2	
	}
	else if(questId = 8350)
	{
	returnValue = Volume 3	
	}
	else if(questId = 8351)
	{
	returnValue = Volume 4	
	}
	else if(questId = 8352)
	{
	returnValue = Volume 5	
	}
	else if(questId = 8353)
	{
	returnValue = Volume 6	
	}
	else if(questId = 8354)
	{
	returnValue = Volume 7	
	}
	else if(questId = 8355)
	{
	returnValue = Volume 8	
	}
	else if(questId = 8356)
	{
	returnValue = Volume 9	
	}
	else if(questId = 8357)
	{
	returnValue = Volume 10	
	}
	else if(questId = 8358)
	{
	returnValue = Volume 11	
	}
	else if(questId = 8359)
	{
	returnValue = Volume 12	
	}
	else if(questId = 8360)
	{
	returnValue = Volume 13	
	}
	else if(questId = 8361)
	{
	returnValue = Volume 14	
	}
	else if(questId = 8362)
	{
	returnValue = Volume 15	
	}
	else if(questId = 8363)
	{
	returnValue = Volume 16	
	}
	else if(questId = 8364)
	{
	returnValue = Volume 17	
	}
	else if(questId = 8365)
	{
	returnValue = Volume 18	
	}
	else if(questId = 8366)
	{
	returnValue = Volume 19	
	}
	else if(questId = 8367)
	{
	returnValue = Volume 20	
	}
	else if(questId = 8368)
	{
	returnValue = Volume 21	
	}
	else if(questId = 8369)
	{
	returnValue = Volume 22	
	}
	else if(questId = 8370)
	{
	returnValue = Volume 23	
	}
	else if(questId = 8371)
	{
	returnValue = Volume 24	
	}
	else if(questId = 8372)
	{
	returnValue = Volume 25	
	}
	else if(questId = 8373)
	{
	returnValue = Volume 26	
	}
	else if(questId = 8374)
	{
	returnValue = Volume 27	
	}
	else if(questId = 8375)
	{
	returnValue = Volume 28	
	}
	else if(questId = 8376)
	{
	returnValue = Volume 29	
	}
	else if(questId = 8377)
	{
	returnValue = Volume 30	
	}
	else if(questId = 8378)
	{
	returnValue = No Bonus	
	}
	else if(questId = 8379)
	{
	returnValue = Exp Bonus	
	}
	else if(questId = 8380)
	{
	returnValue = SP Bonus	
	}
	else if(questId = 8381)
	{
	returnValue = Reputation	
	}
	else if(questId = 8382)
	{
	returnValue = Gold Bonus	
	}
	else if(questId = 8383)
	{
	returnValue = Mirage	
	}
	else if(questId = 8384)
	{
	returnValue = No Bonus	
	}
	else if(questId = 8385)
	{
	returnValue = Exp Bonus	
	}
	else if(questId = 8386)
	{
	returnValue = SP Bonus	
	}
	else if(questId = 8387)
	{
	returnValue = Reputation	
	}
	else if(questId = 8388)
	{
	returnValue = Gold Bonus	
	}
	else if(questId = 8389)
	{
	returnValue = Mirage	
	}
	else if(questId = 8390)
	{
	returnValue = No Bonus	
	}
	else if(questId = 8391)
	{
	returnValue = Exp Bonus	
	}
	else if(questId = 8392)
	{
	returnValue = SP Bonus	
	}
	else if(questId = 8393)
	{
	returnValue = Reputation	
	}
	else if(questId = 8394)
	{
	returnValue = Gold Bonus	
	}
	else if(questId = 8395)
	{
	returnValue = Mirage	
	}
	else if(questId = 8396)
	{
	returnValue = Elder
	}
	else if(questId = 8397)
	{
	returnValue = Armerigo
	}
	else if(questId = 8398)
	{
	returnValue = Penney
	}
	return returnValue
}
	


getPlayerName(theId)
{
	global
	
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	local playerNamePointer := ReadMemory(playerPointer + playerNameOffset, theId)
	
	local playerNameLength := ReadMemory(playerNamePointer + nameLengthOffset, theId)
	
	local playerName := ""
	local tempOffset := 0xFFFFFFFD

	loop %playerNameLength%
	{
		tempOffset := tempOffset + 0x2
		local character := ReadMemory(playerNamePointer + tempOffset,theId, 2)

		SetFormat, IntegerFast, hex
		character += 0  
		character .= ""  
		SetFormat, IntegerFast, d

		playerName := playerName Hex2txt(character)
	}
	
	return playerName
}

getNextQuest(theId)
{
	global
	
	local returnValue := 0
	local questId := 8348
	loop 51
	{	
		value := checkQuestPresent(questId, theId)	
		if(value = 0)
		{
			returnValue := questId
			break
		}
		questId := questId + 1
	}

	return returnValue
}

npcIsClose(questId, theId)
{

	global
	
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	
	SetFormat, IntegerFast, hex
	
	local xCoord := ReadMemory(playerPointer + playerXposOffset, theId)
	local yCoord := ReadMemory(playerPointer + playerYposOffset, theId)
	local zCoord := ReadMemory(playerPointer + playerZposOffset, theId)
	
	local npcX := xCoord%questId%
	local npcY := yCoord%questId%
	local npcZ := zCoord%questId%

	SetFormat, IntegerFast, d
	
	local dX := hextofloat(xcoord) - hextofloat(npcx)
	local dY := hextofloat(ycoord) - hextofloat(npcy)
	local dZ := hextofloat(zcoord) - hextofloat(npcz)
	
	distance := sqrt(dX * dX + dY * dY + dZ * dZ)

	
	if(distance < 5)
	{
		return 1
	}
	else
	{
		return 0
	}

}

handleNpc(questId, theId)
{
	global
	
	SetFormat, IntegerFast, hex
	
	;select NPC
	
	npcTypeId := npcId%questId%
	
	;find the unique npc id
	
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local baseListsPointer := ReadMemory(structurePointer + baseListsOffset, theId)	
	local npcListPointer := ReadMemory(baseListsPointer + npcListOffset, theId)	
	local sortedNpcList := ReadMemory(npcListPointer + sortedNpcListOffset, theId)
	local npcCount  := ReadMemory(npcListPointer + 0x14, theId)
	
	local i := 0x0
	
	loop %npcCount%
	{
		local npcPointer := ReadMemory(sortedNpcList + i,theId)
		local npcType := ReadMemory(npcPointer + npcIdOffset + 0x4,theId)
		local npcId := ReadMemory(npcPointer + npcIdOffset,theId)
		if(npcType = npcTypeId)
		{
			break
		}
	
	
		i := i + 0x4
	}
	

	revHex(revNpcId, npcId)
	packet := ""
	packet = %packet%0200%revNpcId%
	packetSize := 0x6
	packetSizeStr := "06"
	sendPacket(packet, packetSizeStr, packetsize, theId)

	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)

	
	loop
	{
		local targetId := ReadMemory(playerPointer + playerTargetIdOffset, theId)
		if(targetId = npcId)
		{
			break
		}
		sleep 100
	}
	
	;start interaction
	
	packet := ""
	packet = %packet%2300%revNpcId%
	packetSize := 0x6
	packetSizeStr := "06"
	sendPacket(packet, packetSizeStr, packetsize, theId)
	
	sleep 100
	
	;hand in quest
	
	revHex(revQuestId, questId)
	packet := ""
	packet = %packet%2500070000000C000000%revQuestId%0000000000000000
	packetSize := 0x16
	packetSizeStr := "16"
	sendPacket(packet, packetSizeStr, packetsize, theId)
	
	sleep 3000
	
}

getMoveMethod(questId, theId)
{
	global
	
	local x := xCoord%questId%
	local y := yCoord%questId%
	local z := zCoord%questId%
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	
	SetFormat, IntegerFast, hex
	
	local xCoord := ReadMemory(playerPointer + playerXposOffset, theId)
	local yCoord := ReadMemory(playerPointer + playerYposOffset, theId)
	local zCoord := ReadMemory(playerPointer + playerZposOffset, theId)
	

	SetFormat, IntegerFast, d
	
	local dX := hextofloat(xcoord) - hextofloat(x)
	local dY := hextofloat(ycoord) - hextofloat(y)
	local dZ := hextofloat(zcoord) - hextofloat(z)
	
	local distance := sqrt(dX * dX + dZ * dZ)
	local returnValue =
	if(distance < 5)
	{
		returnValue = Falling
	}
	else
	{
		local height := 77.0

		local nTimesUp := 20

		returnValue = FlyUp@%nTimesUp%@SetFlyTo@%x%@%y%@%z%@%height%@Flying@Falling
	}	
	
	return returnValue

	


}


flymodeActive(theId)
{
	global

	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	local transportMode := ReadMemory(playerPointer + playerTransportModeOffset, theId)
	
	if(transportMode = 2)
	{
		return 1
	}
	else
	{
		return 0
	}
}


toggleFlying(theId)
{
	global
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	local flyMountId := ReadMemory(playerPointer + playerFlyMountOffset, theId)
	
	revHex(revFlyMountId, flyMountId)
	packet := ""
	packet = 280001010C00%revFlyMountId%
	packetSize := 0xA
	packetSizeStr := "0A"
	sendPacket(packet, packetSizeStr, packetsize, theId)
	sleep 2000
}





setFlyTo(theId, xCoord, yCoord, zCoord, height)
{
	global
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	local actionStruct := ReadMemory(playerPointer + playerActionStructOffset, theId)

	MoveTo(Xcoord, Ycoord, Zcoord, 0, theId, actionStruct, height)
}


getCurrentCoords(theId)
{
	global
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
		
	local xCoord := ReadMemory(playerPointer + playerXposOffset, theId)
	local yCoord := ReadMemory(playerPointer + playerYposOffset, theId)
	local zCoord := ReadMemory(playerPointer + playerZposOffset, theId)

	local returnValue = %xCoord%@%yCoord%@%zCoord%
	
	return returnValue

}

isIdle(theId)
{
	global
	local baseAddress := ReadMemory(realBaseAddress, theId)
	local structurePointer := ReadMemory(baseAddress + baseOffset, theId)
	local playerPointer := ReadMemory(structurePointer + playerOffset, theId)
	local actionStruct := ReadMemory(playerPointer + playerActionStructOffset, theId)
	local moving := ReadMemory(actionstruct+0x18,theId)

	if(moving = 0)
	{
		return 1
	}
	else
	{
		return 0
	}
	



}



updateStatus(name)
{
	global
	nextQuest := nextQuest%Name%
	clientId := PWidList%Name%
	StringSplit, statusParam, PWstatus%Name%, `,
	currentStatus := statusParam1
		tolog = updating status: status: %currentStatus%, quest: %nextQuest%
		logThis(toLog, name)
	if(currentStatus = "Idle")
	{
		tolog = currentStatus is Idle
		logThis(toLog, name)
		
		nextQuest := getNextQuest(clientId)
		nextQuest%Name% := nextQuest
		if(nextQuest = 0)
		{
			;Stay Idle
			tolog = No new quest found, staying Idle
			logThis(toLog, Name)
		}
		else ;There is a new quest
		{
			if(NpcIsClose(nextQuest, clientId) = 1)
			{
				tolog = Npc is close for quest: %nextQuest%
				logThis(toLog, Name)
				handleNpc(nextQuest, clientId)
				tolog = Handled npc for quest %nextQuest%
				logThis(toLog, Name)
				;Idle again
			}
			else	;You have to move to the Npc
			{
				moveMethod := getMoveMethod(nextQuest, clientId)
				PWstatus%Name% = Moving,%moveMethod%
				tolog = Npc is not close: status: Moving,%moveMethod%
				logThis(toLog, Name)
			}
		}
	}
	else if(currentStatus = "Moving")
	{
		
		moveMethod := statusParam2
		tolog = Moving: %moveMethod%
		logThis(toLog, Name)
		
		stringsplit, moving, moveMethod, @
		if(moving1 = "FlyUp")
		{

		
			if(flyModeActive(clientId) = 1)
			{
				tolog = Flymode is active, so Flying Up
				logThis(toLog, Name)
				flyUp(clientId, moving2)
				tolog = Done flying up
				logThis(toLog, Name)
				;remove this parameter
				nParams := moving0 - 2
				newMoveMethod := ""
				testValues := moving0 . moving1 . moving2 . moving3 . moving4 . moving5 . moving6
								logThis(testValues, Name)
				loop %nParams%
				{
					paramIndex := A_Index + 2
					testValues := paramindex . newmovemethod . moving%paramindex%
					logThis(testValues, Name)
					newMoveMethod := newMoveMethod . moving%paramIndex%
					if(A_Index < nParams)
					{
						newMoveMethod := newMoveMethod . "@"
					}
				}
				PWstatus%Name% = Moving,%newMoveMethod%
				tolog = new status: Moving,%newMoveMethod%
				logThis(toLog, Name)
			}
			else
			{
				tolog = Flymode not active, toggling flymode
				logThis(toLog, Name)
				toggleFlying(clientId)
				tolog = Toggled flymode
				logThis(toLog, Name)				
			}
		}
		else if(moving1 = "SetFlyTo")
		{
			tolog = Setting FlyTo: %moving2%, %moving3%, %moving4%, %moving5%
			logThis(toLog, Name)
			setFlyTo(clientId, moving2, moving3, moving4, moving5)
			currentCoords := getCurrentCoords(clientId)
			
			tolog = Set fly to, current coords: %currentCoords%
			logThis(toLog, Name)
			
			;remove this parameter
			nParams := moving0 - 5
			newMoveMethod := ""
			loop %nParams%
			{
				paramIndex := A_Index + 5
				newMoveMethod := newMoveMethod . moving%paramIndex%
				if(A_Index < nParams)
				{
					newMoveMethod := newMoveMethod . "@"
				}
			}
			PWstatus%Name% = Moving,%newMoveMethod%,%currentCoords%
			tolog = new status: Moving,%newMoveMethod%,%currentCoords%
			logThis(toLog, Name)
		}
		else if(moving1 = "Flying")
		{
			currentCoords := getCurrentCoords(clientId)

			if (isIdle(clientId) = 1)
			{	

				;Done Flying
				tolog = Done flying
				logThis(toLog, Name)	
				;remove this parameter
				nParams := moving0 - 1
				newMoveMethod := ""
				loop %nParams%
				{
					paramIndex := A_Index + 1
					newMoveMethod := newMoveMethod . moving%paramIndex%
					if(A_Index < nParams)
					{
						newMoveMethod := newMoveMethod . "@"
					}
				}
				MoveMethod := newMoveMethod

			}

			PWstatus%Name% = Moving,%MoveMethod%,%currentCoords%
			tolog = flying, new status: Moving,%MoveMethod%,%currentCoords%
			logThis(toLog, Name)

		}
		else if(moving1 = "Falling")
		{
			tolog = Falling now
			logThis(toLog, Name)
			if(flymodeActive(clientId) = 1)
			{
				tolog = Currently flying, toggling flymode
				logThis(toLog, Name)
				toggleFlying(clientId)
				tolog = Toggled flymode
				logThis(toLog, Name)
			}
			else
			{
				tolog = Currently not flying
				logThis(toLog, Name)
			
				currentCoords := getCurrentCoords(clientId)
				if (isIdle(clientId) = 1)
				{
					;Stopped Falling
					tolog = Stopped falling
					logThis(toLog, Name)
					;remove this parameter
					nParams := moving0 - 1
					newMoveMethod := ""
					loop %nParams%
					{
						paramIndex := A_Index + 1
						newMoveMethod := newMoveMethod . moving%paramIndex%
						if(A_Index < nParams)
						{
							newMoveMethod := newMoveMethod . "@"
						}
					}
					PWstatus%Name% = Idle
				}
				
				tolog := PWstatus%Name%
				logThis("status: " . toLog, Name)
				;else
				;{
				;	if(flymodeActive(clientId) = 1)
				;	{
				;		toggleFlying(clientId)
				;	}
				;	PWstatus%Name% = Moving,%MoveMethod%,%currentCoords%
				;}
			}
		}				
		
	}
}


addNewPlayers()
{
	global
	
	loop %nPWs%
	{
		playerId := PWlist%A_Index%
		playername := playername%playerid%
		if(playerNameInLists(playerName) = 0)
		{
			addItem("inactive", playername)
			loop %nPWs%
			{	
				tempId := PWlist%A_Index%
				if(playername%tempid% = playername)
				{
					tempPlayer := tempid
					logthis("selected player: " . tempPlayer, "main")

					break
				}
			}
			PWstatus%tempPlayer% := "Idle"

		}
	}
}

removeNonPresentPlayers()
{
	global
	
	StringSplit, activeArray, ActiveList, `n
	
	loop %ActiveNitems%
	{
		index := A_Index + 1
		playerInList := activeArray%index%
		playerPresent := 0
		loop %nPWs%
		{
			playerid := PWlist%A_Index%
			playername := playername%playerid%
			if(playerInList = playerName)
			{
				playerPresent = 1
				break
			}
		}
		if (playerPresent = 0)
		{
			removeItem("active", playerInList)
		}
	}
	StringSplit, inactiveArray, inActiveList, `n
	
	loop %InActiveNitems%
	{
		index := A_Index + 1
		playerInList := inactiveArray%index%
		playerPresent := 0
		loop %nPWs%
		{
			playerid := PWlist%A_Index%
			playername := playername%playerid%
			if(playerInList = playerName)
			{
				playerPresent = 1
				break
			}
		}
		if (playerPresent = 0)
		{
			removeItem("inactive", playerInList)
		}
	}
	

}


playerNameInLists(playerName)
{

	global

	StringSplit, activeArray, ActiveList, `n
	playerPresent := 0
	loop %ActiveNitems%
	{
		index := A_Index + 1
		playerInList := activeArray%index%
		if(playerInList = playerName)
		{
			playerPresent := 1
			break
		}
	}
	if(playerPresent = 0)
	{
		StringSplit, inactiveArray, inActiveList, `n

		loop %InActiveNitems%
		{
			index := A_Index + 1
			playerInList := inactiveArray%index%

			if(playerInList = playerName)
			{
				playerPresent := 1
				break
			}
		}
	}

	return playerPresent
}


checkQuestPresent(questId, client)
{
	global

	;Get the process Id from the given client title
	winget, pid, PID, %client%

	;Get the process handle from the given client title
	ProcessHandle 	:= 	DllCall("OpenProcess", "int", 2035711, "char", 1, "UInt", PID, "UInt")
	
	functionSize := 100
	
	;Allocate memory to store the packet to be sent, and the method to call the send packet function
	returnAddress 	:=   	DllCall("VirtualAllocEx", "Uint", ProcessHandle, "Uint", 0, "Uint", 0x4, "Uint", 0x1000, "Uint", 0x40)
	functionAddress :=   	DllCall("VirtualAllocEx", "Uint", ProcessHandle, "Uint", 0, "Uint", functionSize, "Uint", 0x1000, "Uint", 0x40)


	revHex(revReturnAddress, returnAddress)	
	revHex(revQuestId, questId)
	revHex(revQuestFunctionAddress, questFunctionAddress)
	revHex(revBaseAddress, realBaseAddress)
	revHex(revQuestFunctionOffset, questFunctionOffset)
	revHex(revPlayerOffSet, playerOffSet, 2)


	;60 			PUSHAD
	;B8 80 45 66 00 	MOV     EAX, 00664580
	;8B 0D 7C 65 98 00 	MOV     ECX, DWORD PTR [98657C]
	;8B 49 1C 		MOV     ECX, DWORD PTR [ECX+1C]
	;8B 49 30 		MOV     ECX, DWORD PTR [ECX+34]
	;8B 89 DC 0D 		MOV     ECX, DWORD PTR [ECX+DDC]
	;68 DD 06 		PUSH    6DD
	;FF D0 			CALL    NEAR EAX
	;A3 32 54 76 98 	MOV     DWORD PTR [98765432], EAX
	;61 			POPAD
	;C3			RET



	func =					
	func = %func%60					;PUSHAD
	func = %func%B8%revQuestFunctionAddress%	;MOV     EAX, questFunction
	func = %func%8B0D%revBaseAddress%		;MOV     ECX, DWORD PTR [baseAddress]
	func = %func%8B491C				;MOV     ECX, DWORD PTR [ECX+1C]
	func = %func%8B49%revPlayerOffSet%				;MOV     ECX, DWORD PTR [ECX+playerOffSet]
	func = %func%8B89%revQuestFunctionOffset%	;MOV     ECX, DWORD PTR [ECX+questFuncOffset]
	func = %func%68%revQuestId%			;PUSH    questId
	func = %func%FFD0				;CALL    NEAR EAX
	func = %func%A3%revReturnAddress%		;MOV     DWORD PTR [returnAddress], EAX
	func = %func%61					;POPAD
	func = %func%C3					;RET


	MCode(checkQuestFunction, func)
	
	
	DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", functionAddress, "Uint", &checkQuestFunction, "Uint", functionSize, "Uint *", 0)
	
	
	
	
	SetFormat, IntegerFast, d
	
	hThrd := DllCall("CreateRemoteThread", "Uint", ProcessHandle, "Uint", 0, "Uint", 0, "Uint", functionAddress, "Uint", 0, "Uint", 0, "Uint", 0)
	loop
	{
		result := DllCall( "WaitForSingleObject", UInt,hThrd, UInt,50 ) 
		if(result <> 258)
		{
			break
		}
		sleep 50
		if(A_Index > 100)
		{
			break
		}
	}
	
	
	DllCall( "CloseHandle", UInt,hThrd )
	
	DllCall("VirtualFreeEx", "Uint", ProcessHandle, "Uint", functionAddress, "Uint", 0, "Uint", 0x8000)
	
	DllCall( "CloseHandle", UInt,ProcessHandle ) 
	
	local returnValue := readMemory(returnAddress, client)
	
	return returnValue
	
}


sendPacket(packet, packetSizeStr, packetsize, client)
{
	global

	MCode(processedPacket, packet)
	
	;Get the process Id from the given client title
	winget, pid, PID, %client%

	;Get the process handle from the given client title
	ProcessHandle 	:= 	DllCall("OpenProcess", "int", 2035711, "char", 1, "UInt", PID, "UInt")
	
	;Allocate memory to store the packet to be sent, and the method to call the send packet function
	packetAddress 	:=   	DllCall("VirtualAllocEx", "Uint", ProcessHandle, "Uint", 0, "Uint", packetSize, "Uint", 0x1000, "Uint", 0x40)
	functionAddress :=   	DllCall("VirtualAllocEx", "Uint", ProcessHandle, "Uint", 0, "Uint", 0x1B, "Uint", 0x1000, "Uint", 0x40)
	
	revHex(packetAddressRev, packetAddress)
	revHex(revSendPacketAddress, SendPacketAddress)
	revHex(revBaseAddress, realBaseAddress)


	func =
	func = %func%60				;PUSHAD
	func = %func%B8%revSendPacketAddress%	;MOV	 EAX, sendPacketAddress
	func = %func%8B0D%revBaseAddress%	;MOV     ECX, DWORD PTR [revBaseAddress]
	func = %func%8B4920			;MOV     ECX, DWORD PTR [ECX+20]
	func = %func%BF%packetAddressRev%	;MOV     EDI, packetAddress	//src pointer
	func = %func%6A%packetSizeStr%		;PUSH    packetSize		//size
	func = %func%57				;PUSH    EDI
	func = %func%FFD0			;CALL    EAX
	func = %func%61				;POPAD
	func = %func%C3				;RET	
	MCode(sendFunction, func)

	
	DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", packetAddress, "Uint", &processedPacket, "Uint", packetSize, "Uint *", 0)
	DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", functionAddress, "Uint", &sendFunction, "Uint", 0x1B, "Uint *", 0)

	hThrd := DllCall("CreateRemoteThread", "Uint", ProcessHandle, "Uint", 0, "Uint", 0, "Uint", functionAddress, "Uint", 0, "Uint", 0, "Uint", 0)
	loop
	{
		result := DllCall( "WaitForSingleObject", UInt,hThrd, UInt,50 ) 
		if(result <> 258)
		{
			break
		}
		sleep 50
		if(A_Index > 100)
		{
			break
		}
	}
	
	DllCall( "CloseHandle", UInt,hThrd )
	
	DllCall("VirtualFreeEx", "Uint", ProcessHandle, "Uint", packetAddress, "Uint", 0, "Uint", 0x8000)
	DllCall("VirtualFreeEx", "Uint", ProcessHandle, "Uint", functionAddress, "Uint", 0, "Uint", 0x8000)
	
	DllCall( "CloseHandle", UInt,ProcessHandle ) 
}


MCode(ByRef code, hex) { ; allocate memory and write Machine Code there
   VarSetCapacity(code,StrLen(hex)//2)
   Loop % StrLen(hex)//2
      NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "Char")
}

revHex(byref CodeRev, Code, requestedLength=8)
{
	;Return a reverse hex string of Code
	
	SetFormat, IntegerFast, hex
	Code += 0  
	Code .= ""  
	SetFormat, IntegerFast, d
	CodeRev =
	temp2 := substr(Code, 3)
	temp2 := "00000000" . temp2

	temp := strlen(temp2)-requestedLength + 1
	temp2 := substr(temp2, temp)

	i := requestedLength - 1
	looplength := requestedLength // 2
	loop %loopLength%
	{

		CodeRev := CodeRev . substr(temp2, i, 2)
		i := i - 2
	}
}



MoveTo(X, Y, Z, moveType, client, actionStruct, height=-1.0)
{
	actionList := ReadMemory(actionStruct+0x30,client)
	MoveAction := ReadMemory(actionList+0x4,client)

	writeMemory(0, MoveAction+0x8, client)				;Action finished = 0
	writeMemory(1, MoveAction+0x14, client)				;Action Start = 1	
	writeMemory(X, MoveAction + 0x20, client)
	writeMemory(Y, MoveAction + 0x24, client)
	writeMemory(Z, MoveAction + 0x28, client)
	writeMemory(FloatToHex(height), MoveAction + 0x68, client)
	if(height >= 0.0)
	{
		writeMemory(26625, MoveAction + 0x64, client)
		writeMemory(256, MoveAction + 0x6C, client) 
	}
	else 
	{
		writeMemory(26624, MoveAction + 0x64, client)
		writeMemory(65536, MoveAction + 0x6C, client) 
	}
	writeMemory(moveType, MoveAction + 0x2C, client)		;Not supported yet
	writeMemory(MoveAction, actionstruct+0xC, client)
	writeMemory(1, actionstruct+0x18, client)
	writeMemory(moveAction, actionstruct+0x14, client)
}



flyUp(client, times)
{

	global

	local loopn := times - 1
	local time := 0.5 ;s
	local baseAddress := ReadMemory(realBaseAddress,client) ;00986c00
	local pointer1 := ReadMemory(baseAddress+baseOffset,client) ;04c88408
	local player := ReadMemory(pointer1+playerOffset,client)
	
	SetFormat, IntegerFast, hex	
	
	local yCoord := readmemory(player+playerYposOffset, client, 4)
	local yCoordFloat := hextofloat(yCoord)

	if(yCoordFloat < 700)
	{

		loop %times%
		{
			sleep 500
			local packet := "0700"
			local counter := readmemory(player+playerCounterOffset, client, 2)
			local interval := readmemory(player+playerIntervalOffset, client, 2) ;0x01F4
			local xCoord := readmemory(player+playerXposOffset, client, 4)
			local zCoord := readmemory(player+playerZposOffset, client, 4)
			local speed := readmemory(player+playerFlySpdOffset, client, 4)
			local moveType := 0x61

			local speedFloat := hextofloat(speed)

			local yCoordFloat := yCoordFloat + speedFloat * time
			local sendSpeedFloat := speedFloat * 256 + 0.5
			local sendSpeedHex := floor(sendSpeedFloat)
			local sendYcoordHex := floattohex(yCoordFloat)
			revHex(value, xCoord)
			packet := packet . value
			revHex(value, sendYcoordHex)
			packet := packet . value
			revHex(value, zCoord)
			packet := packet . value
			revHex(value, sendSpeedHex, 4)
			packet := packet . value
			packet := packet . "00"		;direction
			revHex(value, moveType, 2)
			packet := packet . value
			revHex(value, counter, 4)
			packet := packet . value
			packet := packet . "F401"	;unknown value

			writeMemory(counter + 1,player+playerCounterOffset, client, 2)
			writeMemory(sendYcoordHex,player+playerYposOffset, client)
			sendPacket(packet, "16", 0x16, client)	

		}
		;Send an invalid packet so the server updates your location properly :P:P
		
		local packet := "0700"
		local counter := readmemory(player+playerCounterOffset, client, 2)
		local speedFloat := hextofloat(speed)

		local yCoordFloat := yCoordFloat + speedFloat * time
		local sendSpeedFloat := speedFloat * 256 + 0.5
		local sendSpeedHex := floor(sendSpeedFloat)
		local sendYcoordHex := floattohex(yCoordFloat)
		revHex(value, xCoord)
		packet := packet . value
		revHex(value, sendYcoordHex)
		packet := packet . value
		revHex(value, zCoord)
		packet := packet . value
		revHex(value, sendSpeedHex, 4)
		packet := packet . value
		packet := packet . "00"		;direction
		revHex(value, moveType, 2)
		packet := packet . value
		revHex(value, counter, 4)
		packet := packet . value
		packet := packet . "0000"	;unknown value

		writeMemory(counter + 1,player+playerCounterOffset, client, 2)
		writeMemory(sendYcoordHex,player+playerYposOffset, client)
		sendPacket(packet, "16", 0x16, client)	
	

		sleep 2000
	}
		SetFormat, IntegerFast, d
}

logThis(toLog, playerName)
{
	global
	
	if(logActivities=1)
	{

	FileAppend,
	(
		`n%toLog%
	), %playerName%.txt
	}

}





String2Hex(x)                 ; Convert a string to hex digits
{
   format = %A_FormatInteger%
   SetFormat Integer, H
   hex = X
   Loop Parse, x
   {
      y := ASC(A_LoopField)   ; 2 digit ASCII code of chars of x, 15 < y < 256
      StringTrimLeft y, y, 2  ; Remove leading 0x
      hex = %hex%%y%
   }
   SetFormat Integer, %format%
   Return hex
}

Hex2String(x)                 ; Convert a huge hex number starting with X to string
{
   Loop % StrLen(x)//2        ; 2-digit blocks, 1st digit at is pos 2, after X
   {
      StringMid hex, x, 2*A_Index, 2
      string := string . Chr("0x" hex)
   }
   Return string
}


;----- Hash functions -----

Hash16(x)   ; 16-bit hash related to DJB2 hash(i) = 33*hash(i-1) + x[i]
{
   hash = 5381
   StringLen Len, x
   Loop %Len%
   {
      Transform y, ASC, %x%   ; ASCII code of 1st char
      hash := 33*hash + y                ; *33 = <<5,add
      hash := hash >> 16 ^ hash & 0xFFFF ; Fold over MS & LS word
      StringTrimLeft x, x, 1  ; Remove 1st char from x
   }
   Return hash
}

ReadMemory2(MADDRESS=0,PROGRAM="", size=4, retType="UInt*")
{
	winget, pid, PID, %PROGRAM%
	tooltip, %PROGRAM% | %pid%
	sleep 1000
	ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
	DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,retType,MVALUE,"UInt",size,"UInt *",0)
	DllCall("CloseHandle", "int", ProcessHandle)
	return MVALUE
}

ReadMemory(MADDRESS=0,PROGRAM="", size=4, retType="UInt*")
{
   Static OLDPROC, ProcessHandle
   VarSetCapacity(MVALUE,size,0)							;Make a variable MVALUE with a capacity of 4 bytes
   If PROGRAM != %OLDPROC%							;If the program is not previously opened
   {
      WinGet, pid, pid, % OLDPROC := PROGRAM					;Get the program's process id
      ProcessHandle := ( ProcessHandle ? 0*(closed:=DllCall("CloseHandle"	;
      ,"UInt",ProcessHandle)) : 0 )+(pid ? DllCall("OpenProcess"		;Make sure the program is open
      ,"Int",16,"Int",0,"UInt",pid) : 0)					;
   }
   If (ProcessHandle) && DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,retType,MVALUE,"UInt",size,"UInt *",0)
   	return MVALUE ;return *(&MVALUE+3)<<24 | *(&MVALUE+2)<<16 | *(&MVALUE+1)<<8 | *(&MVALUE)
   return !ProcessHandle ? "Handle Closed: " closed : "Fail"
}

WriteMemory(WVALUE,MADDRESS,PROGRAM, size=4)
{
	winget, pid, PID, %PROGRAM%

	ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
	DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Uint*", WVALUE, "Uint", size, "Uint *", 0)

	DllCall("CloseHandle", "int", ProcessHandle)
	return
}




dec2hex(n) {

	SetFormat, IntegerFast, hex
	n += 0  ; Sets Var (which previously contained 11) to be 0xb.
	n .= ""  ; Necessary due to the "fast" mode.
	SetFormat, IntegerFast, d

   ;oIF := A_FormatInteger
   ;SetFormat,Integer, hex
   ;n := StrLen(n+0) ? n+0 : n
   ;n .= ""
   ;SetFormat,Integer, % oIF
   ;return n
}

hex2dec(n) {
   x := ((substr(n,1,2)!="0x") ? "0x" : "") n
   if ! StrLen(x+0)
      return n
   oIF := A_FormatInteger
   SetFormat,Integer, d
   x += 0
   SetFormat,Integer, % oIF
   return x
}


HexToFloat(d) {
      Return (1-2*(d>>31)) * (2**((d>>23 & 255)-127)) * (1+(d & 8388607)/8388608) ; 2**23
}

Txt2Hex(Txt) {
format := A_FormatInteger
StringSplit, TxtArray, Txt
loop, %TxtArray0%
   {
   CurrentTxt := TxtArray%A_Index%
   blah := Asc(CurrentTxt)
   SetFormat, Integer, Hex
   Hex := Asc(CurrentTxt)
   SetFormat, Integer, Decimal
   StringReplace, Hex, Hex, 0x,,All
   If StrLen(Hex) = 1
      {
      Hex := Hex . "0"
      }
   Hex%A_Index% := Hex
   }
Hex=
Loop, %TxtArray0%
   {
   Hex := Hex . Hex%A_Index%
   }
SetFormat, Integer, %Format%
return %Hex%
}

Hex2Txt(Hex) {
format := A_FormatInteger
go=1
Txt=
HexLen := StrLen(Hex)
Loop, %HexLen%
   {
   If go=1
   {
   go=0
   HexSet := "0x" . SubStr(Hex, A_Index, 2)
   SetFormat, Integer, Decimal
   HexSet += 0
   Txt := Txt . Chr(HexSet)
   }
   else
   {
   go=1
   }
   }
SetFormat, Integer, %Format%
return %Txt%
}

HexToDouble(x) { ; may be wrong at extreme values
   Return (2*(x>0)-1) * (2**((x>>52 & 0x7FF)-1075)) * (0x10000000000000 | x & 0xFFFFFFFFFFFFF)
}

FloatToHex(f) {
   form := A_FormatInteger
   SetFormat Integer, HEX
   v := DllCall("MulDiv", Float,f, Int,1, Int,1, UInt)
   SetFormat Integer, %form%
   Return v
}
