#AutoIt3Wrapper_icon = icon.ico
;********************************************************************************
;* AutoIt Script v3.3                                                           *
;* Project: Prophet Bot Unleashed                                               *
;* Description: Grind Bot for Perfect World INT                                 *
;* Author: The-Prophets - Props To Interest07, Asakai, NoOb & LolKop...         *
;*         This bot wouldn't be possbible if it weren't for all of you guys     *
;********************************************************************************


#RequireAdmin
#include <File.au3>
#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <GuiConstantsEx.au3>
#include <GUIButton.au3>
#include <GUIToolbar.au3>
#include <ProgressConstants.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <NomadMemory.au3>
#include <Array.au3>



;********************************************************************************
;* Options                                                                      *
;********************************************************************************

HotKeySet("{F9}","StartOrStop")
HotKeySet("{end}","FlyUpVertical")


Opt("GUICloseOnESC", 0)
Opt("GUIOnEventMode", 1)
Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 1)

;********************************************************************************
;* Global Software Control Information                                          *
;********************************************************************************
;Chat Base
Global $Chat = 0xAFBEE8, $WHISPER = 0, $LastChat = 0xAFBEF4

; Declare GUI Arrays
Global $EXP_NEEDED[151], $HADTARGET = 0, $DISTANCE = 7, $Sitting = 0, $ATHOME = 0
Global $SELECTED_SPECIAL_INFO[300] = ['None', 'Incr. Movement', 'Unknown Special', 'Incr. Defence', 'Incr. Mag Resist', 'Incr. Attack', 'Incr. Magical Attk', 'Sacrificial Assault', 'Incr. Life', 'Weak']
Global $PET_HUNGER_INFO[300] = ['Full', 'Satisfied', 'Peckish', 'Hungry', 'Hungry', 'Hungry', 'Hungry']
Global $CHAR_CLASS_INFO[300] = ['Blademaster', 'Wizard', 'Psychic', 'Venomancer', 'Barbarian', 'Assassin', 'Archer', 'Cleric', 'Seeker', 'Mystic', 'None']
Global $HERBS[31] = ["","Nectar", "Salvia Root", "Ageratum", "Golden Herb", "Tranquillia Herb", "Elderwood", "Elecampane", "Realgar", "Palo Herb", "Tuckahoe", "Crane Herb", "Black Henbane", "Fleece-flower Root", "Green Berry", "Ligumaloes Wood", "Valdia Root", "Serpentine Herb", "Ox Bezoar", "Tulip", "Perfumedew Herb", "Butterfly Herb", "Tiger-ear Herb", "Red Berry", "Worm Sprouts", "White Berry", "Devilwood", "Scented Fungus", "Tiery Herb", "Longen Herb"]
Global $RESOURCES[23] = ["","Withered Tree Root", "Old Tree Root", "Willow Stake", "Peatree Stake", "Dragonwood Stake", "Cinnabar Ore", "Iron Ore", "Black Iron Ore", "Manganese Iron Ore", "Hsuan Iron Ore", "Meteorite Iron Ore", "Sandstone Rock", "Gravel Pile", "Rubstone Rock", "Corundum Rock", "Granite ROck", "Rough Coal Stack", "Coal Stack", "Fine Coal Stack", "Volcanic Coal Stack", "Lava Coal Stack"]

; Declare GUI Variables
Global $KEYCODE = "--|{F1}|{F2}|{F3}|{F4}|{F5}|{F6}|{F7}|{F8}|{1}|{2}|{3}|{4}|{5}|{6}|{7}|{8}|{9}", $COUNT = 0, $LOG = "", $LOGS = "", $MOBLISTFORMOPEN = "0", $MOVEING = "0", $GATHERING = "0"
Global $SOFTWARE_TITLE = "Prophet Bot Unleashed", $SOFTWARE_VERSION = "", $SOFTWARE_CONFIG = "Prophet-Bot-Config.ini", $STOP = True, $CURRENT_MOB_LIST[100], $MOB_LIST_COUNT = "0", $ACTIVE_SKILL = "0", $ACTIVE_WEAPONS = "0", $TIMER_CHANGE_WEAPON = "0", $TIMER_APOTHOCARY_RAIL = "0", $RAIL_LIST_COUNT = "0" 

; Declare Character Info Variables
Global $ACTIONFLAG, $MOVEFLAG, $CASTING, $LVL, $CLASS, $HP, $MP, $MAXHP, $HPPERC, $MAXMP, $EXP, $STR, $DEX, $VIT, $MAG, $SPIRIT, $GOLD, $AP, $X, $Y, $Z, $NPCID, $RESOURCEID, $LASTGATHERED, $LASTSHOPCHECKED, $CURRENTRAIL, $PACKFULL, $PLAYERCOUNT, $FORM_PARTY, $MOVEMODE, $CHARSTATE, $PLAYERCOUNT, $HEALTAR, $FLYTOESCAPE = 0

; Declare Battle Info Variables
Global $LAST_HP_READ, $FZ, $HEALTAR, $TEMP_TAR, $TAR, $TAR_BASE, $DEFTAR = 0, $DEFTAR2 = 0, $TARGET, $TID, $TARNAME, $TARLVL, $TARHP, $TARMAXHP, $TARAPI, $TARX, $LASTTARX[3], $TARY, $LASTTARY[3], $TARZ, $LASTTARZ[3], $TARSPEC, $LAST_KILLEDTIME, $LAST_KILLED, $KILLS_COUNT, $TARDIS, $LEADER, $KILL = 0, $LASTRAILX = 0, $LASTRAILY = 0, $LASTRAILZ = 0 , $HIGHT = 0, $REST = 0

; Declare Pet Variables
Global $CHECK_HEALPET = "0", $INPUT_PETSLOT = "0", $INPUT_PETHP = "0", $INPUT_PETHEALKEY = "0", $INPUT_PETREZKEY = "0", $MOBLISTOFORMOPEN = "0", $MOVEX = "0", $MOVEY = "0", $MOVEZ = "0", $PETHP[1], $PETHUNGER[1]

; Declare Timer Arrays
Global $BUFFS_TIMER[9], $BUFFS_TIMER_DIFF[9], $SKILL_DELAY_CHECK[10], $PARTYBUFFS_TIMER[9], $PARTYBUFFS_TIMER_DIFF[9]

; Declare Off-Set Variables
Global $SOFTWARE_OFFSET_CONFIG = "Custom_OffSets.ini", $CFG_OFFSET_ROOT_KEY = "Custom_32_Offsets_In_Decimal", $CFG_BASEADDRESS_ROOT_KEY = "Perfect_World_Base_Address_In_Decimal", $CFG_BASEADDRESS_APP_KEY = "Application_Title", $CFG_BASEADDRESS_KEY = "Base_Address", $CFG_BASEADDRESSFZ_KEY = "Base_AddressFZ", $CFG_BASEADDRESSEXP_KEY = "Base_AddressEXP"

; Declare Process Variables
Global $APP_BASE_ADDRESS = "0x" & Hex(IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_BASEADDRESS_ROOT_KEY, $CFG_BASEADDRESS_KEY, "")), $APP_BASE_ADDRESSFZ = "0x" & Hex(IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_BASEADDRESS_ROOT_KEY, $CFG_BASEADDRESSFZ_KEY, "")), $APP_BASE_ADDRESSEXP = "0x" & Hex(IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_BASEADDRESS_ROOT_KEY, $CFG_BASEADDRESSEXP_KEY, ""))
Global $APP_TITLE = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_BASEADDRESS_ROOT_KEY, $CFG_BASEADDRESS_APP_KEY, "Perfect World International"), $HANDLE = ControlGetHandle($APP_TITLE, "", ""), $KERNEL32 = DllOpen('kernel32.dll')
Global $PROCESS_ID = WinGetProcess($APP_TITLE), $PROCESS_INFORMATION = _MemoryOpen($PROCESS_ID), $APP_PATH = _ProcessIdPath($PROCESS_ID) 
Global $ANSWER
If @error Then
	$ANSWER = InputBox("Can´t Find Perfect World", "Impossible to detect your Perfect World. If you have another client you would like to attach to, type the name of that client into the field and click OK.  Or click Cancel to Exit", "", "", -1, -1, 0, 0)
	If $answer = "" Then
		Exit
	Else
		Global $APP_TITLE = $answer, $HANDLE = ControlGetHandle($APP_TITLE, "", "")
		Global $PROCESS_ID = WinGetProcess($APP_TITLE), $PROCESS_INFORMATION = _MemoryOpen($PROCESS_ID), $APP_PATH = _ProcessIdPath($PROCESS_ID) 
		If @error Then
			MsgBox(0, "Can´t Find Perfect World", "Impossible to detect your Perfect World. Review settings in " & $SOFTWARE_OFFSET_CONFIG & ". Set the correct value for " & $CFG_BASEADDRESS_APP_KEY & " and for " & $CFG_BASEADDRESS_KEY & " properties.")
		EndIf
	EndIf
EndIf


; First Time Actions
SetExpList()

; Declare Config File Key Variables
Global $SOFTWARE_OFFSET_CONFIG = "Custom_OffSets.ini", $CFG_OFFSET_ROOT_KEY = "Custom_32_Offsets_In_Decimal"
Global $CFG_OFFSET_PETBASE = "PetBase_OffSet", $CFG_OFFSET_PETHP = "PetHP_OffSet", $CFG_OFFSET_PETHUNGER = "PetHunger_OffSet"

; Declare OFFSET Variables

;--------------------------------------------------------------Offset Pointer Finder--------------------------------------------------------------


$FILE = FileOpen($APP_PATH, 16)
$DATA = FileRead($FILE, FileGetSize($APP_PATH))
FileClose($FILE)
$SELECT = StringRegExp($DATA, '(A1(.{8})578B482081C1EC000000E8(.{8}))', 1)
If @error Then
	MsgBox(0, "Issues Attaching For Offsets", "There may be another bot attached to this process. Please close that bot and try again")
	Exit
EndIf
$OPBASE = rev($SELECT[1])
$PICK = StringRegExp($DATA, '(8B15(.{8})50518B4A2081C1EC000000E8(.{8}))', 1)
$PACKET = StringRegExp($DATA,   '6A21' & _                            ; push    21h
                                'E8.{8}' & _                          ; call    sub_740780      ; Call Procedure
                                '8BF0' & _                            ; mov     esi, eax
                                '83C404' & _                          ; add     esp, 4          ; Add
                                '85F6' & _                            ; test    esi, esi        ; Logical Compare
                                '74.{2}' & _                          ; jz      short loc_5D9D9C ; Jump if Zero (ZF=1)
                                '8A442418' & _                        ; mov     al, [esp+4+moveType]
                                '668B4C2410' & _                      ; mov     cx, [esp+4+ukShort]
                                '66C7060000' & _                      ; mov     word ptr [esi], 0
                                '88461E' & _                          ; mov     [esi+1Eh], al
                                '8B442408' & _                        ; mov     eax, [esp+4+XYZpointer1]
                                '66894E1A' & _                        ; mov     [esi+1Ah], cx
                                'D9442414' & _                        ; fld     [esp+4+moveSpeed] ; Load Real
                                '8B10' & _                            ; mov     edx, [eax]
                                '895602' & _                          ; mov     [esi+2], edx
                                '8B4804' & _                          ; mov     ecx, [eax+4]
                                'D80D.{8}' & _                        ; fmul    ds:flt_8BDB08   ; Multiply Real
                                '894E06' & _                          ; mov     [esi+6], ecx
                                '8B5008' & _                          ; mov     edx, [eax+8]
                                '8B44240C' & _                        ; mov     eax, [esp+4+XYZpointer2]
                                '89560A' & _                          ; mov     [esi+0Ah], edx
                                'D805.{8}' & _                        ; fadd    ds:flt_8AE894   ; Add Real
                                '8B08' & _                            ; mov     ecx, [eax]
                                '894E0E' & _                          ; mov     [esi+0Eh], ecx
                                '8B5004' & _                          ; mov     edx, [eax+4]
                                '895612' & _                          ; mov     [esi+12h], edx
                                '8B4008' & _                          ; mov     eax, [eax+8]
                                '894616' & _                          ; mov     [esi+16h], eax
                                'E8.{8}' & _                          ; call    _ftol           ; Call Procedure
                                '668B4C241C' & _                      ; mov     cx, [esp+4+moveCounter]
                                '6689461C' & _                        ; mov     [esi+1Ch], ax
                                '66894E1F' & _                        ; mov     [esi+1Fh], cx
                                '8B15(.{8})' & _                      ; mov     edx, dword_98657C
                                '6A21' & _                            ; push    21h             ; Size
                                '56' & _                              ; push    esi             ; Src
                                '8B4A20' & _                          ; mov     ecx, [edx+20h]
                                'E8(.{8})' & _                        ; call    __SendPacket    ; Call Procedure
                                '56' & _                              ; push    esi
                                'E8.{8}' & _                          ; call    sub_740790      ; Call Procedure
                                '83C404' & _                          ; add     esp, 4          ; Add
                                '5E' & _                              ; pop     esi
                                'C3',2)                               ; retn                    ; Return Near from Procedure
;ConsoleWrite('$REALBASEADDRESS = 0x' & rev($SELECT[1])&@CRLF)
Global $REALBASEADDRESS = '0x' & rev($SELECT[1])
$CALL_POS = StringInStr($DATA, $SELECT[0])/2 + 0x40000E
;ConsoleWrite('$SELECT_CALL = 0x' & Hex(('0x' & rev($SELECT[2])) + $call_pos + 5)&@CRLF)
Global $SELECT_CALL = '0x' & Hex(('0x' & rev($SELECT[2])) + $call_pos + 5)
$CALL_POS = StringInStr($DATA, $PICK)/2 + 0x400010
;ConsoleWrite('$PICK_CALL = 0x' & Hex(('0x'&rev($PICK)) + $call_pos + 5)&@CRLF)
$CALL_POS = StringInStr($DATA, $PACKET[0])/2 + 0x40007B
;ConsoleWrite('$SENDPACKETADDRESS = 0x' & Hex(Dec(rev($PACKET[2])) + $CALL_POS + 6)&@CRLF)
Global $SENDPACKETADDRESS = '0x' & Hex(Dec(rev($PACKET[2])) + $CALL_POS + 6)

;--------------------------------------------------------------Character Pointer Section--------------------------------------------------------------

Global $OFFSET_TAR[3], $CFG_OFFSET_TAR = "Target_OffSet"
$OFFSET_TAR[1] = 52					;0x30
$OFFSET_TAR[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_TAR, "")

Global $OFFSET_CASTING, $OFFSET_NAME, $OFFSET_LVL, $OFFSET_CLASS, $OFFSET_HP, $OFFSET_CHARID, $OFFSET_MAXHP, $OFFSET_MAX_HP,  $OFFSET_MP, $OFFSET_MAX_MP, $OFFSET_MAXMP, $OFFSET_EXP, $OFFSET_STR, $OFFSET_DEX, $OFFSET_VIT, $OFFSET_MAG, $OFFSET_SPIRIT, $OFFSET_GOLD, $OFFSET_CHI, $OFFSET_AP, $OFFSET_X, $OFFSET_Y, $OFFSET_Z, $OFFSET_TAR, $OFFSET_TARHP, $OFFSET_TARMAXHP, $OFFSET_TARNAME, $OFFSET_TARLVL, $OFFSET_TARSPEC
Global $CFG_OFFSET_CASTING = "CASTING_OffSet", $OFFSET_CASTING = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_CASTING, "")
Global $CFG_OFFSET_NAME = "NAME_OffSet", $OFFSET_NAME = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NAME, "")
Global $CFG_OFFSET_LVL = "LVL_OffSet", $OFFSET_LVL = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_LVL, "")
Global $CFG_OFFSET_CLASS = "CLASS_OffSet", $OFFSET_CLASS = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_CLASS, "")
Global $CFG_OFFSET_HP = "HP_OffSet", $OFFSET_HP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_HP, "")
Global $CFG_OFFSET_CHARID = "CHARID_OffSet", $OFFSET_CHARID = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_CHARID, "")
Global $CFG_OFFSET_MAXHP = "MaxHP_OffSet", $OFFSET_MAX_HP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_MAXHP, "")
Global $CFG_OFFSET_MP = "MP_OffSet", $OFFSET_MP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_MP, "")
Global $CFG_OFFSET_MAXMP = "MaxMP_OffSet", $OFFSET_MAX_MP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_MAXMP, "")
Global $CFG_OFFSET_EXP = "EXP_OffSet", $OFFSET_EXP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_EXP, "")
Global $CFG_OFFSET_STR = "STR_OffSet", $OFFSET_STR = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_STR, "")
Global $CFG_OFFSET_DEX = "DEX_OffSet", $OFFSET_DEX = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_DEX, "")
Global $CFG_OFFSET_VIT = "VIT_OffSet", $OFFSET_VIT = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_VIT, "")
Global $CFG_OFFSET_MAG = "MAG_OffSet", $OFFSET_MAG = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_MAG, "")
Global $CFG_OFFSET_SPIRIT = "SPIRIT_OffSet", $OFFSET_SPIRIT = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_SPIRIT, "")
Global $CFG_OFFSET_GOLD = "Gold_Offset", $OFFSET_GOLD = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_GOLD, "")
Global $CFG_OFFSET_FLYSPEED = "FlySpeed_Offset", $OFFSET_FLYSPEED = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_FLYSPEED, "")
Global $CFG_OFFSET_FLYCOUNTER = "FlyCounter_OffSet", $OFFSET_FLYCOUNTER = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_FLYCOUNTER, "")
Global $CFG_OFFSET_MOVEMODE = "MoveMode_OffSet", $OFFSET_MOVEMODE = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_MOVEMODE, "")
Global $CFG_OFFSET_CHARSTATE = "CharState_OffSet", $OFFSET_CHARSTATE = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_CHARSTATE, "")
Global $CFG_OFFSET_CHI = "CHI_OffSet", $OFFSET_CHI = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_CHI, "")
Global $CFG_OFFSET_MAXCHI = "MAXCHI_OffSet", $OFFSET_MAXCHI = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_MAXCHI, "")
Global $CFG_OFFSET_X = "X_OffSet", $OFFSET_X = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_X, "")
Global $CFG_OFFSET_Y = "Y_OffSet", $OFFSET_Y = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Y, "")
Global $CFG_OFFSET_Z = "Z_OffSet", $OFFSET_Z = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Z, "")

;--------------------------------------------------------------Array Pointer Section--------------------------------------------------------------


;-------------------Player Array Offsets-------------------------
Global $OFFSET_PLAYERBASE[4], $CFG_OFFSET_PLAYERBASE = "PlayerBase_OffSet"
$OFFSET_PLAYERBASE[1] = 28 			;0x18
$OFFSET_PLAYERBASE[2] = 32 			;0x20
$OFFSET_PLAYERBASE[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERBASE, "")

Global $OFFSET_PLAYERCOUNT[4], $CFG_OFFSET_PLAYERCOUNT = "PlayerCount_OffSet"
$OFFSET_PLAYERCOUNT[1] = 28 			;0x18
$OFFSET_PLAYERCOUNT[2] = 32 		;0x20
$OFFSET_PLAYERCOUNT[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERCOUNT, "")

Global $CFG_OFFSET_PLAYERID = "PlayerID_OffSet", $OFFSET_PLAYERID = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERID, "") 
Global $CFG_OFFSET_PLAYERLVL = "PlayerLVL_OffSet", $OFFSET_PLAYERLVL = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERLVL, "") 
Global $CFG_OFFSET_PLAYERNAME = "PlayerName_OffSet", $OFFSET_PLAYERNAME = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERNAME, "") 
Global $CFG_OFFSET_PLAYERHP = "PlayerHP_OffSet", $OFFSET_PLAYERHP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERHP, "") 
Global $CFG_OFFSET_PLAYERMAXHP = "PlayerMAXHP_OffSet", $OFFSET_PLAYERMAXHP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERMAXHP, "") 
Global $CFG_OFFSET_PLAYERCLASS = "PlayerClass_OffSet", $OFFSET_PLAYERCLASS = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PLAYERCLASS, "") 
Global $OFFSET_PLAYERX = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_X, "")
Global $OFFSET_PLAYERY = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Y, "")
Global $OFFSET_PLAYERZ = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Z, "")

;-------------------NPC Array Offsets-------------------------
Global $OFFSET_NPCBASE[4], $CFG_OFFSET_NPCBASE = "NPCBase_OffSet"
$OFFSET_NPCBASE[1] = 28 				;0x18
$OFFSET_NPCBASE[2] = 36 			;0x24
$OFFSET_NPCBASE[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCBASE, "") 				;0x88

Global $OFFSET_NPCCOUNT[4], $CFG_OFFSET_NPCCOUNT = "NPCCount_OffSet"
$OFFSET_NPCCOUNT[1] = 28 			;0x18
$OFFSET_NPCCOUNT[2] = 36 			;0x24
$OFFSET_NPCCOUNT[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCCOUNT, "")

Global $CFG_OFFSET_NPCID = "NPCID_OffSet", $OFFSET_NPCID = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCID, "")
Global $CFG_OFFSET_NPCPAI = "NPCPAI_OffSet", $OFFSET_NPCPAI = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCPAI, "")
Global $CFG_OFFSET_NPCNAME = "NPCName_OffSet", $OFFSET_NPCNAME = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCNAME, "")
Global $CFG_OFFSET_NPCLVL = "NPCLVL_OffSet", $OFFSET_NPCLVL = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCLVL, "")
Global $CFG_OFFSET_NPCHP = "NPCHP_OffSet", $OFFSET_NPCHP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCHP, "")
Global $CFG_OFFSET_NPCMAXHP = "NPCMAXHP_OffSet", $OFFSET_NPCMAXHP = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCMAXHP, "")
Global $CFG_OFFSET_NPCSPECIAL = "NPCSpecial_OffSet", $OFFSET_NPCSPECIAL = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_NPCSPECIAL, "") 
Global $OFFSET_NPCX = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_X, "")
Global $OFFSET_NPCY = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Y, "") 
Global $OFFSET_NPCZ = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Z, "")


;-------------------Item Array Offsets-------------------------
Global $OFFSET_ITEMBASE[4], $CFG_OFFSET_ITEMBASE = "ItemBase_OffSet"
$OFFSET_ITEMBASE[1] = 28 			;0x18
$OFFSET_ITEMBASE[2] = 40 			;0x28
$OFFSET_ITEMBASE[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ITEMBASE, "") 

Global $CFG_OFFSET_ITEMID = "ItemID_OffSet", $OFFSET_ITEMID = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ITEMID, "") 
Global $CFG_OFFSET_ITEMSN = "ItemSN_OffSet", $OFFSET_ITEMSN = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ITEMSN, "") 
Global $CFG_OFFSET_ITEMNAME = "ItemName_OffSet", $OFFSET_ITEMNAME = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ITEMNAME, "")
Global $OFFSET_ITEMX = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_X, "")
Global $OFFSET_ITEMY = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Y, "") 
Global $OFFSET_ITEMZ = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_Z, "") 

;-------------------Inventory Array Offsets-------------------------
Global $OFFSET_INVENTORYBASE[3], $CFG_OFFSET_INVENTORYBASE = "InventoryBase_OffSet"
$OFFSET_INVENTORYBASE[1] = 3236		;0xC50
$OFFSET_INVENTORYBASE[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYBASE, "") 

Global $OFFSET_EQUIPPEDINVENTORBASE[3], $CFG_OFFSET_EQUIPPEDINVENTORBASE = "EquippedInventoryBase_OffSet"
$OFFSET_EQUIPPEDINVENTORBASE[1] = 3252		;0xC50
$OFFSET_EQUIPPEDINVENTORBASE[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $OFFSET_EQUIPPEDINVENTORBASE, "") 

Global $CFG_OFFSET_INVENTORYID = "InventoryID_OffSet", $OFFSET_INVENTORYID = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYID, "") 
Global $CFG_OFFSET_INVENTORYSTACKAMOUNT = "InventoryStackAmount_OffSet", $OFFSET_INVENTORYSTACKAMOUNT = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYSTACKAMOUNT, "") 
Global $CFG_OFFSET_INVENTORYMAXSTACKAMOUNT = "InventoryMAXStackAmount_OffSet", $OFFSET_INVENTORYMAXSTACKAMOUNT = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYMAXSTACKAMOUNT, "") 
Global $CFG_OFFSET_INVENTORYSELLPRICE = "InventoryPrice_OffSet", $OFFSET_INVENTORYSELLPRICE = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYSELLPRICE, "") 
Global $CFG_OFFSET_INVENTORYBUYPRICE = "InventorySellPrice_OffSet", $OFFSET_INVENTORYBUYPRICE = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYBUYPRICE, "") 
Global $CFG_OFFSET_INVENTORYDESCRIPTION = "InventoryDescription_OffSet", $OFFSET_INVENTORYDESCRIPTION = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_INVENTORYDESCRIPTION, "") 

;--------------------------------------------------------------Action Pointer Section--------------------------------------------------------------

Global $OFFSET_ACTIONFLAG[4], $CFG_OFFSET_ACTIONFLAG = "ActionFlag_Offset"
$OFFSET_ACTIONFLAG[1] = 52			;0x30
$OFFSET_ACTIONFLAG[2] = 4168		;0x100C
$OFFSET_ACTIONFLAG[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONFLAG, "24")

Global $OFFSET_ACTIONREAD[5], $CFG_OFFSET_ACTIONREAD = "ActionRead_Offset"
$OFFSET_ACTIONREAD[1] = 52			;0x30
$OFFSET_ACTIONREAD[2] = 4168 		;0x100C
$OFFSET_ACTIONREAD[3] = 48			;030
$OFFSET_ACTIONREAD[4] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONREAD, "4")

Global $OFFSET_ACTIONREAD2[5], $CFG_OFFSET_ACTIONREAD2 = "ActionRead2_Offset"
$OFFSET_ACTIONREAD2[1] = 52			;0x30
$OFFSET_ACTIONREAD2[2] = 4168 		;0x100C
$OFFSET_ACTIONREAD2[3] = 48			;030
$OFFSET_ACTIONREAD2[4] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONREAD2, "8")

Global $OFFSET_ACTIONREAD3[5], $CFG_OFFSET_ACTIONREAD3 = "ActionRead3_Offset"
$OFFSET_ACTIONREAD3[1] = 52			;0x30
$OFFSET_ACTIONREAD3[2] = 4168 		;0x100C
$OFFSET_ACTIONREAD3[3] = 48			;030
$OFFSET_ACTIONREAD3[4] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONREAD3, "28") ; 1c

Global $OFFSET_ACTIONWRITE[4], $CFG_OFFSET_ACTIONWRITE = "ActionWrite_Offset"
$OFFSET_ACTIONWRITE[1] = 52			;0x30
$OFFSET_ACTIONWRITE[2] = 4168 		;0x100C
$OFFSET_ACTIONWRITE[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONWRITE, "12") ;0xC

Global $OFFSET_ACTIONWRITE2[4], $CFG_OFFSET_ACTIONWRITE2 = "ActionWrite2_Offset"
$OFFSET_ACTIONWRITE2[1] = 52		;0x30
$OFFSET_ACTIONWRITE2[2] = 4168 		;0x100C
$OFFSET_ACTIONWRITE2[3] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONWRITE2, "20") ;0x14

Global $OFFSET_ACTIONMOVEX[6], $CFG_OFFSET_ACTIONMOVEX = "ActionMoveX_OffSet"
$OFFSET_ACTIONMOVEX[1] = 52			;0x30
$OFFSET_ACTIONMOVEX[2] = 4168 		;0x100C
$OFFSET_ACTIONMOVEX[3] = 48			;030
$OFFSET_ACTIONMOVEX[4] = 4			;0x4 
$OFFSET_ACTIONMOVEX[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONMOVEX, "32")

