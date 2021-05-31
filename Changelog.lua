--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.7|r",
    "",
    "|cFFFF00Known Issues:|r",
    "[*] Duration & Stack Tracking for Bar Highlight is currently disabled. Something that changed in the API broke this and I haven't been able to figure out what caused it yet despite rooting around for an exceptionally long time. I may have to rewrite this component in the future. I'd suggest using Action Duration Reminder in the meantime.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] The Gamepad Skills Window & Gamepad Skills Advisor now properly show custom passive icons added by LUIE.",
    "[*] The Gamepad Active Effects Window now properly hides buffs & debuffs filtered out by LUIE.",
    "[*] Updated the tooltips for Alliance War Tortes / Scrolls to clarify they increase both \"Alliance Rank and Alliance War Skill Line progression.\"",
    "[*] Updated the backdrop & tooltip for Cyrodiil Food/Drink buffs since the quality was upgraded from White to Blue.",
    "[*] Added Icons & Cast Bar support for various item/collectible fragment combination/use.",
    "[*] Added Icons & Cast Bar support for many Collectibles that were missing it.",
    "[*] Added Icons & Cast Bar support for the Aetherial Well furnishing item.",
    "[*] Updated icons and tooltips for the Champion System update.",
    "[*] Improved icons for several item sets.",
    "[*] Removed the custom icns used for Major/Minor Aegis, Courage, Slayer, and Toughness since ZOS has implemented new icons.",
    "[*] The Active Effects Window will now display more detailed information about the type of Buff/Debuff to match the behavior of mousing over LUIE buffs (I.E. shows whether the effect is unbreakable, a ground effect, an AOE Tracker, etc).",
    "[*] Fixed some missing ACTION_RESULT's for the debug logging option to stop it from throwing errors.",
    "[*] The toggle option to show Set Internal Cooldowns now has support for the Sentry set and has been moved into the Short-Term effects filters.",
    "[*] Added an option to toggle the display of Ability Internal Cooldowns (for Champion Abilities - Expert Evasion & Slippery)",
    "[*] Removed some name override data for Weapon Glyphs (the abilities are just called Crusher/Hardening/Weakening/Weapon Damage) instead of \"X Enchantment.\" This makes the only change from the default UI renaming \"Berserker\" from the Glyph of Weapon Damage to \"Weapon Damage.\"",
    "[*] Updated light/medium/heavy attacks for unarmed/weapons/Volendrung/Werewolf to match the current and updated syntax ZOS implemented ex. \"Light Attack (Two Handed).\"",
    "[*] The Internal Cooldown for Werewolf & Vampire Player Bites now show as Long-Term effects.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Experience: Updated and restored the announcements for Champion Points being earned.",
    "[*] Experience: Cleaned up and normalized messages related to Respec Notifications.",
    "[*] Currency: Fixed an issue where currency postage values weren't always correct when sending mail.",
    "[*] Loot: Fixed an issue where Chat Announcements for learning recipes would display the total item count for that recipe if there were other copies of the recipe in your inventory.",
    "[*] Loot: Fixed some collectibles not showing a collectible link when purchasing them from the event vendor.",
    "[*] Collectible: Collectible Messages now have the option to display both Category & Subcategory.",
    "[*] Group: When forming a group and inviting a player to the group, the inviter will now see a \"You have formed a group\" message followed by a message indicating the invited player has joined.",
    "[*] Group: When you kick the last player in a group instead of seeing a \"You have been removed from the group\" message, it will now be indicated that you have disbanded the group.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Cast Bar: Added a blacklist option for the Cast Bar.",
    "[*] Crowd Control Tracker: \"Hiding Spot\" is now localized and hidden so non-EN clients should not have a stun effect pop up for this.",
    "[*] Potion Timer: Now shows Days/Hours/Minutes format for longer duration CD's such as Research Scrolls & Mementos.",
    "",
    "|cFFFF00Slash Commands:|r",
    "[*] Added the '/setprimaryhome' command to set the primary home.",
    "[*] Added the '/eye' command and keybind to use the Antiquarian's Eye.",
    "[*] Collectible usage keybinds and slash commands will now return an error when trying to use a Merchant/Banker/Fence in a player home.",
    "[*] Collectible usage keybinds and slash commands will now display the collectible name that can't be used when an error occurs.",
    "[*] Fixed an issue where the error alert (if enabled) for collectible usage failure when the collectible was not unlocked was missing the name of the collectible.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] The Experience Bar will now show the proper color/icon for the Champion Point being earned.",
    "[*] Removed a setting that toggled whether to show the max Champion Points the player/target had earned vs the amount allocated. The API no longer provides information about how many points have been allocated for targets.",
    "[*] Fixed an issue where the button to whitelist Assistant names for the Pet Frames was adding \"Tythis\" instead of \"Tythis Andromo.\"",
    "",
}

-- Hide toggle called by the menu or xml button
function LUIE.ToggleChangelog(option)
    LUIE_Changelog:ClearAnchors()
    LUIE_Changelog:SetAnchor(CENTER, GuiRoot, CENTER, 0, -120 )
    LUIE_Changelog:SetHidden(option)
end

-- Called on initialize
function LUIE.ChangelogScreen()
    -- concat messages into one string
    local changelog = table.concat(changelogMessages, "\n")
    -- If text start with '*' replace it with bullet texture
    changelog = string.gsub(changelog, "%[%*%]", "|t12:12:EsoUI/Art/Miscellaneous/bullet.dds|t")
    -- Set the window title
    LUIE_Changelog_Title:SetText(zo_strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIE_Changelog_About:SetText(zo_strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))
    -- Set the changelog text
    LUIE_Changelog_Text:SetText(changelog)

    -- Display the changelog if version number < current version
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= LUIE.version) then
        LUIE_Changelog:SetHidden(false)
    end

    -- Set version to current version
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
