--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Quests namespace
LUIE.Data.Quests = {}
local Quests = LUIE.Data.Quests

LUIE_QUEST_MESSAGE_TURNIN = 1
LUIE_QUEST_MESSAGE_USE = 2
LUIE_QUEST_MESSAGE_EXHAUST = 3
LUIE_QUEST_MESSAGE_OFFER = 4
LUIE_QUEST_MESSAGE_DISCARD = 5
LUIE_QUEST_MESSAGE_CONFISCATE = 6
LUIE_QUEST_MESSAGE_COMBINE = 7
LUIE_QUEST_MESSAGE_MIX = 8
LUIE_QUEST_MESSAGE_BUNDLE = 9
LUIE_QUEST_MESSAGE_LOOT = 10

-- List of Quest Items to ignore when Looted (Alot of quest items swap out for different id's mid quest and it looks silly having a ton of messages print)
Quests.QuestItemHideLoot = {
     -- Seasonal Quests
    [6013] = true, -- Soiled Napkin (Stonetooth Bash)
    [5918] = true, -- Crow Caller (The Witchmother's Bargain)

    -- Main Story Quests
    [2785] = true, -- Ayleid Tome (The Dangerous Past)

    -- Aldmeri Dominion
    [4264] = true, -- Ealcil's Lodestone (The Tempest Unleashed)
    [5434] = true, -- Deployment Plans (A Hostile Situation)
    [5435] = true, -- Poisoned Meat (A Hostile Situation)
    [3437] = true, -- Kindlepitch (Putting the Pieces Together)
    [3555] = true, -- Earring of the Altmer Nobility (Wearing the Veil)
    [3556] = true, -- Earring of the Altmer Nobility (The Veil Falls)
    [3357] = true, -- Runed Talisman (Breaking the Barrier)
    [3324] = true, -- Teleport Scroll (The Serpent's Beacon)
    [3769] = true, -- Teleport Scroll (Depths of Madness)
    [3770] = true, -- Teleport Scroll (Depths of Madness)
    [3771] = true, -- Teleport Scroll (Depths of Madness)
    [3416] = true, -- Teleport Scroll (Depths of Madness)
    [3400] = true, -- Binding Gem (Silent Village)
    [3292] = true, -- Sirinque's Crystal (An Act of Kindness)
    [3532] = true, -- Crystal (Preventative Measure)
    [4492] = true, -- Rajhin's Mantle (A Lasting Winter)
    [4650] = true, -- Heart of Anumaril (Heart of the Matter)
    [4596] = true, -- Rahjin's Mantle (The Orrery of Elden Root)
    [4645] = true, -- Rahjin's Mantle (The Orrery of Elden Root)
    [3663] = true, -- Lord Gharesh-ri's Notebook (Unsafe Haven)
    [4395] = true, -- Bag of Bones (Keeper of the Bones)
    [4396] = true, -- Bag of Bones (Keeper of the Bones)
    [4397] = true, -- Bag of Bones (Keeper of the Bones)
    [4398] = true, -- Bag of Bones (Keeper of the Bones)
    [4241] = true, -- Femur (Keeper of the Bones)
    [4243] = true, -- Tibia (Keeper of the Bones)
    [4244] = true, -- Fibula (Keeper of the Bones)
    [4245] = true, -- Ulna (Keeper of the Bones)
    [4246] = true, -- Radius (Keeper of the Bones)
    [4247] = true, -- Humerus (Keeper of the Bones)
    [4248] = true, -- Clavicle (Keeper of the Bones)
    [4249] = true, -- Scapula (Keeper of the Bones)
    [4251] = true, -- Finger Phalanges (Keeper of the Bones)
    [4252] = true, -- Toe Phalanges (Keeper of the Bones)
    [4253] = true, -- Vertebrae (Keeper of the Bones)
    [4254] = true, -- Ribs (Keeper of the Bones)
    [4259] = true, -- Pelvis (Keeper of the Bones)
    [4408] = true, -- Bone Scepter (The Unquiet Dead)
    [4387] = true, -- Bone Scepter (The Unquiet Dead)
    [4411] = true, -- Bone Scepter (The Unquiet Dead)
    [4431] = true, -- Sigil Geode (Eyes of Azura)
    [4432] = true, -- Sigil Geode (Eyes of Azura)
    [4433] = true, -- Sigil Geode (Eyes of Azura)
    [4442] = true, -- Sigil Geode (Eyes of Azura)
    [3597] = true, -- Rahkaz's Blade (The Enemy Within)
    [4577] = true, -- Dull Crystal Shard (Light in the Darkness)
}

-- List of Quest Items to ignore when Removed (Alot of quest items swap out for different id's mid quest and it looks silly having a ton of messages print)
Quests.QuestItemHideRemove = {
    -- Seasonal Quests
    [6012] = true, -- Soiled Napkin (Stonetooth Bash)

    -- Main Story Quests
    [2760] = true, -- Ayleid Tome (The Dangerous Past)

    -- Aldmeri Dominion
    [4423] = true, -- Ealcil's Lodestone (The Tempest Unleashed)
    [3429] = true, -- Deployment Plans (Ensuring Security)
    [3430] = true, -- Poisoned Meat (Ensuring Security)
    [3437] = true, -- Kindlepitch (Putting the Pieces Together)
    [3503] = true, -- Earring of the Altmer Nobility (Lifting the Veil)
    [3555] = true, -- Earring of the Altmer Nobility (Wearing the Veil)
    [3356] = true, -- Runed Talisman (Breaking the Barrier)
    [3325] = true, -- Teleport Scroll (The Serpent's Beacon)
    [3368] = true, -- Kindlepitch (The Serpent's Beacon)
    [3369] = true, -- Fire Salts (The Serpent's Beacon)
    [3415] = true, -- Teleport Scroll (Depths of Madness)
    [3769] = true, -- Teleport Scroll (Depths of Madness)
    [3770] = true, -- Teleport Scroll (Depths of Madness)
    [3771] = true, -- Teleport Scroll (Depths of Madness)
    [3403] = true, -- Bloodcrown Spores  (Depths of Madness)
    [3404] = true, -- Lavendercap Mushrooms (Depths of Madness)
    [3405] = true, -- Gleamcap Spores (Depths of Madness)
    [3395] = true, -- Binding Gem (Silent Village)
    [3291] = true, -- Micro Etched Crystal (An Act of Kindness)
    [3524] = true, -- Welyknd Stone (Eye of the Ancients)
    [3525] = true, -- Welyknd Stone (Eye of the Ancients)
    [3278] = true, -- Rune of Xarxes (The Mallari-Mora)
    [3279] = true, -- Rune of Magnus (The Mallari-Mora)
    [3532] = true, -- Crystal (Preventative Measure)
    [3491] = true, -- Crystal (Preventative Measure)

    [3458] = true, -- Relic Rescue
    [3459] = true, -- Relic Rescue
    [3460] = true, -- Relic Rescue
    [3461] = true, -- Relic Rescue
    [3462] = true, -- Relic Rescue
    [3463] = true, -- Relic Rescue
    [3464] = true, -- Relic Rescue
    [3465] = true, -- Relic Rescue

    [4492] = true, -- Rajhin's Mantle (A Lasting Winter)
    [3609] = true, -- Heart of Anumaril (Heart of the Matter)
    [4610] = true, -- Rahjin's Mantle (The Orrery of Elden Root)
    [4596] = true, -- Rahjin's Mantle (The Orrery of Elden Root)
    [4645] = true, -- Rahjin's Mantle (The Orrery of Elden Root)
    [3647] = true, -- Lord Gharesh-ri's Notebook (Unsafe Haven)
    [4261] = true, -- Bag of Bones (Keeper of the Bones)
    [4395] = true, -- Bag of Bones (Keeper of the Bones)
    [4396] = true, -- Bag of Bones (Keeper of the Bones)
    [4397] = true, -- Bag of Bones (Keeper of the Bones)
    [4241] = true, -- Femur (Keeper of the Bones)
    [4243] = true, -- Tibia (Keeper of the Bones)
    [4244] = true, -- Fibula (Keeper of the Bones)
    [4245] = true, -- Ulna (Keeper of the Bones)
    [4246] = true, -- Radius (Keeper of the Bones)
    [4247] = true, -- Humerus (Keeper of the Bones)
    [4248] = true, -- Clavicle (Keeper of the Bones)
    [4249] = true, -- Scapula (Keeper of the Bones)
    [4251] = true, -- Finger Phalanges (Keeper of the Bones)
    [4252] = true, -- Toe Phalanges (Keeper of the Bones)
    [4253] = true, -- Vertebrae (Keeper of the Bones)
    [4254] = true, -- Ribs (Keeper of the Bones)
    [4259] = true, -- Pelvis (Keeper of the Bones)
    [4384] = true, -- Bone Scepter (The Unquiet Dead)
    [4408] = true, -- Bone Scepter (The Unquiet Dead)
    [4387] = true, -- Bone Scepter (The Unquiet Dead)
    [4411] = true, -- Bone Scepter (The Unquiet Dead)
    [4479] = true, -- Loriasel Tablet Notes (Eyes of Azura)
    [4430] = true, -- Sigil Geode (Eyes of Azura)
    [4431] = true, -- Sigil Geode (Eyes of Azura)
    [4432] = true, -- Sigil Geode (Eyes of Azura)
    [4433] = true, -- Sigil Geode (Eyes of Azura)
    [4442] = true, -- Sigil Geode (Eyes of Azura)
    [3597] = true, -- Rahkaz's Blade (The Enemy Within)
    [3596] = true, -- Knife (The Enemy Within)
    [4576] = true, -- Dull Crystal Shard (Light in the Darkness)
}

-- Limit the maximum number of quantity of a quest item that can be added.
Quests.QuestItemMaxQuantityAdd = {
    [3518] = 1, -- Welkynd Stone (Eye of the Ancients)
}

-- Call specific functions to add/remove table entries for funky quest items. This will trigger when a certain quest item is added.
Quests.QuestItemModifyOnAdd = {
    [3278] = function() Quests.QuestItemHideLoot[3280] = true end, -- Rune of Xarxes (The Mallari-Mora)
    [3279] = function() Quests.QuestItemHideLoot[3281] = true end, -- Rune of Magnus (The Mallari-Mora)
    [3532] = function() Quests.QuestItemHideLoot[3491] = true end, -- Crystal (Preventative Measure)
    [3769] = function() Quests.QuestItemHideLoot[3415] = true end, -- Teleport Scroll (Depths of Madness)
    [4485] = function() Quests.QuestItemHideRemove[4485] = true end, -- Rajhin's Mantle (A Lasting Winter)
    [4492] = function() Quests.QuestItemHideLoot[4485] = true end, -- Rajhin's Mantle (A Lasting Winter)
    [3597] = function() Quests.QuestItemHideLoot[3596] = true end, -- Rahkaz's Blade (The Enemy Within)
}

-- Call specific functions to add/remove table entries for funky quest items. This will trigger when a certain quest item is removed.
Quests.QuestItemModifyOnRemove = {
    [3532] = function() Quests.QuestItemHideRemove[3491] = nil end, -- Crystal (Preventative Measure)
    [4492] = function() zo_callLater(function() Quests.QuestItemHideRemove[4485] = nil end, 2000) end, -- Rajhin's Mantle (A Lasting Winter)
    [4645] = function() zo_callLater(function() Quests.QuestItemHideRemove[4596] = nil end, 2000) end, -- Rahjin's Mantle (The Orrery of Elden Root)
    [4411] = function() Quests.QuestItemHideRemove[4411] = nil end, -- Bone Scepter (The Unquiet Dead)
    [4479] = function() Quests.QuestItemHideLoot[4479] = true Quests.QuestItemHideRemove[4479] = false end, -- Loriasel Tablet Notes (Eyes of Azura)
    [4442] = function() Quests.QuestItemHideRemove[4433] = nil end, -- Sigil Geode (Eyes of Azura)
    [3597] = function() Quests.QuestItemHideRemove[3596] = nil end, -- Rahkaz's Blade (The Enemy Within)
}

-- When this item is gained display the "material" quest items used to make it.
Quests.QuestItemMerge = {

    [3360] = { 3368, 3369 }, -- Volatile Fire Mixture (The Serpent's Beacon) -- Kindlepitch, Fire Salts
    [3402] = { 3403, 3404, 3405 }, -- Spore Potion (The Depths of Madness) -- Bloodcrown Spores, Lavendercap Mushrooms, Gleamcap Spores

}

-- Message to override when an item is removed.
--LUIE_QUEST_MESSAGE_TURNIN = 1
--LUIE_QUEST_MESSAGE_USE = 2
--LUIE_QUEST_MESSAGE_EXHAUST = 3
--LUIE_QUEST_MESSAGE_OFFER = 4
--LUIE_QUEST_MESSAGE_DISCARD = 5
--LUIE_QUEST_MESSAGE_CONFISCATE = 6
Quests.ItemRemovedMessage = {

    -- Auridon (MSQ)
    [5434] = LUIE_QUEST_MESSAGE_CONFISCATE, -- Deployment Plans (A Hostile Situation)
    [5435] = LUIE_QUEST_MESSAGE_CONFISCATE, -- Poisoned Meat (A Hostile Situation)
    [3470] = LUIE_QUEST_MESSAGE_TURNIN, -- Fistalle's Note (Putting the Pieces Together) -- TODO: Not sure if needed anymore
    [3434] = LUIE_QUEST_MESSAGE_TURNIN, -- Armament Inventory (Putting the Pieces Together) -- TODO: Not sure if needed anymore
    [3435] = LUIE_QUEST_MESSAGE_TURNIN, -- Heritance Officer's Uniform (Putting the Pieces Together) -- TODO: Not sure if needed anymore
    [3534] = LUIE_QUEST_MESSAGE_TURNIN, -- Royal Blade (Lifting the Veil)
    [3556] = LUIE_QUEST_MESSAGE_EXHAUST, -- Earring of Altmer Nobility (The Veil Falls)

    [3544] = LUIE_QUEST_MESSAGE_TURNIN, -- Wedding Ring (Through the Ashes)
    [3548] = LUIE_QUEST_MESSAGE_DISCARD, -- Missing Citizens (Through the Ashes)
    [3543] = LUIE_QUEST_MESSAGE_DISCARD, -- Pendant (Through the Ashes)

}

-- Message to override when an item is received.
--LUIE_QUEST_MESSAGE_COMBINE = 7
--LUIE_QUEST_MESSAGE_MIX = 8
--LUIE_QUEST_MESSAGE_BUNDLE = 9
--LUIE_QUEST_MESSAGE_LOOT = 10
Quests.ItemReceivedMessage = {

    -- Auridon (MSQ)
    [3429] = LUIE_QUEST_MESSAGE_LOOT, -- Deployment Plans (Ensuring Security)
    [3470] = LUIE_QUEST_MESSAGE_LOOT, -- Fistalle's Note (Putting the Pieces Together)
    [3434] = LUIE_QUEST_MESSAGE_LOOT, -- Armament Inventory (Putting the Pieces Together)

    [3543] = LUIE_QUEST_MESSAGE_LOOT, -- Pendant (Through the Ashes)

}

-- TODO: Find a way to extend this to the quest log text
-- Replace the objective update text of a certain quest. Used to fix capitalization/punctuation errors. Matches string. Only works for EN.
Quests.QuestAdvancedOverride = {
    ['Tell Chief Dushkul that Gargak is dead'] = 'Tell Chief Dushkul that Gargak is Dead',
}

Quests.QuestObjectiveCompleteOverride = {
    ['Completed: Run to Next Checkpoint'] = 'Completed: Reach the Next Marker',
    ['Completed: Reach Next Marker'] = 'Completed: Reach the Next Marker',
}
