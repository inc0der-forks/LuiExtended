local Automation = LUIE.Automation

function Automation.MaplInitialize(enabled)
    local settings = Automation.SV

    if settings.autoConfirmFastTravel then
        ESO_Dialogs["FAST_TRAVEL_CONFIRM"].updateFn = function(dialog)
            FastTravelToNode(dialog.data.nodeIndex)
            ZO_Dialogs_ReleaseDialog("FAST_TRAVEL_CONFIRM")
        end

        -- Recall dialog is when gold coins is involved when travelling
        ESO_Dialogs["RECALL_CONFIRM"].updateFn = function(dialog)
            FastTravelToNode(dialog.data.nodeIndex)
            ZO_Dialogs_ReleaseDialog("RECALL_CONFIRM")
        end
    end
end
