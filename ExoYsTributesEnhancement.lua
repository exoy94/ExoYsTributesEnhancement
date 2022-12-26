TributesEnhancement = TributesEnhancement or {}

local ETE = TributesEnhancement

local Lib = LibExoYsUtilities

--[[ Graveyard ]]

  --[[ TODO
whisper:SetHandler( "OnClicked", function( )
    if GetTributeMatchType() == TRIBUTE_MATCH_TYPE_CLIENT then return end
    local opponentName, opponentType = GetTributePlayerInfo(TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT)
    if not opponentType == TRIBUTE_PLAYER_TYPE_REMOTE_PLAYER then return end
    StartChatInput("", CHAT_CHANNEL_WHISPER, opponentName)
  end)
]]

--[[IsFriend(string charOrDisplayName)

AddIgnore(@)
RemoveIgnore(@)
SetSessionIgnore(string userName, boolean isIgnoredThisSession)
ClearSessionIgnores()
GetIgnoredInfo(number index) -> Returns: string displayName, string note
GetNumIgnored()
IsIgnored(string charOrDisplayName)
SetIgnoreNote(number ignoreIndex, string note)]]


--[[
Sound:
music still audible
"Effects volume" is cards played, patron selected and used, currency gained etc
"Interface Volume" sound for concede, end of the game screen etc
TODO
-- igno removes friend list

IsFriend(string charOrDisplayName)

AddIgnore(@)
RemoveIgnore(@)
SetSessionIgnore(string userName, boolean isIgnoredThisSession)
ClearSessionIgnores()
GetIgnoredInfo(number index) -> Returns: string displayName, string note
GetNumIgnored()
IsIgnored(string charOrDisplayName)
SetIgnoreNote(number ignoreIndex, string note)

KEYBOARD_CHAT_SYSTEM:Maximize()
else
KEYBOARD_CHAT_SYSTEM:Minimize()
*GAMEPAD_CHAT...

+ positioning not correct (example jessi's bildschirm)
+ aktuell keine Zeitbeschränkung gegen Freund und NPC's...?!
+ erster Zug
+ etwas mehr als 90 sek (einmal 94 und einmal 96)
+ dauer, wie lange das spiel schon geht

* GetNumPatronsFavoringPlayerPerspective(*[TributePlayerPerspective|#TributePlayerPerspective]* _playerPerspective_)
** _Returns:_ *integer* _numPatronsFavored_

* GetTributePatronIdAtIndex(*luaindex* _index_)
** _Returns:_ *integer* _patronId_

* GetTributePatronNumStarterCards(*integer* _patronId_)
** _Returns:_ *integer* _numStarterCards_

* GetTributePatronNumDockCards(*integer* _patronId_)
** _Returns:_ *integer* _numStarterCards_

-- GetTributePlayerClubRank()
* EVENT_TRIBUTE_CLUB_RANK_CHANGED (*[TributeClubRank|#TributeClubRank]* _newClubRank_)

* EVENT_TRIBUTE_LEADERBOARD_DATA_RECEIVED (*[TributeLeaderboardType|#TributeLeaderboardType]* _leaderboardType_)

h5. TributeClubRank
* TRIBUTE_CLUB_RANK_ADEPT
* TRIBUTE_CLUB_RANK_EXPERT
* TRIBUTE_CLUB_RANK_INITIATE
* TRIBUTE_CLUB_RANK_MASTER
* TRIBUTE_CLUB_RANK_NOVICE
* TRIBUTE_CLUB_RANK_REGULAR
* TRIBUTE_CLUB_RANK_TRAINEE
* TRIBUTE_CLUB_RANK_VETERAN

* GetTributeLeaderboardRankInfo()
** _Returns:_ *integer* _playerLeaderboardRank_, *integer* _totalLeaderboardSize_

* GetTributeLeaderboardsSchedule()
** _Returns:_ *integer* _secondsUntilEnd_, *integer* _secondsUntilNextStart_

-- GetActiveTributePlayerPerspective() 1 during opponent turn,
-- GeTributeRemainingTimeForTurn()

* GetTributePatronSuitIcon(*integer* _patronId_)
** _Returns:_ *textureName* _suitIcon_

* GetTributePatronSmallIcon(*integer* _patronId_)
** _Returns:_ *textureName* _smallIcon_

* GetTributePatronLargeIcon(*integer* _patronId_)
** _Returns:_ *textureName* _largeIcon_

* GetTributePatronLargeRingIcon(*integer* _patronId_)
** _Returns:_ *textureName* _largeRingIcon_

/script d(GetTributeForfeitPenaltyDurationMs())
* GetTributeForfeitPenaltyDurationMs()
** _Returns:_ *integer* _forfeitPenaltyMs_

* GetTotalClubMatchesPlayed()
** _Returns:_ *integer* _totalMatchesPlayed_

* GetCurrentClubMatchStreak()
** _Returns:_ *integer* _currentStreak_

* GetTotalCampaignMatchesPlayed(*integer:nilable* _campaignId_)
** _Returns:_ *integer* _totalMatchesPlayed_

* GetCurrentCampaignMatchStreak(*integer:nilable* _campaignId_)
** _Returns:_ *integer* _currentStreak_

* IsPlacedInCampaign(*integer:nilable* _campaignId_)
** _Returns:_ *bool* _isPlaced_

* RequestActiveTributeCampaignData()
** _Returns:_ *[TributePlayerInitializationState|#TributePlayerInitializationState]* _state_


--- Leaderboard

LEADERBOARD_LIST_MANAGER:GetMasterList()



]]

----------------
-- References --
----------------
--[[
h5. TributePlayerPerspective
* TRIBUTE_PLAYER_PERSPECTIVE_SELF      -- 0
* TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT  -- 1

h5. TributePlayerType
* TRIBUTE_PLAYER_TYPE_BASE              -- 0
* TRIBUTE_PLAYER_TYPE_NPC               -- 2
* TRIBUTE_PLAYER_TYPE_PLAYER            -- 1
* TRIBUTE_PLAYER_TYPE_REMOTE_PLAYER     -- 2

h5. TributeVictoryType
* TRIBUTE_VICTORY_TYPE_CONCESSION       -- 3
* TRIBUTE_VICTORY_TYPE_EARLY_CONCESSION -- 5
* TRIBUTE_VICTORY_TYPE_NONE             -- 0
* TRIBUTE_VICTORY_TYPE_PATRON           -- 2
* TRIBUTE_VICTORY_TYPE_PRESTIGE         -- 1
* TRIBUTE_VICTORY_TYPE_SYSTEM_DISBAND   -- 4

h5. TributeGameFlowState
* TRIBUTE_GAME_FLOW_STATE_BOARD_SETUP   -- 3
* TRIBUTE_GAME_FLOW_STATE_GAME_OVER     -- 5
* TRIBUTE_GAME_FLOW_STATE_INACTIVE      -- 0
* TRIBUTE_GAME_FLOW_STATE_INTRO         -- 1
* TRIBUTE_GAME_FLOW_STATE_PATRON_DRAFT  -- 2
* TRIBUTE_GAME_FLOW_STATE_PLAYING       -- 4
]]



---------------
-- variables --
---------------

ETE.WM = GetWindowManager()



--[[ --------------- ]]
--[[ -- Variables -- ]]
--[[ --------------- ]]

ETE = {
  ['name'] =  "ExoYsTributesEnhancement",
  ['lfgPending'] = false, 
}

ZO_CreateStringId("SI_BINDING_NAME_ETE_TOGGLE_STATS_WINDOW", "Toggle Stats Window")

local EM = GetEventManager() 

--[[ ---------------------- ]]
--[[ -- Custom Constants -- ]]
--[[ ---------------------- ]]

local OUTCOME_UNKOWN = 0
local OUTCOME_VICTORY = 1
local OUTCOME_DEFEAT = 2
local OUTCOME_OMITTED = 3

--[[ ------------------- ]]
--[[ -- Lookup Tables -- ]]
--[[ ------------------- ]]

local matchTypeOrder = {
    TRIBUTE_MATCH_TYPE_CLIENT,          -- 3
    TRIBUTE_MATCH_TYPE_PRIVATE,         -- 2
    TRIBUTE_MATCH_TYPE_CASUAL,          -- 4
    TRIBUTE_MATCH_TYPE_COMPETITIVE      -- 1
}
 
function ETE.GetMatchTypeOrder()
  return matchTypeOrder
end


local matchTypeName = {
  [TRIBUTE_MATCH_TYPE_CASUAL] = ETE_MATCH_TYPE_CASUAL,       -- 4
  [TRIBUTE_MATCH_TYPE_CLIENT] = ETE_MATCH_TYPE_CLIENT,          -- 3
  [TRIBUTE_MATCH_TYPE_COMPETITIVE] = ETE_MATCH_TYPE_COMPETITIVE,  -- 1
  [TRIBUTE_MATCH_TYPE_PRIVATE] = ETE_MATCH_TYPE_PRIVATE,    -- 2
}

function ETE.GetMatchTypeName( matchType )
  return matchTypeName[matchType]
end


local outcomeDesignation = {
  [OUTCOME_VICTORY] = ETE_OUTCOME_VICTORY,
  [OUTCOME_DEFEAT] = ETE_OUTCOME_DEFEAT,
}

function ETE.GetOutcomeDesignation( outcome )
  return outcomeDesignation[outcome]
end

--TODO move to menu
function ETE.TogglePositionFix()
  local setting = ETE.store.fixed
  if setting then ETE.UnlockGui() else ETE.LockGui() end
  ETE.store.fixed = not setting
end

SLASH_COMMANDS["/hourglass"] = ETE.TogglePositionFix

--[[ --------------- ]]
--[[ -- Utilities -- ]]
--[[ --------------- ]]

local function IsPlayerTurn()
  return matchData.perspective == TRIBUTE_PLAYER_PERSPECTIVE_SELF
end


--[[ ---------------- ]]
--[[ -- Match Data -- ]]
--[[ ---------------- ]]

local matchData = {}


local function InitPlayerOpponentTable()
  return { [TRIBUTE_PLAYER_PERSPECTIVE_SELF] = 0, [TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT] = 0, }
end


local function InitializeMatchData()
  local opponentName, opponentType = GetTributePlayerInfo(TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT)
  matchData = {
    matchType = GetTributeMatchType(),
    opponentName = opponentName,
    opponentType = opponentType,
    outcome = OUTCOME_UNKOWN,
    matchStart = GetGameTimeMilliseconds(),
    matchDuration = 0,
    turnStart = 0,
    turns = InitPlayerOpponentTable(),
    time = InitPlayerOpponentTable(),
    patrons = InitPlayerOpponentTable(),
    perspective = 0,
    }
end


local function IsMatchDataInitialized()
  return not ZO_IsTableEmpty(matchData)
end


local function ClearMatchData()
  matchData = {}
end


--[[ ---------------- ]]
--[[ -- Automation -- ]]
--[[ ---------------- ]]

-- player online status

--TODO add change function in gui 
--TODO add option to safe setting for the current match type 
--TODO add option to keep new status for after match 
local function AdjustPlayerStatus() 
  if not IsMatchDataInitialized() then return end 

  ETE.worldPlayerStatus = GetPlayerStatus() 

  local store = ETE.store.automation
  local matchType = matchData.matchType

  if store.changePlayerStatus[matchType].enabled then
    SelectPlayerStatus( store.changePlayerStatus[matchType].status )
    Lib.DebugMsg( ETE.store.debug, "TributesEnhancement", {"Set Player Status", store.changePlayerStatus[matchType].status}, {" (", ")"} )
  end
end

local function RevertPlayerStatus() 
  SelectPlayerStatus( ETE.worldPlayerStatus )
  Lib.DebugMsg( ETE.store.debug, "TributesEnhancement", {"Set Player Status", ETE.worldPlayerStatus}, {" (", ")"} )
  ETE.worldPlayerStatus = nil 
end

----

local function UpdateMatchDataGui()
  local currentTurnDuration = GetGameTimeMilliseconds() - matchData.turnStart
  local playerTime = matchData.time[TRIBUTE_PLAYER_PERSPECTIVE_SELF]
  local opponentTime = matchData.time[TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT]

  if IsPlayerTurn() then
    playerTime = playerTime + currentTurnDuration
  else
    opponentTime = opponentTime + currentTurnDuration
  end

  local output = "Whisper Opponent \n"
  --output = output.."Total: "..Lib.GetFormattedDuration(currentTime - matchData.gameStartTime, "compact").."\n"
  output = output.."Player: "..Lib.GetFormattedDuration(playerTime, "compact", "minute").."\n"
  output = output.."Opponent: "..Lib.GetFormattedDuration(opponentTime, "compact", "minute").."\n"

  ETE.matchDataGui.label:SetText( output )
end

function ETE.OnUpdate()
  UpdateMatchDataGui()
end




local function PostMatchProcess( )

  -- check if it should be omitted

  local victoryPerspective, victoryType = GetTributeResultsWinnerInfo()
  local victory =  victoryPerspective == TRIBUTE_PLAYER_PERSPECTIVE_SELF

  matchData.outcome = victory and OUTCOME_VICTORY or OUTCOME_DEFEAT

  Lib.DebugMsg( ETE.store.debug, "TributesEnhancement", {"PostProcess", "MatchType", ETE.GetMatchTypeName( matchData.matchType )}, {" - ", " (", ")"} )
  Lib.DebugMsg( ETE.store.debug, "TributesEnhancement", {"PostProcess", "Outcome", ETE.GetOutcomeDesignation( matchData.outcome ) }, {" - ", " (", ")"} )

  -- record match data
  local store = ETE.store.statistics.character[ ETE.charId ]
  store.games[matchData.matchType].played = store.games[matchData.matchType].played + 1
  if victory then
    store.games[matchData.matchType].won = store.games[matchData.matchType].won + 1
  end
  store.games[matchData.matchType].time = store.games[matchData.matchType].time + matchData.matchDuration

  -- record victory/defeat type
  if victory then
    store.victory[matchData.matchType][victoryType] = store.victory[matchData.matchType][victoryType] + 1
  else
    store.defeat[matchData.matchType][victoryType] = store.victory[matchData.matchType][victoryType] + 1
  end

end


---------------------------
-- Turn Time Gui Handler --
---------------------------

local function DecideTurnTimeGuiVisibility( setValue )
  local show = true
  if not IsPlayerTurn() and ETE.store.turnTime.onlyForPlayer then show = false end

  local overwrite = type(setValue) == "boolean"
  if overwrite then show = setValue end
  Lib.DebugMsg( ETE.store.dev, "ETE", {"DecideTurnTimeGuiVisibility", tostring(show), overwrite and " (overwrite)" or ""}, {": "} )
  ETE.SetTurnTimeGuiVisibility( show )
end

local function OnUpdateTurnTimeGui()
  
  local timeRemaining = GetTributeRemainingTimeForTurn()
  local output = timeRemaining and Lib.GetCountdownString( timeRemaining, true, true ) or "∞"

  ETE.SetTurnTimeGuiOutput( output )
end


--[[ --------------------- ]]
--[[ -- Event Callbacks -- ]]
--[[ --------------------- ]]

--TODO WARNING Gamepad mode (GAMEPAD_CHAT)
local function MaximizeChat()
  KEYBOARD_CHAT_SYSTEM:Maximize()
end


local function MinimizeChat()
  KEYBOARD_CHAT_SYSTEM:Minimize()
end


local function OnGameFlowStateChange( _, flowState )
  ETE.flowState = flowState
  if flowState == TRIBUTE_GAME_FLOW_STATE_INTRO then
    InitializeMatchData()
    AdjustPlayerStatus()
  elseif flowState == TRIBUTE_GAME_FLOW_STATE_PLAYING then

    matchData.turnStart = GetGameTimeMilliseconds()
    matchData.perspective = GetActiveTributePlayerPerspective()

    EM:RegisterForUpdate(ETE.name.."Update", 100, ETE.OnUpdate)

    ETE.matchDataGui.win:SetHidden(false)

    if matchData.matchType == TRIBUTE_MATCH_TYPE_CASUAL or matchData.matchType == TRIBUTE_MATCH_TYPE_COMPETITIVE then
      if ETE.store.turnTime.enabled then
        DecideTurnTimeGuiVisibility()
      end
    end

  elseif flowState == TRIBUTE_GAME_FLOW_STATE_GAME_OVER then
    EM:UnregisterForUpdate(ETE.name.."Update")

    ETE.matchDataGui.win:SetHidden(true)
    

    matchData.matchDuration = GetGameTimeMilliseconds() - matchData.matchStart --TODO new or old?
    PostMatchProcess()

    DecideTurnTimeGuiVisibility(false)

  elseif flowState == TRIBUTE_GAME_FLOW_STATE_INACTIVE then
    ClearMatchData()
    RevertPlayerStatus()
  end
end


local function OnPlayerTurnStart(_, isPlayer)
  local currentTime = GetGameTimeMilliseconds()
  matchData.turns[matchData.perspective] = matchData.turns[matchData.perspective] + 1

  matchData.time[matchData.perspective] = matchData.time[matchData.perspective] + currentTime - matchData.turnStart

  matchData.patrons[TRIBUTE_PLAYER_PERSPECTIVE_SELF] = GetNumPatronsFavoringPlayerPerspective(TRIBUTE_PLAYER_PERSPECTIVE_SELF)
  matchData.patrons[TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT] = GetNumPatronsFavoringPlayerPerspective(TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT)

  matchData.perspective = isPlayer and TRIBUTE_PLAYER_PERSPECTIVE_SELF or TRIBUTE_PLAYER_PERSPECTIVE_OPPONENT
  matchData.turnStart = currentTime

  -- chat automation
  --[[if isPlayer then
    if ETE.store.automation.minChatAtPlayerTurnStart then
      MinimizeChat()
    end
  else
    if ETE.store.automation.maxChatAtOpponentTurnStart then
      MaximizeChat()
    end
  end]]

  -- call for additional checks etc
  -- sound
end



local function LFG_ReadyCheck( lfgActivity )
    local tributeActivity = {
      [LFG_ACTIVITY_TRIBUTE_CASUAL] = ETE_MATCH_TYPE_CASUAL,
      [LFG_ACTIVITY_TRIBUTE_COMPETITIVE] = ETE_MATCH_TYPE_COMPETITIVE
    }

    if not tributeActivity[lfgActivity] then return end

    ETE.lfgPending = true

    Lib.DebugMsg( ETE.store.debug, "TributesEnhancement", {"ToT Match found", tributeActivity[lfgActivity]}, {" (",")"} )

    if ETE.store.automation[lfgActivity] then
      Lib.DebugMsg( ETE.store.debug, "TributesEnhancement", zo_strformat("Autoaccept in <<1>>s", ETE.store.automation["delay"]) )
      zo_callLater(function() AcceptLFGReadyCheckNotification() end, ETE.store.automation["delay"]*1000)
    end

end

local function OnActivityFinderStatusUpdate(_, finderStatus)

  if finderStatus == ACTIVITY_FINDER_STATUS_NONE then
    ETE.lfgPending = false
  elseif finderStatus == ACTIVITY_FINDER_STATUS_READY_CHECK then
    if ETE.lfgPending then return end
    LFG_ReadyCheck( GetLFGReadyCheckActivityType() )
  end

end



--[[ -------------------- ]]
--[[ -- Initialization -- ]]
--[[ -------------------- ]]

local function GetDefaults()
  local widthRoot, heightRoot = GuiRoot:GetDimensions()
  local defaults = {
    debug = false,
    dev = false,
    fixed = true,
    statistics = {
      character = {}
    },
    automation = {
      [LFG_ACTIVITY_TRIBUTE_CASUAL] = true,
      [LFG_ACTIVITY_TRIBUTE_COMPETITIVE] = true,
      ["delay"] = 5,
      --["maxChatAtGameStart"] = true,
      --["maxChatAtOpponentTurnStart"] = true,
      --["minChatAtPlayerTurnStart"] = true,
      ["changePlayerStatus"] = {},
    },
    turnTime = {
      onlyForPlayer = false,
      enabled = true,
      position = {
        x = 0.85*widthRoot,
        y = 0.4*heightRoot,
      },
      size = 20,
      showLock = true,
    },
    matchData = {
      position = {
        x = 200,
        y = 200,
      },
      enabled = true,
      font = "Univers67",
      size = 20,
    }
  }

  for _, matchType in pairs( matchTypeOrder) do
    defaults.automation.changePlayerStatus[matchType] = {enabled = true, status = PLAYER_STATUS_DO_NOT_DISTURB}
  end

  return defaults
end


local function CreateCharStatistics()
  local t_match = {time = 0, player = 0, won = 0}
  local t_outcome = {}
  for i = 1,4 do --match type
    t_outcome[i] = {}
    for j = 1,6 do --victory type
      t_outcome[i][j-1] = 0
    end
  end

  return {
    name = GetUnitName("player"),
    server = GetWorldName(),
    games = {
      [TRIBUTE_MATCH_TYPE_CASUAL] = t_match,
      [TRIBUTE_MATCH_TYPE_CLIENT] = t_match,
      [TRIBUTE_MATCH_TYPE_COMPETITIVE] = t_match,
      [TRIBUTE_MATCH_TYPE_PRIVATE] = t_match,
    },
    victory = t_outcome,
    defeat = t_outcome,
  } --TODO check if "shallowCopy" is necessary
end


local function Initialize()

  ETE.store = ZO_SavedVars:NewAccountWide("ETESV", 1, nil, GetDefaults() )

  ETE.charId = GetCurrentCharacterId() 

  local characterStore = store.statistics.character[ETE.charId] 
  if characterStore then --TODO check
    characterStore.name = GetUnitName("player") -- handle potential name change
  else 
    characterStore = CreateCharStatistics()
  end

  ETE.InitializeTurnTimeGui()

  ETE.matchDataGui = ETE.CreateMatchDataGui()
  ETE.ApplyMatchDataDesign()

  ETE.InitializeStatsGui()

  EM:RegisterForEvent(ETE.name.."PlayerTurnStart", EVENT_TRIBUTE_PLAYER_TURN_STARTED, OnPlayerTurnStart)
  EM:RegisterForEvent(ETE.name.."FlowStateChange", EVENT_TRIBUTE_GAME_FLOW_STATE_CHANGE, OnGameFlowStateChange)
  EM:RegisterForEvent(ETE.name.."ActivityFinterStatus", EVENT_ACTIVITY_FINDER_STATUS_UPDATE, OnActivityFinderStatusUpdate)

  ZO_PostHook("AcceptLFGReadyCheckNotification", function() ETE.lfgPending = false end)
  ZO_PostHook("DeclineLFGReadyCheckNotification", function() ETE.lfgPending = false end)

  ETE.CreateMenu()
end


local function OnAddonLoaded(_, addonName)
  if addonName == ETE.name then
    Initialize()
    EM:UnregisterForEvent(ETE.name, EVENT_ADD_ON_LOADED)
  end
end
EM:RegisterForEvent(ETE.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)



