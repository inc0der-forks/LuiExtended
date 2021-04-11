local Automation = LUIE.Automation

local bagId = nil
local slotId = nil

local ConfirmationDialogs = {
	["CONFIRM_RETRAIT_LOCKED_ITEM"] = true,
	["CONFIRM_ENCHANT_LOCKED_ITEM"] = true,
	["CONFIRM_IMPROVE_LOCKED_ITEM"] = true,
}

local function OnMouseEnterItem(control)
    local dataEntry = control.dataEntry
    if dataEntry and dataEntry.data then
        local data = dataEntry.data

        if data.bagId == INVENTORY_BACKPACK or data.bagId == INVENTORY_BANK then
            bagId = data.bagId
            slotId = data.slotIndex
        end
    end
end

local function ShowDialogConfirm(dialogName)
    if Automation.SV.autoTypeConfirmDialogs then
        zo_callLater(function()
            if ConfirmationDialogs[dialogName] then
                ZO_Dialog1EditBox:SetText(GetString(SI_PERFORM_ACTION_CONFIRMATION))
                ZO_Dialog1EditBox:LoseFocus()
            end
        end, 10)
    end
end

local function ShowPlatformDialog(dialogName)
    if Automation.SV.autoConfirmDestroyItemDialog then
        zo_callLater(function()
            if dialogName == "DESTROY_ITEM_PROMPT" then
                if bagId == nil then return end
                ZO_Dialogs_ReleaseDialog("DESTROY_ITEM_PROMPT")
                DestroyItem(bagId, slotId)
                bagId = nil
                slotId = nil
            end
        end, 10)
    end
end

local function OnPlayerReady()
    local Settings = Automation.SV
    PLAYER_INVENTORY.lastSuccessfulGuildBankId = Settings.defaultGuildBank
end

function Automation.InventoryIntiialize()
    local Settings = Automation.SV
    ZO_PreHook("ZO_Dialogs_ShowDialog", ShowDialogConfirm)
    ZO_PreHook("ZO_Dialogs_ShowPlatformDialog", ShowPlatformDialog)
    ZO_PreHook("ZO_InventorySlot_OnMouseEnter", OnMouseEnterItem)

    if Settings.autoConfirmDestroyItemDialog then
        ESO_Dialogs["DESTROY_ITEM_PROMPT"].noChoiceCallback = function() return end
    end

    if Settings.enableDefaultGuildBank then
        EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, OnPlayerReady)
    end
end

function Automation.GuildBanksList()
	local i
	local guildBanksList = {}
	for i = 1, GetNumGuilds() do
		local id = GetGuildId(i)
		local guildName = GetGuildName(id)
		-- guildBanksList[guildName] = id
		table.insert(guildBanksList, guildName)
	end

	return guildBanksList
end