Global $OFFSET_ACTIONMOVEY[6], $CFG_OFFSET_ACTIONMOVEY = "ActionMoveY_OffSet"
$OFFSET_ACTIONMOVEY[1] = 52			;0x30
$OFFSET_ACTIONMOVEY[2] = 4168 		;0x100C
$OFFSET_ACTIONMOVEY[3] = 48			;030
$OFFSET_ACTIONMOVEY[4] = 4			;0x4 
$OFFSET_ACTIONMOVEY[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONMOVEY, "40")

Global $OFFSET_ACTIONMOVEZ[6], $CFG_OFFSET_ACTIONMOVEZ = "ActionMoveZ_OffSet"
$OFFSET_ACTIONMOVEZ[1] = 52			;0x30
$OFFSET_ACTIONMOVEZ[2] = 4168 		;0x100C
$OFFSET_ACTIONMOVEZ[3] = 48			;030
$OFFSET_ACTIONMOVEZ[4] = 4			;0x4 
$OFFSET_ACTIONMOVEZ[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONMOVEZ, "36")

Global $OFFSET_ACTIONHEIGHT[6], $CFG_OFFSET_ACTIONHEIGHT = "ActionHeight_OffSet"
$OFFSET_ACTIONHEIGHT[1] = 52		;0x30
$OFFSET_ACTIONHEIGHT[2] = 4168 		;0x100C
$OFFSET_ACTIONHEIGHT[3] = 48		;030
$OFFSET_ACTIONHEIGHT[4] = 4			;0x4 
$OFFSET_ACTIONHEIGHT[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONHEIGHT, "104")

Global $OFFSET_ACTIONHEIGHTFLAG[6], $CFG_OFFSET_ACTIONHEIGHTFLAG = "ActionHeightFlag_OffSet"
$OFFSET_ACTIONHEIGHTFLAG[1] = 52	;0x30
$OFFSET_ACTIONHEIGHTFLAG[2] = 4168 	;0x100C
$OFFSET_ACTIONHEIGHTFLAG[3] = 48	;030
$OFFSET_ACTIONHEIGHTFLAG[4] = 4		;0x4 
$OFFSET_ACTIONHEIGHTFLAG[5]= IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONHEIGHTFLAG, "100")

Global $OFFSET_ACTIONHEIGHTFLAG2[6], $CFG_OFFSET_ACTIONHEIGHTFLAG2 = "ActionHeightFlag2_Offset"
$OFFSET_ACTIONHEIGHTFLAG2[1] = 52	;0x30
$OFFSET_ACTIONHEIGHTFLAG2[2] = 4168 ;0x100C
$OFFSET_ACTIONHEIGHTFLAG2[3] = 48	;030
$OFFSET_ACTIONHEIGHTFLAG2[4] = 4	;0x4 
$OFFSET_ACTIONHEIGHTFLAG2[5]= IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONHEIGHTFLAG2, "108")

Global $OFFSET_ACTIONDONE[6], $CFG_OFFSET_ACTIONDONE = "ActionDoneFlag_OffSet"
$OFFSET_ACTIONDONE[1] = 52			;0x30
$OFFSET_ACTIONDONE[2] = 4168 		;0x100C
$OFFSET_ACTIONDONE[3] = 48			;030
$OFFSET_ACTIONDONE[4] = 4			;0x4 
$OFFSET_ACTIONDONE[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONDONE, "8")

Global $OFFSET_ACTIONVALUE[6], $CFG_OFFSET_ACTIONVALUE = "ActionValue_OffSet"
$OFFSET_ACTIONVALUE[1] = 52			;0x30
$OFFSET_ACTIONVALUE[2] = 4168 		;0x100C
$OFFSET_ACTIONVALUE[3] = 48			;030
$OFFSET_ACTIONVALUE[4] = 4			;0x4 
$OFFSET_ACTIONVALUE[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONVALUE, "44")

Global $OFFSET_ACTIONVALUE2[6], $CFG_OFFSET_ACTIONVALUE2 = "ActionValue2_OffSet"
$OFFSET_ACTIONVALUE2[1] = 52		;0x30
$OFFSET_ACTIONVALUE2[2] = 4168 		;0x100C
$OFFSET_ACTIONVALUE2[3] = 48		;030
$OFFSET_ACTIONVALUE2[4] = 4			;0x4 
$OFFSET_ACTIONVALUE2[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONVALUE2, "64")

Global $OFFSET_ACTIONSETERROR[6], $CFG_OFFSET_ACTIONSETERROR = "ActionSetError_Offset"
$OFFSET_ACTIONSETERROR[1] = 52		;0x30
$OFFSET_ACTIONSETERROR[2] = 4168 	;0x100C
$OFFSET_ACTIONSETERROR[3] = 48		;0x30
$OFFSET_ACTIONSETERROR[4] = 8		;0x8
$OFFSET_ACTIONSETERROR[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONSETERROR, "52")

Global $OFFSET_ACTIONFINISHED[6], $CFG_OFFSET_ACTIONFINISHED = "ActionFinished_Offset"
$OFFSET_ACTIONFINISHED[1] = 52		;0x30
$OFFSET_ACTIONFINISHED[2] = 4168 	;0x100C
$OFFSET_ACTIONFINISHED[3] = 48		;0x30
$OFFSET_ACTIONFINISHED[4] = 8		;0x8
$OFFSET_ACTIONFINISHED[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONFINISHED, "8")

Global $OFFSET_ACTIONSTART[6], $CFG_OFFSET_ACTIONSTART = "ActionStart_Offset"
$OFFSET_ACTIONSTART[1] = 52			;0x30
$OFFSET_ACTIONSTART[2] = 4168 		;0x100C
$OFFSET_ACTIONSTART[3] = 48			;0x30
$OFFSET_ACTIONSTART[4] = 8			;0x8
$OFFSET_ACTIONSTART[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONSTART, "20")

Global $OFFSET_ACTIONNOTSTART[6], $CFG_OFFSET_ACTIONNOTSTART = "ActionNotStart_Offset"
$OFFSET_ACTIONNOTSTART[1] = 52		;0x30
$OFFSET_ACTIONNOTSTART[2] = 4168	;0x100C
$OFFSET_ACTIONNOTSTART[3] = 48		;0x30
$OFFSET_ACTIONNOTSTART[4] = 8		;0x8
$OFFSET_ACTIONNOTSTART[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONNOTSTART, "36")

Global $OFFSET_ACTIONOBJECT[6], $CFG_OFFSET_ACTIONOBJECT = "ActionObject_Offset"
$OFFSET_ACTIONOBJECT[1] = 52		;0x30
$OFFSET_ACTIONOBJECT[2] = 4168 		;0x100C
$OFFSET_ACTIONOBJECT[3] = 48		;0x30
$OFFSET_ACTIONOBJECT[4] = 8			;0x8
$OFFSET_ACTIONOBJECT[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONOBJECT, "32")

Global $OFFSET_OBJECTACTION[6], $CFG_OFFSET_OBJECTACTION = "ObjectAction_Offset"
$OFFSET_OBJECTACTION[1] = 52		;0x30
$OFFSET_OBJECTACTION[2] = 4168 		;0x100C
$OFFSET_OBJECTACTION[3] = 48		;0x30
$OFFSET_OBJECTACTION[4] = 8			;0x8
$OFFSET_OBJECTACTION[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_OBJECTACTION, "56")

Global $OFFSET_ACTIONSKILL[6], $CFG_OFFSET_ACTIONSKILL = "ActionSkill_Offset"
$OFFSET_ACTIONSKILL[1] = 52			;0x30
$OFFSET_ACTIONSKILL[2] = 4168 		;0x100C
$OFFSET_ACTIONSKILL[3] = 48			;0x30
$OFFSET_ACTIONSKILL[4] = 8			;0x8
$OFFSET_ACTIONSKILL[5] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_ACTIONSKILL, "80")


 
;==============================================================End Pointer Section==============================================================

Global $CHAR_DATA_BASE = _MemoryRead(_MemoryRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION) + 0x34 , $PROCESS_INFORMATION)
Global $PLAYER_DATA_BASE = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_PLAYERBASE)
Global $NPC_DATA_BASE = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_NPCBASE)
Global $ITEM_DATA_BASE = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ITEMBASE)
Global $NAME = _MemoryRead(_MemoryRead($CHAR_DATA_BASE + $OFFSET_NAME, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[30]')
Global $CFG_FLYESCAPE_ROOT_KEY = "FlyEscape", $CFG_FLYESCAPE_FLAG_KEY = $NAME & "--" & "FlyEscapeFlag", $CFG_FLYESCAPE_KEY = $NAME & "--" & "FlyEscapeKey", $CFG_FLYESCAPE_DAMAGE_KEY = $NAME & "--" & "FlyEscapeDamage", $CFG_FLYESCAPE_SPACE_KEY = $NAME & "--" & "FlyEscapeTotalSpaces"
Global $CFG_EXTRAS_ROOT_KEY = "Extras", $CFG_EXTRAS_AKS_KEY = $NAME & "--" & "ExtrasAKS", $CFG_HEAL_FM_KEY = $NAME & "--" & "HEALFM", $CFG_EXTRAS_HBN_KEY = $NAME & "--" & "ExtrasHBN", $CFG_EXTRAS_FREEZE_KEY = $NAME & "--" & "ExtrasFreeze", $CFG_EXTRAS_ATTACKRAD_KEY = $NAME & "--" & "ExtrasAttackRad", $CFG_EXTRAS_HOMEX_KEY = $NAME & "--" & "ExtrasHomeX", $CFG_EXTRAS_HOMEY_KEY = $NAME & "--" & "ExtrasHomeY", $CFG_EXTRAS_HOMEZ_KEY = $NAME & "--" & "ExtrasHomeZ"
Global $CFG_SKILLS_ROOT_KEY = "Skills", $CFG_SKILL_UBOUND_KEY = $NAME & "--" & "SkillUbound", $CFG_SKILL_COMBO_KEY = $NAME & "--" & "SkillComboKey", $CFG_SKILL_DELAY_KEY = $NAME & "--" & "SkillDelay", $SKCOUNTCFG = IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_UBOUND_KEY, "1")
Global $CFG_BUFFS_ROOT_KEY = "Buffs", $CFG_BUFFS_FLAG_KEY = $NAME & "--" & "AutoBuffsFlag", $CFG_BUFFS_UBOUND_KEY = $NAME & "--" & "BuffsUbound", $CFG_BUFFS_COMBO_KEY = $NAME & "--" & "BuffsComboKey", $CFG_BUFFS_DELAY_KEY = $NAME & "--" & "BuffsDelay", $CFG_BUFFS_FREQUENCY_KEY = $NAME & "--" & "BuffsFrequency", $SKCOUNTCFG_BUFFS = IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, "1")
Global $CFG_WEAPONS_ROOT_KEY = "ChangeWeapons", $CFG_WEAPONS_FLAG_KEY = $NAME & "--" & "ChangeWeaponsFlag", $CFG_WEAPONS_UBOUND_KEY = $NAME & "--" & "ChangeWeaponsUbound", $CFG_WEAPONS_COMBO_KEY = $NAME & "--" & "ChangeWeaponsComboKey", $CFG_WEAPONS_DELAY_KEY = $NAME & "--" & "ChangeWeaponsDelay", $SKCOUNTCFG_WEAPONS = IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_UBOUND_KEY, "1")
Global $CFG_MOBLIST_ROOT_KEY = "MobList", $CFG_MOBLIST_UBOUND_KEY = $NAME & "--" & "MobListUbound", $CFG_MOBLIST_MONSTER_KEY = $NAME & "--" & "Monster", $CFG_MOBLIST_MONSTERNAME_KEY = $NAME & "--" & "MonsterName", $CFG_MOBLIST_TARGET_KEY = $NAME & "--" & "TargetKey"
Global $CFG_HEAL_ROOT_KEY = "Heal", $CFG_HEAL_AUTOREST_HP_KEY = $NAME & "--" & "AutoRestHP", $CFG_HEAL_AUTOREST_HP_PERC_KEY = $NAME & "--" & "AutoRestHPPerc", $CFG_HEAL_AUTOREST_MP_KEY = $NAME & "--" & "AutoRestMP", $CFG_HEAL_AUTOREST_MP_PERC_KEY = $NAME & "--" & "AutoRestMPPerc", $CFG_HEAL_AUTOREST_KEY = $NAME & "--" & "AutoRestKey", $CFG_HEAL_AUTOPOT_HP_FLAG_KEY = $NAME & "--" & "AutoPotHPFlag", $CFG_HEAL_AUTOPOT_HP_PERC_KEY = $NAME & "--" & "AutoPotHPPerc", $CFG_HEAL_AUTOPOT_HP_KEY = $NAME & "--" & "AutoPotHPKey", $CFG_HEAL_AUTOPOT_HP_TIMER = $NAME & "--" & "AutoPotHPTimer", $CFG_HEAL_AUTOHP_FLAG_KEY = $NAME & "--" & "AutoHPFlag", $CFG_HEAL_AUTOHP_PERC_KEY = $NAME & "--" & "AutoHPPerc", $CFG_HEAL_AUTOHP_KEY = $NAME & "--" & "AutoHPKey", $CFG_HEAL_AUTOHP_TIMER = $NAME & "--" & "AutoHPTimer", $CFG_HEAL_AUTOPOT_MP_FLAG_KEY = $NAME & "--" & "AutoPotFlagMP", $CFG_HEAL_AUTOPOT_MP_PERC_KEY = $NAME & "--" & "AutoPotMPPerc", $CFG_HEAL_AUTOPOT_MP_KEY = $NAME & "--" & "AutoPotMPKey", $CFG_HEAL_RES_ON_DIE_KEY = $NAME & "--" & "ResOnDie", $CFG_HEAL_APOTHOCARY_RAIL_KEY = $NAME & "--" & "ApothocaryRail", $CFG_HEAL_APOTHOCARY_TIMER_KEY = $NAME & "--" & "ApothocaryTimer", $CFG_HEAL_MOVE_TO_CORPSE_KEY = $NAME & "--" & "MoveToCorpse", $CFG_HEAL_DEFEND_KEY = "DEFENDING", $CFG_HEAL_CPU_THROTTLE_KEY = "CPUThrottle", $CFG_HEAL_LAST_GUI_X = "LastGUIX", $CFG_HEAL_LAST_GUI_Y = "LastGUIY"
Global $CFG_PETHEAL_ROOT_KEY = "PetHeal", $CFG_PETHEAL_CHECK_KEY = $NAME & "--" & "AutoHealPetCheck", $CFG_PETATTACK_CHECK_KEY = $NAME & "--" & "PetAttackCheck", $CFG_PETHEAL_SLOT_KEY = $NAME & "--" & "AutoHealPetNumber", $CFG_PETHEAL_HP_KEY = $NAME & "--" & "AutoHealPetHP", $CFG_PETHEAL_HEALKEY_KEY = $NAME & "--" & "AutoHealPetKey", $CFG_PETHEAL_FEEDKEY_KEY = $NAME & "--" & "AutoFeedPetKey", $CFG_PETHEAL_SUMMONKEY_KEY = $NAME & "--" & "SummonPetKey", $CFG_PETHEAL_REZKEY_KEY = $NAME & "--" & "ResPetKey"
Global $CFG_LOOT_ROOT_KEY = "Loot", $CFG_LOOT_FLAG_KEY = $NAME & "--" & "LootFlag", $CFG_LOOTHERBS_FLAG_KEY = $NAME & "--" & "LootHerbsFlag", $CFG_LOOTRESOURCES_FLAG_KEY = $NAME & "--" & "LootResourcesFlag", $CFG_LOOT_TIMES_KEY = $NAME & "--" & "Times", $CFG_LOOT_KEY = $NAME & "--" & "LootKey"
Global $CFG_RAIL_ROOT_KEY = "Rails", $CFG_RAIL_UBOUND_KEY = $NAME & "--" & "RailUbound", $CFG_RAIL_APOTHOCARYID_KEY = $NAME & "--" & "ApothocaryID", $CFG_RAIL_X_KEY = $NAME & "--" & "RailX", $CFG_RAIL_Z_KEY = $NAME & "--" & "RailZ", $CFG_RAIL_Y_KEY = $NAME & "--" & "RailY"

; Declare Hunt Radius Variables
Global $ATTACK_RAD = "0", $TARDIS = "0", $LASTTARDIS = "0", $TARHOMEDIS = "0", $HOME_X = IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HOMEX_KEY, "Float"), $HOME_Y = IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HOMEY_KEY, "Float"), $HOME_Z = IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HOMEZ_KEY, "Float")

; Get the default browser
$default_browser_path = RegRead('HKCR\' & RegRead('HKCR\.html', '') & '\shell\open\command', '')
If StringLeft($default_browser_path, 1) = '"' Then
    $default_browser_path = StringRegExpReplace($default_browser_path, '\A"+|".*\z', '')
Else
    $default_browser_path = StringRegExpReplace($default_browser_path, '\A\s+|\s.*\z', '')
EndIf


;********************************************************************************
;* Main Form Variables                                                          *
;********************************************************************************
Global $LAST_START_X = 0 
Global $LAST_START_Y = 0 
If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_LAST_GUI_X, "") <> -32000 Then
	$LAST_START_X = IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_LAST_GUI_X, "")
EndIf
If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_LAST_GUI_Y, "") <> -32000 Then
	$LAST_START_Y = IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_LAST_GUI_Y, "")
EndIf

; Declare Menu Bar Variables
$ProphetBOT = GUICreate($SOFTWARE_TITLE, 251, 601, $LAST_START_X, $LAST_START_Y)
GUISetState()
GUISetOnEvent($GUI_EVENT_CLOSE, "WindowCloseClicked")
TraySetIcon("ProphetBot.ico")
GUISetIcon("ProphetBot.ico")
$MenuItem1 = GUICtrlCreateMenu("&File")
$MenuItem4 = GUICtrlCreateMenuItem("Start", $MenuItem1)
GUICtrlSetOnEvent(-1, "StartOrStop")
$MenuItem5 = GUICtrlCreateMenuItem("Exit", $MenuItem1)
GUICtrlSetOnEvent(-1, "WindowCloseClicked")
$MenuItem2 = GUICtrlCreateMenu("&Options")
$MenuItem7 = GUICtrlCreateMenuItem("Skills", $MenuItem2)
GUICtrlSetOnEvent(-1, "SetSkills")
$MenuItem6 = GUICtrlCreateMenuItem("Buffs", $MenuItem2)
GUICtrlSetOnEvent(-1, "SetAutoBuffs")
$MenuItem8 = GUICtrlCreateMenuItem("Life Support", $MenuItem2)
GUICtrlSetOnEvent(-1, "SetLifeSupport")
$MenuItem10 = GUICtrlCreateMenuItem("Pet Support", $MenuItem2)
GUICtrlSetOnEvent(-1, "SetPetSupport")
$MenuItem9 = GUICtrlCreateMenuItem("Fly 2 Escape", $MenuItem2)
GUICtrlSetOnEvent(-1, "SetFlyEscape")
$MenuItem11 = GUICtrlCreateMenuItem("Rotate Weapons", $MenuItem2)
GUICtrlSetOnEvent(-1, "SetChangeWeapons")
$MenuItem12 = GUICtrlCreateMenuItem("Target List", $MenuItem2)
GUICtrlSetOnEvent(-1, "Set_MobList")
$MenuItem3 = GUICtrlCreateMenu("Help")
GUISetFont(8, 800, 0, "MS Sans Serif")
GUISetBkColor(0x000000)
Global $MenuItem13 = GUICtrlCreateMenuItem("Online Support", $MenuItem3)
GUICtrlSetOnEvent(-1, "OnlineSupport")
Global $MenuItem14 = GUICtrlCreateMenuItem("About Prophet Bot", $MenuItem3)
GUICtrlSetOnEvent(-1, "Set_AboutProphet")

; Declare Bot Status Group Variables
$BotStatus = GUICtrlCreateGroup("BOT Status", 0, 0, 250, 51, -1, $WS_EX_TRANSPARENT)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($BotStatus), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlCreateGroup("Bot Status", -99, -99, 1, 1)
GUICtrlSetTip(-1, "Bot Status")
$BUTTON_START = GUICtrlCreateButton("Start", 5, 15, 60, 30)
GUICtrlSetOnEvent(-1, "StartOrStop")
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBKColor(-1, 0x000000)
$LABEL_BOT_STATUS = GUICtrlCreateLabel("BOT Status: Stopped", 75, 14, 155, 15)
GUICtrlSetColor(-1, 0xC0C0C0)
$LABEL_GENERAL_STATUS = GUICtrlCreateLabel("Action: Nothing", 75, 31, 200, 15)
GUICtrlSetColor(-1, 0xC0C0C0)

