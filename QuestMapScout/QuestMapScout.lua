--[[

Quest Map Scout
by CaptainBlagbird
https://github.com/CaptainBlagbird

--]]

-- Addon info
AddonName = "QuestMapScout"
-- Saved variables table
if QM_Scout == nil then QM_Scout = {} end


-- Get zone and subzone in one string (e.g. "stonefalls/balfoyen_base")
local function GetZoneAndSubzone()
	return select(3,(GetMapTileTexture()):lower():find("maps/([%w%-]+/[%w%-]+_[%w%-]+)"))
end

-- Event handler function for EVENT_QUEST_ADDED
local function OnQuestAdded(eventCode, journalIndex, questName, objectiveName)
	-- Add quest to saved variables table in correct zone element
	if QM_Scout.zones == nil then QM_Scout.zones = {} end
	local zone = GetZoneAndSubzone()
	if QM_Scout.zones[zone] == nil then QM_Scout.zones[zone] = {} end
	local ids = QuestMap:GetQuestIds(questName)
	local normalizedX, normalizedY = GetMapPlayerPosition("player")
	local quest = {
			["ids"]   = ids,
			["name"] = questName,
			["x"]    = normalizedX,
			["y"]    = normalizedY,
		}	
	table.insert(QM_Scout.zones[zone], quest)
end

-- Event handler function for EVENT_CHATTER_END
local function OnChatterEnd(eventCode)
	-- Stop listening for the quest added event because it would only be for shared quests
	EVENT_MANAGER:UnregisterForEvent(AddonName, EVENT_QUEST_ADDED)
	EVENT_MANAGER:UnregisterForEvent(AddonName, EVENT_CHATTER_END)
end

-- Event handler function for EVENT_QUEST_OFFERED
local function OnQuestOffered(eventCode)
	-- Now that the quest has ben offered we can start listening for the quest added event
	EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_QUEST_ADDED, OnQuestAdded)
	EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_CHATTER_END, OnChatterEnd)
end
EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_QUEST_OFFERED, OnQuestOffered)