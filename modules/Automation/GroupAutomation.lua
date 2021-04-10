local Automation = LUIE.Automation

--accept looking for group ready check notifications
local function OnActivityFinderStatusUpdate(eventCode, status)
    if status == ACTIVITY_FINDER_STATUS_READY_CHECK and HasLFGReadyCheckNotification() then
        LUIE.CallLater("ReadyCheck", 1000, AcceptLFGReadyCheckNotification)
    end

    if status == ACTIVITY_FINDER_STATUS_IN_PROGRESS then
        LUIE.PrintToChat('LFG Activity in Progress')
        PlaySound(SOUNDS.LOCKPICKING_BREAK)
    end
end

--Queue auto confirm
function Automation.GroupInitialize()
    local Settings = Automation.SV
    local eventManager = EVENT_MANAGER

    if Settings.autoConfirmLFG == true then
        eventManager:RegisterForEvent(LUIE.name, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, OnActivityFinderStatusUpdate)
    end
end
