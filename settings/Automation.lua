--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local Automation = LUIE.Automation

local zo_strformat = zo_strformat

-- Create Slash Commands Settings Menu
function Automation.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibAddonMenu2
    if LAM == nil then return end

    local Defaults = Automation.Defaults
    local Settings = Automation.SV

    local panelDataAutomation = {
        type = "panel",
        -- Add automation locale SI_LUI_LAM_AUOTMATION
        name = zo_strformat("<<1>> - <<2>>", LUIE.name, "Automation"),
        displayName = zo_strformat("<<1>> <<2>>", LUIE.name, "Automation"),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
        slashCommand = "/luisc",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsDataAutomation = {}

    local warningText = "You must reload the UI for this option to take effect"

        -- Automation Description
    optionsDataAutomation[#optionsDataAutomation + 1] = {
        type = "description",
        text = "Enables options to automate specific tasks and actions",
    }

    -- Group Automation
    optionsDataAutomation[#optionsDataAutomation + 1] = {
        type = "submenu",
        name = "Group Automation",
        controls = {
            {
                type = "checkbox",
                name = "Auto Confirm LFG",
                tooltip = "Auto accept when a group has been found with the LFG tool",
                getFunc = function()
                    return Settings.autoConfirmLFG
                end,
                setFunc = function(value)
                    Settings.autoConfirmLFG = value
                end,
                warning = warningText,
                default = Defaults.autoConfirmLFG,
                disabled = function()
                    return false
                end,
            },
            {
                type = "checkbox",
                name = "Auto Select Group Category",
                tooltip = "When opening the activity finder, auto select the group category instead of the previously selected category",
                getFunc = function()
                    return Settings.autoSelectGroupCategory
                end,
                setFunc = function(value)
                    Settings.autoSelectGroupCategory = value
                end,
                warning = warningText,
                default = Defaults.autoSelectGroupCategory,
                disabled = function()
                    return false
                end,
            },
            {
                type = "checkbox",
                name = "Auto Accept Group Leave",
                tooltip = "Auto accept the confirmation when leaving group",
                getFunc = function()
                    return Settings.autoAcceptGroupLeave
                end,
                setFunc = function(value)
                    Settings.autoAcceptGroupLeave = value
                end,
                warning = warningText,
                default = Defaults.autoAcceptGroupLeave,
                disabled = function()
                    return false
                end,
            },
        }
    }

    -- Register the settings panel
      LAM:RegisterAddonPanel(LUIE.name .. 'AutomationOptions', panelDataAutomation)
      LAM:RegisterOptionControls(LUIE.name .. 'AutomationOptions', optionsDataAutomation)
end
