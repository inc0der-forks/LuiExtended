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

local function OnGroupSceneShown(_, state)
    if (state == "shown") then
        GROUP_MENU_KEYBOARD:ShowCategory(GROUP_LIST_FRAGMENT)
    end
end

--Queue auto confirm
function Automation.GroupInitialize()
    local Settings = Automation.SV
    local eventManager = EVENT_MANAGER

    if Settings.autoConfirmLFG == true then
        eventManager:RegisterForEvent(LUIE.name, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, OnActivityFinderStatusUpdate)
    end

    if Settings.autoSelectGroupCategory then
        local scene = SCENE_MANAGER:GetScene("groupMenuKeyboard")
        scene:RegisterCallback("StateChange", OnGroupSceneShown)
    end

    if Settings.autoAcceptGroupLeave then
        GROUP_LIST["keybindStripDescriptor"][3].callback = function()
            GroupLeave()
        end
    end
end
