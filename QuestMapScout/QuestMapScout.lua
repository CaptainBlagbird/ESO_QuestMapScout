--[[

Quest Map Scout
by CaptainBlagbird
https://github.com/CaptainBlagbird

--]]

-- Addon info
local AddonName = "QuestMapScout"
-- Local variables
local questGiverName = nil
local preQuest = nil
local reward = nil
-- Init saved variables table
if QM_Scout == nil then QM_Scout = {startTime=GetTimeStamp()} end


-- Get zone and subzone in a single string (e.g. "stonefalls/balfoyen_base")
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
			["ids"]      = ids,
			["name"]     = questName,
			["x"]        = normalizedX,
			["y"]        = normalizedY,
			["giver"]    = questGiverName,
			["preQuest"] = preQuest,
			["otherInfo"] = {
					["time"]      = GetTimeStamp(),
					["api"]       = GetAPIVersion(),
					["lang"]      = GetCVar("language.2")
				},
		}
	table.insert(QM_Scout.zones[zone], quest)
end

-- Event handler function for EVENT_CHATTER_END
local function OnChatterEnd(eventCode)
	preQuest = nil
	reward = nil
	-- Stop listening for the quest added event because it would only be for shared quests
	EVENT_MANAGER:UnregisterForEvent(AddonName, EVENT_QUEST_ADDED)
	EVENT_MANAGER:UnregisterForEvent(AddonName, EVENT_CHATTER_END)
end

-- Event handler function for EVENT_QUEST_OFFERED
local function OnQuestOffered(eventCode)
	-- Get the name of the NPC or intractable object
	-- (This could also be done in OnQuestAdded directly, but it's saver here because we are sure the dialogue is open)
	questGiverName = GetUnitName("interact")
	-- Now that the quest has ben offered we can start listening for the quest added event
	EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_QUEST_ADDED, OnQuestAdded)
	EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_CHATTER_END, OnChatterEnd)
end
EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_QUEST_OFFERED, OnQuestOffered)

-- Event handler function for EVENT_QUEST_COMPLETE_DIALOG
local function OnQuestCompleteDialog(eventCode, journalIndex)
	local numRewards = GetJournalQuestNumRewards(journalIndex)
	if numRewards <= 0 then return end
	reward = {}
	for i=1, numRewards do
		local rewardType = GetJournalQuestRewardInfo(journalIndex, i)
		table.insert(reward, rewardType)
	end
end
EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_QUEST_COMPLETE_DIALOG, OnQuestCompleteDialog)

-- Event handler function for EVENT_QUEST_REMOVED
local function OnQuestRemoved(eventCode, isCompleted, journalIndex, questName, zoneIndex, poiIndex, questID)
	if not isCompleted then return end
	preQuest = questID
	if not QM_Scout.rewards then QM_Scout.rewards = {} end
	-- ZO_ShallowTableCopy(reward, QM_Scout.rewards[questID])
	QM_Scout.rewards[questID] = reward
	reward = nil
end
EVENT_MANAGER:RegisterForEvent(AddonName, EVENT_QUEST_REMOVED, OnQuestRemoved)