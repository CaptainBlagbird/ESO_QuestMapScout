QM_Scout =
{
    ["startTime"] = 1450735124,  -- Timestamp (unix time) when the add-on was installed (may be used in the future to display a message for reminding about uploading the data)
    ["quests"] =  -- Contains a list of quest data per zone/subzone
    {
        ["stormhaven/stormhaven_base"] = 
        {
            [1] = 
            {
                ["name"] = "False Knights",  -- Quest title
                ["giver"] = "Sir Graham",  -- Quest giver (e.g. NPC name or name of the object that started the quest like books etc.)
                ["ids"] =  -- List of possible ids corresponding to the quest title
                {
                    [1] = 1687,
                },
                ["y"] = 0.3275171518,  -- x coordinate where the quest was accepted
                ["x"] = 0.2861485779,  -- y coordinate where the quest was accepted
                ["otherInfo"] = 
                {
                    ["lang"] = "en",  -- Language of the client (used to find out in what language the name of the quest and quest giver is)
                    ["time"] = 1450736079,  -- Timestamp (unix time) when the quest was accepted (used to find out how old and maybe outdated the data is)
                    ["api"] = 100013,  -- API version that was used when the quest was accepted (used to find out how old and maybe outdated the data is)
                },
            },
        },
    },
    ["subZones"] =  -- Contains a list of entrances to subzones (like dungeon/cave/etc)
    {
        ["stormhaven/stormhaven_base"] = 
        {
            ["stormhaven/portdunwatch_base"] = 
            {
                ["x"] = 0.3236285746,  -- x coordinate of the entrance
                ["y"] = 0.3078914285,  -- y coordinate of the entrance
            },
        },
    },
    ["questInfo"] =  -- Contains a list of completed quests (IDs) infos about them
    {
        [1687] = 
        {
            ["repeatType"] = 0,  -- Repeat type (http://wiki.esoui.com/Globals#QuestRepeatableType)
            ["rewardTypes"] =  -- List of reward types (http://wiki.esoui.com/Globals#RewardType)
            {
                [1] = 1,
            },
            ["preQuest"] =  -- List of possible prerequisite quests
            {
                [2569] = 1,  -- Format: [id] = Number of other possible quests with that preQuest
            },
        },
    },
}
