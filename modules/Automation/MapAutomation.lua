local Automation = LUIE.Automation

function Automation.MapInitialize(enabled)
    local Settings = Automation.SV

    if Settings.autoConfirmFastTravel then
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

    if Settings.hideUnownedHousePins then
        RedirectTexture("/esoui/art/icons/poi/poi_group_house_glow.dds","/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("/esoui/art/icons/poi/poi_group_house_unowned.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
    end

    if Settings.hideOwnedHousePins then
        RedirectTexture("/esoui/art/icons/poi/poi_group_house_glow.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("/esoui/art/icons/poi/poi_group_house_owned.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
    end

    if Settings.hideGroupDungeonPins then
        RedirectTexture("/art/icons/poi/poi_dungeon_complete.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("/art/icons/poi/poi_dungeon_incomplete.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("/art/icons/poi/poi_dungeon_glow.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("art/icons/poi/poi_groupinstance_complete.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("art/icons/poi/poi_groupinstance_glow.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
        RedirectTexture("art/icons/poi/poi_groupinstance_incomplete.dds", "/LuiExtended/media/icons/placeholder/blank.dds")
    end
end