; Declare Character Info Group Variables
$CharInfo = GUICtrlCreateGroup("Character Info", 0, 51, 250, 132)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CharInfo), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x00FF00)
$LabeNAME = GUICtrlCreateLabel("Name:", 12, 67, 35, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_NAME = GUICtrlCreateLabel("None", 50, 67, 150, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelLVL = GUICtrlCreateLabel("Level:", 13, 81, 35, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_LVL = GUICtrlCreateLabel("0", 52, 81, 40, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelCLASS = GUICtrlCreateLabel("Class:", 98, 81, 34, 18)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_CLASS = GUICtrlCreateLabel("None", 134, 81, 110, 18)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelHP = GUICtrlCreateLabel("HP:", 9, 100, 22, 17)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($LabelHP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 15743782)
GUICtrlSetBkColor(-1, 0x000000)
$Perc_HP = GUICtrlCreateProgress(32, 98, 120, 17, $PBS_SMOOTH)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($Perc_HP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 15743782)
GUICtrlSetBkColor(-1, 0xFFB3B5)
$Label_HP = GUICtrlCreateLabel("0/0", 32, 98, 120, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 7, 10000, 0, "Arial")
GUICtrlSetBkColor(-1, -2)
$LabelMP = GUICtrlCreateLabel("MP:", 8, 120, 23, 17)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($LabelMP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x3232FF)
GUICtrlSetBkColor(-1, 0x000000)
$Perc_MP = GUICtrlCreateProgress(32, 118, 120, 17, $PBS_SMOOTH)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($Perc_MP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x3232FF)
GUICtrlSetBkColor(-1, 0x9999FF)
$Label_MP = GUICtrlCreateLabel("0/0", 32, 118, 120, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 7, 10000, 0, "Arial")
GUICtrlSetBkColor(-1, -2)
$LabelEXP = GUICtrlCreateLabel("Exp:", 5, 138, 25, 17)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($LabelEXP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x800080)
GUICtrlSetBkColor(-1, 0x000000)
$Perc_EXP = GUICtrlCreateProgress(32, 138, 120, 17, $PBS_SMOOTH)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($Perc_EXP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0xFF00FF)
GUICtrlSetBkColor(-1, 0xD8A0CB)
$Label_EXP = GUICtrlCreateLabel("0/0", 32, 138, 120, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 7, 10000, 0, "Arial")
GUICtrlSetBkColor(-1, -2)
$LabelSTR = GUICtrlCreateLabel("Str:", 166, 97, 20, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_STR = GUICtrlCreateLabel("00", 186, 97, 60, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelDEX = GUICtrlCreateLabel("Dex:", 159, 113, 26, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_DEX = GUICtrlCreateLabel("00", 186, 113, 60, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelVIT = GUICtrlCreateLabel("Vit:", 167, 129, 19, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_VIT = GUICtrlCreateLabel("00", 186, 129, 60, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelMAG = GUICtrlCreateLabel("Mag:", 157, 145, 28, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_MAG = GUICtrlCreateLabel("00", 186, 145, 60, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelXYZ = GUICtrlCreateLabel("XYZ:", 5, 160, 26, 17, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_XYZ = GUICtrlCreateLabel("000.0/000.0/000.0", 31, 160, 125, 17, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabeSPIRIT = GUICtrlCreateLabel("Spirit:", 153, 160, 31, 18, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_SPIRIT = GUICtrlCreateLabel("0", 186, 160, 60, 18, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xC0C0C0)

; Declare Target Info Group Variables
$TarInfo = GUICtrlCreateGroup("Target Info", 0, 184, 250, 75)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($TarInfo), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x00FF00)
$LabelTARNAME = GUICtrlCreateLabel("Name:", 12, 200, 35, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_TARNAME = GUICtrlCreateLabel("None", 50, 200, 195, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelTARDIST = GUICtrlCreateLabel("Dist:", 22, 213, 35, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_TARDIST = GUICtrlCreateLabel("0", 52, 213, 40, 17)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelTARSPEC = GUICtrlCreateLabel("Spec:", 98, 213, 34, 18)
GUICtrlSetColor(-1, 0xC0C0C0)
$Label_TARSPEC = GUICtrlCreateLabel("None", 134, 213, 114, 18)
GUICtrlSetColor(-1, 0xC0C0C0)
$LabelTARHP = GUICtrlCreateLabel("HP:", 9, 232, 22, 17)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($LabelHP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 15743782)
GUICtrlSetBkColor(-1, 0x000000)
$Perc_TARHP = GUICtrlCreateProgress(32, 231, 120, 17, $PBS_SMOOTH)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($Perc_TARHP), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 15743782)
GUICtrlSetBkColor(-1, 0xFFB3B5)
$Label_TARHP = GUICtrlCreateLabel("0/0", 32, 231, 120, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 7, 10000, 0, "Arial")
GUICtrlSetBkColor(-1, -2)

;Declare Hunting Options Group Variables
$HuntOpts = GUICtrlCreateGroup("Hunting Options", 0, 263, 250, 80)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($HuntOpts), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x00FF00)
$CHK_ANTIKS = GUICtrlCreateCheckbox("AntiKS", 5, 278, 105, 20)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHK_ANTIKS), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 15743782)
GUICtrlSetBkColor(-1, 0x000000)
	If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_AKS_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
$CHK_HBN = GUICtrlCreateCheckbox("Hunt By Name", 5, 298,105, 20)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHK_HBN), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x3232FF)
GUICtrlSetBkColor(-1, 0x000000)
	If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HBN_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
$CHK_FZ = GUICtrlCreateCheckbox("Unfreeze", 5, 318, 105, 20)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHK_FZ), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x800080)
GUICtrlSetBkColor(-1, 0x000000)
	If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_FREEZE_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
$Tar_Rad = GUICtrlCreateGroup("Target Radius", 112, 271, 131, 65)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($Tar_Rad), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0xFFFF00)
$BTN_SETRAD = GUICtrlCreateButton("Set", 203, 289, 35, 21, $WS_GROUP)
GUICtrlSetOnEvent(-1, "SETHOMEXYZ")
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBKColor(-1, 0x000000)
$INPT_RAD = GUICtrlCreateInput("", 166, 289, 33, 21)
	If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") <> "0" Then
		GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0"))
	Else
		GUICtrlSetData(-1, "0")
	EndIf
$LABEL_RADIUS = GUICtrlCreateLabel("Radius:", 118, 292, 47, 17)
GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xC0C0C0)
$LABEL_RADCENTER = GUICtrlCreateLabel("0 = No Limit", 114, 315, 127, 17, $SS_CENTER)
GUICtrlSetColor(-1, 0xC0C0C0)

; Declare Battle History Group Variables
$HISTORY = GUICtrlCreateGroup("Battle History", 0, 345, 250, 203)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($HISTORY), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0x00FF00)
$LOG = GUICtrlCreateEdit("", 5, 362, 240, 185, BitOR($ES_CENTER,$ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN), 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($LOG), "wstr", 0, "wstr", 0)
GUISetState(@SW_SHOW)

; Declare Extra GUI Variables
$LabelGOLD = GUICtrlCreateLabel("Gold:", 5, 557, 29, 18, $SS_CENTERIMAGE)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($LabelGOLD), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0xFFFF00)
$Label_GOLD = GUICtrlCreateLabel("0", 37, 557, 70, 18, $SS_CENTERIMAGE)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($Label_GOLD), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0xFFFF00)
$BTN_DONATE = GUICtrlCreateButton("Donate", 172, 554, 74, 21, $BS_BITMAP, $WS_GROUP)
GUICtrlSetImage($BTN_DONATE, @ScriptDir & "\Donate.bmp", -1)
GUICtrlSetOnEvent(-1, "Donate")

;********************************************************************************
;* Start Initiating Bot Variables                                               *
;********************************************************************************

; Init Timer Variables

Global $FLYUPTIMER = TimerInit() + 750, $ChatTimer = TimerInit() + 100, $PLAYERARRAYTIMER = TimerInit() + 750, $NPCARRAYTIMER = TimerInit() + 750, $PETSUPPORTTIMER = TimerInit() + 750, $GATHERARRAYTIMER = TimerInit() +7500, $ITEMARRAYTIMER = TimerInit() + 7500, $TIMER_FEED_PET = TimerInit() + 65000, $MPTimer = TimerInit() + 18000, $HPTimer = TimerInit() + 1000, $HP2Timer = TimerInit() + 1000
          
		    SituationalAwareness()
			BuildItemArray()
; Wait For Character To Log In
 If Not $NAME <> "" Then
	AddHistory("[[[Searching For Character]]]")
	Do
	SituationalAwareness()
		Sleep(1000)
	Until $NAME <> ""
	AddHistory("[[[Character Found]]]")
EndIf

AddHistory(@CRLF&"Prophet Bot Unleashed is Now Unleashed"&@CRLF&@HOUR&":"&@MIN&":"&@SEC &"  |  "&@MON&"/"&@MDAY &"/"&@YEAR&@CRLF&"_"&@CRLF&"(_)"&@CRLF&").("&@CRLF&"/..\"&@CRLF&"/. . .\"&@CRLF&"/._. ._.\"&@CRLF&"|:,' `-.' `:|"&@CRLF&"|   _|_   |"&@CRLF&"|    '|'    |"&@CRLF&"'.__|__.'")
sleep(1000)
RenameWindow()
sleep(1000)
;********************************************************************************
;* Main Loop                                                                    *
;********************************************************************************


;$keys = StringReplace($keys, "{SPACE}", Chr(0x20))
While (1) ;==>Main Loop
	Main()
WEnd ;==>Main Loop


Func Main()
	
	If $STOP = False Then
		If $HP > 0 then
			SituationalAwareness()
			FLYMODE()
			HPMPAutoPotCheck()
			PetSupport()
		Else
			StopCheck()
	    EndIf
		StopCheck()
		If TimerDiff($TIMER_APOTHOCARY_RAIL) / (60000 * 60) > IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_APOTHOCARY_TIMER_KEY, "1") And IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_APOTHOCARY_RAIL_KEY, "1") = 1 And $HP > 0  Then
			AddHistory("Returning to apothocary for repairs")
			sleep(1000)
			
		if $CHARSTATE <> 16 Then
			If IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_FLAG_KEY, 0) = 1 And $HP <> 0 and IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_FM_KEY, "0") <> 1 Then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, "")))
			sleep(2000)
			endif
		endif
			RunApothocaryRail()
			
			sleep(2000)
		if $CHARSTATE = 16 and IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_FM_KEY, "0") = 4 Then
			If IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_FLAG_KEY, 0) = 1 And $HP <> 0 and IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_FM_KEY, "0") <> 1 Then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, "")))
			sleep(2000)
			endif
		endif
		EndIf
		StopCheck()
		If GUICtrlRead($LABEL_BOT_STATUS) <> "BOT Status: Started" Then
			GUICtrlSetData($LABEL_BOT_STATUS, "BOT Status: Started")
		EndIf
		If $HP > 0 then
			HPMPAutoPotCheck()
			PetSupport()
	    EndIf
	    If $HP > 0 then
			SelectTarget()
		EndIf
		If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTHERBS_FLAG_KEY, "0") = 1 Or IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTRESOURCES_FLAG_KEY, "0") = 1  Then
		Do
			sleep(1000)
	SituationalAwareness()
			If $HP > 0 then
				$GATHERING = 0
				if $CHARSTATE = 32 Then
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")))
				sleep(2000)
				endif
				HPMPAutoPotCheck()
				FindHerbsResources()
			Endif
		Until $GATHERING = 0 or $HP = 0
		endif
		If $HADTARGET = 1 And $HP > 0  Then
			$HADTARGET = 0
			$ATHOME = 0
		Elseif $HP > 0 And $ATHOME = 0 Then
			addhistory("Moving Back To HomeXYZ")
			$MOVEING = 1
			MoveToXYZ($HOME_X, $HOME_Y, $HOME_Z, $HOME_Z / 10)
			If $TAR <> 0 Then
					AddHistory("Defending During Movement")
					$TARGET = $TAR
					KillTarget()
					$HADTARGET = 1
					$Kill = 0
			        $ATHOME = 0
				Else
					$HADTARGET = 0
				 $ATHOME = 1
			    endif
			
			
			sleep(2000)
	    EndIf
		HPMPAutoPotCheck()
		If $TAR <> 0 and $HP > 0 Then
					AddHistory("Defending")
					$TARGET = $TAR
					KillTarget()
					$Kill = 0
					$HADTARGET = 1
			        $ATHOME = 0
		endif
	    If $HP = 0 Then
			StopCheck()
		EndIf
		
	Else
		If GUICtrlRead($LABEL_BOT_STATUS) <> "BOT Status: Stopped" Then
			GUICtrlSetData($LABEL_BOT_STATUS, "BOT Status: Stopped")
		EndIf
		$ACTIVE_WEAPONS = 0
		$TIMER_CHANGE_WEAPON = TimerInit()
		GetPetState()
		SituationalAwareness()
		PetSupport()
		HPMPAutoPotCheck()
		Sleep(1000)
	EndIf
EndFunc		;==>

;======================================================================>
;
;
;			Logic Functions
;
;
;======================================================================>
Func BuildChatArray()
	Local $array[1][2], $pointer, $item_base, $counter, $lastchatpointer, $Lastmsg
	$lastchatpointer = _MemoryRead($LASTCHAT, $PROCESS_INFORMATION)
	$Lastmsg = ($lastchatpointer - 10)
	For $i=$Lastmsg to $lastchatpointer - 1
		$pointer = _MemoryRead($CHAT, $PROCESS_INFORMATION)
		
			ReDim $array[$counter + 1][2]
			$array[$counter][0] = _MemoryRead($pointer + $i * dec("1c") + 0x4, $PROCESS_INFORMATION, "Byte") ;SN
			$array[$counter][1] = _MemoryRead(_MemoryRead($pointer + $i * dec("1c") + 0x8, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[100]') ;Name
			if $array[$counter][0] = 4 Then
				addhistory($array[$counter][1])
					
					$WHISPER = 1
					sleep(1000)
				endif
			$counter += 1
	
		
	Next
	;_ArrayDisplay($array)
	Global $ChatArray = $array
	 sleep(10)
EndFunc		;==>

func potone()
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_FLAG_KEY, 0) = 1 And TimerDiff($HPTimer) > IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_TIMER, "1") * 1000 Then
		If GUICtrlRead($PERC_HP) < Int(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_PERC_KEY, 1)) Then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_KEY, 0)))
			$HPTimer = TimerInit()
			
		Endif
	EndIf
	
endfunc

func petdef()
	       
			    SituationalAwareness()
	         
		if $Tar > 0 then
					$TARGET = $TAR
					$HADTARGET = 1
					KillTarget()
					$KILL = 0
					sleep(1000)
		endif
	
	do
		$Kill = 0
	BuildNPCArray()
	HPMPAutoPotCheck()
	AutoBuffsCheck()
	ResetSkillDelays()
	ChangeWeaponsCheck()
	Local $tempnpcarray, $tempnpcarraycount, $counter, $countermonname, $countermonid, $temptar, $temptardis
	$tempnpcarray = $NPCARRAY
	$tempnpcarraysize = Ubound($tempnpcarray)
		For $n = 0 To $tempnpcarraysize - 1
				$temptar = 0

		If  $tempnpcarray[$n][12] = $PETID[1] and $PETID[1] > 0 Then
					$temptar = $tempnpcarray[$n][0]
			
				
				SelectTarID($temptar)
				$ST = TimerInit()
			Do
				sleep(1000)
				SituationalAwareness()
				$Timer = TimerDiff($ST)
			Until $TARMAXHP <> 0 Or $Timer > 2000 or $HP = 0
			if $Tar > 0 then
					$TARGET = $TAR
					$HADTARGET = 1
					KillTarget()
					$KILL = 1
					sleep(1000)
			endif	
		Else
				$KILL = 0
				
				
			EndIf
			
		Next
		
until $Kill = 0 or $HP = 0
        
	endfunc


Func SelectTarget()
	$Kill = 0
	BuildNPCArray()
	HPMPAutoPotCheck()
	AutoBuffsCheck()
	ResetSkillDelays()
	ChangeWeaponsCheck()
	Local $tempnpcarray, $tempnpcarraycount, $counter, $countermonname, $countermonid, $temptar, $temptardis
	$tempnpcarray = $NPCARRAY
	$tempnpcarraysize = Ubound($tempnpcarray)
	If GUICtrlRead($LABEL_GENERAL_STATUS) <> "Action: Finding Target" Then
		GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Finding Target")
	EndIf
	petdef()
	If $Kill = 0 then
	For $n = 0 To $tempnpcarraysize -1
		;Hunt by Name
		$temptar = 0
		If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HBN_KEY, "0") = 1 Then
			;AddHistory("Hunt By Name")
			For $c = 0 To IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, 1)
				If $tempnpcarray[$n][1] = IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTERNAME_KEY & $c, "") Then
					If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") > 0 And $tempnpcarray[$n][11] > IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") Then
						ExitLoop
					Else
						$temptar = $tempnpcarray[$n][0]
						ExitLoop
					EndIf
				EndIf
			Next
		;Hunt by ID
		Else
			For $c = 0 To IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, 1)
				If $tempnpcarray[$n][0] = IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTER_KEY & $c, "") Then
					If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") > 0 And $tempnpcarray[$n][11] > IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") Then
						ExitLoop
					Else
						$temptar = $tempnpcarray[$n][0]
						ExitLoop
					EndIf
				EndIf
			Next
		EndIf
	
		If $temptar <> 0 Then
			SelectTarID($temptar)
			sleep(500)
			$ST = TimerInit()
			Do
				
				SituationalAwareness()
				Sleep(250)
				$Timer = TimerDiff($ST)
			Until $TARMAXHP <> 0 Or $Timer > 1500 or $HP = 0
			If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_AKS_KEY, "0") = 1 And $TARHP = $TARMAXHP Then
				$TARGET = $TAR
				$HADTARGET = 1
				KillTarget()
				ExitLoop
			EndIf
			If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_AKS_KEY, "0") <> 1 Then
				$TARGET = $TAR
				$HADTARGET = 1
				KillTarget()
				If $FLYTOESCAPE = 1 Then
					$FLYTOESCAPE = 0
				EndIf
				ExitLoop
			EndIf
		EndIf
	Next
endif
$KILL = 0
EndFunc		;==>

Func FLYMODE()
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_FM_KEY, "0") = 1 Then
	if $CHARSTATE <> 16 Then
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, "")))
				sleep(2000)
			endif
		endif
	EndFunc

Func ChangeWeaponsCheck()
	If IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_FLAG_KEY, "0") = 1 Then	
		If TimerDiff($TIMER_CHANGE_WEAPON) / 60000 > IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_DELAY_KEY, "180") Then
			$ACTIVE_WEAPONS = $ACTIVE_WEAPONS + 1
			IF $ACTIVE_WEAPONS <= IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_UBOUND_KEY, "1") Then
				$KEY_WEAPON = IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_COMBO_KEY & $ACTIVE_WEAPONS, "")
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_COMBO_KEY & $ACTIVE_WEAPONS, "")))
				$TIMER_CHANGE_WEAPON = TimerInit()
			Else
				$TIMER_CHANGE_WEAPON = TimerInit()
			EndIf
		EndIf
	EndIf
EndFunc		;==>

Func FlyEscapeCheck()
	Local $POTENTIAL_DAMAGE = $MAXHP - $HP, $lastelevation
	If IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_FLAG_KEY, 0) = 1 And $HP <> 0 Then
		If $POTENTIAL_DAMAGE > IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_DAMAGE_KEY, $MAXHP) Then
			$FLYTOESCAPE = 1
			$lastelevation = $Z / 10
			ADDHISTORY("Flying To Escape")
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Flying To Escape")
			If $CHARSTATE <> 16 then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, "")))
			Sleep(2000)
			endif
			Local $flytimer = TimerInit()
			Do
				sleep(1000)
				SituationalAwareness()
				If $TAR > 0 Then
					Sleep(10)
					DeselectTarget()
				EndIf
				FlyUpVertical()
				Sleep(500)
			Until $Z / 10 >= IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_SPACE_KEY, 10) Or $HP = 0 or TimerDiff($flytimer) > 20000
			Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD)
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, $X, "Float")
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, $Y, "Float")
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, $Z, "Float")
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, 0)
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE, 0)
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE2, 0)
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, 1)
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
			Sleep(2000)
			Do
				sleep(1000)
				SituationalAwareness()
				HPMPAutoPotCheck()
			Until GUICtrlRead($PERC_HP) > 98 Or $HP = 0
			AddHistory("Going Back From Escape")
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Going Back")
			
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, "")))
			Sleep(5000)
			GetPetState()
		EndIf
	EndIf
EndFunc

Func HPMPRestoreCheck()
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_HP_KEY, 0) = 1 Then	
		If GUICtrlRead($PERC_HP) < Int(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_HP_PERC_KEY, 1)) Then
			Sleep(10)
			RestoreCharState(1)
		Endif
	EndIf	
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_MP_KEY, 0) = 1 Then	
		If GUICtrlRead($PERC_MP) < Int(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_MP_PERC_KEY, 1)) Then
			Sleep(10)
			RestoreCharState(2)
		Endif
	EndIf	
EndFunc		;==>

Func AutoBuffsCheck()
	If IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FLAG_KEY, "0") = 1 Then	
		For $Q = 1 To IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, "1") Step +1
			$BUFFS_TIMER_DIFF[$Q] = TimerDiff($BUFFS_TIMER[$Q])
		Next
		For $Q = 1 To IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, "1") Step +1
			If $BUFFS_TIMER_DIFF[$Q] / 60000 > IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FREQUENCY_KEY & $Q, "1") And $CASTING = 0 Then
				If $TAR > 0 Then
					Sleep(10)
					DeselectTarget()
					Sleep(500)
				EndIf
				AddHistory("Buffing Myself")
				Sleep(10)
				SendBuff($Q)
				Local $tt = TimerInit()
				Do 
					sleep(1000)
					SituationalAwareness()
				Until $CASTING > 0 Or TimerDiff($TT) > 2500 or $HP = 0
				$BUFFS_TIMER[$Q] = TimerInit()
			EndIf	
		Next
	EndIf	 
EndFunc		;==>

Func HPMPAutoPotCheck()
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_FLAG_KEY, 0) = 1 And TimerDiff($HPTimer) > IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_TIMER, "1") * 1000 Then
		If GUICtrlRead($PERC_HP) < Int(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_PERC_KEY, 1)) Then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_KEY, 0)))
			sleep(1000)
			$HPTimer = TimerInit()
			
		Endif
	EndIf
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_FLAG_KEY, 0) = 1 And TimerDiff($HP2Timer) > IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_TIMER, "1") * 1000 and $REST = 0 Then
		If GUICtrlRead($PERC_HP) < Int(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_PERC_KEY, 1)) Then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_KEY, 0)))
			sleep(1000)
			$HP2Timer = TimerInit()
			
		Endif
	EndIf
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_FLAG_KEY, 0) = 1 And TimerDiff($MPTimer) > 16000 Then
		If GUICtrlRead($PERC_MP) < Int(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_PERC_KEY, 1)) Then
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_KEY, 0)))
			sleep(1000)
			$MPTimer = TimerInit()
			
		Endif
	EndIf
EndFunc		;==>

Func FindHerbsResources()
	Sleep(10)
	BuildItemArray()
	Local $array[1][8], $arraysize, $pointer, $item_base, $counter, $counterherbs, $counterresources, $templasttarx[3], $templasttary[3], $templasttarz[3]
	$tempitemarray = $itemarray
	If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTHERBS_FLAG_KEY, "0") = 1 Or IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTRESOURCES_FLAG_KEY, "0") = 1 Then
		If GUICtrlRead($LABEL_GENERAL_STATUS) <> "Action: Finding Gatherables" Then
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Finding Gatherables")
		EndIf
		For $h = 0 to Ubound($tempitemarray) - 1
			$gathertarget = 0
			If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTHERBS_FLAG_KEY, "0") = 1 Then
				For $i = 0 To UBound($HERBS) - 1
					If $tempitemarray[$h][2] = $HERBS[$i] And $LASTGATHERED <> $tempitemarray[$h][0] Then
						$gathertarget = $tempitemarray[$h][0]
						$gathertargetname = $HERBS[$i]
						$gathertargetdis = $tempitemarray[$h][6]
						$gathertargethomedis = $tempitemarray[$h][7]
						$templasttarx[2] = $tempitemarray[$h][3]
						$templasttarx[1] = Round(($tempitemarray[$h][3] + 4000) / 10, 2)
						$templasttary[2] = $tempitemarray[$h][4]
						$templasttary[1] = Round(($tempitemarray[$h][4] + 5500)  / 10, 2)
						$templasttarz[2] = $tempitemarray[$h][5]
						$templasttarz[1] = Round(($tempitemarray[$h][5]) / 10, 2)
						ExitLoop
					EndIf
				Next
			EndIf
			If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTRESOURCES_FLAG_KEY, "0") = 1  Then
				For $i = 0 To UBound($RESOURCES) - 1
					If $tempitemarray[$h][2] = $RESOURCES[$i] And $LASTGATHERED <> $tempitemarray[$h][0] Then
						$gathertarget = $tempitemarray[$h][0]
						$gathertargetname = $RESOURCES[$i]
						$gathertargetdis = $tempitemarray[$h][6]
						$gathertargethomedis = $tempitemarray[$h][7]
						$templasttarx[2] = $tempitemarray[$h][3]
						$templasttarx[1] = Round(($tempitemarray[$h][3] + 4000) / 10, 2)
						$templasttary[2] = $tempitemarray[$h][4]
						$templasttary[1] = Round(($tempitemarray[$h][4] + 5500)  / 10, 2)
						$templasttarz[2] = $tempitemarray[$h][5]
						$templasttarz[1] = Round(($tempitemarray[$h][5]) / 10, 2)
						ExitLoop
					EndIf
				Next
			EndIf
			If $gathertarget <> 0 And $LASTGATHERED <> $gathertarget Then
				If $gathertargetdis < IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0")  And $gathertargethomedis < IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") Then
					GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Collecting Gatherable")
					AddHistory("Gathering " & $gathertargetname)
					$MOVEING = 1
					GrabHerbResource($gathertarget)
					$GATHERING = 0
					return Main()
				EndIf
			Else
			EndIf
		Next
	EndIf
	$GATHERING = 0
	Return $array
EndFunc		;==>

Func PetSupport()
	If IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_CHECK_KEY, "0") = "1" Then
		Sleep(10)
		GetPetHealth()
		Sleep(10)
		GetPetHunger()
		If $PETHP < IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_HP_KEY, "0") And $PETHP > 0 Then
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Healing Pet")
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_HEALKEY_KEY, "")))
			Sleep(2000)
		EndIf
		If  $PETHUNGER > 0 And TimerDiff($TIMER_FEED_PET) > 60100 And $PETHP > 0 Then
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Feeding Pet")
			Sleep(500)
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_FEEDKEY_KEY, "")))
			$TIMER_FEED_PET = TimerInit()
			Sleep(500)
		EndIf
	EndIf
	$PETSUPPORTTIMER = TimerInit()
EndFunc		;==>

;======================================================================>
;
;
;			Action Functions
;
;
;======================================================================>

Func FlyUpVertical()
	If TimerDiff($FlyUpTimer)  > 500 and $HP > 0 Then
		Local $newX, $newY, $newZ, $flySpeed, $speed, $direction, $moveType, $counter, $time, $packet, $packetsize
		
		$flySpeed = _MemoryRead($CHAR_DATA_BASE + $OFFSET_FLYSPEED, $PROCESS_INFORMATION, "Float")
		$newX = _MemoryRead($CHAR_DATA_BASE + $OFFSET_X, $PROCESS_INFORMATION, "Float")
		$newY = _MemoryRead($CHAR_DATA_BASE + $OFFSET_Z, $PROCESS_INFORMATION, "Float") + ($flySpeed * 0.5)
		$newZ = _MemoryRead($CHAR_DATA_BASE + $OFFSET_Y, $PROCESS_INFORMATION, "Float")
		$speed = floor(($flySpeed * 256.0) + 0.5)
		$direction = 0
		$moveType = 97
		$counter = _MemoryRead($CHAR_DATA_BASE + $OFFSET_FLYCOUNTER, $PROCESS_INFORMATION, "UShort")
		$time = 500
		
		$packet = '0700'
		$packet &= _hex($newX, 8, "float")
		$packet &= _hex($newY, 8, "float")
		$packet &= _hex($newZ, 8, "float")
		$packet &= _hex($speed, 4)
		$packet &= _hex($direction, 2)
		$packet &= _hex(97, 2)
		$packet &= _hex($counter, 4)
		$packet &= _hex($time, 4)
		$packetSize = 22
		_MemoryWrite($CHAR_DATA_BASE + 2344, $PROCESS_INFORMATION, $counter + 1, "UShort")
		_MemoryWrite($CHAR_DATA_BASE + 64, $PROCESS_INFORMATION, $newY, "Float")
		sendPacket($packet, $packetSize, $PROCESS_ID)
		$FlyUpTimer = TimerInit()
		Sleep(100)
		_MemoryWrite($CHAR_DATA_BASE + $OFFSET_Z, $PROCESS_INFORMATION, $newY, "Float")
	EndIf
EndFunc		;==>

Func FlyUpAngle($MOVETOX, $MOVETOY, $MOVETOZ)
	Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD) 
	Local $Flag = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG)
	AddHistory("FLYING  " & $Flag[1])
	AddHistory("MOVE  " & $Read[1])
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, "966.302795410156", "Float") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, "4159.5380859375", "Float") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, "219.026138305664", "Float") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, "0") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, "1") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE, $Read[1]) 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHT, "66", "Float") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG, $Flag[1] + 1) 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG2, "0") 
EndFunc		;==>

Func GrabHerbResource($RESOURCEID)
	If $HP > 0 Then
		Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD2)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFINISHED, 0) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONSTART, 0) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONNOTSTART, 1) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONOBJECT, $RESOURCEID) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_OBJECTACTION, 4) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONSETERROR, 0) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONSKILL, 0) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE, $Read[1]) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, 1) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1])
		$ACTIONFLAG = 1
		$MOVEFLAG = 1
	
		Sleep(250)
		$gt = TimerInit()
		Do
			potone()
			petdef()
			sleep(500)
			
		    SituationalAwareness()
		
			If $TAR <> 0 Then
				$TARGET = $TAR
				$HADTARGET = 1
				AddHistory("Defending During Gathering")
				KillTarget()
				$Kill = 0
				$LASTGATHERED = 0
				$GATHERING = 0
				$LASTGATHERED = 0
				$MOVEFLAG = 0
				$ACTIONFLAG = 0
			EndIf
			$gtimer = TimerDiff($gt)
		until $ACTIONFLAG = 0 Or $HP = 0  Or $gtimer > 50000
		Local $TS = TimerInit()
		Sleep(2000)
		Do
			potone()
			sleep(500)
		
			SituationalAwareness()
			Local $TIMER = TimerDiff($TS)
		until $ACTIONFLAG <> 0  or $TIMER > 5000 Or $HP = 0
		Do
			potone()
			sleep(500)
		SituationalAwareness()
		until $ACTIONFLAG = 0 Or $HP = 0 Or $gtimer > 50000
		$LASTGATHERED = $resourceid
	endif
    petdef()
EndFunc		;==>

Func MoveToXYZ($MOVETOX, $MOVETOY, $MOVETOZ, $HIGHT)
	$Kill = 0
	If $MOVEMODE = 1 and $HP > 0 or $MOVEMODE = 2 and $HP > 0 Then
		Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD) 
		Local $Flag = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, $MOVETOX, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, $MOVETOY, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, $MOVETOZ, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, "0") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, "1") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE, $Read[1]) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHT, $HIGHT, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG, $Flag[1] + 1) 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG2, "0")
		
		
	Else		
		Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, $MOVETOX, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, $MOVETOZ, "Float")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, $MOVETOY, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, "0")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE, "0")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE2, "0")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, "1")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
	EndIf
	$ACTIONFLAG = 1
	Do
		
		sleep(250)
		potone()
		      
		        SituationalAwareness()
				
		If $TAR <> 0 Then
				
					$Kill = 1
				
			    endif
		
		
	Until $LASTTARDIS < $DISTANCE Or $ACTIONFLAG = 0 or $KILL = 1 or $HP = 0
	$MOVEING = 0
EndFunc		;==>

Func DashToXYZ($MOVETOX, $MOVETOY, $MOVETOZ, $HIGHT)
	$MOVEING = 1
	Do 
		sleep(1000)
		SituationalAwareness()
		Sleep(250)
	Until $ACTIONFLAG = 0 Or $HP = 0 Or $TAR <> 0
	if $HP > 0 then
		If $MOVEMODE = 1 or $MOVEMODE = 2 and $HP > 0 Then
			Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD) 
			Local $Flag = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG)
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, $MOVETOX, "Float") 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, $MOVETOY, "Float") 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, $MOVETOZ, "Float") 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, "0") 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, "1") 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE, $Read[1]) 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHT, $HIGHT, "Float") 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG, $Flag[1] + 1) 
			_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONHEIGHTFLAG2, "0") 
		Else		
		Local $Read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, $MOVETOX, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, $MOVETOZ, "Float")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, $MOVETOY, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, 0)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE, 0)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE2, 0)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, 1)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
		
		endif
	endif
	sleep(1000)
	Do
		sleep(1000)
	
		SituationalAwareness()
	Until $TARDIS < 20 Or $ACTIONFLAG = 0 or $HP = 0
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEX, $X + 1, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEZ, $Z, "Float")
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONMOVEY, $Y, "Float") 
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONDONE, 0)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE, 0)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONVALUE2, 0)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, 1)
		_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $Read[1]) 
	Do
		sleep(1000)
	SituationalAwareness()
	Until $ACTIONFLAG = 0 or $HP = 0		
	$MOVEING = 0
	
EndFunc		;==>

Func TalkToNPC($NPCID)
	Local $read = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONREAD2) 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFINISHED, "0") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONSTART, "0") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONNOTSTART, "1") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONOBJECT, $NPCID) 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_OBJECTACTION, "2") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONSETERROR, "0") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONSKILL, "0") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE, $read[1]) 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG, "1") 
	_MemoryPointerWrite($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONWRITE2, $read[1]) 
EndFunc		;==>

Func SendBuff($BUFF_SEQ)
	$KEY = IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_COMBO_KEY & $BUFF_SEQ, "0")
	_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_COMBO_KEY & $BUFF_SEQ, "0")))
	Sleep(Int(IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_DELAY_KEY & $BUFF_SEQ, "0")) * 1000)
EndFunc		;==>

Func TimerBuffsStart()
	If IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FLAG_KEY, "0") = 1 Then
		For $Q = 1 to IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, "1") Step +1
			$BUFFS_TIMER[$Q] = TimerInit()
		Next
	EndIf	
EndFunc		;==>

Func KillTarget()
	if $CHARSTATE = 32 Then
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")))
				sleep(2000)
			endif

	
	Local $active_skill = 0
	Local $lastspirit = $SPIRIT
	Local $ts = TimerInit()
	Local $key, $timer, $w8, $loot, $loottimes, $temphomex, $temphomey, $temphomez
	If $TARGET <> 0 And $TAR = $TARGET Then
		AddHistory("Killing Monster #" & $KILLS_COUNT + 1 & " ID:[" & $TAR & "]")
		GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Killing Monster #" & $KILLS_COUNT + 1)
		If IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETATTACK_CHECK_KEY, "0") = 1 Then
				If $TARDIS > 17 And $TARHP = $TARMAXHP Then
					$MOVEING = 1
					$HIGHT = $LASTTARZ[2] / 10
					DashToXYZ($LASTTARX[2], $LASTTARY[2], $LASTTARZ[2], $HIGHT)
					Do
						SetPetAttack($TARGET)
						sleep(500)
						SituationalAwareness()
					$TIMER = TimerDiff($TS)
				Until $TARHP < $TARMAXHP Or $TAR = "" or $TIMER > 10000	or $HP = 0
			Else
				Do
						SetPetAttack($TARGET)
						sleep(500)
						SituationalAwareness()
					$TIMER = TimerDiff($TS)
				Until $TARHP < $TARMAXHP Or $TAR = "" or $TIMER > 10000	or $HP = 0
				EndIf
			EndIf
		Do
			sleep(500)
				SituationalAwareness()
			If $HP > 0 then
				FlyEscapeCheck()
				FLYMODE()
				HPMPAutoPotCheck()
				GetPetState()
				PetSupport()
			EndIf
			if $CHARSTATE = 32 Then
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")))
				sleep(2000)
			endif
		
			;Check The Last Time Used The Active Skill (Delay Configured to Each Skill)
			$w8 = IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_DELAY_KEY & $ACTIVE_SKILL, "1")
			;Check to see if Pet should Attack First
			If TimerDiff($SKILL_DELAY_CHECK[$ACTIVE_SKILL]) > ($w8 * 1000) And $CASTING = 0 Then
				;Set the Active Skill
				$ACTIVE_SKILL = $ACTIVE_SKILL + 1
				If $ACTIVE_SKILL > $SKCOUNTCFG Then
					$ACTIVE_SKILL = 1
				EndIf
				;Update the Timer to Active Skill
				$SKILL_DELAY_CHECK[$ACTIVE_SKILL] = TimerInit()
				;Send the Skill Command to Game
				$key = IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_COMBO_KEY & $ACTIVE_SKILL, "{F1}")
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_COMBO_KEY & $ACTIVE_SKILL, "{F1}")))
			EndIf
			If $TARHP = $TARMAXHP Then
				$TIMER = TimerDiff($TS)
				If $TIMER > 30000 Then
					Sleep(10)
					DeselectTarget()
				EndIf
			EndIf	
			$TIMER = TimerDiff($TS)
		Until $TAR = 0 or $TIMER > 180000 or $HP = 0
		If $HP = 0 Then
		EndIf
		$temphomex = $HOME_X
		$temphomey = $HOME_Y
		$temphomez = $HOME_Z
		$HOME_X = $LASTTARX[2]
		$HOME_Y = $LASTTARY[2]
		$HOME_Z = $LASTTARZ[2]
		$LAST_KILLEDTIME = TimerInit()
		$SPIRIT = _MemoryRead($CHAR_DATA_BASE + $OFFSET_SPIRIT, $PROCESS_INFORMATION)
		
			$KILLS_COUNT = $KILLS_COUNT + 1
		
		If  IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_FLAG_KEY, "0") = 1 Then
			Sleep(1000)
			BuildItemArray()
		EndIf
		Local $tempitemarray, $tempitemarraysize, $counter, $tempitem, $tempitemdis
		$tempitemarray = $ITEMARRAY
		$tempitemarraysize = Ubound($tempitemarray)
		If GUICtrlRead($LABEL_GENERAL_STATUS) <> "Action: Scanning Items" Then
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Scanning Items")
		EndIf
		For $n = 0 To $tempitemarraysize -1
			If $tempitemarray[$n][7] < 7 And $tempitemarray[$n][7] > 0 Then
				$counter = $counter + 1
				$HIGHT =  $tempitemarray[$n][5] / 10
				
			EndIf
		Next	
		If $counter > "" Then
			$loot = 1
			$loottimes = $counter * 8
		EndIf
		If $TARDIS > 6 And $LOOT = 1 Then
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Moveing To Corpse")
			Do
				sleep(500)
				SituationalAwareness()
			Until $ACTIONFLAG = 0 or $HP = 0
			If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_MOVE_TO_CORPSE_KEY, "0") = 1 And IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_FLAG_KEY, "0") = 1 Then
				$MOVEING = 1
				$MTLT = TimerInit()
			Do
				sleep(500)
			SituationalAwareness()
				$Timer = TimerDiff($MTLT)
	        Until $CASTING = 0 Or $Timer > 5000 or $HP = 0
				
					sleep(10)
					MoveToXYZ($LASTTARX[2], $LASTTARY[2], $LASTTARZ[2], $HIGHT)
				
			EndIf
				$MOVEING = 0
				$LASTGATHERED = 0
		EndIf
			
		If $LOOT = 1 And IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_FLAG_KEY, "0") = 1 Then
			If $loottimes = 1 Then
				AddHistory("Looting 1 Items")
			
			Else
				AddHistory("Looting " & $loottimes / 8 & " Items")
				sleep(10)
				PickLoot($loottimes)
			EndIf
		EndIf
		$HOME_X = $temphomex
		$HOME_Y = $temphomey
		$HOME_Z = $temphomez
	EndIf
	$ATHOME = 0
EndFunc		;==>   

Func PickLoot($MAX)
	$PLT = TimerInit()
	Do
		sleep(1000)
		SituationalAwareness()
		$Timer = TimerDiff($PLT)
	Until $CASTING = 0 Or $Timer > 5000 or $HP =0
	If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_FLAG_KEY, "0") = 1 Then
		GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Looting")
		For $P = $MAX To 1 Step -1
			$PKEY = IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_KEY, "0")
			_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_KEY, "0")))
			Sleep(250)
		Next
		if $REST = 1 Then
			$Rest = 0
			sleep(250)
		elseif $HP > 0 then
			sleep(10)
		HPMPRestoreCheck()
		
	    endif
	EndIf
EndFunc		;==>

Func SelectTarIDd($id)
	Local $pRemoteThread, $vBuffer, $loop, $result, $OPcode
	; --- save the position of the allocated memory ---
	$pRemoteMem = DllCall($kernel32, 'int', 'VirtualAllocEx', 'int', $PROCESS_INFORMATION[1], 'ptr', 0, 'int', 0x46, 'int', 0x1000, 'int', 0x40)
	; --- build up the asm code ---
	; 0046061D  A1 6C3E9F00       MOV EAX,DWORD PTR DS:[9F3E6C]
	; 00460622  57                PUSH EDI                        <---- EDI Contains Mob-ID
	; 00460623  8B48 20           MOV ECX,DWORD PTR DS:[EAX+20]
	; 00460626  81C1 EC000000     ADD ECX,0EC
	; 0046062C  E8 8F961800       CALL elementc.005E9CC0
	$OPcode &= '60'                                                           ; 
	$OPcode &= 'A1'&_hex($REALBASEADDRESS)                          ; mov eax, [base]
	$OPcode &= '68'&_hex($id)                                                 ; push mob-id
	$OPcode &= '8B4820'                                                       ; mov ecx, [eax+0x20]
	$OPcode &= '81C1'&_hex(0xEC)                                              ; add ecx, 0xEC
	$OPcode &= 'E8'&_hex($SELECT_CALL-$pRemoteMem[0]-5-StringLen($OPcode)/2)  ; call select_call
	$OPcode &= '61'                                                           ; popad
	$OPcode &= 'C3'                                                           ; retn
	; --- enter the asm code to to a dllstruct, which can be used with WriteProcessMemory ---
	$vBuffer = DllStructCreate('byte[' & StringLen($OPcode) / 2 & ']')
	For $loop = 1 To DllStructGetSize($vBuffer)
		DllStructSetData($vBuffer, 1, Dec(StringMid($OPcode, ($loop - 1) * 2 + 1, 2)), $loop)
	Next
	; --- now letz write the code from our dllstruct ---
	DllCall($kernel32, 'int', 'WriteProcessMemory', 'int', $PROCESS_INFORMATION[1], 'int', $pRemoteMem[0], 'int', DllStructGetPtr($vBuffer), 'int', DllStructGetSize($vBuffer), 'int', 0)
	; --- now we run the asm code we've just written ---
	$hRemoteThread = DllCall($kernel32, 'int', 'CreateRemoteThread', 'int', $PROCESS_INFORMATION[1], 'int', 0, 'int', 0, 'int', $pRemoteMem[0], 'ptr', 0, 'int', 0, 'int', 0)
	; --- wait till the thread did his job ---
	Do
		$result = DllCall('kernel32.dll', 'int', 'WaitForSingleObject', 'int', $hRemoteThread[0], 'int', 50)
	Until $result[0] <> 258
	Sleep(250)
	; --- close everything we've opened ---
	DllCall($kernel32, 'int', 'CloseHandle', 'int', $hRemoteThread[0])
	DllCall($kernel32, 'ptr', 'VirtualFreeEx', 'hwnd', $PROCESS_INFORMATION[1], 'int', $pRemoteMem[0], 'int', 0, 'int', 0x8000)
	Return True
EndFunc		;==>

Func GetPetState()
	$PETNO = IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SLOT_KEY, "0")
	If $PETNO = 0 Then
		else
		Global $OFFSET_PETSTATE[4]
		$OFFSET_PETSTATE[1] = Dec("34")
		$OFFSET_PETSTATE[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PETBASE, "")
		$OFFSET_PETSTATE[3] = 8
		Global $PETSTATE = _MEMORYPOINTERREAD($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_PETSTATE, "UShort")
		$PETSTATE = $PETSTATE[1]
		GetPetHealth()
		If $PETHP = 0 Then
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_REZKEY_KEY, "")))
				sleep(1000)
				Do
					sleep(1000)
					SituationalAwareness()
				until $ACTIONFLAG = 0 or $HP = 0
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SUMMONKEY_KEY, "")))
				sleep(1000)
				Do
					sleep(1000)
					SituationalAwareness()
				until $ACTIONFLAG = 0 or $HP = 0
				sleep(10)
				setPetFollow()
			Elseif $PETSTATE > 20 Then
				
				_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SUMMONKEY_KEY, "")))
				sleep(1000)
				Do
					sleep(1000)
					SituationalAwareness()
				until $ACTIONFLAG = 0 or $HP = 0
				sleep(10)
				setPetFollow()
		EndIf
	EndIf
EndFunc		;==>

Func GetPetHealth()
	$PETNO = IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SLOT_KEY, "0")
	Global $OFFSET_PETHP[5]
	$OFFSET_PETHP[1] = Dec("34")
	$OFFSET_PETHP[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PETBASE, "")
	$OFFSET_PETHP[3] = 16 + (($PETNO - 1) * 4)
	$OFFSET_PETHP[4] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PETHP, "")
	Global $PETHP = _MEMORYPOINTERREAD($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_PETHP)
	$PETHP = $PETHP[1]
EndFunc		;==>

Func GetPetHunger()
	$PETNO = IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SLOT_KEY, "0")
	Global $OFFSET_PETHUNGER[5]
	$OFFSET_PETHUNGER[1] = Dec("34")
	$OFFSET_PETHUNGER[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PETBASE, "")
	$OFFSET_PETHUNGER[3] = 16 + (($PETNO - 1) * 4)
	$OFFSET_PETHUNGER[4] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PETHUNGER, "")
	$PETHUNGER = _MEMORYPOINTERREAD($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_PETHUNGER)
	$PETHUNGER = $PETHUNGER[1]
EndFunc		;==>

Func ResetSkillDelays()
	$SKILL_DELAY_CHECK[1] = TimerInit()
	$SKILL_DELAY_CHECK[2] = TimerInit()
	$SKILL_DELAY_CHECK[3] = TimerInit()
	$SKILL_DELAY_CHECK[4] = TimerInit()
	$SKILL_DELAY_CHECK[5] = TimerInit()
	$SKILL_DELAY_CHECK[6] = TimerInit()
	$SKILL_DELAY_CHECK[7] = TimerInit()
	$SKILL_DELAY_CHECK[8] = TimerInit()
	$SKILL_DELAY_CHECK[9] = TimerInit()
EndFunc		;==>

Func SellItems()
	sleep(10)
	BuildInventoryArray()
	Local $tempinventoryarray = $INVENTORYARRAY, $tempinventoryarraysize = UBound($tempinventoryarray), $buylist, $donotselllist, $donotsell
	_FileReadToArray("Gather Config/" & $NAME & "_BuyList.gat", $buylist)
	_FileReadToArray("Gather Config/" & $NAME & "_DoNotSellList.gat", $donotselllist)
	;_ArrayDisplay($donotselllist)
	For $i = 1 to UBound($buylist) - 1
		ReDim $donotselllist[Ubound($donotselllist) + 1]
		$donotselllist[Ubound($donotselllist) - 1] = $buylist[$i]
	Next
	;_ArrayDisplay($donotselllist)
	For $i = 0 To $tempinventoryarraysize -1
		$donotsell = False
		For $j = 1 to Ubound($donotselllist) - 1
			If $tempinventoryarray[$i][1] = $donotselllist[$j] Then
				$donotsell = True
				ExitLoop
			EndIf
		Next	
		If $tempinventoryarray[$i][0] <> 0 and $donotsell = False Then
			$sellid = $tempinventoryarray[$i][1]
			$sellamount = $tempinventoryarray[$i][2]
			;AddHistory("Selling " & $tempinventoryarray[$i][1])
			sellItem($sellid, $i, $sellamount)
			sleep(1000)
		EndIf
	Next
EndFunc

Func BuyItems()
	 sleep(10)
	BuildInventoryArray()
	Local $buylist, $buylistqty, $curqty, $buyamount, $shopindex
	 _FileReadToArray("Gather Config/" & $NAME & "_BuyList.gat", $buylist)
	 _FileReadToArray("Gather Config/" & $NAME & "_BuyListQTY.gat", $buylistqty)
	For $i = 1 to Ubound($buylist) - 1
		$curqty = 0
		For $j = 0 to $INVENTORYARRAYSIZE - 1
			If $buylist[$i] = $INVENTORYARRAY[$j][1] Then
				$curqty = $curqty + $INVENTORYARRAY[$j][2]
			EndIf
		Next
		addhistory("buying items")
		If 0 = 0 Then
			addhistory("need pots")
			If $buylist[$i] = 8617 Then
				$shopindex = 0
			ElseIf $buylist[$i] = 8618 Then
				$shopindex = 1
			ElseIf $buylist[$i] = 8619 Then
				$shopindex = 2
			ElseIf $buylist[$i] = 8620 Then
				$shopindex = 3
			ElseIf $buylist[$i] = 8621 Then
				$shopindex = 4
			ElseIf $buylist[$i] = 8612 Then
				$shopindex = 5
			ElseIf $buylist[$i] = 8613 Then
				$shopindex = 6
			ElseIf $buylist[$i] = 8614 Then
				$shopindex = 7
			ElseIf $buylist[$i] = 8647 Then
				$shopindex = 8
			ElseIf $buylist[$i] = 8648 Then
				$shopindex = 9
			ElseIf $buylist[$i] = 8649 Then
				$shopindex = 10
			ElseIf $buylist[$i] = 8650 Then
				$shopindex = 11
			ElseIf $buylist[$i] = 8651 Then
				$shopindex = 12
			ElseIf $buylist[$i] = 8642 Then
				$shopindex = 13
			ElseIf $buylist[$i] = 8643 Then
				$shopindex = 14
			ElseIf $buylist[$i] = 8644 Then
				$shopindex = 15
			Else
				$shopindex = "N/A"
			EndIf
			Addhistory("Have " & $curqty & " Of " & $buylist[$i])
			If $curqty < $buylistqty[$i] Then
				$buyamount = $buylistqty[$i] - $curqty
				AddHistory("$curqty =  " & $curqty)
				AddHistory("$buylistqty = " & $buylistqty[$i])
				AddHistory("$buyamount =  " & $buyamount)
				Do 
					BuildInventoryArray()
					sleep(1000)
					$curqty = 0
					For $k = 0 to $INVENTORYARRAYSIZE - 1
						If $buylist[$i] = $INVENTORYARRAY[$k][1] Then
							$curqty = $curqty + $INVENTORYARRAY[$k][2]
						EndIf
					Next
					$buyamount = $buylistqty[$i] - $curqty
					If $buyamount <= 100 And $buyamount > 0 Then
						$amount = $buyamount
						Addhistory("Buying1 " & $amount & " of " & $buylist[$i] & " Shop " & $shopindex)
						BuyItem($buylist[$i], $shopindex, $amount)
						$amount = $amount - $buyamount
						Sleep(2000)
					ElseIf $buyamount > 100 Then
						$amount = 100
						Addhistory("Buying2 " & $amount & " of " & $buylist[$i] & " Shop " & $shopindex)
						BuyItem($buylist[$i], $shopindex, $amount)
						$buyamount = $buyamount - 100
						Sleep(2000)
					EndIf
				Until $buyamount = 0
			EndIf
		Else
			addhistory("noshopindex")
		EndIf
	Next
EndFunc

Func Resurrect()
	Sleep(1000)
	GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Resurrecting")
	Do
		RezToTown()
		Sleep(5000)
		SituationalAwareness()
	Until $HP > 0
	_SendMessage($HANDLE, 256, KEYCODE("{ESC}"))
	 sleep(10)
	GetPetState()
	Sleep(1000)
	FLYMODE()
	GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Returning to Battle")
	$CURRENTRAIL = "Resurrect"
	 sleep(10)
	RunRail()
EndFunc		;==>

Func RestoreCharState($MODE)
	GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Restoring")
	AddHistory("Restoring")
	$KEY = IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")
	If $CHARSTATE = 32 Then
		sleep(500)
		elseif $CHARSTATE <> 32 then
	_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")))
	Sleep(2000)
	EndIf
	$RestTimer = TimerInit()
	If $MODE = 1 Then
		Do 
			petdef()
			sleep(1000)
		SituationalAwareness()

			sleep(10)
			HPMPAutoPotCheck()
			If $TAR <> 0 Then
				$TARGET = $TAR
				$HADTARGET = 1
				AddHistory("Defending During Restore")
				$REST = 1
				sleep(10)
				KillTarget()
				If $CHARSTATE <> 32 Then
					_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")))
					Sleep(2000)
				EndIf
			EndIf
			$RestTimerDiff = TimerDiff($RestTimer)
		Until $RestTimerDiff / 60000 > 3 Or GUICtrlRead($PERC_HP) > 98 Or $TAR <> 0 or $HP = 0
	Elseif $MODE = 2 Then
		Do 
			petdef()
			sleep(1000)

		SituationalAwareness()
			HPMPAutoPotCheck()
			If $TAR <> 0 Then
				$TARGET = $TAR
				AddHistory("Defending During Restore")
				$REST = 1
				$HADTARGET = 1
				sleep(10)
				KillTarget()
				If $CHARSTATE <> 32 Then
					_SendMessage($HANDLE, 256, KEYCODE(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "")))
					Sleep(2000)
				EndIf
			EndIf
			$RestTimerDiff = TimerDiff($RestTimer)
		Until $RestTimerDiff / 60000 > 3 Or GUICtrlRead($PERC_MP) > 98 Or $TAR <> 0 or $HP = 0
	EndIf
EndFunc		;==>

;======================================================================>
;
;
;			Processing Functions
;
;
;======================================================================>

Func SetExpList()
	For $i=0 To 150
		$exp_needed[$i] = _MemoryRead($APP_BASE_ADDRESSEXP + ($i*4) , $PROCESS_INFORMATION)
	Next
EndFunc		;==>

Func Keycode($key)
	If $key == "{F1}" Then
		Return 112
	ElseIf $key == "{F2}" Then
		Return 113
	ElseIf $key == "{F3}" Then
		Return 114
	ElseIf $key == "{F4}" Then
		Return 115
	ElseIf $key == "{F5}" Then
		Return 116
	ElseIf $key == "{F6}" Then
		Return 117
	ElseIf $key == "{F7}" Then
		Return 118
	ElseIf $key == "{F8}" Then
		Return 119
	ElseIf $key == "{0}" Then
		Return 48
	ElseIf $key == "{1}" Then
		Return 49
	ElseIf $key == "{2}" Then
		Return 50
	ElseIf $key == "{3}" Then
		Return 51
	ElseIf $key == "{4}" Then
		Return 52
	ElseIf $key == "{5}" Then
		Return 53
	ElseIf $key == "{6}" Then
		Return 54
	ElseIf $key == "{7}" Then
		Return 55
	ElseIf $key == "{8}" Then
		Return 56
	ElseIf $key == "{9}" Then
		Return 57
	ElseIf $key == "{TAB}" Then
		Return 9
	ElseIf $key == "{LMB}" Then
		Return 1
	ElseIf $key == "{RMB}" Then
		Return 2
	ElseIf $key == "{SHIFT}" Then
		Return 160
	ElseIf $key == "{CTRL}" Then
		Return 162
	ElseIf $key == "{ALT}" Then
		Return 18
	ElseIf $key == "{SPACE}" Then
		Return 32
	ElseIf $key == "{ESC}" Then
		Return 27
	ElseIf $key == "{+}" Then
		Return 107
	ElseIf $key == "{-}" Then
		Return 109
	Else
		Return "none"
	EndIf
EndFunc		;==>

Func AddHistory($TEXT)
	If _GUICtrlEdit_GetLineCount($LOG) > 14 Then
		GuiCtrlSetData($LOG, "")
	EndIf
	$OLDLOGS = guictrlread($LOG)
	GuiCtrlSetData($LOG, $TEXT & @crlf & $OLDLOGS)
EndFunc		;==>

Func StopCheck()
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_RES_ON_DIE_KEY, 0) = 1 Then
		If $HP = 0 Then
			GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Dead")
			Do
				sleep(1000)
				SituationalAwareness()
				If $HP = 0 Then
					 sleep(10)
					Resurrect()
				EndIf
				sleep(250)
			Until $HP > 0 
		EndIf
	EndIf	
EndFunc		;==>

Func GetRealXYZ($RawX, $RawY, $RawZ)
	Local $RealXYZ
	$RealX = ($RawX + 4000) / 10 
	$RealY = ($RawY + 5500) / 10 
	$RealZ = $RawZ / 10
	Return $RealX & "," & $RealY & "," & $RealZ
EndFunc		;==>

Func GetGrade($X1, $Y1, $Z1, $X2, $Y2, $Z2)
	Local $RISE, $RUN, $GRADE
	$RISE = GetSlopeDistance($X1, $Y1, $Z1, $X2, $Y2, $Z2)
	$RUN = GetDistance($X1, $Y1, $X2, $Y2)
	$GRADE = ($RUN / $RISE) * 100
	Return $GRADE
EndFunc		;==>

Func GetDistance($X1, $Y1, $X2, $Y2)
	GetRealXYZ($X1, $Y1, "")
	Local $DIS
	$DIS = Round(10*Sqrt(($X1-$X2)^2+($Y1-$Y2)^2), 1)
	Return $DIS
EndFunc		;==>

Func GetSlopeDistance($X1, $Y1, $Z1, $X2, $Y2, $Z2)
	Local $DIS
	$DIS = Round(10*Sqrt(($X1-$X2)^2+($Y1-$Y2)^2+($Z1-$Z2)^2), 1)
	Return $DIS
EndFunc		;==>

Func StrAddComma($sStr, $sSeperator = -1, $sEnd = -1)
    If $sSeperator = -1 Or $sSeperator = Default Then $sSeperator = ','
    If $sEnd = -1 Or $sEnd = Default Then $sEnd = '.'
    Local $aNum = StringSplit($sStr, $sEnd), $nHold, $aSRE, $fUB, $iAdd
    If UBound($aNum) > 2 Then
        $aSRE = StringRegExp($aNum[1], '(\d+)(\d{3})', 3)
        $fUB = True
    Else
        $aSRE = StringRegExp($sStr, '(\d+)(\d{3})', 3)
    EndIf
    If UBound($aSRE) = 2 Then
        While IsArray($aSRE)
            $nHold = $sSeperator & $aSRE[1] & $nHold
            $aSRE = StringRegExp($aSRE[0], '(\d+)(\d{3})', 3)
            $iAdd += 1
        WEnd
    EndIf
    If $fUB And $nHold Then
        Return SetError(0, 0, StringTrimRight($sStr, ($iAdd + 1) * 3) & $nHold & $sEnd & $aNum[2])
    ElseIf $nHold Then
        Return SetError(0, 0, StringTrimRight($sStr, $iAdd * 3) & $nHold)
    EndIf
    Return SetError(1, 0, $sStr)
EndFunc		;==>

Func _hex ($Value, $size=8, $type="int")
    Local $tmp1, $tmp2, $i 
    if($type = "int") Then
        $tmp1 = StringRight("000000000" & Hex ($Value),$size) 
    ElseIf($type = "float") Then
        $tmp1 = StringRight("000000000" & _FloatToHex ($Value),$size) 
    EndIf
    For $i = 0 To StringLen($tmp1) / 2 - 1 
        $tmp2 = $tmp2 & StringMid($tmp1, StringLen($tmp1) - 1 - 2 * $i, 2)
    Next
    Return $tmp2
EndFunc		;==>

Func _FloatToHex ( $floatval )
    $sF = DllStructCreate("float")
    $sB = DllStructCreate("ptr", DllStructGetPtr($sF))
    If $floatval = "" Then Exit
    DllStructSetData($sF, 1, $floatval)
    $return=DllStructGetData($sB, 1)
    Return $return
EndFunc		;==>

Func Rev($string)
	Local $all
	For $i = StringLen($string) + 1 To 1 Step -2
		$all = $all & StringMid($string, $i, 2)
	Next
	Return $all
EndFunc		;==>

Func _ProcessIdPath ( $vPID ) 
    Local $objWMIService, $oColItems
    Local $sNoExePath = ''
    Local Const $wbemFlagReturnImmediately = 0x10
    Local Const $wbemFlagForwardOnly = 0x20
    
    Local $RetErr_ProcessDoesntExist = 1
    Local $RetErr_ProcessPathUnknown = 2
    Local $RetErr_ProcessNotFound = 3
    Local $RetErr_ObjCreateErr = 4
    Local $RetErr_UnknownErr = 5
    
    If Not ProcessExists ( $vPID )  Then
        SetError ( $RetErr_ProcessDoesntExist ) 
        Return $sNoExepath
    EndIf
    
    $objWMIService = ObjGet ( 'winmgmts:\\localhost\root\CIMV2' ) 
    $oColItems = $objWMIService.ExecQuery  ( 'SELECT * FROM Win32_Process', 'WQL', $wbemFlagReturnImmediately + $wbemFlagForwardOnly ) 
    
    If IsObj ( $oColItems )  Then
        For $objItem In $oColItems
            If $vPID = $objItem.ProcessId Then
                If $objItem.ExecutablePath = '0' Then
                    If FileExists ( @SystemDir & '\' & $objItem.Caption )  Then
                        Return @SystemDir & '\' & $objItem.Caption
                    Else
                        SetError ( $RetErr_ProcessPathUnknown ) 
                        Return $sNoExepath
                    EndIf
                Else
                    Return $objItem.Executablepath
                EndIf
            EndIf
        Next
        SetError ( $RetErr_ProcessNotFound ) 
        Return $sNoExepath
    Else
        SetError ( $RetErr_ObjCreateErr ) 
        Return $sNoExepath
    EndIf
    
    SetError ( $RetErr_UnknownErr ) 
    Return $sNoExepath
EndFunc		;==>_ProcessIdPath

Func RenameWindow()
	If $ANSWER Then
		WinSetTitle($ANSWER, "", $NAME)
	Else
		WinSetTitle(IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_BASEADDRESS_ROOT_KEY, $CFG_BASEADDRESS_APP_KEY, "Element Client"), "", $NAME)
	EndIf

	Global $APP_TITLE = $NAME, $HANDLE = ControlGetHandle($APP_TITLE, "", "")
	If @error Then
		If @error Then
			MsgBox(0, "Can´t Find Perfect World", "Impossible to detect your Perfect World. Review settings in " & $SOFTWARE_OFFSET_CONFIG & ". Set the correct value for " & $CFG_BASEADDRESS_APP_KEY & " and for " & $CFG_BASEADDRESS_KEY & " properties.")
			Exit
		EndIf
	EndIf
		

	
EndFunc		;==>

;======================================================================>
;
;
;			Situational Awareness Functions
;
;
;======================================================================>

Func SituationalAwareness()
	If  TimerDiff($ChatTimer) > 10000 then
		BuildChatArray()
		if $WHISPER = 1 Then
				SoundPlay("Alien.wav")
				$WHISPER = 0
			EndIf
			$ChatTimer = TimerInit()
	EndIf
		$NAME = _MemoryRead(_MemoryRead($CHAR_DATA_BASE + $OFFSET_NAME, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[30]')
		If $NAME <> "" Then
			$CLASS = _MemoryRead($CHAR_DATA_BASE + $OFFSET_CLASS, $PROCESS_INFORMATION)
			$LVL = _MemoryRead($CHAR_DATA_BASE + $OFFSET_LVL, $PROCESS_INFORMATION)
		Else
			$LVL = "0"
			$CLASS = "8"
		EndIf
		$CHARID = _MemoryRead($CHAR_DATA_BASE + $OFFSET_CHARID, $PROCESS_INFORMATION)
		$HP = _MemoryRead($CHAR_DATA_BASE + $OFFSET_HP, $PROCESS_INFORMATION)
		$MAXHP = _MemoryRead($CHAR_DATA_BASE + $OFFSET_MAX_HP, $PROCESS_INFORMATION)
		$HPPERC = ($HP / $MAXHP) * 100
		$MP = _MemoryRead($CHAR_DATA_BASE + $OFFSET_MP, $PROCESS_INFORMATION)
		$MAXMP = _MemoryRead($CHAR_DATA_BASE + $OFFSET_MAX_MP, $PROCESS_INFORMATION)
		$EXP = _MemoryRead($CHAR_DATA_BASE + $OFFSET_EXP, $PROCESS_INFORMATION)
		$STR = _MemoryRead($CHAR_DATA_BASE + $OFFSET_STR, $PROCESS_INFORMATION)
		$DEX = _MemoryRead($CHAR_DATA_BASE + $OFFSET_DEX, $PROCESS_INFORMATION)
		$VIT = _MemoryRead($CHAR_DATA_BASE + $OFFSET_VIT, $PROCESS_INFORMATION)
		$MAG = _MemoryRead($CHAR_DATA_BASE + $OFFSET_MAG, $PROCESS_INFORMATION)
		$SPIRIT = _MemoryRead($CHAR_DATA_BASE + $OFFSET_SPIRIT, $PROCESS_INFORMATION)
		$GOLD = _MemoryRead($CHAR_DATA_BASE + $OFFSET_GOLD, $PROCESS_INFORMATION)
		$CHI = _MemoryRead($CHAR_DATA_BASE + $OFFSET_CHI, $PROCESS_INFORMATION)
		$AP = _MemoryRead($CHAR_DATA_BASE + $OFFSET_AP, $PROCESS_INFORMATION)
		$X = _MemoryRead($CHAR_DATA_BASE + $OFFSET_X, $PROCESS_INFORMATION, "float")
		$Y = _MemoryRead($CHAR_DATA_BASE + $OFFSET_Y, $PROCESS_INFORMATION, "float")
		$Z = _MemoryRead($CHAR_DATA_BASE + $OFFSET_Z, $PROCESS_INFORMATION, "float")
		$TEMPACTIONFLAG = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_ACTIONFLAG)
		$MOVEMODE = _MemoryRead($CHAR_DATA_BASE + $OFFSET_MOVEMODE, $PROCESS_INFORMATION)
		$CHARSTATE = _MemoryRead($CHAR_DATA_BASE + $OFFSET_CHARSTATE, $PROCESS_INFORMATION, "byte")
		$ACTIONFLAG = $TEMPACTIONFLAG[1]
		$CASTING = _MemoryRead($CHAR_DATA_BASE + $OFFSET_CASTING, $PROCESS_INFORMATION)
		BuildGlobalData()
EndFunc		;==>

Func BuildGlobalData()
	BuildPlayerArray()
	BuildNPCArray()
	Local $tar_temp, $tempnpcarray, $tempplayerarray, $selected
	$tempnpcarray = $NPCARRAY
	$tempplayerarray = $PLAYERARRAY
	$tar_temp = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_TAR)
	$selected = 0
	If TimerDiff($GATHERARRAYTIMER) > 5000 Then
		_FileReadToArray("Gather Config/" & $NAME & "_HerbsToLoot.gat", $HERBS)
		_FileReadToArray("Gather Config/" & $NAME & "_ResourcesToLoot.gat", $RESOURCES)
		$GATHERARRAYTIMER = TimerInit()
	EndIf
	If $tar_temp[1] = 0 Then
		$tar = 0
	Else
		$tempnpcarray = $npcarray
		$tempnpcarraysize = $npcarraysize
		For $x=0 To $tempnpcarraysize - 1
			If $tar_temp[1] = $tempnpcarray[$x][0] Then
				$TAR = $tar_temp[1]
				$Selected = 1
				ExitLoop
			EndIf
		Next
		If $Selected = 1 Then
			
			$TARNAME = $tempnpcarray[$x][1]
			$TARLVL = $tempnpcarray[$x][2]
			$TARHP = $tempnpcarray[$x][3]
			$TARMAXHP = $tempnpcarray[$x][4]
			If $tempnpcarray[$x][5] < 9 Then
				$TARSPEC = $SELECTED_SPECIAL_INFO[$tempnpcarray[$x][5]]
			EndIf
			$TARX = Round(($tempnpcarray[$x][6]+4000)/10, 1)
			$TARY = Round(($tempnpcarray[$x][7]+5500)/10, 1)
			$TARZ = Round($tempnpcarray[$x][8]/10, 1)
			If $TARX <> 400 And $TARY <> 550 Then
				$LASTTARX[1] = Round(($tempnpcarray[$x][6]+4000)/10, 1)
				$LASTTARX[2] = $tempnpcarray[$x][6]
				$LASTTARY[1] = Round(($tempnpcarray[$x][7]+5500)/10, 1)
				$LASTTARY[2] = $tempnpcarray[$x][7]
				$LASTTARZ[1] = Round($tempnpcarray[$x][8]/10, 1)
				$LASTTARZ[2] = $tempnpcarray[$x][8]
				$TARDIS = $tempnpcarray[$x][10] 
				$TARHOMEDIS = $tempnpcarray[$x][11] 
			EndIf
		Else
			$tempplayerarray = $playerarray
			$tempplayerarraysize = $playerarraysize
			For $x=0 To $tempplayerarraysize - 1
				If $tar_temp[1] = $tempplayerarray[$x][0] Then
					$tar = $tar_temp[1]
					$TARNAME = $tempplayerarray[$x][0]
					$SELECTED = 2
					ExitLoop
				EndIf
			Next
			If $Selected = 2 Then
				$TARNAME = $tempplayerarray[$x][1]
				$TARLVL = $tempplayerarray[$x][2]
				$TARHP = $tempplayerarray[$x][3]
				$TARMAXHP = $tempplayerarray[$x][4]
				$TARSPEC = $char_class_info[$tempplayerarray[$x][5]]
				$TARX = Round(($tempplayerarray[$x][6]+4000)/10, 1)
				$TARY = Round(($tempplayerarray[$x][7]+5500)/10, 1)
				$TARZ = Round($tempplayerarray[$x][8]/10, 1)
				If $TARX <> 400 And $TARY <> 550 Then
					$LASTTARX[1] = Round(($tempplayerarray[$x][6]+4000)/10, 1)
					$LASTTARX[2] = $tempplayerarray[$x][6]
					$LASTTARY[1] = Round(($tempplayerarray[$x][7]+5500)/10, 1)
					$LASTTARY[2] = $tempplayerarray[$x][7]
					$LASTTARZ[1] = Round($tempplayerarray[$x][8]/10, 1)
					$LASTTARZ[2] = $tempplayerarray[$x][8]
					$TARDIS = $tempplayerarray[$x][10] 
					$TARHOMEDIS = $tempplayerarray[$x][11] 
				EndIf
			EndIf
	    EndIf	
	endif
	UpdateGuiData()
EndFunc		;==>

Func UpdateGuiData()
	; --- GUI Stuff ---
	If GUICtrlRead($CHK_ANTIKS) <> IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_AKS_KEY, "0") Then
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_AKS_KEY, GUICtrlRead($CHK_ANTIKS))
	EndIf
	If GUICtrlRead($CHK_HBN) <> IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HBN_KEY, "0") Then
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HBN_KEY, GUICtrlRead($CHK_HBN))
	EndIf
	If GUICtrlRead($CHK_FZ) <> IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_FREEZE_KEY, "0") Then
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_FREEZE_KEY, GUICtrlRead($CHK_FZ))
	EndIf
	If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_FREEZE_KEY, "0") = 1 Then
		$FZ = _MemoryRead($APP_BASE_ADDRESSFZ, $PROCESS_INFORMATION)
		If $FZ <> 1 Then
			_MemoryWrite($APP_BASE_ADDRESSFZ, $PROCESS_INFORMATION, "1")
		EndIf
	EndIf
	
	; --- Char Stuff ---
	If GUICtrlRead($Label_NAME) <> $NAME Then
		GUICtrlSetData($Label_NAME, $NAME)
	EndIf
	If GUICtrlRead($Label_LVL) <> $LVL Then
		GUICtrlSetData($Label_LVL, $LVL)
	EndIf
	If GUICtrlRead($Label_Class) <> $char_class_info[$CLASS] Then
		GUICtrlSetData($Label_Class, $char_class_info[$CLASS])
	EndIf
	If GUICtrlRead($Perc_HP) <> $HP/$MAXHP * 100 Then
		GUICtrlSetData($Perc_HP, $HP/$MAXHP * 100)
		GUICtrlSetData($Label_HP, StrAddComma($HP) & "/" & StrAddComma($MAXHP))
	EndIf
	If GUICtrlRead($Perc_MP) <> $MP/$MAXMP * 100 Then
		GUICtrlSetData($Perc_MP, $MP/$MAXMP * 100)
		GUICtrlSetData($Label_MP, StrAddComma($MP) & "/" & StrAddComma($MAXMP))
	EndIf
	If GUICtrlRead($Label_EXP) <> Round($EXP / $exp_needed[$LVL] * 100, 2) & "%" Then
		GUICtrlSetData($Perc_EXP, Round($EXP / $exp_needed[$LVL] * 100, 2))
		GUICtrlSetData($Label_EXP, Round($EXP / $exp_needed[$LVL] * 100, 2) & "%")
	EndIf
	If GUICtrlRead($Label_NAME) = "" Then
		GUICtrlSetData($Label_EXP, "0%")
	EndIf
	If GUICtrlRead($Label_LVL) = 0 Then
		GUICtrlSetData($Label_LVL, $LVL)
	EndIf
	If GUICtrlRead($Label_NAME) = "" Then
		GUICtrlSetData($Label_XYZ, "000/000/000")
	ElseIf GUICtrlRead($Label_XYZ) <>  Round(($X + 4000) / 10, 2) & "/" & Round(($Y + 5500) / 10, 2) & "/" & Round($Z / 10, 1) Then
		$MOVEFLAG = 1
		GUICtrlSetData($Label_XYZ, Round(($X + 4000) / 10, 2) & "/" & Round(($Y + 5500) / 10, 2) & "/" & Round($Z / 10, 1))
	Else
		$MOVEFLAG = 0
	EndIf
	If GUICtrlRead($Label_STR) <> $STR Then
		GUICtrlSetData($Label_STR, $STR)
	EndIf
	If GUICtrlRead($Label_DEX) <> $DEX Then
		GUICtrlSetData($Label_DEX, $DEX)
	EndIf
	If GUICtrlRead($Label_VIT) <> $VIT Then
		GUICtrlSetData($Label_VIT, $VIT)
	EndIf
	If GUICtrlRead($Label_MAG) <> $MAG Then
		GUICtrlSetData($Label_MAG, $MAG)
	EndIf
	If GUICtrlRead($Label_SPIRIT) <> $SPIRIT Then
		GUICtrlSetData($Label_SPIRIT, $SPIRIT)
	EndIf
	If GUICtrlRead($Label_GOLD) <> $GOLD Then
		GUICtrlSetData($Label_GOLD, $GOLD)
	EndIf
	
	; --- Target Stuff ---
	If Not $TAR Then
		If GUICtrlRead($label_TarNAME) <> "None" Then
			GUICtrlSetData($Label_TarNAME, "None")
		EndIf
		If $MOVEING = 1 Then
			$LASTTARDIS =  GetDistance(($X + 4000) / 10, ($Y + 5500) / 10, $LASTTARX[1], $LASTTARY[1]) ;($X + 4000) / 10 & "/" & ($Y + 5500) / 10 & "/" & $Z / 10
			GUICtrlSetData($Label_TarDIST, $LASTTARDIS & "m")
		Else
			GUICtrlSetData($Label_TarDIST, "0m")
		EndIf
		If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") = 0 Then
			GUICtrlSetData($LABEL_RADCENTER, "Infinite Radius")
		Else
			GUICtrlSetData($LABEL_RADCENTER, "Hunt By Radius ON")
		EndIf
		If GUICtrlRead($Label_TarSPEC) <> "None" Then
			GUICtrlSetData($Label_TarSPEC, "None")
		EndIf
		If GUICtrlRead($Perc_TarHP) <> "0" Then
			GUICtrlSetData($Perc_TarHP, "0")
		EndIf
		If GUICtrlRead($Label_TarHP) <> "0/0" Then
			GUICtrlSetData($Label_TarHP, "0/0")
		EndIf
	Else
		If GUICtrlRead($label_TarNAME) <> $TARNAME & " [" & $TARLVL & "]" Then
			GUICtrlSetData($Label_TarNAME, $TARNAME & " [" & $TARLVL & "]")
		EndIf
		If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") = 0 Then
			If GUICtrlRead($Label_TarDIST) <> $TARDIS Then
				GUICtrlSetData($Label_TarDIST, $TARDIS & "m")
			EndIf
		Else
			If GUICtrlRead($LABEL_TARDIST) <> $TARDIS & "m" Then
				If IniRead($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, "0") = 0 Then
					GUICtrlSetData($LABEL_RADCENTER, "0 = No Limit")
				Else
					GUICtrlSetData($LABEL_RADCENTER, "Dist: " & $TARHOMEDIS & "m")
				EndIf
				GUICtrlSetData($Label_TarDIST, $TARDIS & "m")
			EndIf
		EndIf
		If GUICtrlRead($Label_TarSPEC) <> $TARSPEC Then
			GUICtrlSetData($Label_TarSPEC, $TARSPEC)
		EndIf
		If GUICtrlRead($Label_TarHP) <> StrAddComma($TARHP) & "/" & StrAddComma($TARMAXHP) Then
			GUICtrlSetData($Perc_TarHP, $TARHP/$TARMAXHP * 100)
			GUICtrlSetData($Label_TarHP, StrAddComma($TARHP) & "/" & StrAddComma($TARMAXHP))
		EndIf
	EndIf
EndFunc		;==>

;======================================================================>
;
;			Array Functions
;	0 = ID
;	1 = Name5
;	2 = Level
;	3 = HP
;	4 = MAXHP
;	5 = Class
;	6 = X
;	7 = Y
;	8 = Z
;	9 = $PlayerBase
;	10 = Distance 
;	11 = Distance from home
;
;======================================================================>

Func BuildPlayerArray()
	Local $array[1][12], $sortedPlayerList, $playerCountPointer, $playerCount, $playerPointer
	$playerCount = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_PLAYERCOUNT)
	If $playerCount[1] <> 0 Then
		ReDim $array[$playerCount[1]][12]
		For $p=0 To ($playerCount[1] - 1)
			$playerPointer = _MemoryRead($PLAYER_DATA_BASE[1] + $p * 4, $PROCESS_INFORMATION)
			$array[$p][0] = _MemoryRead($playerPointer + $OFFSET_PLAYERID, $PROCESS_INFORMATION) ;ID
			$array[$p][1] = _MemoryRead(_MemoryRead($playerPointer + $OFFSET_PLAYERNAME + 0x0, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[30]') ;Name
			$array[$p][2] = _MemoryRead($playerPointer + $OFFSET_PLAYERLVL, $PROCESS_INFORMATION) ;Level
			$array[$p][3] = _MemoryRead($playerPointer + $OFFSET_PLAYERHP, $PROCESS_INFORMATION) ;HP
			$array[$p][4] = _MemoryRead($playerPointer + $OFFSET_PLAYERMAXHP, $PROCESS_INFORMATION) ;MAXHP
			$array[$p][5] = _MemoryRead($playerPointer + $OFFSET_PLAYERCLASS, $PROCESS_INFORMATION) ;Class
			$array[$p][6] = _MemoryRead($playerPointer + $OFFSET_PLAYERX, $PROCESS_INFORMATION, 'float') ;X
			$array[$p][7] = _MemoryRead($playerPointer + $OFFSET_PLAYERY, $PROCESS_INFORMATION, 'float') ;Y
			$array[$p][8] = _MemoryRead($playerPointer + $OFFSET_PLAYERZ, $PROCESS_INFORMATION, 'float') ;Z
			$array[$p][9] = $playerPointer ;Player Base
			$array[$p][10] = GetSlopeDistance(($X + 4000) / 10, ($Y + 5500) / 10, $Z / 10, ($array[$p][6] + 4000) / 10, ($array[$p][7] + 5500) / 10, $array[$p][8] / 10)
			$array[$p][11] = GetSlopeDistance(($HOME_X + 4000) / 10, ($HOME_Y + 5500) / 10, $HOME_Z / 10, ($array[$p][6] + 4000) / 10, ($array[$p][7] + 5500) / 10, $array[$p][8] / 10)
		Next
	EndIf
	_ArraySort($array, "", "", "", 10)
	;_ArrayDisplay($array)
	Global $PlayerArray = $array, $PlayerArraySize = $playerCount[1]
	 sleep(10)
EndFunc		;==>

Func BuildNPCArray()
	Local $array[1][17], $sortedNPCList, $NPCCount, $NPCPointer
	Global $OFFSET_PETID[4]
	$OFFSET_PETID[1] = Dec("34")
	$OFFSET_PETID[2] = IniRead($SOFTWARE_OFFSET_CONFIG, $CFG_OFFSET_ROOT_KEY, $CFG_OFFSET_PETBASE, "")
	$OFFSET_PETID[3] = Dec("3C")
	Global $PETID = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_PETID)
	$NPCCount = _MemoryPointerRead($APP_BASE_ADDRESS, $PROCESS_INFORMATION, $OFFSET_NPCCOUNT)
	If $NPCCount[1] <> 0 Then
		ReDim $array[$NPCCount[1]][17]
		For $n=0 To ($NPCCount[1] - 1)
			$NPCPointer = _MemoryRead($NPC_DATA_BASE[1] + $n * 4, $PROCESS_INFORMATION)
			$array[$n][0] = _MemoryRead($NPCPointer + $OFFSET_NPCID, $PROCESS_INFORMATION) ;ID
			$array[$n][1] = _MemoryRead(_MemoryRead($NPCPointer + $OFFSET_NPCNAME, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[30]') 	;Name
			$array[$n][2] = _MemoryRead($NPCPointer + $OFFSET_NPCLVL, $PROCESS_INFORMATION) ;Level
			$array[$n][3] = _MemoryRead($NPCPointer + $OFFSET_NPCHP, $PROCESS_INFORMATION) ;HP
			$array[$n][4] = _MemoryRead($NPCPointer + $OFFSET_NPCMAXHP, $PROCESS_INFORMATION) ;MAXHP
			$array[$n][5] = _MemoryRead($NPCPointer + $OFFSET_NPCSPECIAL, $PROCESS_INFORMATION) ;Special Information
			$array[$n][6] = _MemoryRead($NPCPointer + $OFFSET_NPCX, $PROCESS_INFORMATION, 'float') ;X
			$array[$n][7] = _MemoryRead($NPCPointer + $OFFSET_NPCY, $PROCESS_INFORMATION, 'float') ;Y
			$array[$n][8] = _MemoryRead($NPCPointer + $OFFSET_NPCZ, $PROCESS_INFORMATION, 'float') ;Z
			$array[$n][9] = $NPCPointer ;NPC Base
			$array[$n][10] = GetSlopeDistance(($X + 4000) / 10, ($Y + 5500) / 10, $Z / 10, ($array[$n][6] + 4000) / 10, ($array[$n][7] + 5500) / 10, $array[$n][8] / 10)
			$array[$n][11] = GetSlopeDistance(($HOME_X + 4000) / 10, ($HOME_Y + 5500) / 10, $HOME_Z / 10, ($array[$n][6] + 4000) / 10, ($array[$n][7] + 5500) / 10, $array[$n][8] / 10)
			$array[$n][12] = _MemoryRead($NPCPointer + Dec("2DC"), $PROCESS_INFORMATION) ;Its Target ID
			$array[$n][13] = _MemoryRead($NPCPointer + Dec("2E0"), $PROCESS_INFORMATION) ;Aggro Flag
			$array[$n][14] = _MemoryRead($NPCPointer + Dec("2B8"), $PROCESS_INFORMATION) ;Type of attack
			$array[$n][15] = _MemoryRead($NPCPointer + $OFFSET_NPCPAI, $PROCESS_INFORMATION) ;Physical Attacking ID
			$array[$n][16] = $PETID[1] ;Pet ID
		Next
	EndIf
	_ArraySort($array, "", "", "", 10)
	;_ArrayDisplay($array)
	Global $NPCArray = $array, $NPCArraySize = $NPCCount[1]
	 sleep(100)
EndFunc		;==>

Func BuildItemArray()
	Local $array[1][8], $pointer, $item_base, $counter
	For $i=0 To 768
		$pointer = _MemoryRead(_MemoryRead($ITEM_DATA_BASE[1] + $i * 0x4, $PROCESS_INFORMATION) + 0x4 , $PROCESS_INFORMATION)
		If $pointer <> 0 Then
			ReDim $array[$counter + 1][8]
			$array[$counter][0] = _MemoryRead($pointer + $OFFSET_ITEMID, $PROCESS_INFORMATION) ;ID
			$array[$counter][1] = _MemoryRead($pointer + $OFFSET_ITEMSN, $PROCESS_INFORMATION) ;SN
			$array[$counter][2] = _MemoryRead(_MemoryRead($pointer + $OFFSET_ITEMNAME, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[30]') ;Name
			$array[$counter][3] = _MemoryRead($pointer + $OFFSET_ITEMX, $PROCESS_INFORMATION, 'float') ;X
			$array[$counter][4] = _MemoryRead($pointer + $OFFSET_ITEMY, $PROCESS_INFORMATION, 'float') ;X
			$array[$counter][5] = _MemoryRead($pointer + $OFFSET_ITEMZ, $PROCESS_INFORMATION, 'float') ;Y
			$array[$counter][6] = GetSlopeDistance(($X + 4000) / 10, ($Y + 5500) / 10, $Z / 10, ($array[$counter][3] + 4000) / 10, ($array[$counter][4] + 5500) / 10, $array[$counter][5] / 10)
			$array[$counter][7] = GetSlopeDistance(($HOME_X + 4000) / 10, ($HOME_Y + 5500) / 10, $HOME_Z / 10, ($array[$counter][3] + 4000) / 10, ($array[$counter][4] + 5500) / 10, $array[$counter][5] / 10)
			$counter += 1
		EndIf
	Next
	_ArraySort($array, "", "", "", 6)
	;_ArrayDisplay($array)
	Global $ItemArray = $array, $ItemArraySize = $counter - 1
	 sleep(10)
EndFunc		;==>

Func BuildInventoryArray()
	Local $array[1][7], $pointer, $inventory_base, $counter, $inventorysize
	$inventorysize = _MemoryRead(_MemoryRead($CHAR_DATA_BASE + 0xCA4, $PROCESS_INFORMATION) + 0x10, $PROCESS_INFORMATION) ;[CHAR_DATA_BASE + 0xC50] + 0x10] ;or 0x14, not sure if both work, might be different with extended inventory
	$pointer = _MemoryRead(_MemoryRead($CHAR_DATA_BASE + 0xCA4, $PROCESS_INFORMATION) + 0xC, $PROCESS_INFORMATION)
	For $i=0 To $inventorysize - 1
		$inventory_base = _MemoryRead($pointer + $i * 0x4, $PROCESS_INFORMATION)
		ReDim $array[$i + 1][7]
		$array[$i][0] = _MemoryRead($inventory_base, $PROCESS_INFORMATION) ;ID
		$array[$i][1] = _MemoryRead($inventory_base + $OFFSET_INVENTORYID, $PROCESS_INFORMATION) ;ID
		$array[$i][2] = _MemoryRead($inventory_base + $OFFSET_INVENTORYSTACKAMOUNT, $PROCESS_INFORMATION) ;Stack Amount
		$array[$i][3] = _MemoryRead($inventory_base + $OFFSET_INVENTORYMAXSTACKAMOUNT, $PROCESS_INFORMATION) ;MAX Stack Amount
		$array[$i][4] = _MemoryRead($inventory_base + $OFFSET_INVENTORYSELLPRICE, $PROCESS_INFORMATION) ;Sell Price
		$array[$i][5] = _MemoryRead($inventory_base + $OFFSET_INVENTORYBUYPRICE, $PROCESS_INFORMATION) ;Buy Price
		$array[$i][6] = _MemoryRead(_MemoryRead($inventory_base + $OFFSET_INVENTORYDESCRIPTION, $PROCESS_INFORMATION), $PROCESS_INFORMATION, 'wchar[30]') ;Name
	Next
	If $array[$inventorysize - 1][0] <> "" Then
		$PACKFULL = True
	Else
		$PACKFULL = False
	EndIf
	;_ArrayDisplay($array)

	
	Global $InventoryArray = $array, $InventoryArraySize = $inventorysize - 1
	 sleep(10)
EndFunc		;==>

Func BuildDoNotSellList()
	sleep(10)
	BuildInventoryArray()
	Local $tempinventoryarray = $InventoryArray
	Local $array[1]
	For $i = 0 to Ubound($tempinventoryarray) - 1
		If $tempinventoryarray[$i][1] <> 0 Then
			_ArraySearch($array, $tempinventoryarray[$i][1])
			If @error = 6 Then
				ReDim $array[Ubound($array) + 1]
				$array[Ubound($array) - 1] = $tempinventoryarray[$i][1]
			EndIf
		EndIf
	Next
	;_ArrayDisplay($array)
	Local $BuyList[1] 
	$BuyList[0]= "Insert Item ID's That You Wish To Purchase At Apothocary, Each On A Seperate Line (Delete This Text)"
	Local $BuyListQTY[1] 
	$BuyListQTY[0] = "Insert Quantities Of The Item ID's In The Buy List, Each On A Seperate Line (Delete This Text)"
	_FileWriteFromArray("Gather Config/" & $NAME & "_DoNotSellList.gat" , $array, 1)
	_FileWriteFromArray("Gather Config/" & $NAME & "_BuyList.gat" , $BuyList, 1)
	_FileWriteFromArray("Gather Config/" & $NAME & "_BuyListQTY.gat" , $BuyListQTY, 1)
EndFunc
;======================================================================>
;
;
;			Packet Functions
;
;
;======================================================================>

Func sendPacket($packet, $packetSize, $PROCESS_ID)
	;Declare local variables
	Local $pRemoteThread, $vBuffer, $loop, $result, $OPcode, $processHandle, $packetAddress
	
	;Open process for given processId
	$processHandle = $PROCESS_INFORMATION[1]
	
	;Allocate memory for the OpCode and retrieve address for this
	$functionAddress = DllCall($KERNEL32, 'int', 'VirtualAllocEx', 'int', $processHandle, 'ptr', 0, 'int', 0x46, 'int', 0x1000, 'int', 0x40)
	
	;Allocate memory for the packet to be sent and retrieve the address for this
	$packetAddress = DllCall($KERNEL32, 'int', 'VirtualAllocEx', 'int', $processHandle, 'ptr', 0, 'int', $packetSize, 'int', 0x1000, 'int', 0x40)
	
	;Construct the OpCode for calling the 'SendPacket' function
	$OPcode &= '60'								;PUSHAD
	$OPcode &= 'B8'&_hex($SENDPACKETADDRESS)	;MOV	 EAX, sendPacketAddress
	$OPcode &= '8B0D'&_hex($REALBASEADDRESS)	;MOV     ECX, DWORD PTR [revBaseAddress]
	$OPcode &= '8B4920'							;MOV     ECX, DWORD PTR [ECX+20]
	$OPcode &= 'BF'&_hex($packetAddress[0])		;MOV     EDI, packetAddress	//src pointer
	$OPcode &= '6A'&_hex($packetSize,2)			;PUSH    packetSize		//size
	$OPcode &= '57'								;PUSH    EDI
	$OPcode &= 'FFD0'							;CALL    EAX
	$OPcode &= '61'								;POPAD
	$OPcode &= 'C3'								;RET		
	
	;Put the OpCode into a struct for later memory writing
	$vBuffer = DllStructCreate('byte[' & StringLen($OPcode) / 2 & ']')
	For $loop = 1 To DllStructGetSize($vBuffer)
		DllStructSetData($vBuffer, 1, Dec(StringMid($OPcode, ($loop - 1) * 2 + 1, 2)), $loop)
	Next
	
	;Write the OpCode to previously allocated memory
	DllCall($KERNEL32, 'int', 'WriteProcessMemory', 'int', $processHandle, 'int', $functionAddress[0], 'int', DllStructGetPtr($vBuffer), 'int', DllStructGetSize($vBuffer), 'int', 0)
		
	;Put the packet into a struct for later memory writing
	$vBuffer = DllStructCreate('byte[' & StringLen($packet) / 2 & ']')
	For $loop = 1 To DllStructGetSize($vBuffer)
		DllStructSetData($vBuffer, 1, Dec(StringMid($packet, ($loop - 1) * 2 + 1, 2)), $loop)
	Next
	
	;Write the packet to previously allocated memory
	DllCall($KERNEL32, 'int', 'WriteProcessMemory', 'int', $processHandle, 'int', $packetAddress[0], 'int', DllStructGetPtr($vBuffer), 'int', DllStructGetSize($vBuffer), 'int', 0)
		
	;Create a remote thread in order to run the OpCode
	$hRemoteThread = DllCall($KERNEL32, 'int', 'CreateRemoteThread', 'int', $processHandle, 'int', 0, 'int', 0, 'int', $functionAddress[0], 'ptr', 0, 'int', 0, 'int', 0)
	
	;Wait for the remote thread to finish
	Do
		$result = DllCall('kernel32.dll', 'int', 'WaitForSingleObject', 'int', $hRemoteThread[0], 'int', 50)
	Until $result[0] <> 258
	
	;Close the handle to the previously created remote thread
	DllCall($KERNEL32, 'int', 'CloseHandle', 'int', $hRemoteThread[0])
	
	;Free the previously allocated memory
	DllCall($KERNEL32, 'ptr', 'VirtualFreeEx', 'hwnd', $processHandle, 'int', $functionAddress[0], 'int', 0, 'int', 0x8000)
	DllCall($KERNEL32, 'ptr', 'VirtualFreeEx', 'hwnd', $processHandle, 'int', $packetAddress[0], 'int', 0, 'int', 0x8000)
	
	;Close the Process
	;memclose($processHandle)
	
	Return True
EndFunc		;==>

Func logOut()
	;Sends a packet to log the character from the server
	local $packet, $packetSize
	
	$packet = '0100'
	$packet &= '01000000'
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

;Func selectTargetID($targetId)
Func SelectTarID($targetId)
	;Select the NPC/Mob/Player denoted by targetId
	local $packet, $packetSize
	
	$packet = '0200'
	$packet &= _hex($targetId)
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func regularAttack($afterSkill)
	;Start with regular attacks. $afterskill is 1 if you
	;start attacking after using a skill.
	local $packet, $packetSize
	
	$packet = '0300'
	$packet &= _hex($afterSkill, 2)
	$packetSize = 3
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func pickUpItem($uniqueItemId, $itemTypeId)
	;Picks up an item. uniqueItemId is the unique id belonging
	;to the individual item on the ground. itemTypeId is the id for 
	;the type of item it is. This would be the same as the last
	;part in the url on pwdatabase. example:
	;http://www.pwdatabase.com/pwi/items/3044
	;the itemTypeId for gold is 3044.
	
	local $packet, $packetSize
	
	$packet = '0600'
	$packet &= _hex($uniqueItemId)
	$packet &= _hex($itemTypeId)
	$packetSize = 10
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func deselectTarget()
	;Deselects the currently selected target
	local $packet, $packetSize
	
	$packet = '0800'
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func updateInvPosition($invPosition)
	;This packet is sent whenever you pick up HH/TT items
	;Unsure as to why. Also happens when you find a 
	;quest item or equipment.
	local $packet, $packetSize
	
	$packet = '0900'
	$packet &= _hex($invPosition, 2)
	$packetSize = 3
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func swapItemInInv($invIndex1, $invIndex2)
	;Swaps the items in the two given inventory locations
	;The index for a standard unexpanded inventory runs from 
	;0, top left, to 31, bottom right
	local $packet, $packetSize
	
	$packet = '0C00'
	$packet &= _hex($invIndex1, 2)
	$packet &= _hex($invIndex2, 2)
	$packetSize = 4
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func splitStackItemInInv($invIndexSource, $invIndexDestination, $amount)
	;Splits a stack in your inventory located at invIndexSource
	;Take off $amouunt from the stack and place them at invIndexDestination
	;The index for a standard unexpanded inventory runs from 
	;0, top left, to 31, bottom right	
	local $packet, $packetSize
	
	$packet = '0D00'
	$packet &= _hex($invIndexSource, 2)
	$packet &= _hex($invIndexDestination, 2)
	$packet &= _hex($amount, 4)
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func dropItemOnFloor($invIndexSource, $amount)
	;Drops the stack located at invIndexSource in your inventory
	;onto the floor.
	;The index for a standard unexpanded inventory runs from 
	;0, top left, to 31, bottom right	
	local $packet, $packetSize
	
	$packet = '0E00'
	$packet &= _hex($invIndexSource, 2)
	$packet &= _hex($amount, 4)
	$packetSize = 5
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func swapEquip($equipIndex1, $equipIndex2)
	;Swaps the items in the two given equipment locations
	;The index for equipment runs from 
	;0, weapon, to 24, speaker?. This also includes fashion
	;Obviously there aren't a lot of equipment types you can swap
	;besides rings.
	local $packet, $packetSize
	
	$packet = '1000'
	$packet &= _hex($equipIndex1, 2)
	$packet &= _hex($equipIndex2, 2)
	$packetSize = 4
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func swapEquipWithInv($invIndex, $equipIndex)
	;Swaps the items in the invIndex location with the 
	;item in the equipment location
	;The index for equipment runs from 
	;0, weapon, to 24, speaker?. This also includes fashion
	;The index for a standard unexpanded inventory runs from 
	;0, top left, to 31, bottom right
	local $packet, $packetSize
	
	$packet = '1100'
	$packet &= _hex($invIndex, 2)
	$packet &= _hex($equipIndex, 2)
	$packetSize = 4
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func dropGold($amount)
	;Drops $amount of gold to floor
	local $packet, $packetSize
	
	$packet = '1400'
	$packet &= _hex($invIndex)
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func updateStats()
	;Is sent whenever a new item is equipped or stat 
	;screen is opened or you level up.
	local $packet, $packetSize
	
	$packet = '1500'
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func startNpcDialogue($npcId)
	;Opens up an NPC's main menu. Is necessary before
	;accepting/handing in quests, buy/sell/repair
	local $packet, $packetSize
	
	$packet = '2300'
	$packet &= _hex($npcId)
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func useItem($index, $itemTypeId, $equip=0)
	;uses the item located at index. By default inventory index
	;is used. If equip=1, then equipment index is used. This
	;is necessary when toggling fly mode, as your fly gear
	;is then used. 
	;itemTypeId is the id for 
	;the type of item it is. This would be the same as the last
	;part in the url on pwdatabase. example:
	;http://www.pwdatabase.com/pwi/items/3044
	;the itemTypeId for gold is 3044.
	local $packet, $packetSize

	$packet = '2800'
	$packet &= _hex($equip, 2)
	$packet &= '01'
	$packet &= _hex($index, 2)
	$packet &= '00'
	$packet &= _hex($itemTypeId)
	
	$packetSize = 10
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func useSkill($skillId, $targetId)
	;uses the specified skill on the target. Pass your own
	;Id if you wish to use buffs. When teleporting targetId
	;is the targeted city.
	local $packet, $packetSize

	$packet = '2900'
	$packet &= _hex($skillId)
	$packet &= '0001'
	$packet &= _hex($targetId)
	
	$packetSize = 12
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func cancelAction()
	;Cancels for example your current skillCast
	local $packet, $packetSize

	$packet = '2A00'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func startMeditating()
	;Starts meditating for faster HP/MP regen
	local $packet, $packetSize

	$packet = '2E00'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func stopMeditating()
	;Stop meditating for faster HP/MP regen
	local $packet, $packetSize

	$packet = '2F00'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func useEmotion($emoteIndex)
	;uses the emotion located at index emoteIndex 0 to 26
	local $packet, $packetSize

	$packet = '3000'
	$packet &= _hex($emoteIndex, 4)
	
	$packetSize = 4
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func swapItemInBank($bankIndex1, $bankIndex2)
	;swaps the location of two stacks in bank. bankIndex runs
	;from 0, topleft,  to 15, bottomright, in a standard non 
	;upgraded bank.
	local $packet, $packetSize

	$packet = '3800'
	$packet &= '03'
	$packet &= _hex($bankIndex1, 2)
	$packet &= _hex($bankIndex2, 2)
	
	$packetSize = 5
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func splitStackItemInBank($bankIndexSource, $bankIndexDestination, $amount)
	;Splits a stack in your bank located at bankIndexSource
	;Take off $amouunt from the stack and place them at bankIndexDestination
	;The index for a standard unexpanded bank runs from 
	;0, top left, to 15, bottom right	
	local $packet, $packetSize
	
	$packet = '3900'
	$packet &= '03'
	$packet &= _hex($bankIndexSource, 2)
	$packet &= _hex($bankIndexDestination, 2)
	$packet &= _hex($amount, 4)
	
	$packetSize = 7
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func swapItemBankAndInv($bankIndex, $invIndex)
	;Swaps a stack in your bank located at bankIndex 
	;with one in your inventory located at invIndex
	local $packet, $packetSize
	
	$packet = '3A00'
	$packet &= '03'
	$packet &= _hex($bankIndex, 2)
	$packet &= _hex($invIndex, 2)
	
	$packetSize = 5
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func splitStackItemInBankToInv($bankIndexSource, $invIndexDestination, $amount)
	;Splits a stack in your bank located at bankIndexSource
	;Take off $amouunt from the stack and place them at invIndexDestination
	local $packet, $packetSize
	
	$packet = '3B00'
	$packet &= '03'
	$packet &= _hex($bankIndexSource, 2)
	$packet &= _hex($invIndexDestination, 2)
	$packet &= _hex($amount, 4)
	
	$packetSize = 7
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func splitStackItemInInvToBank($invIndexSource, $bankIndexDestination, $amount)
	;Splits a stack in your inventory located at invIndexSource
	;Take off $amouunt from the stack and place them at bankIndexDestination
	local $packet, $packetSize
	
	$packet = '3C00'
	$packet &= '03'
	$packet &= _hex($invIndexSource, 2)
	$packet &= _hex($bankIndexDestination, 2)
	$packet &= _hex($amount, 4)
	
	$packetSize = 7
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func useSkillWithoutCastTime($skillId, $targetId)
	;uses the specified skill on the target. This function is used
	; instead of the regular skill use one for skills such as 
	; change to fox/tiger form or the speed buff skills. Pass your own
	;Id if you wish to use buffs. 
	local $packet, $packetSize

	$packet = '5000'
	$packet &= _hex($skillId)
	$packet &= '0001'
	$packet &= _hex($targetId)
	
	$packetSize = 12
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func initiateSettingUpCatShop()
	;Starts setting up cat shop. This function is needed
	;before setting up the catshop.
	local $packet, $packetSize

	$packet = '5400'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func toggleFashionDisplay()
	;Switches between fashion and regular appearance.
	local $packet, $packetSize

	$packet = '5500'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func increaseFlySpeed($start)
	;If start=1, start faster flying. 
	;If start=0, stop faster flying
	local $packet, $packetSize

	$packet = '5A00'
	$packet &= _hex($start)
	
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func summonPet($petIndex)
	;summons pet at index petIndex. petIndex runs from 
	;0 to 9, depending on how many slots you have unlocked
	local $packet, $packetSize

	$packet = '6400'
	$packet &= _hex($petIndex)
	
	$packetSize = 6
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func recallPet()
	;recalls your currently summoned pet
	local $packet, $packetSize

	$packet = '6500'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func setPetMode($petMode)
	;Sets the pet to the specified mode:
	;petMode=0 -> defensive
	;petMode=1 -> attack
	;petMode=2 -> manual
	local $packet, $packetSize

	$packet = '6700'
	$packet &= '00000000'
	$packet &= '03000000'
	$packet &= _hex($petMode)
	
	$packetSize = 14
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func setPetFollow()
	;Pet follows the owner
	local $packet, $packetSize

	$packet = '6700'
	$packet &= '00000000'
	$packet &= '02000000'
	$packet &= '00000000'

	$packetSize = 14
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func setPetStop()
	;Pet stops doing whatever it was doing
	local $packet, $packetSize

	$packet = '6700'
	$packet &= '00000000'
	$packet &= '02000000'
	$packet &= '01000000'

	$packetSize = 14
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func setPetAttack($targetId)
	;Sets pet to do standard attacks on the target.
	local $packet, $packetSize

	$packet = '6700'
	$packet &= _hex($targetId)
	$packet &= '01'
	$packet &= '00000000'

	$packetSize = 11
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func setPetUseSkill($targetId, $skillId)
	;Uses skillId on the targetId. Walks up to target if out of range.
	local $packet, $packetSize

	$packet = '6700'
	$packet &= _hex($targetId)
	$packet &= '04000000'
	$packet &= _hex($skillId)
	$packet &= '00'

	$packetSize = 15
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func setPetStandardSkill($skillId)
	;Sets skillId to be the skill the pet uses whenever
	;it is cooled down
	local $packet, $packetSize

	$packet = '6700'
	$packet &= '00000000'
	$packet &= '05000000'
	$packet &= _hex($skillId)

	$packetSize = 14
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func useGenieSkill($skillId,$targetId)
	;Uses skillId on the target
	local $packet, $packetSize

	$packet = '7400'
	$packet &= _hex($skillId, 4)
	$packet &= '0001'
	$packet &= _hex($targetId)

	$packetSize = 10
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func feedEquippedGenie($invIndex, $amount)
	;Feeds the equipped genie the amount indicated from
	;inv index 
	local $packet, $packetSize

	$packet = '7500'
	$packet &= _hex($invIndex, 2)
	$packet &= _hex($amount)

	$packetSize = 7
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func acceptQuest($questId)
	;Accept a new quest
	local $packet, $packetSize

	$packet = '2500'
	$packet &= '07000000'
	$packet &= '04000000'
	$packet &= _hex($questId)

	$packetSize = 14
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func handInQuest($questId,$optionIndex)
	;Hand in quest, select reward optionIndex, 
	;which runs from 0 for first option, to more.
	local $packet, $packetSize
	$packet = '2500'
	$packet &= '06000000'
	$packet &= '08000000'
	$packet &= _hex($questId)
	$packet &= _hex($optionIndex)
    $packet &= '09000001'
	$packetSize = 18
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func sellItem($itemTypeId,$invIndex,$amount)
	;Sell $amount of items of type itemTypeId, located at invIndex
	;This function could be expanded to include selling multiple items
	;simultaneously. This would require setting nBytes equal to 
	;4 + 12 * nDifferent items. Add the extra items on the same way
	;as the first item.
	local $packet, $packetSize

	$packet = '2500'
	$packet &= '02000000'
	$packet &= '10000000' ;nBytes following
	$packet &= '01000000' ;nDifferent items being sold
	$packet &= _hex($itemTypeId)
	$packet &= _hex($invIndex)
	$packet &= _hex($amount)

	$packetSize = 26
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func buyItem($itemTypeId,$shopIndex,$amount)
	;Buy $amount of items of type itemTypeId, located at shopIndex
	;shopIndex is calculated as follows:
	;Each tab in the shop has 32 available spaces, index of each space 
	;starts at 0, index of each tab starts at 0. $shopIndex would then be 
	;shopIndex = tabIndex * 32 + spaceIndex
	;This function could be expanded to include buying multiple items
	;simultaneously. This would require setting nBytes equal to 
	;8 + 12 * nDifferent items. Add the extra items on the same way
	;as the first item.
	local $packet, $packetSize 
    $packet = '2500'
	$packet &= '01000000'
	$packet &= '1c000000' ;nBytes following
	$packet &= '00000000'
	$packet &= '00000000'
	$packet &= '00000000'
	$packet &= '01000000' ;nDifferent items being bought
	$packet &= _hex($itemTypeId)
	$packet &= _hex($shopIndex)
	$packet &= _hex($amount)

	$packetSize = 38
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>


Func repairAll()
	;Repair all items
	local $packet, $packetSize

	$packet = '2500'
	$packet &= '03000000'
	$packet &= '06000000' 
	$packet &= 'FFFFFFFF'
	$packet &= '0000' 

	$packetSize = 16
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func repairItem($itemTypeId, $isEquipped, $locationIndex)
	;repairs the item of type itemTypeId at locationIndex, if 
	;isEquipped=1, location refers to equipment. If isEquipped=0,
	;location refers to inventory.
	local $packet, $packetSize

	$packet = '2500'
	$packet &= '03000000'
	$packet &= '06000000' 
	$packet &= _hex($itemTypeId)
	$packet &= _hex($isEquipped, 2)
	$packet &= _hex($locationIndex, 2)

	$packetSize = 16
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func upgradeSkill($skillId)
	;Upgrades the requested skill by one level
	local $packet, $packetSize

	$packet = '2500'
	$packet &= '09000000'
	$packet &= '04000000' 
	$packet &= _hex($skillId)

	$packetSize = 14
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func RezToTown()
	;Respawn in town after death
	local $packet, $packetSize
	
	$packet = '0400'
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func RezWithScroll()
	;Respawn in the place you died, costs a rez scroll
	local $packet, $packetSize
	
	$packet = '0500'
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

Func RezAccept()
	;Accept rez by a priest.
	local $packet, $packetSize

	$packet = '5700'
	
	$packetSize = 2
	
	sendPacket($packet, $packetSize, $PROCESS_ID)
EndFunc		;==>

;======================================================================>
;
;
;			Form Functions
;
;
;======================================================================>

;********************************************************************************
;* Main Form Functions															*
;********************************************************************************
Func StartOrStop()
	
	If $STOP = True Then
		;AdlibUnRegister("Main")
		GUICtrlSetData($BUTTON_START, "Stop")
		GUICtrlSetOnEvent($BUTTON_START, "StartOrStop")
		GUICtrlSetData($MenuItem4, "Stop")
		GUICtrlSetOnEvent($MenuItem4, "StartOrStop")
		GuiCtrlSetData($LOG, "")
		AddHistory("[[[Prophet Bot Started]]]")
		$TIMER_APOTHOCARY_RAIL = TimerInit()
		$STOP = False
	Else
		;AdlibRegister("Main")
		GUICtrlSetData($BUTTON_START, "Start")
		GUICtrlSetOnEvent($BUTTON_START, "StartOrStop")
		GUICtrlSetData($MenuItem4, "Start")
		GUICtrlSetOnEvent($MenuItem4, "StartOrStop")
		AddHistory("[[[Prophet Bot Stopped]]]")
		$STOP = True
	EndIf
	
EndFunc		;==>StartOrStop

Func SetHomeXYZ()

	$HOME_X = $X
	$HOME_Y = $Y
	$HOME_Z = $Z
	If Not @error Then
		$ATTACK_RAD = GUICtrlRead($INPT_RAD)
		If GUICtrlRead($INPT_RAD) <> 0 Then
			ADDHISTORY("Base = " & Round(($HOME_X + 4000) / 10, 1) & "/" & Round(($HOME_Y + 5500) / 10, 1) & " With A " & GUICtrlRead($INPT_RAD) & " Radius")
		Else
			ADDHISTORY("Base = " & Round(($HOME_X + 4000) / 10, 1) & "/" & Round(($HOME_Y + 5500) / 10, 1) & " With No Radius")
		EndIf
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_ATTACKRAD_KEY, GUICtrlRead($INPT_RAD))
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HOMEX_KEY, $HOME_X)
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HOMEY_KEY, $HOME_Y)
		IniWrite($SOFTWARE_CONFIG, $CFG_EXTRAS_ROOT_KEY, $CFG_EXTRAS_HOMEZ_KEY, $HOME_Z)
	EndIf
	
EndFunc		;==>SetHomeXYZ

Func Donate()
	ShellExecute($default_browser_path, "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=PWProphets@Yahoo.Com&lc=US&item_name=Perfect%20World%20Prophet%20Bot&currency_code=USD")
EndFunc		;==>Donate

Func WindowCloseClicked()
	Local $softwarewinpos
	$softwarewinpos = WinGetPos($SOFTWARE_TITLE)
	If $softwarewinpos[0] <> 32000 Then
		IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_LAST_GUI_X, $softwarewinpos[0])
	EndIf
	If $softwarewinpos[1] <> 32000 Then
		IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_LAST_GUI_Y, $softwarewinpos[1])
	EndIf
	Exit
EndFunc		;==>WindowCloseClicked

;********************************************************************************
;* Set Skills Form & Functions													*
;********************************************************************************

Func SetSkills()
	
	Global $FORM_SKILL = GUICreate("Skills", 250, 400, -1, -1, -1, -1, $ProphetBOT)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowSkillCloseClicked")
	GUISwitch($FORM_SKILL)
	GUISetBkColor(0x000000)
	GUISetFont(9, 800, 0, "MS Sans Serif")

	Global $HISTORY = GUICtrlCreateGroup("Skill List", 0, 0, 250, 399)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($HISTORY), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetTip(-1, "Skills List")

	Global $SCOMBOKEY[9], $SKCOUNT, $LABELSK1[9], $LABELSK2[9], $LABELSK3[9], $SDELAY[9], $FORM_SKILL
	$SKCOUNTCFG = IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_UBOUND_KEY, 1)
	GUISetFont(8, 800, 0, "Arial")

	Global $BUTTON_ADD_SKILL = GUICtrlCreateButton("Add", 75, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "AddSkill")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	Global $BUTTON_REMOVE_SKILL = GUICtrlCreateButton("Remove", 130, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "RemoveSkill")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	Global $BUTTON_SAVE_SKILLS = GUICtrlCreateButton("Save", 185, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "SaveSkills")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	For $SKCOUNT = 1 To IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_UBOUND_KEY, 1) Step +1

		$LABELSK1[$SKCOUNT] = GUICtrlCreateLabel("Key", 20, 57 + ($SKCOUNT - 1) * 42, 30, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
		$SCOMBOKEY[$SKCOUNT] = GUICtrlCreateCombo("", 50, 55 + ($SKCOUNT - 1) * 42, 60, 150)
		GUICtrlSetData(-1, $KEYCODE, IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_COMBO_KEY & $SKCOUNT, "{F1}"))

		$LABELSK2[$SKCOUNT] = GUICtrlCreateLabel("Delay", 120, 57 + ($SKCOUNT - 1) * 42, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
		$SDELAY[$SKCOUNT] = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_DELAY_KEY & $SKCOUNT, "1"), 155, 55 + ($SKCOUNT - 1) * 42, 40, 20)
		
		$LABELSK3[$SKCOUNT] = GUICtrlCreateLabel("Secs", 200, 57 + ($SKCOUNT - 1) * 42, 35, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
	Next
	$SKCOUNT = $SKCOUNT - 1
	GUISetState(@SW_SHOW, $FORM_SKILL)
EndFunc		;==>SetSkills

Func AddSkill()
	
	GUISwitch($FORM_SKILL)
	
	$SKCOUNTCFG = $SKCOUNTCFG + 1

	If $SKCOUNTCFG >= 9 Then
		
		$SKCOUNTCFG = 9
		MsgBox(0, "Error", "Max Skills Reached")

	Else

		$LABELSK1[$SKCOUNTCFG] = GUICtrlCreateLabel("Key", 20, 57 + ($SKCOUNTCFG - 1) * 42, 30, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

		$SCOMBOKEY[$SKCOUNTCFG] = GUICtrlCreateCombo("", 50, 55 + ($SKCOUNTCFG - 1) * 42, 60, 150)
		GUICtrlSetData(-1, $KEYCODE, IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_COMBO_KEY & $SKCOUNTCFG, "{F1}"))

		$LABELSK2[$SKCOUNTCFG] = GUICtrlCreateLabel("Delay", 120, 57 + ($SKCOUNTCFG - 1) * 42, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

		$SDELAY[$SKCOUNTCFG] = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_DELAY_KEY & $SKCOUNTCFG, "1"), 155, 55 + ($SKCOUNTCFG - 1) * 42, 40, 20)
		
		$LABELSK3[$SKCOUNTCFG] = GUICtrlCreateLabel("secs", 200, 57 + ($SKCOUNTCFG - 1) * 42, 35, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	EndIf
	
EndFunc		;==>AddSkill

Func RemoveSkill()
	
	GUISwitch($FORM_SKILL)
	
	If $SKCOUNTCFG < 2 Then
		$SKCOUNTCFG = 1
		MsgBox(0, "Error", "Minimum Skills Reached")
	Else
		GUICtrlDelete($SCOMBOKEY[$SKCOUNTCFG])
		GUICtrlDelete($LABELSK1[$SKCOUNTCFG])
		GUICtrlDelete($LABELSK2[$SKCOUNTCFG])
		GUICtrlDelete($LABELSK3[$SKCOUNTCFG])
		GUICtrlDelete($SDELAY[$SKCOUNTCFG])
		$SKCOUNTCFG = $SKCOUNTCFG - 1
	EndIf
	
EndFunc		;==>RemoveSkill

Func SaveSkills()
	
	$COUNT = 1
	$MAX = $SKCOUNTCFG
	$ACTIVE_SKILL = 1
	
	IniWrite($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_UBOUND_KEY, $MAX)
	IniWrite($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_COMBO_KEY & $COUNT, GUICtrlRead($SCOMBOKEY[$COUNT]))
	IniWrite($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_DELAY_KEY & $COUNT, GUICtrlRead($SDELAY[$COUNT]))

	Do
		$COUNT = $COUNT + 1
		IniWrite($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_COMBO_KEY & $COUNT, GUICtrlRead($SCOMBOKEY[$COUNT]))
		IniWrite($SOFTWARE_CONFIG, $CFG_SKILLS_ROOT_KEY, $CFG_SKILL_DELAY_KEY & $COUNT, GUICtrlRead($SDELAY[$COUNT]))
		sleep(250)
	Until $COUNT >= $MAX
	
	GUIDelete($FORM_SKILL)
	
EndFunc		;==>SaveSkills

Func WindowSkillCloseClicked()
	GUIDelete($FORM_SKILL)
EndFunc		;==>WindowSkillCloseClicked

;********************************************************************************
;* Life Support Form & Functions												*
;********************************************************************************

Func SetLifeSupport()

	Global $FORM_LIFESUPPORT = GUICreate("Life Support", 621, 320, -1, -1, -1, -1, $PROPHETBOT)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowLifeSupportCloseClicked")
	GUISwitch($FORM_LIFESUPPORT)
	GUISetBkColor(0x000000)

	;Auto Rest Section
	;--------------------------------------------------------------------------------
	
	Global $CHECK_AUTO_REST_HP, $CHECK_AUTO_REST_MP, $SLIDE_AUTO_REST_HP, $SLIDE_AUTO_REST_MP, $REST_KEY
	
	Global $GROUP_AUTO_REST = GUICtrlCreateGroup("Automatic Rest", 5, 5, 160, 215)
	GUICtrlSetOnEvent(-1, "SaveAutoPotRest")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_AUTO_REST), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetTip(-1, "Bot Status")

	;Auto-Rest HP
	Global $CHECK_AUTO_REST_HP = GUICtrlCreateCheckbox("Restore HP", 20, 25, 90, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTO_REST_HP), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFF0000)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_HP_KEY, "0") = 1 Then
		$STATE = $GUI_CHECKED
	Else
		$STATE = $GUI_UNCHECKED
	EndIf
	
	GUICtrlSetState(-1, $STATE)

	Global $SLIDE_AUTO_REST_HP = GUICtrlCreateSlider(25, 50, 100, 20)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_HP_PERC_KEY, "0"))
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetLimit(-1, 100, 0)
	GUICtrlCreateLabel("0           50        100% HP", 30, 70, 120, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	;End Auto-Rest HP

	;Auto-Rest MP
	Global $CHECK_AUTO_REST_MP = GUICtrlCreateCheckbox("Restore MP", 20, 100, 90, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTO_REST_MP), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_MP_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf

	Global $SLIDE_AUTO_REST_MP = GUICtrlCreateSlider(25, 130, 100, 20)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_MP_PERC_KEY, "0"))
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetLimit(-1, 100, 0)
	GUICtrlCreateLabel("0           50        100% MP", 30, 150, 120, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	;End Auto-Rest MP

	;Auto-Rest Key
	GUICtrlCreateLabel("Key:", 20, 180, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	Global $REST_KEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, "--"), 60, 180, 50, 20)
	GUICtrlSetData(-1, $KEYCODE , "")
	;End Auto-Rest Key
	
	;--------------------------------------------------------------------------------
	;End Auto Rest Section


	;Auto Loot Section
	;--------------------------------------------------------------------------------
	Global $CHECK_AUTO_PICK, $AUTO_PICK_TIMES, $AUTO_PICK_KEY

	Global $GROUP_AUTO_PICK = GUICtrlCreateGroup("Automatic Get Loot", 170, 5, 445, 75)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_AUTO_PICK), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")

	Global $CHECK_AUTO_PICK = GUICtrlCreateCheckbox("Auto Loot", 185, 25, 80, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTO_PICK), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x800080)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf

	GUICtrlCreateLabel("Key:", 275, 28, 40, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		

	Global $AUTO_PICK_KEY = GUICtrlCreateCombo("", 305, 25, 50, 50)
	GUICtrlSetData(-1, $KEYCODE , IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_KEY, "--"))

	
	Global $CHECK_AUTO_PICKHERBS = GUICtrlCreateCheckbox("Get Herbs", 185, 50, 80, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTO_PICKHERBS), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x008000)
	GUICtrlSetBkColor(-1, 0x000000)
	
	If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTHERBS_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
	
	Global $CHECK_AUTO_PICKRESOURCES = GUICtrlCreateCheckbox("Get Resources", 285, 50, 120, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTO_PICKRESOURCES), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x804000)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTRESOURCES_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
	
	Global $BUTTON_RESETMININGFILES = GUICtrlCreateButton("Reset Files", 410, 52, 80, 18)
	GUICtrlSetOnEvent(-1, "ResetMiningFiles")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	;Move To Corpse
	Global $CHECK_MOVE_TO_CORPSE = GUICtrlCreateCheckbox("Move To Corpse", 375, 25, 120, 18)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_MOVE_TO_CORPSE), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)
		
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_MOVE_TO_CORPSE_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf

	;Move To Corpse

	;--------------------------------------------------------------------------------
	;End Auto Loot Section
	
	;Auto Pot Section
	;--------------------------------------------------------------------------------
	
	Global $CHECK_AUTOPOT_FLAG_HP, $CHECK_AUTOPOT_FLAG_MP, $SLIDE_AUTOPOT_HP, $SLIDE_AUTOPOT_MP, $AUTOPOT_HP_PERC, $AUTOPOT_MP_PERC
	Global $AUTOPOT_HP_KEY, $AUTOPOT_MP_KEY
	Global $CHECK_RES_ON_DIE
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")



	Global $GROUP_AUTOPOT = GUICtrlCreateGroup("Automatic Pot", 170, 85, 445, 135)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_AUTOPOT), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	
	;Auto-Pot HP
	Global $CHECK_AUTOPOT_FLAG_HP = GUICtrlCreateCheckbox("Auto-Pot HP", 185, 105, 90, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTOPOT_FLAG_HP), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFF0000)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_FLAG_KEY, "0") = 1 Then
		$STATE = $GUI_CHECKED
	Else
		$STATE = $GUI_UNCHECKED
	EndIf
	
	GUICtrlSetState(-1, $STATE)

	Global $SLIDE_AUTOPOT_HP = GUICtrlCreateSlider(190, 135, 100, 20)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_PERC_KEY, "0"))
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetLimit(-1, 100, 0)
	GUICtrlCreateLabel("0           50        100% HP", 195, 155, 120, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	GUICtrlCreateLabel("Key:", 185, 182, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	Global $AUTOPOT_HP_KEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_KEY, "--"), 210, 180, 45, 20)
	GUICtrlSetData(-1, $KEYCODE , "")
	
	Global $AUTOPOT_HP_TIMER = GUICtrlCreateInput("", 260, 180, 20, 21)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_TIMER, "1"))
	
	GUICtrlCreateLabel("Sec", 285, 182, 20, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
	;End Auto-Pot HP
	
	;Auto Pot HP2
	Global $AUTOHP_KEY, $CHECK_AUTOHP_FLAG, $SLIDE_AUTOHP, $AUTOHP_PERC, $CFG_HEAL_AUTOHP_FLAG_KEY = $NAME & "--" & "AUTOHPFlag", $CFG_HEAL_AUTOHP_PERC_KEY = $NAME & "--" & "AUTOHPPerc", $CFG_HEAL_AUTOHP_KEY = $NAME & "--" & "AUTOHPKey"
	Global $CHECK_AUTOHP_FLAG = GUICtrlCreateCheckbox("Auto-HP 2", 330, 105, 90, 20) ;+145
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTOHP_FLAG), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf

	Global $SLIDE_AUTOHP = GUICtrlCreateSlider(335, 135, 100, 20)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_PERC_KEY, "0"))
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetLimit(-1, 100, 0)
	GUICtrlCreateLabel("0           50        100% HP", 340, 155, 120, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	GUICtrlCreateLabel("Key:", 330, 182, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	Global $AUTOHP_KEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_KEY, "--"), 355, 180, 45, 20)
	GUICtrlSetData(-1, $KEYCODE, "")
	
	Global $AUTOHP_TIMER = GUICtrlCreateInput("", 405, 180, 20, 21)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_TIMER, "1"))
	
	GUICtrlCreateLabel("Sec", 430, 182, 20, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
	
	;End Auto HP2	

	;Auto-Pot MP
	Global $CHECK_AUTOPOT_FLAG_MP = GUICtrlCreateCheckbox("Auto-Pot MP", 475, 105, 90, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_AUTOPOT_FLAG_MP), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf

	Global $SLIDE_AUTOPOT_MP = GUICtrlCreateSlider(480, 135, 100, 20)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_PERC_KEY, "0"))
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetLimit(-1, 100, 0)
	GUICtrlCreateLabel("0           50        100% MP", 485, 155, 120, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	GUICtrlCreateLabel("Key:", 475, 182, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	Global $AUTOPOT_MP_KEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_KEY, "--"), 500, 180, 45, 20)
	GUICtrlSetData(-1, $KEYCODE, "")
	;End Auto-Pot MP

	Global $GROUP_AUTO_RAIL = GUICtrlCreateGroup("Rail Systems", 5, 220, 505, 95)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_AUTO_RAIL), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetTip(-1, "Bot Status")

	;Res On Die
	Global $CHECK_RES_ON_DIE = GUICtrlCreateCheckbox("Res On Die", 20, 240, 120, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_RES_ON_DIE), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)
		
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_RES_ON_DIE_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
	
	Global $BUTTON_SETRESURRECTRAIL = GUICtrlCreateButton("Set Rail", 165, 240, 80, 18)
	GUICtrlSetOnEvent(-1, "SetResurrectRail")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	Global $BUTTON_TESTRESURRECTRAIL = GUICtrlCreateButton("Test Rail", 255, 240, 80, 18)
	GUICtrlSetOnEvent(-1, "RunResurrectRail")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	;End Res On Die

	;Apothocary Rail
	Global $CHECK_APOTHOCARY_RAIL = GUICtrlCreateCheckbox("Apothocary Rail", 20, 262, 120, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_APOTHOCARY_RAIL), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)
		
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_APOTHOCARY_RAIL_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
	
	Global $BUTTON_SETAPOTHOCARYRAIL = GUICtrlCreateButton("Set Rail", 165, 262, 80, 18)
	GUICtrlSetOnEvent(-1, "SetApothocaryRail")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	Global $BUTTON_TESAPOTHOCARYRAIL = GUICtrlCreateButton("Test Rail", 255, 262, 80, 18)
	GUICtrlSetOnEvent(-1, "RunApothocaryRail")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	GUICtrlCreateLabel("How Often:", 350, 264, 60, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		

	Global $APOTHOCARY_TIMER = GUICtrlCreateInput("", 410, 262, 30, 18)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_APOTHOCARY_TIMER_KEY, "1"))
	
	GUICtrlCreateLabel("Hours", 445, 264, 60, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

	Global $BUTTON_SETDONOTSELLLIST = GUICtrlCreateButton("Set Do Not Sell List", 165, 284, 170, 18)
	GUICtrlSetOnEvent(-1, "BuildDoNotSellList")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	GUICtrlCreateLabel("<- Will not sell any items in pack", 350, 286, 150, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		
	Global $CHK_FLYMODE = GUICtrlCreateCheckbox("FLYMODE", 20, 286, 120, 18)
		DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHK_FLYMODE), "wstr", 0, "wstr", 0)
		GUICtrlSetColor(-1, 15743782)
		GUICtrlSetBkColor(-1, 0x000000)
	If IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_FM_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
		
		
		
	;End Apothocary Rail

	;--------------------------------------------------------------------------------
	;End Auto Pot Section
	
	GUICtrlCreateLabel("<= CPU Throttle", 535, 228, 80, 30)
	GUICtrlSetColor(-1, 0xC0C0C0)
	
	Global $SLIDE_CPUTHROTTLE = GUICtrlCreateSlider(513, 226, 18, 90, BitOR($TBS_VERT,$TBS_AUTOTICKS,$TBS_NOTICKS))
	GUICtrlSetLimit(-1, 750, 100)
	GUICtrlSetData(-1, IniRead($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_CPU_THROTTLE_KEY, "0"))
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetColor(-1, 0xC0C0C0)

	Global $BUTTON_SAVE_AUTOPOTREST = GUICtrlCreateButton("Save", 534, 298, 80, 18)
	GUICtrlSetOnEvent(-1, "SaveAutoPotRest")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	GUISetState(@SW_SHOW, $FORM_LIFESUPPORT)

EndFunc		;==>SetLifeSupport

Func SetResurrectRail()
	$CURRENTRAIL = "Resurrect"
	$RAIL_LIST_COUNT = 0
	ToolTip("Now go back to the game!", 0, 0)
	WinWaitActive($APP_TITLE)
	ToolTip("Go to nearest Teleport Master and press F11. Run to hunting ground pressing F11 every 20+ meters", 0, 0)
	HotKeySet("{F11}", "SaveRailPointInList")
EndFunc		;==>SetResurrectRail

Func RunResurrectRail()
	 $CURRENTRAIL = "Resurrect"
	RunRail()
EndFunc		;==>RunResurrectRail

Func SetApothocaryRail()
	ToolTip("Now go back to the game!", 0, 0)
	WinWaitActive($APP_TITLE)
	IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, 0)
	ToolTip("Go to nearest Apothocary, select it, and press Shift + F10", 0, 0)
	HotKeySet("+{F10}", "SetApothocaryID")
	Sleep(250)
	Do
	
		
		SituationalAwareness()
		sleep(1000)
	Until IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, "") <> 0
	HotKeySet("+{F10}", "")
	Addhistory("Set Apothocary ID = " & IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, ""))
	 $CURRENTRAIL = "Apothocary"
	$RAIL_LIST_COUNT = 0
	ToolTip("Now go back to the game!", 0, 0)
	WinWaitActive($APP_TITLE)
	ToolTip("press F11 now, Run to hunting ground pressing F11 every 20+ meters", 0, 0)
	HotKeySet("{F11}", "SaveRailPointInList")
EndFunc		;==>SetApothocaryRail

Func SetApothocaryID()
	If $TARDIS < 20 Then
		IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, $TAR) 
	Else
		ToolTip("Stand closer to Apothocary ", 0, 0)
	EndIf
EndFunc		;==>SetApothocaryID

Func RunApothocaryRail()
	$CURRENTRAIL = "Apothocary"
	If $HP > 0 Then
	sleep(10)
	FLYMODE()
	RunRail()
	endif
	sleep(10)
	BuildNPCArray()
	Local $tempnpcarray[1][13], $tempnpcarraysize
	GUICtrlSetData($LABEL_GENERAL_STATUS, "Action: Running Apothocary Rail")
	$tempnpcarray = $NPCARRAY
	$tempnpcarraysize = UBound($tempnpcarray)
	
	For $a = 0 To $tempnpcarraysize - 1
		If IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, "") = $tempnpcarray[$a][0] And $tempnpcarray[$a][10] < 30 Then
			sleep(10)
			TalkToNPC(IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, ""))
			Sleep(1000)
			Do 
				sleep(1000)
				SituationalAwareness()
			Until $ACTIONFLAG = 0
			Sleep(2000)
			RepairAll()
			Sleep(2000)
			SellItems()
			Sleep(2000)
			BuyItems()
			Sleep(2000)
			_SendMessage($HANDLE, 256, KEYCODE("{ESC}"))
			Sleep(2000)
			RunApothocaryRail()
			$TIMER_APOTHOCARY_RAIL = TimerInit()
			
		EndIf
	Next
EndFunc		;==>RunApothocaryRail

Func Talktoapothocary()
	AddHistory("Trying to talk to NPC")
	sleep(10)
	TalkToNPC(IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_APOTHOCARYID_KEY, ""))
EndFunc		;==>Talktoapothocary



Func RunRail()
	If Round(10*Sqrt((($X + 4000) / 10 - Round((IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & "1", "0") + 4000) / 10, 2))^2+(($Y + 5500) / 10 - Round((IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & "1", "0") + 5500) / 10, 2))^2+($Z / 10 - Round(IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & "1", "0") / 10, 2))^2), 1) < Round(10*Sqrt((($X + 4000) / 10 - Round((IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, ""), "0") + 4000) / 10, 2))^2+(($Y + 5500) / 10 - Round((IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, ""), "0") + 5500) / 10, 2))^2+(($Z / 10) - Round(IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, ""), "0") / 10, 2))^2), 1) Then
		$RAIL_LIST_COUNT = 0
		Do 
			

				SituationalAwareness()
			If $HP > 0 then
				FLYMODE()
				HPMPAutoPotCheck()
				
				
			EndIf
		
			sleep(10)
			If $KILL = 0 then
				$RAIL_LIST_COUNT = $RAIL_LIST_COUNT + 1
				$MOVEING = 1
				$LASTTARX[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARX[1] = Round(($LASTTARX[2] + 4000) / 10, 2)
				$LASTTARZ[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARZ[1] = Round(($LASTTARZ[2]) / 10, 2)
				$LASTTARY[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARY[1] = Round(($LASTTARY[2] + 5500)  / 10, 2)
				MoveToXYZ($LASTTARX[2], $LASTTARY[2], $LASTTARZ[2], $LASTTARZ[1])
				If $KILL = 1 Then
					If $TAR <> 0 Then
						AddHistory("Defending During Movement")
						$TARGET = $TAR
						$HADTARGET = 1
						sleep(10)
						KillTarget()
						$RAIL_LIST_COUNT = $RAIL_LIST_COUNT - 1
						Sleep(250)
					EndIf
				EndIf
			ElseIf $KILL = 1 Then
				$KILL = 0
				$LASTTARX[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARX[1] = Round(($LASTTARX[2] + 4000) / 10, 2)
				$LASTTARZ[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARZ[1] = Round(($LASTTARZ[2]) / 10, 2)
				$LASTTARY[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARY[1] = Round(($LASTTARY[2] + 5500)  / 10, 2)
				MoveToXYZ($LASTTARX[2], $LASTTARY[2], $LASTTARZ[2], $LASTTARZ[1])
				If $TAR <> 0 Then
					AddHistory("Defending During Movement")
					$TARGET = $TAR
					$HADTARGET = 1
					sleep(10)
					KillTarget()
				EndIf
			EndIf
			If $STOP = True Then
				Return
			EndIf
			sleep(10)
		Until $RAIL_LIST_COUNT >= "251" Or $RAIL_LIST_COUNT >= IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, "") or $HP = 0
	Else
		$RAIL_LIST_COUNT = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, "")
		$RAIL_LIST_COUNT = $RAIL_LIST_COUNT - 1
		Do 
			

				SituationalAwareness()

			If $HP > 0 then
				FLYMODE()
				HPMPAutoPotCheck()
			EndIf
			sleep(10)
			If $KILL = 0 then
				$RAIL_LIST_COUNT = $RAIL_LIST_COUNT - 1
				$MOVEING = 1
				$LASTTARX[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARX[1] = Round(($LASTTARX[2] + 4000) / 10, 2)
				$LASTTARZ[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARZ[1] = Round(($LASTTARZ[2]) / 10, 2)
				$LASTTARY[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARY[1] = Round(($LASTTARY[2] + 5500)  / 10, 2)
				sleep(10)
				MoveToXYZ($LASTTARX[2], $LASTTARY[2], $LASTTARZ[2], $LASTTARZ[1])
				if $KILL = 1 Then
					If $TAR <> 0 Then
						AddHistory("Defending During Movement")
						$TARGET = $TAR
						$HADTARGET = 1
						sleep(10)
						KillTarget()
					$RAIL_LIST_COUNT = $RAIL_LIST_COUNT + 1
					Sleep(250)
					endif
				endif
			elseif $KILL = 1 Then
				$KILL = 0
				$LASTTARX[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARX[1] = Round(($LASTTARX[2] + 4000) / 10, 2)
				$LASTTARZ[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARZ[1] = Round(($LASTTARZ[2]) / 10, 2)
				$LASTTARY[2] = IniRead($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, "0")
				$LASTTARY[1] = Round(($LASTTARY[2] + 5500)  / 10, 2)
				sleep(10)
				MoveToXYZ($LASTTARX[2], $LASTTARY[2], $LASTTARZ[2], $LASTTARZ[1])
				If $TAR <> 0 Then
						AddHistory("Defending During Movement")
						$TARGET = $TAR
						$HADTARGET = 1
						sleep(10)
						KillTarget()
				endif
			EndIf
			If $STOP = True Then
				Return
			EndIf
			sleep(10)
		Until $RAIL_LIST_COUNT = 1 or $HP = 0 
	EndIf
	$MOVEING = 0
EndFunc		;==>RunRail

Func SaveRailPointInList()
	
	HotKeySet("{F10}", "EndRailPointList")
	
	$RAIL_LIST_COUNT = $RAIL_LIST_COUNT + 1

	If $RAIL_LIST_COUNT <= 250 Then
		If $RAIL_LIST_COUNT <= 249 Then
			ToolTip("Rail Point " & $RAIL_LIST_COUNT & " Saved" & @CRLF & "Run to next point and press F11 to set or F10 To end", 0, 0)
			IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, $RAIL_LIST_COUNT)
		Else
			ToolTip("Rail Point " & $RAIL_LIST_COUNT & " Saved" & @CRLF & "Maximum Rail Points Reached", 0, 0)
			IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_UBOUND_KEY & $CURRENTRAIL, $RAIL_LIST_COUNT)
		EndIf
		IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_X_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, _MemoryRead($CHAR_DATA_BASE + $OFFSET_X, $PROCESS_INFORMATION, "float"))
		IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Y_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, _MemoryRead($CHAR_DATA_BASE + $OFFSET_Y, $PROCESS_INFORMATION, "float"))
		IniWrite($SOFTWARE_CONFIG, $CFG_RAIL_ROOT_KEY, $CFG_RAIL_Z_KEY & $CURRENTRAIL & $RAIL_LIST_COUNT, _MemoryRead($CHAR_DATA_BASE + $OFFSET_Z, $PROCESS_INFORMATION, "float"))
		Sleep(1500)
		ToolTip("")
		
	Else
		ToolTip("Max Rail Points Reached. Test Rail for Errors", 0, 0)
	EndIf
	
EndFunc		;==>SaveRailPointInList

Func EndRailPointList()
	
	ToolTip("Rail Finished, Test Rail for Errors", 0, 0)
	Sleep(1000)
	ToolTip("")
	HotKeySet("{F10}")
	HotKeySet("{F11}")
	
EndFunc		;==>EndRailPointList

Func ResetMiningFiles()
	Global $HERBS[31] = ["","Nectar", "Salvia Root", "Ageratum", "Golden Herb", "Tranquillia Herb", "Elderwood", "Elecampane", "Realgar", "Palo Herb", "Tuckahoe", "Crane Herb", "Black Henbane", "Fleece-flower Root", "Green Berry", "Ligumaloes Wood", "Valdia Root", "Serpentine Herb", "Ox Bezoar", "Tulip", "Perfumedew Herb", "Butterfly Herb", "Tiger-ear Herb", "Red Berry", "Worm Sprouts", "White Berry", "Devilwood", "Scented Fungus", "Tiery Herb", "Longen Herb"]
	_FileWriteFromArray("Gather Config/" & $NAME & "_HerbsToLoot.gat" , $HERBS, 1)

	Global $RESOURCES[23] = ["","Withered Tree Root", "Old Tree Root", "Willow Stake", "Peatree Stake", "Dragonwood Stake", "Cinnabar Ore", "Iron Ore", "Black Iron Ore", "Manganese Iron Ore", "Hsuan Iron Ore", "Meteorite Iron Ore", "Sandstone Rock", "Gravel Pile", "Rubstone Rock", "Corundum Rock", "Granite ROck", "Rough Coal Stack", "Coal Stack", "Fine Coal Stack", "Volcanic Coal Stack", "Lava Coal Stack"]
	_FileWriteFromArray("Gather Config/" & $NAME & "_ResourcesToLoot.gat" , $RESOURCES, 1)
EndFunc		;==>ResetMiningFiles

Func SaveAutoPotRest()

	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_HP_KEY, GUICtrlRead($CHECK_AUTO_REST_HP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_HP_PERC_KEY, GUICtrlRead($SLIDE_AUTO_REST_HP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_MP_KEY, GUICtrlRead($CHECK_AUTO_REST_MP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_MP_PERC_KEY, GUICtrlRead($SLIDE_AUTO_REST_MP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOREST_KEY, GUICtrlRead($REST_KEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_FM_KEY, GUICtrlRead($CHK_FLYMODE))
	
	IniWrite($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_FLAG_KEY, GUICtrlRead($CHECK_AUTO_PICK))
	IniWrite($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_KEY, GUICtrlRead($AUTO_PICK_KEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOT_TIMES_KEY, GUICtrlRead($AUTO_PICK_TIMES))

	IniWrite($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTHERBS_FLAG_KEY, GUICtrlRead($CHECK_AUTO_PICKHERBS))
	IniWrite($SOFTWARE_CONFIG, $CFG_LOOT_ROOT_KEY, $CFG_LOOTRESOURCES_FLAG_KEY, GUICtrlRead($CHECK_AUTO_PICKRESOURCES))

	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_FLAG_KEY, GUICtrlRead($CHECK_AUTOPOT_FLAG_HP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_PERC_KEY, GUICtrlRead($SLIDE_AUTOPOT_HP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_KEY, GUICtrlRead($AUTOPOT_HP_KEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_HP_TIMER, GUICtrlRead($AUTOPOT_HP_TIMER))
	
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_FLAG_KEY, GUICtrlRead($CHECK_AUTOHP_FLAG))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_PERC_KEY, GUICtrlRead($SLIDE_AUTOHP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_KEY, GUICtrlRead($AUTOHP_KEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOHP_TIMER, GUICtrlRead($AUTOHP_TIMER))

	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_FLAG_KEY, GUICtrlRead($CHECK_AUTOPOT_FLAG_MP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_PERC_KEY, GUICtrlRead($SLIDE_AUTOPOT_MP))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_AUTOPOT_MP_KEY, GUICtrlRead($AUTOPOT_MP_KEY))

	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_RES_ON_DIE_KEY, GUICtrlRead($CHECK_RES_ON_DIE))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_MOVE_TO_CORPSE_KEY, GUICtrlRead($CHECK_MOVE_TO_CORPSE))
	
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_APOTHOCARY_RAIL_KEY, GUICtrlRead($CHECK_APOTHOCARY_RAIL))
	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_APOTHOCARY_TIMER_KEY, GUICtrlRead($APOTHOCARY_TIMER))


	IniWrite($SOFTWARE_CONFIG, $CFG_HEAL_ROOT_KEY, $CFG_HEAL_CPU_THROTTLE_KEY, GUICtrlRead($SLIDE_CPUTHROTTLE))
	
	GUIDelete($FORM_LIFESUPPORT)

EndFunc		;==>SaveAutoPotRest

Func WindowLifeSupportCloseClicked()
	HotKeySet("{F11}")
	HotKeySet("{F10}")
	GUIDelete($FORM_LIFESUPPORT)
EndFunc		;==>WindowLifeSupportCloseClicked

;********************************************************************************
;* Pet Support Form & Functions												    * 
;********************************************************************************

Func SetPetSupport()

	Global $FORM_PETSUPPORT = GUICreate("Pet Support", 250, 259, -1, -1, -1, -1, $PROPHETBOT)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowPetSupportCloseClicked")
	GUISetBkColor(0x000000)
	GUISwitch($FORM_PETSUPPORT)

	Global $GROUP_PETSUPPORT = GUICtrlCreateGroup("Pet Support", 0, 0, 250, 400)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_PETSUPPORT), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	
	Global $PETNO = IniRead("smurfit.ini", "WF Pet", "petslot", "1")

	Global $CHECK_HEALPET = GUICtrlCreateCheckbox("Auto Heal Pet", 5, 20, 100, 17)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_HEALPET), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)
	If IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_CHECK_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf

	Global $CHECK_PETATTACK = GUICtrlCreateCheckbox("Pet Attack First", 120, 20, 125, 17)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_PETATTACK), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)
	If IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETATTACK_CHECK_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
	
	Global $GROUP_PETSETTING = GUICtrlCreateGroup("Auto Heal Pet Settings", 25, 40, 200, 196)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_PETSETTING), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	Global $LABEL_PETSLOT = GUICtrlCreateLabel("Pet Slot :", 90, 61, 52, 18)
	GUICtrlSetColor(-1, 0xC0C0C0)
	Global $LABEL_PETHEALHP = GUICtrlCreateLabel("HP To Heal At :", 58, 91, 79, 18)
	GUICtrlSetColor(-1, 0xC0C0C0)
	Global $LABEL_PETHEALKEY = GUICtrlCreateLabel("Heal Pet Key :", 65, 119, 70, 18)
	GUICtrlSetColor(-1, 0xC0C0C0)
	Global $LABEL_PETFEEDKEY = GUICtrlCreateLabel("Feed Pet Key :", 63, 148, 70, 18)
	GUICtrlSetColor(-1, 0xC0C0C0)
	Global $LABEL_PETSUMMONKEY = GUICtrlCreateLabel("Summon Pet Key :", 47, 177, 90, 18)
	GUICtrlSetColor(-1, 0xC0C0C0)
	Global $LABEL_PETREZKEY = GUICtrlCreateLabel("Rez Pet Key :", 69, 203, 90, 18)
	GUICtrlSetColor(-1, 0xC0C0C0)
	

	Global $INPUT_PETSLOT = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SLOT_KEY, "0"), 148, 59, 50, 22)
	Global $INPUT_PETHP = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_HP_KEY, "0"), 148, 88, 50, 22)
	Global $INPUT_PETHEALKEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_HEALKEY_KEY, "--"), 148, 117, 50, 22)
	GUICtrlSetData(-1, $KEYCODE, "")
	Global $INPUT_PETFEEDKEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_FEEDKEY_KEY, "--"), 148, 146, 50, 22)
	GUICtrlSetData(-1, $KEYCODE, "")
	Global $INPUT_PETSUMMONKEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SUMMONKEY_KEY, "--"), 148, 175, 50, 22)
	GUICtrlSetData(-1, $KEYCODE, "")
	Global $INPUT_PETREZKEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_REZKEY_KEY, "--"), 148, 203, 50, 22)
	GUICtrlSetData(-1, $KEYCODE, "")
	Global $BUTTON_SAVE_PETSETTING = GUICtrlCreateButton("Save", 146, 239, 80, 18)
	GUICtrlSetOnEvent(-1, "SaveSetPetSupport")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	GUISetState(@SW_SHOW, $FORM_PETSUPPORT)

EndFunc		;==>SetPetSupport

Func SaveSetPetSupport()

	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_CHECK_KEY, GUICtrlRead($CHECK_HEALPET))
	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SLOT_KEY, GUICtrlRead($INPUT_PETSLOT))
	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_HP_KEY, GUICtrlRead($INPUT_PETHP))
	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETATTACK_CHECK_KEY, GUICtrlRead($CHECK_PETATTACK))
	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_HEALKEY_KEY, GUICtrlRead($INPUT_PETHEALKEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_FEEDKEY_KEY, GUICtrlRead($INPUT_PETFEEDKEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_SUMMONKEY_KEY, GUICtrlRead($INPUT_PETSUMMONKEY))
    IniWrite($SOFTWARE_CONFIG, $CFG_PETHEAL_ROOT_KEY, $CFG_PETHEAL_REZKEY_KEY, GUICtrlRead($INPUT_PETREZKEY))
	GUIDelete($FORM_PETSUPPORT)

EndFunc		;==>SaveSetPetSupport



Func WindowPetSupportCloseClicked()
	GUIDelete($FORM_PETSUPPORT)
EndFunc		;==>WindowPetSupportCloseClicked

;********************************************************************************
;* Auto Buffs Form & Functions												    *
;********************************************************************************

Func SetAutoBuffs()

	
	Global $FORM_BUFFS = GUICreate("Auto-Buff", 370, 230, -1, -1, -1, -1, $PROPHETBOT)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowAutoBuffCloseClicked")
	GUISetBkColor(0x000000)
	GUISwitch($FORM_BUFFS)

	Global $BUFFSCOMBOKEY[9], $BUFFSCOUNT, $LABELBUFFS1[9], $LABELBUFFS2[9], $LABELBUFFS3[9], $LABELBUFFS4[9], $LABELBUFFS5[9], $BUFFSDELAY[9], $BUFFSFREQUENCY[9]
	Global $BUFFS_FLAG
	$SKCOUNTCFG_BUFFS = IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, 1)
	
	$GROUP_BUFFS = GUICtrlCreateGroup("Buffs", 0, 0, 370, 230)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_BUFFS), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	
	$BUTTON_ADD_BUFFS = GUICtrlCreateButton("Add", 75, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "AddBuffs")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	$BUTTON_REMOVE_BUFFS = GUICtrlCreateButton("Remove", 130, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "RemoveBuffs")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	$BUTTON_SAVE_BUFFS = GUICtrlCreateButton("Save", 185, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "SaveBuffs")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	$BUFFS_FLAG = GUICtrlCreateCheckbox("Use Auto-Buff", 250, 28, 100, 18)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($BUFFS_FLAG), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)
	
	If IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED) 
	EndIf	

	For $BUFFSCOUNT = 1 To IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, 1) Step +1

		$LABELBUFFS1[$BUFFSCOUNT] = GUICtrlCreateLabel("Key", 20, 57 + ($BUFFSCOUNT - 1) * 42, 30, 20)
			GUICtrlSetColor(-1, 0xC0C0C0)

		$BUFFSCOMBOKEY[$BUFFSCOUNT] = GUICtrlCreateCombo("", 50, 55 + ($BUFFSCOUNT - 1) * 42, 60, 150)
		GUICtrlSetData(-1, $KEYCODE, IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_COMBO_KEY & $BUFFSCOUNT, "{F1}"))

		$LABELBUFFS2[$BUFFSCOUNT] = GUICtrlCreateLabel("Delay", 120, 57 + ($BUFFSCOUNT - 1) * 42, 50, 20)
			GUICtrlSetColor(-1, 0xC0C0C0)

		$BUFFSDELAY[$BUFFSCOUNT] = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_DELAY_KEY & $BUFFSCOUNT, "1"), 155, 55 + ($BUFFSCOUNT - 1) * 42, 40, 20)
		
		$LABELBUFFS3[$BUFFSCOUNT] = GUICtrlCreateLabel("secs", 200, 57 + ($BUFFSCOUNT - 1) * 42, 35, 20)
			GUICtrlSetColor(-1, 0xC0C0C0)

		$LABELBUFFS4[$BUFFSCOUNT] = GUICtrlCreateLabel("Interval", 235, 57 + ($BUFFSCOUNT - 1) * 42, 50, 20)
			GUICtrlSetColor(-1, 0xC0C0C0)

		$BUFFSFREQUENCY[$BUFFSCOUNT] = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FREQUENCY_KEY & $BUFFSCOUNT, "1"), 280, 55 + ($BUFFSCOUNT - 1) * 42, 40, 20)
		
		$LABELBUFFS5[$BUFFSCOUNT] = GUICtrlCreateLabel("mins", 325, 57 + ($BUFFSCOUNT - 1) * 42, 35, 20)
			GUICtrlSetColor(-1, 0xC0C0C0)

	Next
	
	$BUFFSCOUNT = $BUFFSCOUNT - 1

	GUISetState(@SW_SHOW, $FORM_BUFFS)

EndFunc		;==>SetAutoBuffs

Func AddBuffs()

	GUISwitch($FORM_BUFFS)
	
	$SKCOUNTCFG_BUFFS = $SKCOUNTCFG_BUFFS + 1

	If $SKCOUNTCFG_BUFFS >= 5 Then
		
		$SKCOUNTCFG_BUFFS = 4
		MsgBox(0, "Error", "Max Auto-Buffs Reached")

	Else

		$LABELBUFFS1[$SKCOUNTCFG_BUFFS] = GUICtrlCreateLabel("Key", 20, 57 + ($SKCOUNTCFG_BUFFS - 1) * 42, 30, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

		$BUFFSCOMBOKEY[$SKCOUNTCFG_BUFFS] = GUICtrlCreateCombo("", 50, 55 + ($SKCOUNTCFG_BUFFS - 1) * 42, 60, 150)
		GUICtrlSetData(-1, $KEYCODE, IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_COMBO_KEY & $SKCOUNTCFG_BUFFS, "{F1}"))

		$LABELBUFFS2[$SKCOUNTCFG_BUFFS] = GUICtrlCreateLabel("Delay", 120, 57 + ($SKCOUNTCFG_BUFFS - 1) * 42, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

		$BUFFSDELAY[$SKCOUNTCFG_BUFFS] = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_DELAY_KEY & $SKCOUNTCFG_BUFFS, "1"), 155, 55 + ($SKCOUNTCFG_BUFFS - 1) * 42, 40, 20)
		
		$LABELBUFFS3[$SKCOUNTCFG_BUFFS] = GUICtrlCreateLabel("secs", 200, 57 + ($SKCOUNTCFG_BUFFS - 1) * 42, 35, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

		$LABELBUFFS4[$SKCOUNTCFG_BUFFS] = GUICtrlCreateLabel("Interval", 235, 57 + ($SKCOUNTCFG_BUFFS - 1) * 42, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

		$BUFFSFREQUENCY[$SKCOUNTCFG_BUFFS] = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FREQUENCY_KEY & $BUFFSCOUNT, "1"), 280, 55 + ($SKCOUNTCFG_BUFFS - 1) * 42, 40, 20)
		
		$LABELBUFFS5[$SKCOUNTCFG_BUFFS] = GUICtrlCreateLabel("mins", 325, 57 + ($SKCOUNTCFG_BUFFS - 1) * 42, 35, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)


	EndIf
EndFunc		;==>AddBuffs

Func RemoveBuffs()
	GUISwitch($FORM_BUFFS)
	If $SKCOUNTCFG_BUFFS < 2 Then
		$SKCOUNTCFG_BUFFS = 1
		MsgBox(0, "Error", "Minimum Auto-Buffs Reached")
	Else
		GUICtrlDelete($BUFFSCOMBOKEY[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($LABELBUFFS1[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($LABELBUFFS2[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($LABELBUFFS3[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($LABELBUFFS4[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($LABELBUFFS5[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($BUFFSDELAY[$SKCOUNTCFG_BUFFS])
		GUICtrlDelete($BUFFSFREQUENCY[$SKCOUNTCFG_BUFFS])
		$SKCOUNTCFG_BUFFS = $SKCOUNTCFG_BUFFS - 1
	EndIf
EndFunc		;==>RemoveBuffs

Func SaveBuffs()
	$COUNT = 1
	$MAX = $SKCOUNTCFG_BUFFS
	$ACTIVE_BUFFS = 1
	IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_UBOUND_KEY, $MAX)
	IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FLAG_KEY, GUICtrlRead($BUFFS_FLAG))
	IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_COMBO_KEY & $COUNT, GUICtrlRead($BUFFSCOMBOKEY[$COUNT]))
	IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_DELAY_KEY & $COUNT, GUICtrlRead($BUFFSDELAY[$COUNT]))
	IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FREQUENCY_KEY & $COUNT, GUICtrlRead($BUFFSFREQUENCY[$COUNT]))
	Do
		$COUNT = $COUNT + 1
		IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_COMBO_KEY & $COUNT, GUICtrlRead($BUFFSCOMBOKEY[$COUNT]))
		IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_DELAY_KEY & $COUNT, GUICtrlRead($BUFFSDELAY[$COUNT]))
		IniWrite($SOFTWARE_CONFIG, $CFG_BUFFS_ROOT_KEY, $CFG_BUFFS_FREQUENCY_KEY & $COUNT, GUICtrlRead($BUFFSFREQUENCY[$COUNT]))
		sleep(250)
	Until $COUNT >= $MAX
	GUIDelete($FORM_BUFFS)	
EndFunc		;==>SaveBuffs

Func WindowAutoBuffCloseClicked()
	GUIDelete($FORM_BUFFS)
EndFunc		;==>WindowAutoBuffCloseClicked

;********************************************************************************
;* Change Weapons Form & Functions												*
;********************************************************************************

Func SetChangeWeapons()

	
	Global $FORM_WEAPONS = GUICreate("Auto Rotate Weapon", 340, 230, -1, -1, -1, -1, $PROPHETBOT)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowChangeWeaponsCloseClicked")
	GUISetBkColor(0x000000)
	GUISwitch($FORM_WEAPONS)

	Global $WEAPONSCOMBOKEY[9], $WEAPONSCOUNT, $LABELWEAPONS1[9], $WEAPONS_DELAY
	Global $WEAPONS_FLAG
	$SKCOUNTCFG_WEAPONS = IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_UBOUND_KEY, 1)
	
	$GROUP_WEAPONS = GUICtrlCreateGroup("Rotate Weapon", 10, 10, 185, 210)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_WEAPONS), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	
	$BUTTON_ADD_WEAPONS = GUICtrlCreateButton("Add", 25, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "AddWeapon")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	$BUTTON_REMOVE_WEAPONS = GUICtrlCreateButton("Remove", 80, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "RemoveWeapon")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	$BUTTON_SAVE_WEAPONS = GUICtrlCreateButton("Save", 135, 28, 50, 18)
	GUICtrlSetOnEvent(-1, "SaveWeapons")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)
	
	$WEAPONS_FLAG = GUICtrlCreateCheckbox("Use Rotate Weapon", 200, 28, 135, 18)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($WEAPONS_FLAG), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED) 
	EndIf	
	
	$LABEL_WEAPONS_DELAY = GUICtrlCreateLabel("Interval (In Minutes)", 200, 55, 130, 18)
		GUICtrlSetColor(-1, 0xC0C0C0)
	$WEAPONS_DELAY = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_DELAY_KEY, "180"), 200, 75, 50, 20)

	For $WEAPONSCOUNT = 1 To IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_UBOUND_KEY, 1) Step +1

		$LABELWEAPONS1[$WEAPONSCOUNT] = GUICtrlCreateLabel("Weapon " & $WEAPONSCOUNT, 20, 57 + ($WEAPONSCOUNT - 1) * 42, 50, 20)
			GUICtrlSetColor(-1, 0xC0C0C0)

		$WEAPONSCOMBOKEY[$WEAPONSCOUNT] = GUICtrlCreateCombo("", 90, 55 + ($WEAPONSCOUNT - 1) * 42, 60, 150)
		GUICtrlSetData(-1, $KEYCODE , IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_COMBO_KEY & $WEAPONSCOUNT, "{F1}"))

	Next
	
	$WEAPONSCOUNT = $WEAPONSCOUNT - 1

	GUISetState(@SW_SHOW, $FORM_WEAPONS)

EndFunc		;==>SetChangeWeapons

Func AddWeapon()
	GUISwitch($FORM_WEAPONS)
	$SKCOUNTCFG_WEAPONS = $SKCOUNTCFG_WEAPONS + 1
	If $SKCOUNTCFG_WEAPONS >= 5 Then
		$SKCOUNTCFG_WEAPONS = 4
		MsgBox(0, "Error", "Max Change Weapons Reached")
	Else
		$LABELWEAPONS1[$SKCOUNTCFG_WEAPONS] = GUICtrlCreateLabel("Weapon " & $SKCOUNTCFG_WEAPONS, 20, 57 + ($SKCOUNTCFG_WEAPONS - 1) * 42, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
		$WEAPONSCOMBOKEY[$SKCOUNTCFG_WEAPONS] = GUICtrlCreateCombo("", 90, 55 + ($SKCOUNTCFG_WEAPONS - 1) * 42, 60, 150)
		GUICtrlSetData(-1, $KEYCODE, IniRead($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_COMBO_KEY & $SKCOUNTCFG_WEAPONS, "{F1}"))
	EndIf
EndFunc		;==>AddWeapon

Func RemoveWeapon()
	GUISwitch($FORM_WEAPONS)
	If $SKCOUNTCFG_WEAPONS < 2 Then
		$SKCOUNTCFG_WEAPONS = 1
		MsgBox(0, "Error", "Minimum Change Weapons Reached")
	Else
		GUICtrlDelete($WEAPONSCOMBOKEY[$SKCOUNTCFG_WEAPONS])
		GUICtrlDelete($LABELWEAPONS1[$SKCOUNTCFG_WEAPONS])
		$SKCOUNTCFG_WEAPONS = $SKCOUNTCFG_WEAPONS - 1
	EndIf
EndFunc		;==>RemoveWeapon

Func SaveWeapons()
	$COUNT = 1
	$MAX = $SKCOUNTCFG_WEAPONS
	$ACTIVE_WEAPONS = 0
	IniWrite($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_UBOUND_KEY, $MAX)
	IniWrite($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_FLAG_KEY, GUICtrlRead($WEAPONS_FLAG))
	IniWrite($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_DELAY_KEY, GUICtrlRead($WEAPONS_DELAY))
	IniWrite($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_COMBO_KEY & $COUNT, GUICtrlRead($WEAPONSCOMBOKEY[$COUNT]))
	Do
		$COUNT = $COUNT + 1
		IniWrite($SOFTWARE_CONFIG, $CFG_WEAPONS_ROOT_KEY, $CFG_WEAPONS_COMBO_KEY & $COUNT, GUICtrlRead($WEAPONSCOMBOKEY[$COUNT]))
		sleep(250)
	Until $COUNT >= $MAX
	GUIDelete($FORM_WEAPONS)	
EndFunc		;==>SaveWeapons

Func WindowChangeWeaponsCloseClicked()
	GUIDelete($FORM_WEAPONS)
EndFunc		;==>WindowChangeWeaponsCloseClicked

;********************************************************************************
;* Fly To Escape Form & Functions                                                 *
;********************************************************************************

Func SetFlyEscape()

	Global $FORM_FLYESCAPE = GUICreate("Fly Escape", 255, 170, -1, -1, -1, -1, $PROPHETBOT)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowFlyEscapeCloseClicked")
	GUISetBkColor(0x000000)
	GUISwitch($FORM_FLYESCAPE)
	
	Global $CHECK_FLYESCAPE, $FLYESCAPE_KEY, $FLYESCAPE_DAMAGE_KEY, $FLY_ESCAPE_SPACE_KEY, $BUTTON_FLY_ESCAPE_SAVE
	
	$GROUP_FLYESCAPE = GUICtrlCreateGroup(" Fly Escape Options ", 0, 0, 255, 135)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_FLYESCAPE), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	
	$CHECK_FLYESCAPE = GUICtrlCreateCheckbox("Try To Fly To Escape Death", 15, 25, 200, 20)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($CHECK_FLYESCAPE), "wstr", 0, "wstr", 0)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUICtrlSetColor(-1, 0xFFFF00)
	GUICtrlSetBkColor(-1, 0x000000)

	If IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_FLAG_KEY, "0") = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	Else
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	EndIf
	
	GUICtrlCreateLabel("Key to Fly:", 15, 55, 50, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
	
	$FLYESCAPE_KEY = GUICtrlCreateCombo(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, "--"), 125, 50, 50, 20)
	GUICtrlSetData(-1, $KEYCODE , "")
	
	GUICtrlCreateLabel("Danage to Fly:", 15, 85, 100, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
	$FLYESCAPE_DAMAGE_KEY = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_DAMAGE_KEY, "0"), 125, 80, 50, 20)


	GUICtrlCreateLabel("Fly to Z =", 15, 110, 110, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)
	$FLY_ESCAPE_SPACE_KEY = GUICtrlCreateInput(IniRead($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_SPACE_KEY, "0"), 125,105, 50, 20)


	$BUTTON_FLY_ESCAPE_SAVE = GUICtrlCreateButton("Save", 170, 140, 80, 20)
	GUICtrlSetOnEvent(-1, "SaveFlyToEscape")
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBKColor(-1, 0x000000)

	GUISetState(@SW_SHOW, $FORM_FLYESCAPE)
	
EndFunc		;==>SetFlyEscape

Func SaveFlyToEscape()

	IniWrite($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_FLAG_KEY, GUICtrlRead($CHECK_FLYESCAPE))
	IniWrite($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_KEY, GUICtrlRead($FLYESCAPE_KEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_DAMAGE_KEY, GUICtrlRead($FLYESCAPE_DAMAGE_KEY))
	IniWrite($SOFTWARE_CONFIG, $CFG_FLYESCAPE_ROOT_KEY, $CFG_FLYESCAPE_SPACE_KEY, GUICtrlRead($FLY_ESCAPE_SPACE_KEY))

	GUIDelete($FORM_FLYESCAPE)

EndFunc		;==>SaveFlyToEscape

Func WindowFlyEscapeCloseClicked()
	GUIDelete($FORM_FLYESCAPE)
EndFunc		;==>WindowFlyEscapeCloseClicked

;********************************************************************************
;* Target List Form & Functions													*
;********************************************************************************

Func Set_MobList()
	sleep(10)
	BuildNPCArray()
	$MobListFormOpen = 1
	Global $FORM_MOBLIST = GUICreate("Target List", 260, 200, -1, -1, -1, -1, $PROPHETBOT)
	GUISetBkColor(0x000000)
	
	Global $MobMenuItem1 = GUICtrlCreateMenu("&File")
	
	Global $MobMenuItem4 = GUICtrlCreateMenuItem("Exit", $MobMenuItem1)
	GUICtrlSetOnEvent(-1, "WindowMobListCloseClicked")
	
	Global $MobMenuItem2 = GUICtrlCreateMenu("&Options")
	
	Global $MobMenuItem5 = GUICtrlCreateMenuItem("Add To MobList", $MobMenuItem2)
	GUICtrlSetOnEvent(-1, "SetMobList")
	
	Global $MobMenuItem6 = GUICtrlCreateMenuItem("Reset MobList", $MobMenuItem2)
	GUICtrlSetOnEvent(-1, "ResetMobList")

	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowMobListCloseClicked")
	GUISwitch($FORM_MOBLIST)
	GUISetState(@SW_SHOW, $FORM_MOBLIST)

	Global $LABEL_LIST_MOB = GUICtrlCreateLabel("Current Target List (Max: 100)", 5, 5, 250, 20)
		GUICtrlSetColor(-1, 0xC0C0C0)

	GUICtrlSetColor(-1, 0x00FF00)
	Global $LIST_MOB = GUICtrlCreateListView("#|ID", 5, 0, 220, 190)
	sleep(10)
	RefreshMobList()
EndFunc		;==>Set_MobList

Func ResetMobList()
	
	$COUNT = 0
	
	Do
		$COUNT = $COUNT + 1
		IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTER_KEY & $COUNT, "")
		IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTERNAME_KEY & $COUNT, "")
		sleep(10)
	Until $COUNT > IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, 1)
	
	IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, "0")
	$MOB_LIST_COUNT = 0
	sleep(10)
	RefreshMobList()

	MsgBox(0, "MobList Reseted", "The MobList Was Reseted!")
	
EndFunc		;==>ResetMobList

Func RefreshMobList()
	If $MobListFormOpen = 1 Then
		GUICtrlDelete($LIST_MOB)
		GUICtrlCreateListView("#|ID|NAME                              ", 5, 25, 250, 150)
		$COUNT = 0
	
		Do
			$COUNT = $COUNT + 1
			GUICtrlCreateListViewItem($COUNT & ")|" & IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTER_KEY & $COUNT, "") & "|" & IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTERNAME_KEY & $COUNT, ""), $LIST_MOB)
			sleep(10)
		Until $COUNT >= IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, 1)
	EndIf

EndFunc		;==>RefreshMobList

Func SetMobList()
	
	
	ToolTip("Now go back to the game!", 0, 0)
	WinWaitActive($APP_TITLE)
	ToolTip("Select the monster that you want to fight then press F11. You can do that 100 times.", 0, 0)
	HotKeySet("{F11}", "SaveMobInMobList")
	
	
EndFunc		;==>SetMobList

Func SaveMobInMobList()
	
	HotKeySet("{F10}", "EndSelectMobList")
	
	IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, 1)
	$MOB_LIST_COUNT = IniRead($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, 1) + 1

	If $MOB_LIST_COUNT <= 100 Then
		
		If Not @error Then
			
			IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTER_KEY & $MOB_LIST_COUNT, $TAR)
			IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_MONSTERNAME_KEY & $MOB_LIST_COUNT, $TARNAME)
			
			If $MOB_LIST_COUNT <= 99 Then
				ToolTip("Monster " & $MOB_LIST_COUNT & " Saved" & @CRLF & "Select another monsters and press F11 to set or F10 To end", 0, 0)
				IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, $MOB_LIST_COUNT)
			Else
				ToolTip("Monster " & $MOB_LIST_COUNT & " Saved" & @CRLF & "Now Press Start/F9 to start Bot", 0, 0)
				IniWrite($SOFTWARE_CONFIG, $CFG_MOBLIST_ROOT_KEY, $CFG_MOBLIST_UBOUND_KEY, $MOB_LIST_COUNT)
			EndIf

			Sleep(10)
			ToolTip("")
		Else
			ToolTip("Error!" & @error)
		EndIf
		
	Else
		ToolTip("Max Monsters Reached. Now Press Start/F9 to start Bot", 0, 0)
	EndIf
	sleep(10)
	RefreshMobList()
	
EndFunc		;==>SaveMobInMobList

Func EndSelectMobList()
	
	ToolTip("Set MobList Finished, Now Press F9 to Start", 0, 0)
	Sleep(1000)
	ToolTip("")
	HotKeySet("{F10}")
	HotKeySet("{F11}")
	
EndFunc		;==>EndSelectMobList

Func WindowMobListCloseClicked()
	$MobListFormOpen = 0
	HotKeySet("{F11}")
	HotKeySet("{F10}")
	GUIDelete($FORM_MobList)
EndFunc		;==>WindowMobListCloseClicked

;********************************************************************************
;* About Form & Functions                                        					*
;********************************************************************************
	
Func Set_AboutProphet()

	Global $FORM_ABOUT = GUICreate("About Prophet Bot", 301, 237, 397, 300)
	GUISetOnEvent($GUI_EVENT_CLOSE, "WindowAboutProphetCloseClicked")
	GUISetBkColor(0x000000)
	GUISwitch($FORM_ABOUT)
	
	Global $GROUP_ABOUT = GUICtrlCreateGroup("About Prophet Bot V3.0", 2, 0, 297, 234)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($GROUP_ABOUT), "wstr", 0, "wstr", 0)
	GUICtrlSetColor(-1, 0x00FF00)
	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
	GUISetState(@SW_SHOW, $FORM_ABOUT)
	
EndFunc		;==>Set_AboutProphet

Func OnlineSupport()
	ShellExecute($default_browser_path, "http://www.elitepvpers.de/forum/pw-hacks-bots-cheats-exploits/655847-perfect-world-bot-pwi-prophet-bot-recoded.html")
EndFunc		;==>OnlineSupport

Func WindowAboutProphetCloseClicked()
	GUIDelete($FORM_ABOUT)
EndFunc		;==>WindowAboutProphetCloseClicked
