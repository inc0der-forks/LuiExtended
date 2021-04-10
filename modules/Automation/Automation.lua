LUIE.Automation = {}
LUIE.Automation.SV = nil

local Automation = LUIE.Automation
local Group = LUIE.Automation.Group

Automation.Enabled = false

Automation.Defaults = {
    autoConfirmLFG = false
}


function Automation.Initialize(enabled)
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV

    if isCharacterSpecific then
        Automation.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, "Automation", Automation.Defaults)
    else
        Automation.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, "Automation", Automation.Defaults)
    end
end
