--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- ChatAnnouncements namespace
LUIE.ChatAnnouncements = {}
local ChatAnnouncements = LUIE.ChatAnnouncements

local Effects = LUIE.Data.Effects
local Quests = LUIE.Data.Quests

local printToChat = LUIE.PrintToChat
local zo_strformat = zo_strformat

local eventManager = EVENT_MANAGER
local windowManager = WINDOW_MANAGER

local moduleName = LUIE.name .. "ChatAnnouncements"

------------------------------------------------
-- DEFAULT VARIABLE SETUP ----------------------
------------------------------------------------
ChatAnnouncements.Enabled = false
ChatAnnouncements.Defaults = {
    -- Chat Message Settings
    ChatPlayerDisplayOptions      = 2,
    --NotificationColor             = { .75, .75, .75, 1 },
    BracketOptionCharacter        = 2,
    BracketOptionItem             = 2,
    BracketOptionLorebook         = 2,
    BracketOptionCollectible      = 2,
    BracketOptionCollectibleUse   = 2,
    BracketOptionAchievement      = 2,
    ChatMethod                    = "Print to All Tabs",
    ChatBypass                    = true,
    ChatTab                       = { [1] = true, [2] = true, [3] = true, [4] = true, [5] = true },
    ChatSystemAll                 = true,
    TimeStamp                     = false,
    TimeStampFormat               = "HH:m:s",
    TimeStampColor                = { 143/255, 143/255, 143/255 },

    -- Achievements
    Achievement = {
        AchievementCategory1          = true,
        AchievementCategory2          = true,
        AchievementCategory3          = true,
        AchievementCategory4          = true,
        AchievementCategory5          = true,
        AchievementCategory6          = true,
        AchievementCategory7          = true,
        AchievementCategory8          = true,
        AchievementCategory9          = true,
        AchievementCategory10         = true,
        AchievementCategory11         = true,
        AchievementCategory12         = true,
        AchievementCategory13         = true,
        AchievementCategory14         = true,
        AchievementCategory15         = true,
        AchievementCategory16         = true,
        AchievementCategory17         = true,
        AchievementCategory18         = true,
        AchievementCategory19         = true,
        AchievementCategory20         = true,
        AchievementCategory21         = true,
        AchievementCategory22         = true,
        AchievementCategory23         = true,
        AchievementCategory24         = true,
        AchievementCategory25         = true,
        AchievementCategory26         = true,
        AchievementProgressMsg        = GetString(SI_LUIE_CA_ACHIEVEMENT_PROGRESS_MSG),
        AchievementCompleteMsg        = GetString(SI_ACHIEVEMENT_AWARDED_CENTER_SCREEN),
        AchievementColorProgress      = true,
        AchievementColor1             = { .75, .75, .75, 1 },
        AchievementColor2             = { 1, 1, 1, 1 },
        AchievementCompPercentage     = false,
        AchievementUpdateCA           = false,
        AchievementUpdateAlert        = false,
        AchievementCompleteCA         = true,
        AchievementCompleteCSA        = true,
        AchievementCompleteAlert      = false,
        AchievementIcon               = true,
        AchievementCategory           = true,
        AchievementSubcategory        = true,
        AchievementDetails            = true,
        AchievementBracketOptions     = 4,
        AchievementCatBracketOptions  = 2,
        AchievementStep               = 10,
    },

    -- Group
    Group = {
        GroupCA                       = true,
        GroupAlert                    = false,
        GroupLFGCA                    = true,
        GroupLFGAlert                 = false,
        GroupLFGQueueCA               = true,
        GroupLFGQueueAlert            = false,
        GroupLFGCompleteCA            = false,
        GroupLFGCompleteCSA           = true,
        GroupLFGCompleteAlert         = false,
        GroupVoteCA                   = true,
        GroupVoteAlert                = true,
        GroupRaidCA                   = false,
        GroupRaidCSA                  = true,
        GroupRaidAlert                = false,
        GroupRaidScoreCA              = false,
        GroupRaidScoreCSA             = true,
        GroupRaidScoreAlert           = false,
        GroupRaidBestScoreCA          = false,
        GroupRaidBestScoreCSA         = true,
        GroupRaidBestScoreAlert       = false,
        GroupRaidReviveCA             = false,
        GroupRaidReviveCSA            = true,
        GroupRaidReviveAlert          = false,
        GroupRaidArenaCA              = false,
        GroupRaidArenaCSA             = true,
        GroupRaidArenaAlert           = false,
        GroupRaidArenaRoundCA         = false,
        GroupRaidArenaRoundCSA        = true,
        GroupRaidArenaRoundAlert      = false,
    },

    -- Social
    Social = {
        -- Guild
        GuildCA                       = true,
        GuildAlert                    = false,
        GuildRankCA                   = true,
        GuildRankAlert                = false,
        GuildManageCA                 = false,
        GuildManageAlert              = false,
        GuildIcon                     = true,
        GuildAllianceColor            = true,
        GuildColor                    = { 1, 1, 1, 1 },
        GuildRankDisplayOptions       = 1,

        -- Friend
        FriendIgnoreCA                = true,
        FriendIgnoreAlert             = false,
        FriendStatusCA                = true,
        FriendStatusAlert             = false,

        -- Duel
        DuelCA                        = true,
        DuelAlert                     = false,
        DuelBoundaryCA                = false,
        DuelBoundaryCSA               = true,
        DuelBoundaryAlert             = false,
        DuelWonCA                     = false,
        DuelWonCSA                    = true,
        DuelWonAlert                  = false,
        DuelStartCA                   = false,
        DuelStartCSA                  = true,
        DuelStartAlert                = false,
        DuelStartOptions              = 1,

        -- Pledge of Mara
        PledgeOfMaraCA                = true,
        PledgeOfMaraCSA               = true,
        PledgeOfMaraAlert             = false,
        PledgeOfMaraAlertOnlyFail     = true,
    },

    -- Notifications
    Notify = {
        -- Notifications
        NotificationConfiscateCA      = true,
        NotificationConfiscateAlert   = false,
        NotificationLockpickCA        = true,
        NotificationLockpickAlert     = false,
        NotificationMailCA            = false,
        NotificationMailAlert         = false,
        NotificationTradeCA           = true,
        NotificationTradeAlert        = false,
        NotificationRespecCA          = true,
        NotificationRespecCSA         = true,
        NotificationRespecAlert       = false,
        NotificationGroupAreaCA       = false,
        NotificationGroupAreaCSA      = true,
        NotificationGroupAreaAlert    = false,

        -- Disguise
        DisguiseCA                    = false,
        DisguiseCSA                   = true,
        DisguiseAlert                 = false,
        DisguiseWarnCA                = false,
        DisguiseWarnCSA               = true,
        DisguiseWarnAlert             = false,
        DisguiseAlertColor            = { 1, 0, 0, 1 },

        -- Storage / Riding Upgrades
        StorageRidingColor            = { .75, .75, .75, 1 },
        StorageRidingBookColor        = { .75, .75, .75, 1 },
        StorageRidingCA               = true,
        StorageRidingCSA              = true,
        StorageRidingAlert            = false,

        StorageBagColor               = { .75, .75, .75, 1 },
        StorageBagCA                  = true,
        StorageBagCSA                 = true,
        StorageBagAlert               = false,
    },

    -- Collectibles
    Collectibles = {
        CollectibleCA                 = true,
        CollectibleCSA                = true,
        CollectibleAlert              = false,
        CollectibleBracket            = 4,
        CollectiblePrefix             = GetString(SI_LUIE_CA_COLLECTIBLE),
        CollectibleIcon               = true,
        CollectibleColor1             = { .75, .75, .75, 1 },
        CollectibleColor2             = { .75, .75, .75, 1 },
        CollectibleCategory           = true,
        CollectibleUseCA              = false,
        CollectibleUseAlert           = false,
        CollectibleUsePetNickname     = false,
        CollectibleUseIcon            = true,
        CollectibleUseColor           = { .75, .75, .75, 1 },
        CollectibleUseCategory3       = true, -- Appearance
        CollectibleUseCategory7       = true, -- Assistants
        --CollectibleUseCategory8       = true, -- Mementos
        CollectibleUseCategory10      = true, -- Non-Combat Pets
        CollectibleUseCategory12      = true, -- Special
    },

    -- Lorebooks
    Lorebooks = {
        LorebookCA                    = true,  -- Display a CA for Lorebooks
        LorebookCSA                   = true,  -- Display a CSA for Lorebooks
        LorebookAlert                 = false, -- Display a ZO_Alert for Lorebooks
        LorebookCollectionCA          = true,
        LorebookCollectionCSA         = true,
        LorebookCollectionAlert       = false,
        LorebookCollectionPrefix      = GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE),
        LorebookPrefix1               = GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED),
        LorebookPrefix2               = GetString(SI_LUIE_CA_LOREBOOK_BOOK),
        LorebookBracket               = 4, -- Bracket Options
        LorebookColor1                = { .75, .75, .75, 1 }, -- Lorebook Message Color 1
        LorebookColor2                = { .75, .75, .75, 1 }, -- Lorebook Message Color 2
        LorebookIcon                  = true,  -- Display an icon for Lorebook CA
        LorebookShowHidden            = false, -- Display books even when they are hidden in the journal menu
        LorebookCategory              = true,  -- Display "added to X category" message
    },

    -- Quest
    Quests = {
        QuestShareCA                    = true,
        QuestShareAlert                 = false,
        QuestColorLocName               = { 1, 1, 1, 1 },
        QuestColorLocDescription        = { .75, .75, .75, 1 },
        QuestColorName                  = { 1, 0.647058, 0, 1 },
        QuestColorDescription           = { .75, .75, .75, 1 },
        QuestLocLong                    = true,
        QuestIcon                       = true,
        QuestLong                       = true,
        QuestLocDiscoveryCA             = true,
        QuestLocDiscoveryCSA            = true,
        QuestLocDiscoveryAlert          = false,
        QuestICDiscoveryCA              = false,
        QuestICDiscoveryCSA             = true,
        QuestICDiscoveryAlert           = false,
        QuestICDescription              = true,
        QuestCraglornBuffCA             = false,
        QuestCraglornBuffCSA            = true,
        QuestCraglornBuffAlert          = false,
        QuestLocObjectiveCA             = true,
        QuestLocObjectiveCSA            = true,
        QuestLocObjectiveAlert          = false,
        QuestLocCompleteCA              = true,
        QuestLocCompleteCSA             = true,
        QuestLocCompleteAlert           = false,
        QuestAcceptCA                   = true,
        QuestAcceptCSA                  = true,
        QuestAcceptAlert                = false,
        QuestCompleteCA                 = true,
        QuestCompleteCSA                = true,
        QuestCompleteAlert              = false,
        QuestAbandonCA                  = true,
        QuestAbandonCSA                 = true,
        QuestAbandonAlert               = false,
        QuestFailCA                     = true,
        QuestFailCSA                    = true,
        QuestFailAlert                  = false,
        QuestObjCompleteCA              = false,
        QuestObjCompleteCSA             = true,
        QuestObjCompleteAlert           = false,
        QuestObjUpdateCA                = false,
        QuestObjUpdateCSA               = true,
        QuestObjUpdateAlert             = false,
    },

    -- Experience
    XP = {
        ExperienceEnlightenedCA         = false,
        ExperienceEnlightenedCSA        = true,
        ExperienceEnlightenedAlert      = false,
        ExperienceLevelUpCA             = true,
        ExperienceLevelUpCSA            = true,
        ExperienceLevelUpAlert          = false,
        ExperienceLevelUpCSAExpand      = true,
        ExperienceLevelUpIcon           = true,
        ExperienceLevelColorByLevel     = true,
        ExperienceLevelUpColor          = { .75, .75, .75, 1 },
        Experience                      = true,
        ExperienceIcon                  = true,
        ExperienceMessage               = GetString(SI_LUIE_CA_EXPERIENCE_MESSAGE),
        ExperienceName                  = GetString(SI_LUIE_CA_EXPERIENCE_NAME),
        ExperienceHideCombat            = false,
        ExperienceFilter                = 0,
        ExperienceThrottle              = 3500,
        ExperienceColorMessage          = { .75, .75, .75, 1 },
        ExperienceColorName             = { .75, .75, .75, 1 },
    },

    -- Skills
    Skills = {
        SkillPointCA                    = true,
        SkillPointCSA                   = true,
        SkillPointAlert                 = false,
        SkillPointSkyshard           = GetString(SI_SKYSHARD_GAINED),
        SkillPointBracket               = 4,
        SkillPointsPartial              = true,
        SkillPointColor1                = { .75, .75, .75, 1 },
        SkillPointColor2                = { .75, .75, .75, 1 },

        SkillLineUnlockCA               = true,
        SkillLineUnlockCSA              = true,
        SkillLineUnlockAlert            = false,
        SkillLineCA                     = false,
        SkillLineCSA                    = true,
        SkillLineAlert                  = false,
        SkillAbilityCA                  = false,
        SkillAbilityCSA                 = true,
        SkillAbilityAlert               = false,
        SkillLineIcon                   = true,
        SkillLineColor                  = { .75, .75, .75, 1 },

        SkillGuildFighters              = true,
        SkillGuildMages                 = true,
        SkillGuildUndaunted             = true,
        SkillGuildThieves               = true,
        SkillGuildDarkBrotherhood       = true,
        SkillGuildPsijicOrder           = true,
        SkillGuildIcon                  = true,
        SkillGuildMsg                   = GetString(SI_LUIE_CA_SKILL_GUILD_MSG),
        SkillGuildRepName               = GetString(SI_LUIE_CA_SKILL_GUILD_REPUTATION),
        SkillGuildColor                 = { .75, .75, .75, 1 },
        SkillGuildColorFG               = { .75, .37, 0, 1},
        SkillGuildColorMG               = { 0, .52, .75, 1},
        SkillGuildColorUD               = { .58, .75, 0, 1},
        SkillGuildColorTG               = { .29, .27, .42, 1},
        SkillGuildColorDB               = { .70, 0, .19, 1},
        SkillGuildColorPO               = { .5, 1, 1, 1 },

        SkillGuildThrottle              = 0,
        SkillGuildThreshold             = 0,
        SkillGuildAlert                 = false,
    },

    -- Currency
    Currency = {
        CurrencyAPColor                 = { 0.164706, 0.862745, 0.133333, 1 },
        CurrencyAPFilter                = 0,
        CurrencyAPName                  = GetString(SI_LUIE_CA_CURRENCY_ALLIANCE_POINT),
        CurrencyIcon                    = true,
        CurrencyAPShowChange            = true,
        CurrencyAPShowTotal             = false,
        CurrencyAPThrottle              = 3500,
        CurrencyColor                   = { .75, .75, .75, 1 },
        CurrencyColorDown               = { 0.7, 0, 0, 1 },
        CurrencyColorUp                 = { 0.043137, 0.380392, 0.043137, 1 },
        CurrencyContextColor            = true,
        CurrencyGoldChange              = true,
        CurrencyGoldColor               = { 1, 1, 0.2, 1 },
        CurrencyGoldFilter              = 0,
        CurrencyGoldHideAH              = false,
        CurrencyGoldHideListingAH       = false,
        CurrencyGoldName                = GetString(SI_LUIE_CA_CURRENCY_GOLD),
        CurrencyGoldShowTotal           = false,
        CurrencyGoldThrottle            = true,
        CurrencyTVChange                = true,
        CurrencyTVColor                 = { 0.368627, 0.643137, 1, 1 },
        CurrencyTVFilter                = 0,
        CurrencyTVName                  = GetString(SI_LUIE_CA_CURRENCY_TELVAR_STONE),
        CurrencyTVShowTotal             = false,
        CurrencyTVThrottle              = 2500,
        CurrencyWVChange                = true,
        CurrencyWVColor                 = { 1, 1, 1, 1 },
        CurrencyWVName                  = GetString(SI_LUIE_CA_CURRENCY_WRIT_VOUCHER),
        CurrencyWVShowTotal             = false,
        CurrencyTransmuteChange         = true,
        CurrencyTransmuteColor          = { 1, 1, 1, 1 },
        CurrencyTransmuteName           = GetString(SI_LUIE_CA_CURRENCY_TRANSMUTE_CRYSTAL),
        CurrencyTransmuteShowTotal      = false,
        CurrencyEventChange             = true,
        CurrencyEventColor              = { 250/255, 173/255, 187/255, 1 },
        CurrencyEventName               = GetString(SI_LUIE_CA_CURRENCY_EVENT_TICKET),
        CurrencyEventShowTotal          = false,
        CurrencyCrownsChange            = false,
        CurrencyCrownsColor             = { 1, 1, 1, 1 },
        CurrencyCrownsName              = GetString(SI_LUIE_CA_CURRENCY_CROWN),
        CurrencyCrownsShowTotal         = false,
        CurrencyCrownGemsChange         = false,
        CurrencyCrownGemsColor          = { 244/255, 56/255, 247/255, 1 },
        CurrencyCrownGemsName           = GetString(SI_LUIE_CA_CURRENCY_CROWN_GEM),
        CurrencyCrownGemsShowTotal      = false,
        CurrencyOutfitTokenChange       = true,
        CurrencyOutfitTokenColor        = { 255/255, 225/255, 125/255, 1 },
        CurrencyOutfitTokenName         = GetString(SI_LUIE_CA_CURRENCY_OUTFIT_TOKENS),
        CurrencyOutfitTokenShowTotal    = false,
        CurrencyUndauntedChange         = true,
        CurrencyUndauntedColor          = { 1, 1, 1, 1 },
        CurrencyUndauntedName           = GetString(SI_LUIE_CA_CURRENCY_UNDAUNTED),
        CurrencyUndauntedShowTotal      = false,
        CurrencyMessageTotalAP          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALAP),
        CurrencyMessageTotalGold        = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALGOLD),
        CurrencyMessageTotalTV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALTV),
        CurrencyMessageTotalWV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALWV),
        CurrencyMessageTotalTransmute   = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALTRANSMUTE),
        CurrencyMessageTotalEvent       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALEVENT),
        CurrencyMessageTotalCrowns      = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALCROWNS),
        CurrencyMessageTotalCrownGems   = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALGEMS),
        CurrencyMessageTotalOutfitToken = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALOUTFITTOKENS),
        CurrencyMessageTotalUndaunted   = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALUNDAUNTED),
    },

    -- Loot
    Inventory = {
        Loot                            = true,
        LootBank                        = true,
        LootBlacklist                   = false,
        LootTotal                       = false,
        LootTotalString                 = GetString(SI_LUIE_CA_LOOT_MESSAGE_TOTAL),
        LootCraft                       = true,
        LootGroup                       = true,
        LootIcons                       = true,
        LootMail                        = true,
        LootNotTrash                    = true,
        LootOnlyNotable                 = false,
        LootShowArmorType               = false,
        LootShowStyle                   = false,
        LootShowTrait                   = false,
        LootConfiscate                  = true,
        LootTrade                       = true,
        LootVendor                      = true,
        LootVendorCurrency              = true,
        LootVendorTotalCurrency         = false,
        LootVendorTotalItems            = false,
        LootShowCraftUse                = false,
        LootShowDestroy                 = true,
        LootShowRemove                  = true,
        LootShowDisguise                = true,
        LootShowLockpick                = true,
        LootQuestAdd                    = true,
        LootQuestRemove                 = false,
    },

    ContextMessages = {
        CurrencyMessageConfiscate       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CONFISCATE),
        CurrencyMessageDeposit          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSIT),
        CurrencyMessageDepositStorage   = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE),
        CurrencyMessageDepositGuild     = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
        CurrencyMessageEarn             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_EARN),
        CurrencyMessageLoot             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOOT),
        CurrencyMessageSteal            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STEAL),
        CurrencyMessageLost             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOST),
        CurrencyMessagePickpocket       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_PICKPOCKET),
        CurrencyMessageReceive          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_RECEIVE),
        CurrencyMessageSpend            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SPEND),
        CurrencyMessagePay              = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_PAY),
        CurrencyMessageTradeIn          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEIN),
        CurrencyMessageTradeInNoName    = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME),
        CurrencyMessageTradeOut         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEOUT),
        CurrencyMessageTradeOutNoName   = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME),
        CurrencyMessageMailIn           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILIN),
        CurrencyMessageMailInNoName     = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME),
        CurrencyMessageMailOut          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILOUT),
        CurrencyMessageMailOutNoName    = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME),
        CurrencyMessageMailCOD          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILCOD),
        CurrencyMessagePostage          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_POSTAGE),
        CurrencyMessageWithdraw         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAW),
        CurrencyMessageWithdrawStorage  = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE),
        CurrencyMessageWithdrawGuild    = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
        CurrencyMessageStable           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STABLE),
        CurrencyMessageStorage          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STORAGE),
        CurrencyMessageWayshrine        = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WAYSHRINE),
        CurrencyMessageUnstuck          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_UNSTUCK),
        CurrencyMessageChampion         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CHAMPION),
        CurrencyMessageAttributes       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_ATTRIBUTES),
        CurrencyMessageSkills           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SKILLS),
        CurrencyMessageMorphs           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MORPHS),
        CurrencyMessageBounty           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BOUNTY),
        CurrencyMessageTrader           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADER),
        CurrencyMessageRepair           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_REPAIR),
        CurrencyMessageListing          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LISTING),
        CurrencyMessageCampaign         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CAMPAIGN),
        CurrencyMessageFence            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_FENCE_VALUE),
        CurrencyMessageFenceNoV         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_FENCE),
        CurrencyMessageSellNoV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SELL),
        CurrencyMessageBuyNoV           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BUY),
        CurrencyMessageBuybackNoV       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BUYBACK),
        CurrencyMessageSell             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SELL_VALUE),
        CurrencyMessageBuy              = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BUY_VALUE),
        CurrencyMessageBuyback          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BUYBACK_VALUE),
        CurrencyMessagePickpocket       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_PICKPOCKET),
        CurrencyMessageLaunder          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LAUNDER_VALUE),
        CurrencyMessageLaunderNoV       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LAUNDER),
        CurrencyMessageConfiscate       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CONFISCATE),
        CurrencyMessageUse              = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_USE),
        CurrencyMessageCraft            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CRAFT),
        CurrencyMessageExtract          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_EXTRACT),
        CurrencyMessageUpgrade          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_UPGRADE),
        CurrencyMessageUpgradeFail      = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_UPGRADE_FAIL),
        CurrencyMessageRefine           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_REFINE),
        CurrencyMessageDeconstruct      = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DECONSTRUCT),
        CurrencyMessageResearch         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_RESEARCH),
        CurrencyMessageDestroy          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DESTROY),
        CurrencyMessageLockpick         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOCKPICK),
        CurrencyMessageRemove           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_REMOVE),
        CurrencyMessageQuestTurnIn      = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TURNIN),
        CurrencyMessageQuestUse         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_QUESTUSE),
        CurrencyMessageQuestExhaust     = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_EXHAUST),
        CurrencyMessageQuestOffer       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_OFFER),
        CurrencyMessageQuestDiscard     = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DISCARD),
        CurrencyMessageQuestConfiscate  = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_QUESTCONFISCATE),
        CurrencyMessageQuestCombine     = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_COMBINE),
        CurrencyMessageQuestMix         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MIX),
        CurrencyMessageQuestBundle      = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BUNDLE),
        CurrencyMessageGroup            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_GROUP),
        CurrencyMessageDisguiseEquip    = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP),
        CurrencyMessageDisguiseRemove   = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE),
        CurrencyMessageDisguiseDestroy  = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY),
    },

    DisplayAnnouncements = {
        Debug                           = false -- Display EVENT_DISPLAY_ANNOUNCEMENT debug messages
    },
}

------------------------------------------------
-- LOCAL (GLOBAL) VARIABLE SETUP ---------------
------------------------------------------------

-- Basic
local g_activatedFirstLoad          = true

-- Message Printer
local g_queuedMessages              = { }           -- Table to hold messages for the 50 ms tick function to print them.
local g_queuedMessagesCounter       = 1             -- Counter value for queued message printer

-- Loot/Currency
local g_savedPurchase               = { }
local g_savedLaunder                = { }
local g_isLooted                    = false         -- Toggled on to modify loot notification to "looted."
local g_isPickpocketed              = false         -- Toggled on to modify loot notification to "pickpocketed."
local g_isStolen                    = false         -- Toggled on to modify loot notification to "stolen."
local g_itemReceivedIsQuestReward   = false         -- Toggled on to modify loot notification to "received." This overrides the "looted" tag applied to quest item rewards.
local g_itemReceivedIsQuestAbandon  = false         -- Toggled on to modify remove notification to "removed" when a quest is abandoned.
local g_itemsConfiscated            = false         -- Toggled on when items are confiscated to modify the notification message.
local g_weAreInAStore               = false         -- Toggled on when the player opens a store.
local g_weAreInAFence               = false         -- Toggled on when the player opens a fence.
local g_itemWasDestroyed            = false         -- Tracker for item being destroyed
local g_lockpickBroken              = false         -- Tracker for lockpick being broken
local g_groupLootIndex              = {}            -- Table to hold group member names for group loot display.

-- Currency Throttle
local g_currencyGoldThrottleValue   = 0             -- Held value for gold throttle (counter)
local g_currencyGoldThrottleTotal   = 0             -- Held value for gold throttle (total gold)
local g_currencyAPThrottleValue     = 0             -- Held value for AP throttle (counter)
local g_currencyAPThrottleTotal     = 0             -- Held value for AP throttle (total gold)
local g_currencyTVThrottleValue     = 0             -- Held value for TV throttle (counter)
local g_currencyTVThrottleTotal     = 0             -- Held value for TV throttle (total gold)

-- Loot (Crafting)
local g_smithing                    = {}            -- Table for smithing mode
local g_enchanting                  = {}            -- Table for enchanting mode
local g_enchant_prefix_pos          = {}
local g_enchant_prefix_neg          = {}
local g_smithing_prefix_pos         = {}
local g_smithing_prefix_neg         = {}
local g_itemCounterGain             = 0             -- Counter value for items created via crafting
local g_itemStringGain              = ""            -- Counter value for items created via crafting
local g_itemCounterLoss             = 0             -- Counter value for items removed via crafting
local g_itemStringLoss              = ""            -- Combined string variable for items removed via crafting
local g_oldItem                     = { }           -- Saved old item for crafting upgrades

-- Experience
local g_xpCombatBufferValue         = 0             -- Buffered XP Value
local g_guildSkillThrottle          = 0             -- Buffered Fighter's Guild Reputation Value
local g_guildSkillThrottleLine      = nil           -- Grab the name for Fighter's Guild reputation (since index isn't always the same) to pass over to Buffered Printer Function

-- Mail
local g_mailCOD                     = 0             -- Tracks COD amount
local g_postageAmount               = 0             -- Tracks Postage amount
local g_mailCODPresent              = false         -- Tracks whether the currently opened mail has a COD value present. On receiving items from the mail this will modify the message displayed.
local g_inMail                      = false         -- Toggled on when looting mail to prevent notable item display from hiding items acquired.
local g_mailTarget                  = ""            -- Target of mail being sent.
local g_mailStacksOut               = { }           -- Table for storing items to be mailed out.

-- Disguise
local g_currentDisguise             = nil           -- Holds current disguise itemId
local g_disguiseState               = nil           -- Holds current disguise state

-- Indexing
local g_bankBag
local g_bankStacks                  = {}            -- Bank Inventory Index
local g_banksubStacks               = {}            -- Subscriber Bank Inventory Index
local g_houseBags                   = {}            -- House Storage Index
local g_equippedStacks              = {}            -- Equipped Items Index
local g_inventoryStacks             = {}            -- Inventory Index
local g_JusticeStacks               = {}            -- Justice Items Index (only filled as a comparison table when items are confiscated)
local g_guildBankCarry              = nil           -- Saves item data when an item is removed/deposited into the guild bank.

-- Group
local currentGroupLeaderRawName     = nil           -- Tracks current Group Leader Name
local currentGroupLeaderDisplayName = nil           -- Tracks current Group Leader Display Name

-- LFG
local g_stopGroupLeaveQueue         = false         -- Stops group notification messages from printing for a short time an LFG group is formed - Implemented due to odd behavior on LFG group formation.
local g_lfgDisableGroupEvents       = false         -- Stops group notification messages from printing for a short time an LFG group is formed - Implemented due to odd behavior on LFG group formation.
local g_groupJoinFudger             = false         -- Toggled on when a group invite is accepted. Controls display of group join message.
local g_joinLFGOverride             = false         -- Toggled on to stop display of standard group join message when joining an LFG group. Instead an alternate message with the LFG activity name will display.
local g_leaveLFGOverride            = false         -- Toggled on to modify group leave message to display "You are no longer in an LFG group."
local g_showActivityStatus          = true          -- Variable to control display of LFG quest
local g_showRCUpdates               = true          -- Variable to control display of LFG Ready Check Announcements
local g_savedQueueValue             = 0             -- Saved LFG queue status
local g_rcSpamPrevention            = false         -- Stops LFG failed ready checks from spamming the player
local g_LFGJoinAntiSpam             = false         -- Stops LFG join messages from spamming the player when a group already in an activity is queueing
local g_rcUpdateDeclineOverride     = false         -- Variable set to true for 5 seconds when a LFG group joing event happens, this prevents RC declined messages from erroneously appearing after solo joining an in progress LFG group.

-- Guild
local g_selectedGuild               = 1             -- Set selected guild to 1 by default, whenever the player reloads their first guild will always be selected
local g_pendingHeraldryCost         = 0             -- Pending cost of heraldry change used to modify currency messages.
local g_guildRankData               = {}            -- Variable to store local player guild ranks, for guild rank changes.

-- Achievements
local g_achievementLastPercentage   = {}            -- Here we will store last displayed percentage for achievement

-- Collectible Usage Tracking
local currentAssistant = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT)
local currentVanity = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
local currentSpecial = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN)
local currentHat = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HAT)
local currentHair = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HAIR)
local currentHeadMark = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HEAD_MARKING)
local currentFacialHair = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_FACIAL_HAIR_HORNS)
local currentMajorAdorn = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_FACIAL_ACCESSORY)
local currentMinorAdorn = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_PIERCING_JEWELRY)
local currentCostume = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME)
local currentBodyMarking = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_BODY_MARKING)
local currentSkin = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_SKIN)
local currentPersonality = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_PERSONALITY)
local currentPolymorph = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH)
local lastCollectibleUsed = 0

-- Quest
local g_stopDisplaySpam             = false         -- Toggled on to stop spam display of EVENT_DISPLAY_ANNOUNCEMENTS from IC zone transitions.
local g_questIndex                  = { }           -- Index of all current quests. Allows us to read the index so that all quest notifications can use the difficulty icon.
local g_questItemAdded              = { }           -- Hold index of Quest items that are added - Prevents pointless and annoying messages from appearing when the same quest item is immediately added and removed when quest updates.
local g_questItemRemoved            = { }           -- Hold index of Quest items that are removed - Prevents pointless and annoying messages from appearing when the same quest item is immediately added and removed when quest updates.
local g_loginHideQuestLoot          = true          -- Set to true onPlayerActivated and toggled after 1 sec

-- Trade
local g_tradeTarget                 = ""            -- Saves name of target player being traded with.
local g_tradeStacksIn               = { }           -- Table for storing items to be traded in.
local g_tradeStacksOut              = { }           -- Table for storing items to be traded out.

------------------------------------------------
-- COLORIZE VALUES -----------------------------
------------------------------------------------

-- Basic
--local NotificationColorize

-- Guild
local GuildColorize

-- Currency
local CurrencyColorize
local CurrencyUpColorize
local CurrencyDownColorize
local CurrencyGoldColorize
local CurrencyAPColorize
local CurrencyTVColorize
local CurrencyWVColorize
local CurrencyOutfitTokenColorize
local CurrencyUndauntedColorize
local CurrencyTransmuteColorize
local CurrencyEventColorize
local CurrencyCrownsColorize
local CurrencyCrownGemsColorize

-- Disguise
local DisguiseAlertColorize

-- Achievements
local AchievementColorize1
local AchievementColorize2

-- Experience
local ExperienceMessageColorize
local ExperienceNameColorize
local ExperienceLevelUpColorize

-- Skill Point/Lines
local SkillPointColorize1
local SkillPointColorize2
local SkillLineColorize

-- Guild Skills
local SkillGuildColorize
local SkillGuildColorizeFG
local SkillGuildColorizeMG
local SkillGuildColorizeUD
local SkillGuildColorizeTG
local SkillGuildColorizeDB

-- Collectibles
local CollectibleColorize1
local CollectibleColorize2
local CollectibleUseColorize

-- Lorebooks
local LorebookColorize1
local LorebookColorize2

-- Quests
local QuestColorLocNameColorize
local QuestColorLocDescriptionColorize
local QuestColorQuestNameColorize
local QuestColorQuestDescriptionColorize

-- Storage
local StorageRidingColorize
local StorageRidingBookColorize
local StorageBagColorize

------------------------------------------------
-- BRACKET OPTIONS -----------------------------
------------------------------------------------

-- 5 Option Bracket (1)
local bracket1 = {
    [1] = "[",
    [2] = "(",
    [3] = "",
    [4] = "",
    [5] = "",
}

-- 5 Option Bracket (2)
local bracket2 = {
    [1] = "]",
    [2] = ")",
    [3] = " -",
    [4] = ":",
    [5] = "",
}

-- 4 Option Bracket (1)
local bracket3 = {
    [1] = "[",
    [2] = "(",
    [3] = "- ",
    [4] = "",
}

-- 4 Option Bracket (2)
local bracket4 = {
    [1] = "]",
    [2] = ")",
    [3] = "",
    [4] = "",
}

------------------------------------------------
-- LINK BRACKET OPTIONS ------------------------
------------------------------------------------

local linkBrackets = {
    [1] = LINK_STYLE_DEFAULT,
    [2] = LINK_STYLE_BRACKETS,
}

local linkBracket1 = {
    [1] = "",
    [2] = "[",
}

local linkBracket2 = {
    [1] = "",
    [2] = "]",
}

------------------------------------------------
-- ITEM BLACKLIST ------------------------------
------------------------------------------------

-- List of items to whitelist as notable loot
local g_notableIDs = {
    [56862]  = true,    -- Fortified Nirncrux
    [56863]  = true,    -- Potent Nirncrux
    [68342]  = true,    -- Hakeijo
}

local g_removeableIDs = {
    [44486] = true, -- Prismatic Blade (Fighters Guild Quests)
    [44487] = true, -- Prismatic Greatblade (Fighters Guild Quests)
    [44488] = true, -- Prismatic Long Bow (Fighters Guild Quests)
    [44489] = true, -- Prismatic Flamestaff (Fighters Guild Quests)
    [33235] = true, -- Wabbajack (Mages Guild Quests)

    -- New Life Festival
    [100393] = true, -- Histmuck Blobfin (Fish Boon Feast)
    [100394] = true, -- Shadowfen Creeping Leech (Fish Boon Feast)
    [100395] = true, -- Black Marsh Cucumber (Fish Boon Feast)
}

-- List of items to blacklist as annyoing loot
local g_blacklistIDs = {
    -- General
    [64713]  = true,    -- Laurel
    [64690]  = true,    -- Malachite Shard
    [69432]  = true,    -- Glass Style Motif Fragment
    [134623] = true,    -- Uncracked Transmutation Geode

    -- Trial Plunder
    [114427] = true,    -- Undaunted Plunder
    [81180]  = true,    -- The Serpent's Egg-Tooth
    [74453]  = true,    -- The Rid-Thar's Moon Pearls
    [87701]  = true,    -- Star-Studded Champion's Baldric
    [87700]  = true,    -- Periapt of Elinhir

    -- Trial Weekly Coffers
    [139664] = true,    -- Mage's Ignorant Coffer
    [139674] = true,    -- Saint's Beatified Coffer
    [139670] = true,    -- Dro-m'Athra's Burnished Coffer
    [138711] = true,    -- Welkynar's Grounded Coffer

    -- Mercenary Motif Pages
    [64716]  = true,    -- Mercenary Motif
    [64717]  = true,    -- Mercenary Motif
    [64718]  = true,    -- Mercenary Motif
    [64719]  = true,    -- Mercenary Motif
    [64720]  = true,    -- Mercenary Motif
    [64721]  = true,    -- Mercenary Motif
    [64722]  = true,    -- Mercenary Motif
    [64723]  = true,    -- Mercenary Motif
    [64724]  = true,    -- Mercenary Motif
    [64725]  = true,    -- Mercenary Motif
    [64726]  = true,    -- Mercenary Motif
    [64727]  = true,    -- Mercenary Motif
    [64728]  = true,    -- Mercenary Motif
    [64729]  = true,    -- Mercenary Motif
}

local guildAllianceColors = {
    [1] = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ALLIANCE, ALLIANCE_ALDMERI_DOMINION)),
    [2] = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ALLIANCE, ALLIANCE_DAGGERFALL_COVENANT)),
    [3] = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ALLIANCE, ALLIANCE_EBONHEART_PACT)),
}

function ChatAnnouncements.Initialize(enabled)
    -- Load settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        ChatAnnouncements.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, "ChatAnnouncements", ChatAnnouncements.Defaults)
    else
        ChatAnnouncements.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, "ChatAnnouncements", ChatAnnouncements.Defaults)
    end

    -- Some modules might need to pull some of the color settings from CA so we want these to always be set regardless of CA module being enabled/disabled.
    ChatAnnouncements.RegisterColorEvents()
    -- Always register this function for other components to use
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COLLECTIBLE_USE_RESULT, ChatAnnouncements.CollectibleUsed)

    -- Disable module if setting not toggled on
    if not enabled then
        return
    end
    ChatAnnouncements.Enabled = true

    -- Get current group leader
    currentGroupLeaderRawName = GetRawUnitName(GetGroupLeaderUnitTag())
    currentGroupLeaderDisplayName = GetUnitDisplayName(GetGroupLeaderUnitTag())

    -- Setup group variables
    if IsInLFGGroup() then
        g_LFGJoinAntiSpam = true
    end

    -- Posthook Crafting Interface (Keyboard)
    ChatAnnouncements.CraftModeOverrides()

    -- Register events
    ChatAnnouncements.RegisterGoldEvents()
    ChatAnnouncements.RegisterLootEvents()
    ChatAnnouncements.RegisterMailEvents()
    ChatAnnouncements.RegisterXPEvents()
    ChatAnnouncements.RegisterAchievementsEvent()
    -- TODO: Possibly don't register these unless enabled, I'm not sure -- at least move to better sorted order
    eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_BAG_CAPACITY_CHANGED, ChatAnnouncements.StorageBag)
    eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_BANK_CAPACITY_CHANGED, ChatAnnouncements.StorageBank)
    -- TODO: Move these too:
    LINK_HANDLER:RegisterCallback(LINK_HANDLER.LINK_MOUSE_UP_EVENT, LUIE.HandleClickEvent)
    LINK_HANDLER:RegisterCallback(LINK_HANDLER.LINK_CLICKED_EVENT, LUIE.HandleClickEvent)

    -- TODO: also move this
    eventManager:RegisterForEvent(moduleName, EVENT_SKILL_XP_UPDATE, ChatAnnouncements.SkillXPUpdate)

    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, ChatAnnouncements.OnPlayerActivated)

    ChatAnnouncements.RegisterGuildEvents()
    ChatAnnouncements.RegisterSocialEvents()
    ChatAnnouncements.RegisterDisguiseEvents()
    ChatAnnouncements.RegisterQuestEvents()

    ChatAnnouncements.HookFunction()

     -- Index members for Group Loot
    ChatAnnouncements.IndexGroupLoot()
end

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENT HANDLER AND COLOR REGISTRATION -----------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

function ChatAnnouncements.RegisterColorEvents()
    CurrencyColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyColor))
    CurrencyUpColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyColorUp))
    CurrencyDownColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyColorDown))
    CollectibleColorize1 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Collectibles.CollectibleColor1))
    CollectibleColorize2 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Collectibles.CollectibleColor2))
    CollectibleUseColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Collectibles.CollectibleUseColor))
    CurrencyGoldColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyGoldColor))
    CurrencyAPColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyAPColor))
    CurrencyTVColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyTVColor))
    CurrencyWVColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyWVColor))
    CurrencyOutfitTokenColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyOutfitTokenColor))
    CurrencyUndauntedColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyUndauntedColor))
    CurrencyTransmuteColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyTransmuteColor))
    CurrencyEventColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyEventColor))
    CurrencyCrownsColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyCrownsColor))
    CurrencyCrownGemsColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Currency.CurrencyCrownGemsColor))
    DisguiseAlertColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Notify.DisguiseAlertColor))
    AchievementColorize1 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Achievement.AchievementColor1))
    AchievementColorize2 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Achievement.AchievementColor2))
    LorebookColorize1 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Lorebooks.LorebookColor1))
    LorebookColorize2 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Lorebooks.LorebookColor2))
    ExperienceMessageColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.XP.ExperienceColorMessage)):ToHex()
    ExperienceNameColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.XP.ExperienceColorName)):ToHex()
    ExperienceLevelUpColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.XP.ExperienceLevelUpColor))
    SkillPointColorize1 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillPointColor1))
    SkillPointColorize2 = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillPointColor2))
    SkillLineColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillLineColor))
    SkillGuildColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColor)):ToHex()
    SkillGuildColorizeFG = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColorFG)):ToHex()
    SkillGuildColorizeMG = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColorMG)):ToHex()
    SkillGuildColorizeUD = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColorUD)):ToHex()
    SkillGuildColorizeTG = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColorTG)):ToHex()
    SkillGuildColorizeDB = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColorDB)):ToHex()
    SkillGuildColorizePO = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Skills.SkillGuildColorPO)):ToHex()
    QuestColorLocNameColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Quests.QuestColorLocName)):ToHex()
    QuestColorLocDescriptionColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Quests.QuestColorLocDescription)):ToHex()
    QuestColorQuestNameColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Quests.QuestColorName))
    QuestColorQuestDescriptionColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Quests.QuestColorDescription)):ToHex()
    StorageRidingColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Notify.StorageRidingColor))
    StorageRidingBookColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Notify.StorageRidingBookColor))
    StorageBagColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Notify.StorageBagColor))
    --NotificationColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Notify.NotificationColor))
    GuildColorize = ZO_ColorDef:New(unpack(ChatAnnouncements.SV.Social.GuildColor))
end

function ChatAnnouncements.RegisterSocialEvents()
    eventManager:RegisterForEvent(moduleName, EVENT_FRIEND_ADDED, ChatAnnouncements.FriendAdded)
    eventManager:RegisterForEvent(moduleName, EVENT_FRIEND_REMOVED, ChatAnnouncements.FriendRemoved)
    eventManager:RegisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_ADDED, ChatAnnouncements.FriendInviteAdded)
    eventManager:RegisterForEvent(moduleName, EVENT_IGNORE_ADDED, ChatAnnouncements.IgnoreAdded)
    eventManager:RegisterForEvent(moduleName, EVENT_IGNORE_REMOVED, ChatAnnouncements.IgnoreRemoved)
    eventManager:RegisterForEvent(moduleName, EVENT_FRIEND_PLAYER_STATUS_CHANGED, ChatAnnouncements.FriendPlayerStatus)
end

function ChatAnnouncements.RegisterQuestEvents()
    eventManager:RegisterForEvent(moduleName, EVENT_QUEST_SHARED, ChatAnnouncements.QuestShared)
    -- Create a table for quests
    for i = 1, 25 do
        if IsValidQuestIndex(i) then
            local name = GetJournalQuestName(i)
            local questType = GetJournalQuestType(i)
            local instanceDisplayType = GetJournalQuestInstanceDisplayType(i)

            if name == "" then
                name = GetString(SI_QUEST_JOURNAL_UNKNOWN_QUEST_NAME)
            end

            g_questIndex[name] = {
                questType = questType,
                instanceDisplayType = instanceDisplayType
            }
        end
    end
end

function ChatAnnouncements.RegisterGuildEvents()
    -- TODO: Possibly implement conditionals here again in the future
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, ChatAnnouncements.GuildAddedSelf)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_INVITE_ADDED, ChatAnnouncements.GuildInviteAdded)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_RANK_CHANGED, ChatAnnouncements.GuildRank)
    eventManager:RegisterForEvent(moduleName, EVENT_HERALDRY_SAVED, ChatAnnouncements.GuildHeraldrySaved)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_RANKS_CHANGED, ChatAnnouncements.GuildRanksSaved)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_RANK_CHANGED, ChatAnnouncements.GuildRankSaved)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_DESCRIPTION_CHANGED, ChatAnnouncements.GuildTextChanged)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_MOTD_CHANGED, ChatAnnouncements.GuildTextChanged)
    -- Index Guild Ranks
    g_guildRankData = {}
    for i = 1,5 do
        local guildId = GetGuildId(i)
        local memberIndex = GetPlayerGuildMemberIndex(guildId)
        local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
        g_guildRankData[guildId] = rankIndex
    end
end

function ChatAnnouncements.RegisterAchievementsEvent()
    eventManager:UnregisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED)
    if ChatAnnouncements.SV.Achievement.AchievementUpdateCA or ChatAnnouncements.SV.Achievement.AchievementUpdateAlert then
        eventManager:RegisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED, ChatAnnouncements.OnAchievementUpdated)
    end
end

function ChatAnnouncements.RegisterXPEvents()
    eventManager:UnregisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN)
    if ChatAnnouncements.SV.XP.Experience or ChatAnnouncements.SV.XP.ExperienceLevelUp then
        eventManager:RegisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN, ChatAnnouncements.OnExperienceGain)
    end
end

function ChatAnnouncements.RegisterGoldEvents()
    eventManager:UnregisterForEvent(moduleName, EVENT_CURRENCY_UPDATE)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_REMOVED)

    eventManager:RegisterForEvent(moduleName, EVENT_CURRENCY_UPDATE, ChatAnnouncements.OnCurrencyUpdate)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, ChatAnnouncements.OnMailAttach)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, ChatAnnouncements.OnMailAttachRemove)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX, ChatAnnouncements.OnMailCloseBox)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS, ChatAnnouncements.OnMailSuccess)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED, ChatAnnouncements.MailMoneyChanged)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED, ChatAnnouncements.MailCODChanged)
    eventManager:RegisterForEvent(moduleName, EVENT_MAIL_REMOVED, ChatAnnouncements.MailRemoved)
end

function ChatAnnouncements.RegisterMailEvents()
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_READABLE)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_OPEN_MAILBOX)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED)
    eventManager:UnregisterForEvent(moduleName, EVENT_MAIL_REMOVED)
    if ChatAnnouncements.SV.MiscMail or ChatAnnouncements.SV.Inventory.LootMail then
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_READABLE, ChatAnnouncements.OnMailReadable)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, ChatAnnouncements.OnMailTakeAttachedItem)
    end
    if ChatAnnouncements.SV.MiscMail or ChatAnnouncements.SV.Inventory.LootMail or ChatAnnouncements.SV.Currency.CurrencyGoldChange then
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, ChatAnnouncements.OnMailAttach)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, ChatAnnouncements.OnMailAttachRemove)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS, ChatAnnouncements.OnMailSuccess)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED, ChatAnnouncements.MailMoneyChanged)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED, ChatAnnouncements.MailCODChanged)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_REMOVED, ChatAnnouncements.MailRemoved)
    end
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.MiscMail or ChatAnnouncements.SV.Inventory.LootMail or ChatAnnouncements.SV.Currency.CurrencyGoldChange then
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_OPEN_MAILBOX, ChatAnnouncements.OnMailOpenBox)
        eventManager:RegisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX, ChatAnnouncements.OnMailCloseBox)
    end
end

function ChatAnnouncements.RegisterLootEvents()
    -- NON CONDITIONAL EVENTS
    -- LOCKPICK
    eventManager:RegisterForEvent(moduleName, EVENT_LOCKPICK_BROKE, ChatAnnouncements.MiscAlertLockBroke)
    eventManager:RegisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS, ChatAnnouncements.MiscAlertLockSuccess)
    -- LOOT RECEIVED
    eventManager:UnregisterForEvent(moduleName, EVENT_LOOT_RECEIVED)
    -- QUEST REWARD CONTEXT
    -- INDEX
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    -- VENDOR
    eventManager:UnregisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT)
    eventManager:UnregisterForEvent(moduleName, EVENT_BUY_RECEIPT)
    eventManager:UnregisterForEvent(moduleName, EVENT_SELL_RECEIPT)
    eventManager:UnregisterForEvent(moduleName, EVENT_OPEN_FENCE)
    eventManager:UnregisterForEvent(moduleName, EVENT_CLOSE_STORE)
    eventManager:UnregisterForEvent(moduleName, EVENT_OPEN_STORE)
    eventManager:UnregisterForEvent(moduleName, EVENT_ITEM_LAUNDER_RESULT)
    -- BANK
    eventManager:UnregisterForEvent(moduleName, EVENT_OPEN_BANK)
    eventManager:UnregisterForEvent(moduleName, EVENT_CLOSE_BANK)
    eventManager:UnregisterForEvent(moduleName, EVENT_OPEN_GUILD_BANK)
    eventManager:UnregisterForEvent(moduleName, EVENT_CLOSE_GUILD_BANK)
    eventManager:UnregisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_ADDED)
    eventManager:UnregisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_REMOVED)
    -- CRAFT
    eventManager:UnregisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, ChatAnnouncements.CraftingOpen)
    eventManager:UnregisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, ChatAnnouncements.CraftingClose)
    -- TRADE
    eventManager:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_ADDED)
    eventManager:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_REMOVED)
    -- JUSTICE/DESTROY
    eventManager:UnregisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED)
    -- LOOT FAILED
    eventManager:UnregisterForEvent(moduleName, EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_IS_FULL)
    eventManager:UnregisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED)

    -- LOOT RECEIVED
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootQuestAdd or ChatAnnouncements.SV.Inventory.LootQuestRemove then
        eventManager:RegisterForEvent(moduleName, EVENT_LOOT_RECEIVED, ChatAnnouncements.OnLootReceived)
    end
    -- QUEST LOOT
    if ChatAnnouncements.SV.Inventory.LootQuestAdd or ChatAnnouncements.SV.Inventory.LootQuestRemove then
        ChatAnnouncements.AddQuestItemsToIndex()
    end
    -- INDEX
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
        g_equippedStacks = {}
        g_inventoryStacks = {}
        ChatAnnouncements.IndexEquipped()
        ChatAnnouncements.IndexInventory()
    end
    -- VENDOR
    if ChatAnnouncements.SV.Inventory.LootVendor then
        eventManager:RegisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT, ChatAnnouncements.OnBuybackItem)
        eventManager:RegisterForEvent(moduleName, EVENT_BUY_RECEIPT, ChatAnnouncements.OnBuyItem)
        eventManager:RegisterForEvent(moduleName, EVENT_SELL_RECEIPT, ChatAnnouncements.OnSellItem)
        eventManager:RegisterForEvent(moduleName, EVENT_ITEM_LAUNDER_RESULT, ChatAnnouncements.FenceSuccess)
    end
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootVendor then
        eventManager:RegisterForEvent(moduleName, EVENT_OPEN_FENCE, ChatAnnouncements.FenceOpen)
        eventManager:RegisterForEvent(moduleName, EVENT_OPEN_STORE, ChatAnnouncements.StoreOpen)
        eventManager:RegisterForEvent(moduleName, EVENT_CLOSE_STORE, ChatAnnouncements.StoreClose)
    end
    -- BANK
    if ChatAnnouncements.SV.Inventory.LootBank then
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_ADDED, ChatAnnouncements.GuildBankItemAdded)
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_REMOVED, ChatAnnouncements.GuildBankItemRemoved)
    end
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootBank then
        eventManager:RegisterForEvent(moduleName, EVENT_OPEN_BANK, ChatAnnouncements.BankOpen)
        eventManager:RegisterForEvent(moduleName, EVENT_CLOSE_BANK, ChatAnnouncements.BankClose)
        eventManager:RegisterForEvent(moduleName, EVENT_OPEN_GUILD_BANK, ChatAnnouncements.GuildBankOpen)
        eventManager:RegisterForEvent(moduleName, EVENT_CLOSE_GUILD_BANK, ChatAnnouncements.GuildBankClose)
    end
    if ChatAnnouncements.SV.Inventory.LootTrade then
        eventManager:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_ADDED, ChatAnnouncements.OnTradeAdded)
        eventManager:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_REMOVED, ChatAnnouncements.OnTradeRemoved)
    end
    -- TRADE
    eventManager:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_ACCEPTED, ChatAnnouncements.TradeInviteAccepted)
    -- CRAFT
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootCraft then
        eventManager:RegisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, ChatAnnouncements.CraftingOpen)
        eventManager:RegisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, ChatAnnouncements.CraftingClose)
    end
    -- JUSTICE/DESTROY
    if ChatAnnouncements.SV.Inventory.LootShowDestroy then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED, ChatAnnouncements.DestroyItem)
    end
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Notify.NotificationConfiscateCA or ChatAnnouncements.SV.Notify.NotificationConfiscateAlert or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED, ChatAnnouncements.JusticeStealRemove)
    end

    --[[if ChatAnnouncements.SV.ShowLootFail then
        eventManager:RegisterForEvent(moduleName, EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL, ChatAnnouncements.InventoryFullQuest)
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_IS_FULL, ChatAnnouncements.InventoryFull)
        eventManager:RegisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED, ChatAnnouncements.LootItemFailed)
    end]]
end

function ChatAnnouncements.RegisterDisguiseEvents()
    eventManager:UnregisterForEvent(moduleName .. "Player", EVENT_DISGUISE_STATE_CHANGED)
    if ChatAnnouncements.SV.Notify.DisguiseCA or ChatAnnouncements.SV.Notify.DisguiseCSA or ChatAnnouncements.SV.Notify.DisguiseAlert or ChatAnnouncements.SV.Notify.DisguiseWarnCA or ChatAnnouncements.SV.Notify.DisguiseWarnCSA or ChatAnnouncements.SV.Notify.DisguiseWarnAlert then
        eventManager:RegisterForEvent(moduleName .. "Player", EVENT_DISGUISE_STATE_CHANGED, ChatAnnouncements.DisguiseState )
        eventManager:AddFilterForEvent(moduleName .. "Player", EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
        g_currentDisguise = GetItemId(0, 10) or 0 -- Get the currently equipped disguise itemId if any
        if g_activatedFirstLoad then
            g_disguiseState = 0
            g_activatedFirstLoad = false
        else
            g_disguiseState = GetUnitDisguiseState("player") -- Get current player disguise state
            if g_disguiseState > 0 then
                g_disguiseState = 1 -- Simplify all the various states into a basic 0 = false, 1 = true value
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

-- Called by most functions that use character or display name to resolve LINK display method.
function ChatAnnouncements.ResolveNameLink(characterName, displayName)
    local nameLink

    if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            nameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
    elseif ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(characterName, nil, CHARACTER_LINK_TYPE, characterName)
        else
            nameLink = ZO_LinkHandler_CreateLink(characterName, nil, CHARACTER_LINK_TYPE, characterName)
        end
    elseif ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
        local displayBothString = zo_strformat("<<1>><<2>>", characterName, displayName)
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            nameLink = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
    end

    return nameLink
end

-- Called by most functions that use character or display name to resolve NON-LINK display method (mostly used for alerts).
function ChatAnnouncements.ResolveNameNoLink(characterName, displayName)
    local nameLink
    if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
        nameLink = displayName
    elseif ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
        nameLink = characterName
    elseif ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
        nameLink = zo_strformat("<<1>><<2>>", characterName, displayName)
    end

    return nameLink
end

function ChatAnnouncements.GuildHeraldrySaved()
    if ChatAnnouncements.SV.Currency.CurrencyGoldChange then
        local value = g_pendingHeraldryCost > 0 and g_pendingHeraldryCost or 1000
        local type = "LUIE_CURRENCY_HERALDRY"
        local formattedValue = nil -- Un-needed, we're not going to try to show the total guild bank gold here.
        local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(value)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        local currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyGoldName, value)
        local currencyTotal = nil
        local messageTotal = ""
        local messageChange = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_HERALDRY)
        ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end

    if g_selectedGuild ~= nil then
        local id = g_selectedGuild
        local guildName = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
        local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
        local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

        if ChatAnnouncements.SV.Social.GuildManageCA then
            local finalMessage = zo_strformat(GetString(SI_LUIE_CA_GUILD_HERALDRY_UPDATE), guildNameAlliance)
            g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "NOTIFICATION", isSystem = true }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Social.GuildManageAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_HERALDRY_UPDATE), guildNameAllianceAlert))
        end
    end
end

function ChatAnnouncements.GuildRanksSaved(eventCode, guildId)
    local guildName = GetGuildName(guildId)
    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

    if ChatAnnouncements.SV.Social.GuildManageCA then
        local finalMessage = zo_strformat(GetString(SI_LUIE_CA_GUILD_RANKS_UPDATE), guildNameAlliance)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "NOTIFICATION", isSystem = true }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
    end
    if ChatAnnouncements.SV.Social.GuildManageAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_RANKS_UPDATE), guildNameAllianceAlert))
    end
end

function ChatAnnouncements.GuildRankSaved(eventCode, guildId, rankIndex)
    local rankName
    local rankNameDefault = GetDefaultGuildRankName(guildId, rankIndex)
    local rankNameCustom = GetGuildRankCustomName(guildId, rankIndex)

    if rankNameCustom == "" then
        rankName = rankNameDefault
    else
        rankName = rankNameCustom
    end

    local icon = GetGuildRankIconIndex(guildId, rankIndex)
    local icon = GetGuildRankLargeIcon(icon)
    local guildName = GetGuildName(guildId)
    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    local rankSyntax = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(icon, 16, 16), rankName)) or (guildColor:Colorize(rankName))
    local rankSyntaxAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(icon, "100%", "100%", rankName) or rankName

    if ChatAnnouncements.SV.Social.GuildManageCA then
        printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_RANK_UPDATE), rankSyntax, guildNameAlliance), true)
    end
    if ChatAnnouncements.SV.Social.GuildManageAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_RANK_UPDATE), rankSyntaxAlert, guildNameAllianceAlert))
    end
end

function ChatAnnouncements.GuildTextChanged(eventCode, guildId)
    local guildName = GetGuildName(guildId)
    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    -- Depending on event code set message context.
    local messageString = eventCode == EVENT_GUILD_DESCRIPTION_CHANGED and SI_LUIE_CA_GUILD_DESCRIPTION_CHANGED or EVENT_GUILD_MOTD_CHANGED and SI_LUIE_CA_GUILD_MOTD_CHANGED or nil

    if messageString ~= nil then
        if ChatAnnouncements.SV.Social.GuildManageCA then
            local finalMessage = zo_strformat(GetString(messageString), guildNameAlliance)
            g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "NOTIFICATION", isSystem = true }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Social.GuildManageAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(messageString), guildNameAllianceAlert))
        end
    end
end

function ChatAnnouncements.GuildRank(eventCode, guildId, DisplayName, newRank)
    local currentRank = g_guildRankData[guildId]
    local hasPermission1 = DoesGuildRankHavePermission(guildId, currentRank, GUILD_PERMISSION_PROMOTE)
    local hasPermission2 = DoesGuildRankHavePermission(guildId, currentRank, GUILD_PERMISSION_DEMOTE)

    if ((hasPermission1 or hasPermission2) and DisplayName ~= LUIE.PlayerDisplayName and ChatAnnouncements.SV.Social.GuildRankDisplayOptions == 2) or (ChatAnnouncements.SV.Social.GuildRankDisplayOptions == 3 and DisplayName ~= LUIE.PlayerDisplayName) then
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(DisplayName, nil, DISPLAY_NAME_LINK_TYPE, DisplayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(DisplayName, nil, DISPLAY_NAME_LINK_TYPE, DisplayName)
        end
        local rankName
        local rankNameDefault = GetDefaultGuildRankName(guildId, newRank)
        local rankNameCustom = GetGuildRankCustomName(guildId, newRank)

        if rankNameCustom == "" then
            rankName = rankNameDefault
        else
            rankName = rankNameCustom
        end

        local icon = GetGuildRankIconIndex(guildId, newRank)
        local icon = GetGuildRankLargeIcon(icon)
        local guildName = GetGuildName(guildId)
        local guilds = GetNumGuilds()

        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            local guildAlliance = GetGuildAlliance(id)
            local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
            local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
            local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
            local rankSyntax = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(icon, 16, 16), rankName)) or (guildColor:Colorize(rankName))
            local rankSyntaxAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(icon, "100%", "100%", rankName) or rankName

            if guildName == name then
                if ChatAnnouncements.SV.Social.GuildRankCA then
                    printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED), displayNameLink, guildNameAlliance, rankSyntax), true)
                end
                if ChatAnnouncements.SV.Social.GuildRankAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED), DisplayName, guildNameAllianceAlert, rankSyntaxAlert))
                end
                break
            end
        end
    end

    if DisplayName == LUIE.PlayerDisplayName then
        local rankName
        local rankNameDefault = GetDefaultGuildRankName(guildId, newRank)
        local rankNameCustom = GetGuildRankCustomName(guildId, newRank)
        if rankNameCustom == "" then
            rankName = rankNameDefault
        else
            rankName = rankNameCustom
        end

        local icon = GetGuildRankIconIndex(guildId, newRank)
        local icon = GetGuildRankLargeIcon(icon)

        local guildName = GetGuildName(guildId)

        if currentRank > newRank then
            changestring = GetString(SI_LUIE_CA_GUILD_RANK_UP)
        end
        if currentRank < newRank then
            changestring = GetString(SI_LUIE_CA_GUILD_RANK_DOWN)
        end

        g_guildRankData[guildId] = newRank

        local guilds = GetNumGuilds()
        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            local guildAlliance = GetGuildAlliance(id)
            local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
            local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
            local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
            local rankSyntax = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(icon, 16, 16), rankName)) or (guildColor:Colorize(rankName))
            local rankSyntaxAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(icon, "100%", "100%", rankName) or rankName

            if guildName == name then
                if ChatAnnouncements.SV.Social.GuildRankCA then
                    printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED_SELF), changestring, rankSyntax, guildNameAlliance), true)
                end
                if ChatAnnouncements.SV.Social.GuildRankAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED_SELF), changestring, rankSyntaxAlert, guildNameAllianceAlert))
                end
                break
            end
        end
    end
end

-- EVENT_GUILD_SELF_JOINED_GUILD
function ChatAnnouncements.GuildAddedSelf(eventCode, guildId, guildName)
    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
        local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
        local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

        if guildName == name then
            if ChatAnnouncements.SV.Social.GuildCA then
                printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_JOIN_SELF), guildNameAlliance), true)
            end
            if ChatAnnouncements.SV.Social.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_JOIN_SELF), guildNameAllianceAlert))
            end
            break
        end
    end

    -- Reindex Guild Ranks
    g_guildRankData = {}
    for i = 1,5 do
        local guildId = GetGuildId(i)
        local memberIndex = GetPlayerGuildMemberIndex(guildId)
        local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
        g_guildRankData[guildId] = rankIndex
    end
end

-- EVENT_GUILD_INVITE_ADDED
function ChatAnnouncements.GuildInviteAdded(eventCode, guildId, guildName, guildAlliance, inviterName)
    local displayNameLink
    if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
        displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(inviterName, nil, DISPLAY_NAME_LINK_TYPE, inviterName)
    else
        displayNameLink = ZO_LinkHandler_CreateLink(inviterName, nil, DISPLAY_NAME_LINK_TYPE, inviterName)
    end
    local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    if ChatAnnouncements.SV.Social.GuildCA then
        printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), displayNameLink, guildNameAlliance), true)
    end
    if ChatAnnouncements.SV.Social.GuildAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), inviterName, guildNameAllianceAlert))
    end
end

function ChatAnnouncements.FriendAdded(eventCode, displayName)
    if ChatAnnouncements.SV.Social.FriendIgnoreCA then
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_FRIEND_ADDED, displayNameLink), true)
    end
    if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_FRIEND_ADDED, displayName))
    end
end

function ChatAnnouncements.FriendRemoved(eventCode, displayName)
    if ChatAnnouncements.SV.Social.FriendIgnoreCA then
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED, displayNameLink), true)
    end
    if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED, displayName))
    end
end

function ChatAnnouncements.FriendInviteAdded(eventCode, displayName)
    if ChatAnnouncements.SV.Social.FriendIgnoreCA then
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST, displayNameLink), true)
    end
    if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST, displayName))
    end
end

function ChatAnnouncements.IgnoreAdded(eventCode, displayName)
    if ChatAnnouncements.SV.Social.FriendIgnoreCA then
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED, displayNameLink), true)
    end
    if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED, displayName))
    end
end

function ChatAnnouncements.IgnoreRemoved(eventCode, displayName)
    if ChatAnnouncements.SV.Social.FriendIgnoreCA then
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED, displayNameLink), true)
    end
    if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED, displayName))
    end
end

function ChatAnnouncements.FriendPlayerStatus(eventCode, displayName, characterName, oldStatus, newStatus)
    local wasOnline = oldStatus ~= PLAYER_STATUS_OFFLINE
    local isOnline = newStatus ~= PLAYER_STATUS_OFFLINE

    if wasOnline ~= isOnline then
        local chatText
        local alertText
        local displayNameLink
        local characterNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
            characterNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(characterName, nil, CHARACTER_LINK_TYPE, characterName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
            characterNameLink = ZO_LinkHandler_CreateLink(characterName, nil, CHARACTER_LINK_TYPE, characterName)
        end
        if isOnline then
            if characterName ~= "" then
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON, displayNameLink, characterNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON, displayName, characterName)
            else
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON, displayNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON, displayName)
            end
        else
            if characterName ~= "" then
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF, displayNameLink, characterNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF, displayName, characterName)
            else
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF, displayNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF, displayName)
            end
        end

        if ChatAnnouncements.SV.Social.FriendStatusCA then
            printToChat(chatText, true)
        end
        if ChatAnnouncements.SV.Social.FriendStatusAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
        end
    end
end

function ChatAnnouncements.QuestShared(eventCode, questId)
    if ChatAnnouncements.SV.Quests.QuestShareCA or ChatAnnouncements.SV.Quests.QuestShareAlert then
        local questName, characterName, timeSinceRequestMs, displayName = GetOfferedQuestShareInfo(questId)

        local finalName = ChatAnnouncements.ResolveNameLink(characterName, displayName)

        local message = zo_strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE), finalName, QuestColorQuestNameColorize:Colorize(questName))
        local alertMessage = zo_strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P), finalName, questName)

        if ChatAnnouncements.SV.Quests.QuestShareCA then
            printToChat(message, true)
        end
        if ChatAnnouncements.SV.Quests.QuestShareAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
        end
    end
end

-- EVENT_ACTIVITY_FINDER_STATUS_UPDATE
function ChatAnnouncements.ActivityStatusUpdate(eventCode, status)
    --d("status: " .. status)
    if g_showActivityStatus then
        local message
        -- If we are NOT queued and were formerly queued, forming group, or in a ready check, display left queue message.
        if status == ACTIVITY_FINDER_STATUS_NONE and (g_savedQueueValue == 1 or g_savedQueueValue == 4) then
                message = (GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_END))
        end
        -- If we are queued and previously we were not queued then display a message.
        if status == ACTIVITY_FINDER_STATUS_QUEUED and (g_savedQueueValue == 0 or g_savedQueueValue == 2) then
                message = (GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_START))
        end
        -- If we were in the queue and are now in progress without a ready check triggered, we left the queue to find a replacement member so this should be displayed.
        if status == ACTIVITY_FINDER_STATUS_IN_PROGRESS and (g_savedQueueValue == 1) then
                message = (GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_END))
        end
        if g_savedQueueValue == 5 and status == 1 then status = 5 end -- Fixes an error that occurs when joining an LFG instance while already in an LFG group.

        if message then
            if ChatAnnouncements.SV.Group.GroupLFGQueueCA then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGQueueAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
        end
    end

    if status == 0 then
        g_showRCUpdates = true
    end -- Should always trigger at the end result of a ready check failing.
    if status == 4 then
        g_showRCUpdates = false
    end

    -- Prevents potential consecutive events from spamming
    if status == 5 and g_savedQueueValue ~= 5 then
        message = (GetString(SI_LFGREADYCHECKCANCELREASON4))
        if message then
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
        end
        g_stopGroupLeaveQueue = true
        g_showRCUpdates = true
        g_LFGJoinAntiSpam = false
        g_showActivityStatus = false
        zo_callLater(function() g_showActivityStatus = true end, 1000)
        zo_callLater(function() g_stopGroupLeaveQueue = false end, 1000)
    end

    g_savedQueueValue = status
end

-- EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED
function ChatAnnouncements.ReadyCheckUpdate(eventCode)
    --d("ready check update")
    local activityType, playerRole = GetLFGReadyCheckNotificationInfo()
    local tanksAccepted, tanksPending, healersAccepted, healersPending, dpsAccepted, dpsPending = GetLFGReadyCheckCounts()
    --d(tanksAccepted .. " " .. tanksPending .. " " .. healersAccepted .. " " .. healersPending .. " " .. dpsAccepted .." " .. dpsPending)
    if g_showRCUpdates then
        local activityName

        if activityType == 0 then
            return
        end
        if activityType == LFG_ACTIVITY_AVA then
            activityName = GetString(SI_LFGACTIVITY1) -- TODO: Untested
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND_NON_CHAMPION then
            activityName = zo_strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY7), GetString(SI_BATTLEGROUND_FINDER_GENERAL_ACTIVITY_DESCRIPTOR)) -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND_CHAMPION then
            activityName = zo_strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY5), GetString(SI_BATTLEGROUND_FINDER_GENERAL_ACTIVITY_DESCRIPTOR)) -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND_LOW_LEVEL then
            activityName = zo_strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY8), GetString(SI_BATTLEGROUND_FINDER_GENERAL_ACTIVITY_DESCRIPTOR)) -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_DUNGEON then
            activityName = zo_strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY2), GetString(SI_DUNGEON_FINDER_GENERAL_ACTIVITY_DESCRIPTOR))
        end
        if activityType == LFG_ACTIVITY_HOME_SHOW then
            activityName = GetString(SI_LFGACTIVITY6) -- TODO: Untested
        end
        if activityType == LFG_ACTIVITY_MASTER_DUNGEON then
            activityName = zo_strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY3), GetString(SI_DUNGEON_FINDER_GENERAL_ACTIVITY_DESCRIPTOR))
        end
        if activityType == LFG_ACTIVITY_TRIAL then
            activityName = GetString(SI_LFGACTIVITY4) -- TODO: Untested
        end

        local message
        local alertText
        if playerRole ~= 0 then
            local roleIconSmall = zo_strformat("<<1>> ", zo_iconFormat(GetRoleIcon(playerRole), 16, 16)) or ""
            local roleIconLarge =zo_strformat("<<1>> ", zo_iconFormat(GetRoleIcon(playerRole), "100%", "100%")) or ""
            local roleString = GetString("SI_LFGROLE", playerRole)
            message = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY_ROLE), activityName, roleIconSmall, roleString )
            alertText = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY_ROLE), activityName, roleIconLarge, roleString )
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
            end
        else
            message = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY), activityName)
            alertText = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY), activityName)
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
            end
        end
    end

    g_showRCUpdates = false

    if not g_showRCUpdates and (tanksAccepted == 0 and tanksPending == 0 and healersAccepted == 0 and healersPending == 0 and dpsAccepted == 0 and dpsPending == 0) and not g_rcUpdateDeclineOverride then
        if g_rcSpamPrevention == false then
            local message
            message = (GetString(SI_LFGREADYCHECKCANCELREASON3))
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
            g_rcSpamPrevention = true
            zo_callLater(function() g_rcSpamPrevention = false end, 1000)
            g_showActivityStatus = false
            zo_callLater(function() g_showActivityStatus = true end, 1000)
            g_showRCUpdates = true
        end
    end
end

--[[ Would love to be able to use this function but its too buggy for now. Spams every single time someone updates their role, as well as when people join/leave group. If the player joins a large party for the first time then
this broadcasts the role of every single player in the party. Too bad this doesn't only trigger when someone in group actually updates their role instead.
No localization support yet.
function ChatAnnouncements.GMRC(eventCode, unitTag, dps, healer, tank)

local updatedRoleName = GetUnitName(unitTag)
local updatedRoleAccountName = GetUnitDisplayName(unitTag)

local characterNameLink = ZO_LinkHandler_CreateCharacterLink(updatedRoleName)
local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(updatedRoleAccountName)
local displayBothString = ( zo_strformat("<<1>><<2>>", updatedRoleName, updatedRoleAccountName) )
local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, updatedRoleAccountName)

local rolestring1 = ""
local rolestring2 = ""
local rolestring3 = ""
local message = ""

    -- Return here in case something happens
    if not (dps or healer or tank) then
        return
    end

    -- fill in strings for roles
    if dps then
        rolestring3 = "DPS"
    end
    if healer then
        rolestring2 = "Healer"
    end
    if tank then
        rolestring1 = "Tank"
    end

    -- Get appropriate 2nd string for role
    if dps and not (healer or tank) then
        message = (zo_strformat("<<1>>", rolestring3) )
    elseif healer and not (dps or tank) then
        message = (zo_strformat("<<1>>", rolestring2) )
    elseif tank and not (dps or healer) then
        message = (zo_strformat("<<1>>", rolestring1) )
    elseif dps and healer and not tank then
        message = (zo_strformat("<<1>>, <<2>>", rolestring2, rolestring3) )
    elseif dps and tank and not healer then
        message = (zo_strformat("<<1>>, <<2>>", rolestring1, rolestring3) )
    elseif healer and tank and not dps then
        message = (zo_strformat("<<1>>, <<2>>", rolestring1, rolestring2) )
    elseif dps and healer and tank then
        message = (zo_strformat("<<1>>, <<2>>, <<3>>", rolestring1, rolestring2, rolestring3) )
    end

    if updatedRoleName ~= LUIE.PlayerNameFormatted then
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has updated their role: <<2>>", displayNameLink, message) )
        end
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has updated their role: <<2>>", characterNameLink, message) )
        end
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has updated their role: <<2>>", displayBoth, message) )
        end
    else
        printToChat(zo_strformat("You have updated your role: <<1>>", message) )
    end
end
]]--

--[[ Would love to be able to use this function but its too buggy for now. When a single player disconnects for the first time in the group, another player will see a message for the online/offline status of every other
player in the group. Possibly reimplement and limit it to 2 player groups?
No localization support yet.
function ChatAnnouncements.GMCS(eventCode, unitTag, isOnline)

    local onlineRoleName = GetUnitName(unitTag)
    local onlineRoleDisplayName = GetUnitDisplayName(unitTag)

    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(onlineRoleName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(onlineRoleDisplayName)
    local displayBothString = ( zo_strformat("<<1>><<2>>", onlineRoleName, onlineRoleDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, onlineRoleDisplayName)


    if not isOnline and onlineRoleName ~=LUIE.PlayerNameFormatted then
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has disconnected.", displayNameLink) )
        end
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has disconnected.", characterNameLink) )
        end
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has disconnected.", displayBoth) )
        end
    elseif isOnline and onlineRoleName ~=LUIE.PlayerNameFormatted then
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has reconnected.", displayNameLink) )
        end
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has reconnected.", characterNameLink) )
        end
        if ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(zo_strformat("|cFEFEFE<<1>>|r has reconnected.", displayBoth) )
        end
    end
end
]]--

local RESPEC_TYPE_CHAMPION = 1
local RESPEC_TYPE_ATTRIBUTES = 2
local RESPEC_TYPE_SKILLS = 3
local RESPEC_TYPE_MORPHS = 4

local LUIE_AttributeDisplayType = {
    [RESPEC_TYPE_CHAMPION] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_CHAMPION),
    [RESPEC_TYPE_ATTRIBUTES] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES),
    [RESPEC_TYPE_SKILLS] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS),
    [RESPEC_TYPE_MORPHS] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_MORPHS),
}

function ChatAnnouncements.PointRespecDisplay(respecType)
    local message = LUIE_AttributeDisplayType[respecType] .. "."
    local messageCSA = LUIE_AttributeDisplayType[respecType]

    if ChatAnnouncements.SV.Notify.NotificationRespecCA then
        printToChat(message, true)
    end

    if ChatAnnouncements.SV.Notify.NotificationRespecCSA then
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
        messageParams:SetText(messageCSA)
        messageParams:SetSound(SOUNDS.DISPLAY_ANNOUNCEMENT)
        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
    end

    if ChatAnnouncements.SV.Notify.NotificationRespecAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
    end
end

function ChatAnnouncements.OnCurrencyUpdate(eventCode, currency, currencyLocation, newValue, oldValue, reason)
    if (currencyLocation ~= CURRENCY_LOCATION_CHARACTER and currencyLocation ~= CURRENCY_LOCATION_ACCOUNT) then
        return
    end

    local UpOrDown = newValue - oldValue

    --[[ DEBUG
    d("currency: " .. currency)
    d("NV: " .. newValue)
    d("OV: " .. oldValue)
    d("reason: " .. reason)
    ]]

    -- If the total gold change was 0 or (Reason 7 = Command) or (Reason 28 = Mount Feed) or (Reason 35 = Player Init) - End Now
    if UpOrDown == 0 or UpOrDown + g_postageAmount == 0 or UpOrDown - g_postageAmount == 0 or reason == 7 or reason == 28 or reason == 35 then
        return
    end

    local formattedValue = ZO_LocalizeDecimalNumber(newValue)
    local changeColor                                                   -- Gets the value from CurrencyUpColorize or CurrencyDownColorize to color strings
    local changeType                                                    -- Amount of currency gained or lost
    local currencyTypeColor                                             -- Determines color to use for colorization of currency based off currency type.
    local currencyIcon                                                  -- Determines icon to use for currency based off currency type.
    local currencyName                                                  -- Determines name to use for currency based off type.
    local currencyTotal                                                 -- Determines if the total should be displayed based off type.
    local messageChange                                                 -- Set to a string value based on the reason code.
    local messageTotal                                                  -- Set to a string value based on the currency type.
    local type

    if currency == CURT_MONEY then -- Gold
        -- Send change info to the throttle printer and end function now if we throttle gold from loot.
        if not ChatAnnouncements.SV.Currency.CurrencyGoldChange then return end
        if ChatAnnouncements.SV.Currency.CurrencyGoldThrottle and (reason == 0 or reason == 13) then
            -- NOTE: Unlike other throttle events, we used zo_callLater here because we have to make the call immediately
            --(if some of the gold is looted after items, the message will appear after the loot if we don't use zo_callLater instead of a RegisterForUpdate)
            zo_callLater( ChatAnnouncements.CurrencyGoldThrottlePrinter, 50 )
            g_currencyGoldThrottleValue = g_currencyGoldThrottleValue + UpOrDown
            g_currencyGoldThrottleTotal = GetCarriedCurrencyAmount(1)
            return
        end

        -- If looted gold is below the filter value, end now.
        if ChatAnnouncements.SV.Currency.CurrencyGoldFilter > 0 and (reason == 0 or reason == 13) then
            if UpOrDown < ChatAnnouncements.SV.Currency.CurrencyGoldFilter then
                return
            end
        end

        currencyTypeColor = CurrencyGoldColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyGoldName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalGold

    elseif currency == CURT_ALLIANCE_POINTS then -- Alliance Points
        if not ChatAnnouncements.SV.Currency.CurrencyAPShowChange then return end
        -- Send change info to the throttle printer and end function now if we throttle Alliance Points Gained
        if ChatAnnouncements.SV.Currency.CurrencyAPThrottle > 0 and (reason == 13 or reason == 40 or reason == 41) then
            eventManager:UnregisterForUpdate(moduleName .. "BufferedAP")
            eventManager:RegisterForUpdate(moduleName .. "BufferedAP", ChatAnnouncements.SV.Currency.CurrencyAPThrottle, ChatAnnouncements.CurrencyAPThrottlePrinter )
            g_currencyAPThrottleValue = g_currencyAPThrottleValue + UpOrDown
            g_currencyAPThrottleTotal = GetCarriedCurrencyAmount(2)
            return
        end

        -- If earned AP is below the filter value, end now.
        if ChatAnnouncements.SV.Currency.CurrencyAPFilter > 0 and (reason == 13 or reason == 40 or reason == 41) then
            if UpOrDown < ChatAnnouncements.SV.Currency.CurrencyAPFilter then
                return
            end
        end

        -- Immediately print value if another source of AP is gained (or spent)
        if ChatAnnouncements.SV.Currency.CurrencyAPThrottle > 0 and (reason ~= 13 and reason ~= 40 and reason ~= 41) then
            ChatAnnouncements.CurrencyAPThrottlePrinter()
        end

        currencyTypeColor = CurrencyAPColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/alliancepoints.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyAPName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyAPShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalAP

    elseif currency == CURT_TELVAR_STONES then -- TelVar Stones
        if not ChatAnnouncements.SV.Currency.CurrencyTVChange then return end
        -- Send change info to the throttle printer and end function now if we throttle Tel Var Gained
        if ChatAnnouncements.SV.Currency.CurrencyTVThrottle > 0 and (reason == 0 or reason == 65) then
            eventManager:UnregisterForUpdate(moduleName .. "BufferedTV")
            eventManager:RegisterForUpdate(moduleName .. "BufferedTV", ChatAnnouncements.SV.Currency.CurrencyTVThrottle, ChatAnnouncements.CurrencyTVThrottlePrinter )
            g_currencyTVThrottleValue = g_currencyTVThrottleValue + UpOrDown
            g_currencyTVThrottleTotal = GetCarriedCurrencyAmount(3)
            return
        end

        -- If earned Tel Var is below the filter value, end now.
        if ChatAnnouncements.SV.Currency.CurrencyTVFilter > 0 and (reason == 0 or reason == 65) then
            if UpOrDown < ChatAnnouncements.SV.Currency.CurrencyTVFilter then
                return
            end
        end

        -- Immediately print value if another source of TV is gained or lost
        if ChatAnnouncements.SV.Currency.CurrencyTVThrottle > 0 and (reason ~= 0 and reason ~= 65) then
            ChatAnnouncements.CurrencyTVThrottlePrinter()
        end

        currencyTypeColor = CurrencyTVColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_telvar.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyTVName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyTVShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalTV

    elseif currency == CURT_WRIT_VOUCHERS then -- Writ Vouchers
        if not ChatAnnouncements.SV.Currency.CurrencyWVChange then return end
        currencyTypeColor = CurrencyWVColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_writvoucher.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyWVName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyWVShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalWV
    elseif currency == CURT_STYLE_STONES then -- Outfit Tokens
        if not ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange then return end
        currencyTypeColor = CurrencyOutfitTokenColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/token_clothing_16.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyOutfitTokenName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyOutfitTokenShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalOutfitToken
    elseif currency == CURT_CHAOTIC_CREATIA then -- Transmute Crystals
        if not ChatAnnouncements.SV.Currency.CurrencyTransmuteChange then return end
        currencyTypeColor = CurrencyTransmuteColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_seedcrystal_16.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyTransmuteName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyTransmuteShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalTransmute
    elseif currency == CURT_EVENT_TICKETS then -- Event Tickets
        if not ChatAnnouncements.SV.Currency.CurrencyEventChange then return end
        currencyTypeColor = CurrencyEventColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_eventticket.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyEventName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyEventShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalEvent
    elseif currency == CURT_UNDAUNTED_KEYS then -- Undaunted Keys
        if not ChatAnnouncements.SV.Currency.CurrencyUndauntedChange then return end
        currencyTypeColor = CurrencyUndauntedColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/undauntedkey.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyUndauntedName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyUndauntedShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalUndaunted
    elseif currency == CURT_CROWNS then -- Crowns
        if not ChatAnnouncements.SV.Currency.CurrencyCrownsChange then return end
        currencyTypeColor = CurrencyCrownsColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_crown.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyCrownsName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyCrownsShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalCrowns
    elseif currency == CURT_CROWN_GEMS then -- Crown Gems
        if not ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange then return end
        currencyTypeColor = CurrencyCrownGemsColorize:ToHex()
        currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_crown_gems.dds|t" or ""
        currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyCrownGemsName, UpOrDown)
        currencyTotal = ChatAnnouncements.SV.Currency.CurrencyCrownGemsShowTotal
        messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalCrownGems
    else -- If for some reason there is no currency type, end the function now
        return
    end

    -- Did we gain or lose currency
    if UpOrDown > 0 then
        if ChatAnnouncements.SV.Currency.CurrencyContextColor then
            changeColor = CurrencyUpColorize:ToHex()
        else
            changeColor = CurrencyColorize:ToHex()
        end
        changeType = ZO_LocalizeDecimalNumber(newValue - oldValue + g_postageAmount)
    elseif UpOrDown < 0 then
        if ChatAnnouncements.SV.Currency.CurrencyContextColor then
            changeColor = CurrencyDownColorize:ToHex()
        else
            changeColor = CurrencyColorize:ToHex()
        end
        changeType = ZO_LocalizeDecimalNumber(oldValue - newValue - g_postageAmount)
    end

    -- Determine syntax based on reason
    -- Sell/Buy from a Merchant
    if reason == 1 and UpOrDown > 0 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
        if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    elseif reason == 1 and UpOrDown < 0 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
        if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Mail (2)
    elseif reason == 2 and UpOrDown > 0  then
        messageChange = g_mailTarget ~="" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailIn or ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailInNoName
        if g_mailTarget ~="" then type = "LUIE_CURRENCY_MAIL" end
    elseif reason == 2 and UpOrDown < 0  then
        if g_mailCODPresent then
            messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailCOD
        else
            messageChange = g_mailTarget ~="" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOut or ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOutNoName
        end
        if g_mailTarget ~="" then type = "LUIE_CURRENCY_MAIL" end
    -- Buyback (64)
    elseif reason == 64 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
        if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Receive/Give Money in a Trade (Likely consolidate this later)
    elseif reason == 3 and UpOrDown > 0 then
        messageChange = g_tradeTarget ~="" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeIn or ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeInNoName
        if g_tradeTarget ~="" then type = "LUIE_CURRENCY_TRADE" end
    elseif reason == 3 and UpOrDown < 0 then
        messageChange = g_tradeTarget ~="" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOut or ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOutNoName
        if g_tradeTarget ~="" then type = "LUIE_CURRENCY_TRADE" end
    -- Receive from Quest Reward (4), Medal (21), AH Refund (32), Jump Failure Refund (54)
    elseif reason == 4 or reason == 21 or reason == 32 or reason == 54 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
    -- Sell to Fence (63)
    elseif reason == 63 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
        if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Bag Space (8)
    elseif reason == 8 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageStorage
        type = "LUIE_CURRENCY_BAG"
    -- Bank Space (9)
    elseif reason == 9 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageStorage
        type = "LUIE_CURRENCY_BANK"
    -- Spend - NPC Conversation (5)
    elseif reason == 5 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessagePay
    -- Edit Guild Heraldry (49), Buy Guild Tabard (50)
    elseif reason == 49 or reason == 50 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
    -- Battleground (12)
    elseif reason == 12 and UpOrDown < 0 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCampaign
    elseif reason == 12 and UpOrDown > 0 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
    -- Wayshrine (19)
    elseif reason == 19 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageWayshrine
    -- Craft (24)
    elseif reason == 24 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse
    -- Repairs (29)
    elseif reason == 29 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageRepair
    -- Listing Fee (33)
    elseif reason == 33 then
        if ChatAnnouncements.SV.Currency.CurrencyGoldHideListingAH then return end
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageListing
    -- Respec Skills (44)
    elseif reason == 44 then
        ChatAnnouncements.PointRespecDisplay(RESPEC_TYPE_SKILLS)
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSkills
    -- Respec Attributes (45)
    elseif reason == 45 then
        ChatAnnouncements.PointRespecDisplay(RESPEC_TYPE_ATTRIBUTES)
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageAttributes
    -- Unstuck (48)
    elseif reason == 48 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUnstuck
    -- Respec Morphs (55)
    elseif reason == 55 then
        ChatAnnouncements.PointRespecDisplay(RESPEC_TYPE_MORPHS)
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageMorphs
    -- Pay Fence (56)
    elseif reason == 56 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageBounty
    -- Champion Point Respec (61)
    elseif reason == 61 then
        ChatAnnouncements.PointRespecDisplay(RESPEC_TYPE_CHAMPION)
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageChampion
    --  Launder (60)
    elseif reason == 60 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
        if not ChatAnnouncements.SV.Inventory.LootVendorCurrency then
            messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
        else
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Keep Reward (14), Keep Repair (40), PVP Resurrect (41), Defensive Keep Reward (75)
elseif reason == 14 or reason == 40 or reason == 41 or reason == 75 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageEarn
    -- Reward (27)
    elseif reason == 27 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
    -- Buy on AH (31)
    elseif reason == 31 then
        if ChatAnnouncements.SV.Currency.CurrencyGoldHideAH then return end
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
    -- Deposit in Bank (42)
    elseif reason == 42 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
    -- Deposit in Guild Bank (51)
    elseif reason == 51 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositGuild
    -- Withdraw from Bank (43)
    elseif reason == 43 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdraw
    -- Withdraw from Guild Bank (52)
    elseif reason == 52 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawGuild
    -- Confiscated -- Pay to Guard (47), Killed by Guard (57)
    elseif reason == 47 or reason == 57 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageConfiscate
        zo_callLater(ChatAnnouncements.JusticeDisplayConfiscate, 50)
    -- Pickpocketed (59)
    elseif reason == 59 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessagePickpocket
    -- Looted - From Chest (0), Looted from Player/NPC (65)
    elseif reason == 0 or reason == 65 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
    -- Looted - Stolen Gold (62)
    elseif reason == 62 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSteal
    -- Looted (13)
    elseif reason == 13 then
        if currency == CURT_ALLIANCE_POINTS then
            messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageEarn
        else
            messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
        end
    -- Died to Player/NPC (67)
    elseif reason == 67 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLost
    -- Crown Crate Duplicate (69), Item Converted To Gems (70), Crowns Purchased (73)
    elseif reason == 69 or reason == 70 or reason == 73 then
        messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
    -- Purchased with Gems (71), Purchased with Crowns (72)
    elseif reason == 71 or reason == 72 then
        if currency == CURT_STYLE_STONES or currency == CURT_EVENT_TICKETS then
            messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
        else
            messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend
        end

    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    elseif reason == 6 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 15 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason) -- Keep Upgrade
    elseif reason == 16 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 18 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 20 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 22 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 23 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 25 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 26 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 30 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 34 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 36 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 37 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 38 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 39 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 46 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 53 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 58 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 66 then messageChange = zo_strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    -- END DEBUG EVENTS
    -- ==============================================================================
    -- If none of these returned true, then we must have just looted the gold (Potentially a few currency change events I missed too may have to adjust later)
    else messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot end

    -- Send relevant values over to the currency printer
    ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
end

-- Printer function receives values from currency update or from other functions that display currency updates.
-- Type here refers to an LUIE_CURRENCY_TYPE
function ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type, carriedItem, carriedItemTotal)
    local messageP1  -- First part of message - Change
    local messageP2  -- Second part of the message (if enabled) - Total

    messageP1 = ("|r|c" .. currencyTypeColor .. currencyIcon .. " " .. changeType .. currencyName .. "|r|c" .. changeColor)

    if (currencyTotal and type ~= "LUIE_CURRENCY_HERALDRY") or (type == "LUIE_CURRENCY_VENDOR" and ChatAnnouncements.SV.Inventory.LootVendorTotalCurrency) then
        messageP2 = ("|r|c" .. currencyTypeColor .. currencyIcon .. " " .. formattedValue .. "|r|c" .. changeColor)
    else
        messageP2 = "|r"
    end

    local formattedMessageP1
    if type == "LUIE_CURRENCY_BAG" or type == "LUIE_CURRENCY_BANK" then
        local function ResolveStorageType()
            local bagType
            local icon
            if type == "LUIE_CURRENCY_BAG" then
                bagType = string.format(linkBracket1[ChatAnnouncements.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_BAGTYPE1) .. linkBracket2[ChatAnnouncements.SV.BracketOptionItem])
                icon = ChatAnnouncements.SV.Inventory.LootIcons and "|t16:16:/esoui/art/icons/store_upgrade_bag.dds|t " or ""
            end
            if type == "LUIE_CURRENCY_BANK" then
                bagType = string.format(linkBracket1[ChatAnnouncements.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_BAGTYPE2) .. linkBracket2[ChatAnnouncements.SV.BracketOptionItem])
                icon = ChatAnnouncements.SV.Inventory.LootIcons and "|t16:16:/esoui/art/icons/store_upgrade_bank.dds|t " or ""
            end
            return string.format("|r" .. icon .. "|cFFFFFF" .. bagType .. "|r|c" .. changeColor)
        end
        formattedMessageP1 = (string.format(messageChange, ResolveStorageType(), messageP1))
    elseif type == "LUIE_CURRENCY_HERALDRY" then
        local icon = ChatAnnouncements.SV.Inventory.LootIcons and "|t16:16:LuiExtended/media/unitframes/ca_heraldry.dds|t " or ""
        local heraldryMessage = string.format("|r" .. icon .. "|cFFFFFF" .. linkBracket1[ChatAnnouncements.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_CURRENCY_NAME_HERALDRY) .. linkBracket2[ChatAnnouncements.SV.BracketOptionItem] .. "|r|c" .. changeColor)
        formattedMessageP1 = (string.format(messageChange, messageP1, heraldryMessage))
    elseif type == "LUIE_CURRENCY_RIDING_SPEED" or type == "LUIE_CURRENCY_RIDING_CAPACITY" or type == "LUIE_CURRENCY_RIDING_STAMINA" then
        local function ResolveRidingStats()
            -- if somevar then icon = else no
            local skillType
            local icon
            if type == "LUIE_CURRENCY_RIDING_SPEED" then
                skillType = string.format(linkBracket1[ChatAnnouncements.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE1) .. linkBracket2[ChatAnnouncements.SV.BracketOptionItem])
                icon = ChatAnnouncements.SV.Inventory.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_speed.dds|t " or ""
            elseif type == "LUIE_CURRENCY_RIDING_CAPACITY" then
                skillType = string.format(linkBracket1[ChatAnnouncements.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE2) .. linkBracket2[ChatAnnouncements.SV.BracketOptionItem])
                icon = ChatAnnouncements.SV.Inventory.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_capacity.dds|t " or ""
            elseif type == "LUIE_CURRENCY_RIDING_STAMINA" then
                skillType = string.format(linkBracket1[ChatAnnouncements.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE3) .. linkBracket2[ChatAnnouncements.SV.BracketOptionItem])
                icon = ChatAnnouncements.SV.Inventory.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_stamina.dds|t " or ""
            end
            return string.format("|r" .. icon .. "|cFFFFFF" .. skillType .. "|r|c" .. changeColor)
        end
        formattedMessageP1 = (string.format(messageChange, ResolveRidingStats(), messageP1))

    elseif type == "LUIE_CURRENCY_VENDOR" then
        item = string.format("|r" .. carriedItem .. "|c" .. changeColor)
        formattedMessageP1 = (string.format(messageChange, item, messageP1))
    elseif type == "LUIE_CURRENCY_TRADE" then
        name = string.format("|r" .. g_tradeTarget .. "|c" .. changeColor)
        formattedMessageP1 = (string.format(messageChange, messageP1, name))
    elseif type == "LUIE_CURRENCY_MAIL" then
        name = string.format("|r" .. g_mailTarget .. "|c" .. changeColor)
        formattedMessageP1 = (string.format(messageChange, messageP1, name))
    else
        formattedMessageP1 = (string.format(messageChange, messageP1))
    end
    local formattedMessageP2 = (currencyTotal or (type == "LUIE_CURRENCY_VENDOR" and ChatAnnouncements.SV.Inventory.LootVendorTotalCurrency)) and (string.format(messageTotal, messageP2)) or messageP2
    local finalMessage
    if currencyTotal and type ~= "LUIE_CURRENCY_HERALDRY" and type ~= "LUIE_CURRENCY_VENDOR" and type ~= "LUIE_CURRENCY_POSTAGE" or (type == "LUIE_CURRENCY_VENDOR" and ChatAnnouncements.SV.Inventory.LootVendorTotalCurrency) then
        if type == "LUIE_CURRENCY_VENDOR" then
            finalMessage = string.format("|c%s%s|r%s |c%s%s|r", changeColor, formattedMessageP1, carriedItemTotal, changeColor, formattedMessageP2)
        else
            finalMessage = string.format("|c%s%s|r |c%s%s|r", changeColor, formattedMessageP1, changeColor, formattedMessageP2)
        end
    else
        if type == "LUIE_CURRENCY_VENDOR" then
            finalMessage = string.format("|c%s%s|r%s", changeColor, formattedMessageP1, carriedItemTotal)
        else
            finalMessage = string.format("|c%s%s|r", changeColor, formattedMessageP1)
        end
    end

    -- If this value is being sent from the Throttle Printer, do not throttle the printout of the value
    if type == "LUIE_CURRENCY_THROTTLE" then
        printToChat(finalMessage)
    -- Otherwise sent to our Print Queued Messages function to be processed on a 50 ms delay.
    else
        local resolveType = type == "LUIE_CURRENCY_POSTAGE" and "CURRENCY POSTAGE" or "CURRENCY"
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = resolveType }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
    end
end

function ChatAnnouncements.CurrencyGoldThrottlePrinter()
    if g_currencyGoldThrottleValue > 0 and g_currencyGoldThrottleValue > ChatAnnouncements.SV.Currency.CurrencyGoldFilter then
        local formattedValue = ZO_LocalizeDecimalNumber(GetCarriedCurrencyAmount(1))
        local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyGoldThrottleValue)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        local currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyGoldName, g_currencyGoldThrottleValue)
        local currencyTotal = ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal
        local messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalGold
        local messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
        local type = "LUIE_CURRENCY_THROTTLE"
        ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    g_currencyGoldThrottleValue = 0
    g_currencyGoldThrottleTotal = 0
end

function ChatAnnouncements.CurrencyAPThrottlePrinter()
    if g_currencyAPThrottleValue > 0 and g_currencyAPThrottleValue > ChatAnnouncements.SV.Currency.CurrencyAPFilter then
        local formattedValue = ZO_LocalizeDecimalNumber(g_currencyAPThrottleTotal)
        local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyAPThrottleValue)
        local currencyTypeColor = CurrencyAPColorize:ToHex()
        local currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/alliancepoints.dds|t" or ""
        local currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyAPName, g_currencyAPThrottleValue)
        local currencyTotal = ChatAnnouncements.SV.Currency.CurrencyAPShowTotal
        local messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalAP
        local messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageEarn
        local type = "LUIE_CURRENCY_THROTTLE"
        ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    eventManager:UnregisterForUpdate(moduleName .. "BufferedAP")
    g_currencyAPThrottleValue = 0
    g_currencyAPThrottleTotal = 0
end

function ChatAnnouncements.CurrencyTVThrottlePrinter()
    if g_currencyTVThrottleValue > 0 and g_currencyTVThrottleValue > ChatAnnouncements.SV.Currency.CurrencyTVFilter then
        local formattedValue = ZO_LocalizeDecimalNumber(g_currencyTVThrottleTotal)
        local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyTVThrottleValue)
        local currencyTypeColor = CurrencyTVColorize:ToHex()
        local currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_telvar.dds|t" or ""
        local currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyTVName, g_currencyTVThrottleValue)
        local currencyTotal = ChatAnnouncements.SV.Currency.CurrencyTVShowTotal
        local messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalTV
        local messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
        local type = "LUIE_CURRENCY_THROTTLE"
        ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    eventManager:UnregisterForUpdate(moduleName .. "BufferedTV")
    g_currencyTVThrottleValue = 0
    g_currencyTVThrottleTotal = 0
end

function ChatAnnouncements.MiscAlertLockBroke(eventCode, inactivityLengthMs)
    g_lockpickBroken = true
    zo_callLater (function() g_lockpickBroken = false end, 200)
end

function ChatAnnouncements.MiscAlertLockSuccess(eventCode)
    if ChatAnnouncements.SV.Notify.NotificationLockpickCA then
        local message = GetString(SI_LUIE_CA_LOCKPICK_SUCCESS)
        g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "NOTIFICATION" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )

    end
    if ChatAnnouncements.SV.Notify.NotificationLockpickAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_LOCKPICK_SUCCESS))
    end
    g_lockpickBroken = true
    zo_callLater (function() g_lockpickBroken = false end, 200)
end

function ChatAnnouncements.StorageBag(eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
    if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
        if ChatAnnouncements.SV.Notify.StorageBagCA then
            local formattedString = StorageBagColorize:Colorize(zo_strformat(SI_INVENTORY_BAG_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "MESSAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        if ChatAnnouncements.SV.Notify.StorageBagAlert then
            local text = zo_strformat(SI_LUIE_CA_STORAGE_BAG_UPGRADE)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
    end
end

function ChatAnnouncements.StorageBank(eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
    if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
        if ChatAnnouncements.SV.Notify.StorageBagCA then
            local formattedString = StorageBagColorize:Colorize(zo_strformat(SI_INVENTORY_BANK_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "MESSAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        if ChatAnnouncements.SV.Notify.StorageBagAlert then
            local text = zo_strformat(SI_LUIE_CA_STORAGE_BANK_UPGRADE)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
    end
end

function ChatAnnouncements.OnBuybackItem(eventCode, itemName, quantity, money, itemSound)
    local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    local icon = itemIcon
    local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
    local type = "LUIE_CURRENCY_VENDOR"
    local messageChange = (money ~= 0 and ChatAnnouncements.SV.Inventory.LootVendorCurrency) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuyback or ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuybackNoV
    local itemCount = quantity > 1 and (" |cFFFFFFx" .. quantity .. "|r") or ""
    local carriedItem
    if ChatAnnouncements.SV.BracketOptionItem == 1 then
        carriedItem = ( formattedIcon .. itemName ..  itemCount )
    else
        carriedItem = ( formattedIcon .. itemName:gsub("^|H0", "|H1", 1) ..  itemCount )
    end

    local carriedItemTotal = ""
    if ChatAnnouncements.SV.Inventory.LootVendorTotalItems then
        local total1, total2, total3 = GetItemLinkStacks(itemName)
        local total = total1 + total2 + total3
        if total > 1 then
            carriedItemTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end

    if money ~= 0 and ChatAnnouncements.SV.Inventory.LootVendorCurrency then
        -- Stop messages from printing if for some reason the currency event never triggers
        if g_savedPurchase.formattedValue then
            ChatAnnouncements.CurrencyPrinter(g_savedPurchase.formattedValue, changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, messageChange, g_savedPurchase.messageTotal, type, carriedItem, carriedItemTotal)
        end
    else
        local finalMessageP1 = string.format(carriedItem .. "|r|c" .. changeColor)
        local finalMessageP2 = string.format(messageChange, finalMessageP1)
        local finalMessage = string.format("|c%s%s|r%s", changeColor, finalMessageP2, carriedItemTotal)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
    end
    g_savedPurchase = { }
end

isCollectibleHorse = {
    [GetCollectibleInfo(3)] = 3,
    [GetCollectibleInfo(4)] = 4,
    [GetCollectibleInfo(5)] = 5,
}

function ChatAnnouncements.OnBuyItem(eventCode, itemName, entryType, quantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
    local itemIcon
    if isCollectibleHorse[itemName] then
        local id = isCollectibleHorse[itemName]
        itemName = GetCollectibleLink(id, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        _, _, itemIcon = GetCollectibleInfo(id)
    else
        itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    end

    local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
    local icon = itemIcon
    local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
    local type = "LUIE_CURRENCY_VENDOR"
    local messageChange = ( (money ~= 0 or specialCurrencyQuantity1 ~= 0 or specialCurrencyQuantity2 ~= 0) and ChatAnnouncements.SV.Inventory.LootVendorCurrency) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuy or ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuyNoV
    local itemCount = quantity > 1 and (" |cFFFFFFx" .. quantity .. "|r") or ""
    local carriedItem
    if ChatAnnouncements.SV.BracketOptionItem == 1 then
        carriedItem = ( formattedIcon .. itemName ..  itemCount )
    else
        carriedItem = ( formattedIcon .. itemName:gsub("^|H0", "|H1", 1) ..  itemCount )
    end

    local carriedItemTotal = ""
    if ChatAnnouncements.SV.Inventory.LootVendorTotalItems then
        local total1, total2, total3 = GetItemLinkStacks(itemName)
        local total = total1 + total2 + total3
        if total > 1 then
            carriedItemTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end

    if (money ~= 0 or specialCurrencyQuantity1 ~= 0 or specialCurrencyQuantity2 ~= 0) and ChatAnnouncements.SV.Inventory.LootVendorCurrency then
        -- Stop messages from printing if for some reason the currency event never triggers
        if g_savedPurchase.formattedValue then
            ChatAnnouncements.CurrencyPrinter(g_savedPurchase.formattedValue, changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, messageChange, g_savedPurchase.messageTotal, type, carriedItem, carriedItemTotal)
        end
    else
        local finalMessageP1 = string.format(carriedItem .. "|r|c" .. changeColor)
        local finalMessageP2 = string.format(messageChange, finalMessageP1)
        local finalMessage = string.format("|c%s%s|r%s", changeColor, finalMessageP2, carriedItemTotal)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
    end

    g_savedPurchase = { }
end

function ChatAnnouncements.OnSellItem(eventCode, itemName, quantity, money)
    local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    local icon = itemIcon
    local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
    local type = "LUIE_CURRENCY_VENDOR"
    local messageChange
    if g_weAreInAFence then
        messageChange = (money ~= 0 and ChatAnnouncements.SV.Inventory.LootVendorCurrency) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageFence or ChatAnnouncements.SV.ContextMessages.CurrencyMessageFenceNoV
    else
        messageChange = (money ~= 0 and ChatAnnouncements.SV.Inventory.LootVendorCurrency) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageSell or ChatAnnouncements.SV.ContextMessages.CurrencyMessageSellNoV
    end
    local itemCount = quantity > 1 and (" |cFFFFFFx" .. quantity .. "|r") or ""
    local carriedItem
    if ChatAnnouncements.SV.BracketOptionItem == 1 then
        carriedItem = ( formattedIcon .. itemName ..  itemCount )
    else
        carriedItem = ( formattedIcon .. itemName:gsub("^|H0", "|H1", 1) ..  itemCount )
    end

    local carriedItemTotal = ""
    if ChatAnnouncements.SV.Inventory.LootVendorTotalItems then
        local total1, total2, total3 = GetItemLinkStacks(itemName)
        local total = total1 + total2 + total3
        if total > 1 then
            carriedItemTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end

    if money ~= 0 and ChatAnnouncements.SV.Inventory.LootVendorCurrency then
        -- Stop messages from printing if for some reason the currency event never triggers
        if g_savedPurchase.formattedValue then
            ChatAnnouncements.CurrencyPrinter(g_savedPurchase.formattedValue, changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, messageChange, g_savedPurchase.messageTotal, type, carriedItem, carriedItemTotal)
        end
    else
        local finalMessageP1 = string.format(carriedItem .. "|r|c" .. changeColor)
        local finalMessageP2 = string.format(messageChange, finalMessageP1)
        local finalMessage = string.format("|c%s%s|r%s", changeColor, finalMessageP2, carriedItemTotal)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
    end
    g_savedPurchase = { }
end

function ChatAnnouncements.MailMoneyChanged(eventCode)
    g_mailCOD = 0
    g_postageAmount = GetQueuedMailPostage()
end

function ChatAnnouncements.MailCODChanged(eventCode)
    g_mailCOD = GetQueuedCOD()
    g_postageAmount = GetQueuedMailPostage()
end

function ChatAnnouncements.MailRemoved(eventCode)
    if ChatAnnouncements.SV.Notify.NotificationMailCA or ChatAnnouncements.SV.Notify.NotificationMailAlert then
        if ChatAnnouncements.SV.Notify.NotificationMailCA then
            local message = GetString(SI_LUIE_CA_MAIL_DELETED_MSG)
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "NOTIFICATION", isSystem = true }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_MAIL_DELETED_MSG))
        end
    end
end

function ChatAnnouncements.OnMailReadable(eventCode, mailId)
    local senderDisplayName, senderCharacterName, _, _, _, fromSystem, fromCustomerService, _, _, _, codAmount = GetMailItemInfo ( mailId )

    -- Use different color if the mail is from System (Hireling Mail, Rewards for the Worthy, etc)
    if fromSystem or fromCustomerService then
        g_mailTarget = ZO_GAME_REPRESENTATIVE_TEXT:Colorize(senderDisplayName)
    elseif senderDisplayName ~= "" and senderCharacterName ~= "" then
        local finalName = ChatAnnouncements.ResolveNameLink(senderCharacterName, senderDisplayName)
        g_mailTarget = ZO_SELECTED_TEXT:Colorize(finalName)
    else
        local finalName
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            finalName = ZO_LinkHandler_CreateLinkWithoutBrackets(senderDisplayName, nil, DISPLAY_NAME_LINK_TYPE, senderDisplayName)
        else
            finalName = ZO_LinkHandler_CreateLink(senderDisplayName, nil, DISPLAY_NAME_LINK_TYPE, senderDisplayName)
        end
        g_mailTarget = ZO_SELECTED_TEXT:Colorize(finalName)
    end

    if codAmount > 0 then
        g_mailCODPresent = true
    end
end

function ChatAnnouncements.OnMailTakeAttachedItem(eventCode, mailId)
    if ChatAnnouncements.SV.Notify.NotificationMailCA or ChatAnnouncements.SV.Notify.NotificationMailAlert then
        local mailString
        if g_mailCODPresent then
            mailString = GetString(SI_LUIE_CA_MAIL_RECEIVED_COD)
        else
            mailString = GetString(SI_LUIE_CA_MAIL_RECEIVED)
        end
        if mailString then
            if ChatAnnouncements.SV.Notify.NotificationMailCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = mailString, type = "NOTIFICATION", isSystem = true }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end
            if ChatAnnouncements.SV.Notify.NotificationMailAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, mailString)
            end
        end
    end
end

function ChatAnnouncements.OnMailAttach(eventCode, attachmentSlot)
    g_postageAmount = GetQueuedMailPostage()
    local mailIndex = attachmentSlot
    local bagId, slotId, icon, stack = GetQueuedItemAttachmentInfo(attachmentSlot)
    local itemId = GetItemId(bagId, slotId)
    local itemLink = GetMailQueuedAttachmentLink(attachmentSlot, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
    local itemType = GetItemLinkItemType(itemLink)
    g_mailStacksOut[mailIndex] = {icon = icon, stack = stack, itemId = itemId, itemLink = itemLink, itemType = itemType}
end

-- Removes items from index if they are removed from the trade
function ChatAnnouncements.OnMailAttachRemove(eventCode, attachmentSlot)
    g_postageAmount = GetQueuedMailPostage()
    local mailIndex = attachmentSlot
    g_mailStacksOut[mailIndex] = nil
end

function ChatAnnouncements.OnMailOpenBox(eventCode)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.LootMail then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
        g_inventoryStacks = {}
        ChatAnnouncements.IndexInventory() -- Index Inventory
    end
    g_inMail = true
end

function ChatAnnouncements.OnMailCloseBox(eventCode)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
    end
    if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_inMail = false
    g_mailStacksOut = {}
end

-- Sends results of the trade to the Item Log print function and clears variables so they are reset for next trade interactions
function ChatAnnouncements.OnMailSuccess(eventCode)
    if g_postageAmount > 0 then
        local type = "LUIE_CURRENCY_POSTAGE"
        local formattedValue = ZO_LocalizeDecimalNumber(GetCarriedCurrencyAmount(1))
        local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_postageAmount)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        local currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyGoldName, g_postageAmount)
        local currencyTotal = ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal
        local messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalGold
        local messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessagePostage
        ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end

    if ChatAnnouncements.SV.Notify.NotificationMailCA or ChatAnnouncements.SV.Notify.NotificationMailAlert then
        local mailString
        if not g_mailCODPresent then
            if g_mailCOD > 1 then
                mailString = GetString(SI_LUIE_CA_MAIL_SENT_COD)
            else
                mailString = GetString(SI_LUIE_CA_MAIL_SENT)
            end
        end
        if mailString then
            if ChatAnnouncements.SV.Notify.NotificationMailCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = mailString, type = "NOTIFICATION", isSystem = true }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end
            if ChatAnnouncements.SV.Notify.NotificationMailAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, mailString)
            end
        end
    end

    if ChatAnnouncements.SV.Inventory.LootMail then
        for mailIndex = 1,6 do -- Have to iterate through all 6 possible mail attachments, otherwise nil values will bump later items off the list potentially.
            if g_mailStacksOut[mailIndex] ~= nil then
                local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                local logPrefix = g_mailTarget ~= "" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOut or ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOutNoName
                local item = g_mailStacksOut[mailIndex]
                ChatAnnouncements.ItemPrinter(item.icon, item.stack, item.itemType, item.itemId, item.itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
            end
        end
    end

    g_mailCODPresent = false
    g_mailCOD = 0
    g_postageAmount = 0
    g_mailStacksOut = {}
end

function ChatAnnouncements.OnExperienceGain(eventCode, reason, level, previousExperience, currentExperience, championPoints)
    -- d("Experience Gain) previousExperience: " .. previousExperience .. " --- " .. "currentExperience: " .. currentExperience)
    if ChatAnnouncements.SV.XP.Experience and ( not ( ChatAnnouncements.SV.XP.ExperienceHideCombat and reason == 0 ) or not reason == 0 ) then

        local change = currentExperience - previousExperience -- Change in Experience Points on gaining them

        -- If throttle is enabled, save value and end function here
        if ChatAnnouncements.SV.XP.ExperienceThrottle > 0 and reason == 0 then
            g_xpCombatBufferValue = g_xpCombatBufferValue + change
            -- We unregister the event, then re-register it, this keeps the buffer at a constant X throttle after XP is gained.
            eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
            eventManager:RegisterForUpdate(moduleName .. "BufferedXP", ChatAnnouncements.SV.XP.ExperienceThrottle, ChatAnnouncements.PrintBufferedXP )
            return
        end

        -- If filter is enabled and value is below filter then end function here
        if ChatAnnouncements.SV.XP.ExperienceFilter > 0 and reason == 0 then
            if change < ChatAnnouncements.SV.XP.ExperienceFilter then
                return
            end
        end

        -- If we gain experience from a non combat source, and our buffer function holds a value, then we need to immediately dump this value before the next XP update is processed.
        if ChatAnnouncements.SV.XP.ExperienceThrottle > 0 and g_xpCombatBufferValue > 0 and (reason ~= 0 and reason ~= 99) then
            eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
            ChatAnnouncements.PrintBufferedXP()
        end

        ChatAnnouncements.PrintExperienceGain(change)
    end
end

function ChatAnnouncements.PrintExperienceGain(change)
    local icon = ChatAnnouncements.SV.XP.ExperienceIcon and ("|t16:16:/esoui/art/icons/icon_experience.dds|t ") or ""
    local xpName = zo_strformat(ChatAnnouncements.SV.XP.ExperienceName, change)
    local messageP1 = ("|r|c" .. ExperienceNameColorize .. icon .. ZO_LocalizeDecimalNumber(change) .. " " .. xpName .. "|r|c" .. ExperienceMessageColorize)
    local formattedMessageP1 = (string.format(ChatAnnouncements.SV.XP.ExperienceMessage, messageP1))
    local finalMessage = string.format("|c%s%s|r", ExperienceMessageColorize, formattedMessageP1)

    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "EXPERIENCE" }
    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
end

function ChatAnnouncements.PrintBufferedXP()
    if g_xpCombatBufferValue > 0 and g_xpCombatBufferValue > ChatAnnouncements.SV.XP.ExperienceFilter then
        local change = g_xpCombatBufferValue
        ChatAnnouncements.PrintExperienceGain(change)
    end
    eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
    g_xpCombatBufferValue = 0
end

-- Helper function to return color (without |c prefix) according to current percentage
local function AchievementPctToColour(pct)
    return pct == 1 and "71DE73" or pct < 0.33 and "F27C7C" or pct < 0.66 and "EDE858" or "CCF048"
end

function ChatAnnouncements.OnAchievementUpdated(eventCode, id)
    local topLevelIndex, categoryIndex, achievementIndex = GetCategoryInfoFromAchievementId(id)

    -- Bail out if this achievement comes from unwanted category
    -- TODO: Make this less shit in the future
    if topLevelIndex == 1 and not ChatAnnouncements.SV.Achievement.AchievementCategory1 then return end
    if topLevelIndex == 2 and not ChatAnnouncements.SV.Achievement.AchievementCategory2 then return end
    if topLevelIndex == 3 and not ChatAnnouncements.SV.Achievement.AchievementCategory3 then return end
    if topLevelIndex == 4 and not ChatAnnouncements.SV.Achievement.AchievementCategory4 then return end
    if topLevelIndex == 5 and not ChatAnnouncements.SV.Achievement.AchievementCategory5 then return end
    if topLevelIndex == 6 and not ChatAnnouncements.SV.Achievement.AchievementCategory6 then return end
    if topLevelIndex == 7 and not ChatAnnouncements.SV.Achievement.AchievementCategory7 then return end
    if topLevelIndex == 8 and not ChatAnnouncements.SV.Achievement.AchievementCategory8 then return end
    if topLevelIndex == 9 and not ChatAnnouncements.SV.Achievement.AchievementCategory9 then return end
    if topLevelIndex == 10 and not ChatAnnouncements.SV.Achievement.AchievementCategory10 then return end
    if topLevelIndex == 11 and not ChatAnnouncements.SV.Achievement.AchievementCategory11 then return end
    if topLevelIndex == 12 and not ChatAnnouncements.SV.Achievement.AchievementCategory12 then return end
    if topLevelIndex == 13 and not ChatAnnouncements.SV.Achievement.AchievementCategory13 then return end
    if topLevelIndex == 14 and not ChatAnnouncements.SV.Achievement.AchievementCategory14 then return end
    if topLevelIndex == 15 and not ChatAnnouncements.SV.Achievement.AchievementCategory15 then return end
    if topLevelIndex == 16 and not ChatAnnouncements.SV.Achievement.AchievementCategory16 then return end
    if topLevelIndex == 17 and not ChatAnnouncements.SV.Achievement.AchievementCategory17 then return end
    if topLevelIndex == 18 and not ChatAnnouncements.SV.Achievement.AchievementCategory18 then return end
    if topLevelIndex == 19 and not ChatAnnouncements.SV.Achievement.AchievementCategory19 then return end
    if topLevelIndex == 20 and not ChatAnnouncements.SV.Achievement.AchievementCategory20 then return end
    if topLevelIndex == 21 and not ChatAnnouncements.SV.Achievement.AchievementCategory21 then return end
    if topLevelIndex == 22 and not ChatAnnouncements.SV.Achievement.AchievementCategory22 then return end
    if topLevelIndex == 23 and not ChatAnnouncements.SV.Achievement.AchievementCategory23 then return end
    if topLevelIndex == 24 and not ChatAnnouncements.SV.Achievement.AchievementCategory24 then return end
    if topLevelIndex == 25 and not ChatAnnouncements.SV.Achievement.AchievementCategory25 then return end
    if topLevelIndex == 25 and not ChatAnnouncements.SV.Achievement.AchievementCategory26 then return end

    if ChatAnnouncements.SV.Achievement.AchievementUpdateCA or ChatAnnouncements.SV.Achievement.AchievementUpdateAlert then
        local totalCmp = 0
        local totalReq = 0
        local showInfo = false

        local numCriteria = GetAchievementNumCriteria(id)
        local cmpInfo = {}
        for i = 1, numCriteria do
            local name, numCompleted, numRequired = GetAchievementCriterion(id, i)

            table.insert(cmpInfo, { zo_strformat(name), numCompleted, numRequired })

            -- Collect the numbers to calculate the correct percentage
            totalCmp = totalCmp + numCompleted
            totalReq = totalReq + numRequired

            -- Show the achievement on every special achievement because it's a rare event
            if numRequired == 1 and numCompleted == 1 then
                showInfo = true
            end
        end

        if not showInfo then
            -- Achievement completed
            -- This is the first numCompleted value
            -- Show every time
            if ( totalCmp == totalReq ) or ( totalCmp == 1 ) or ( ChatAnnouncements.SV.Achievement.AchievementStep == 0 ) then
                showInfo = true
            else
                -- Achievement step hit
                local percentage = math.floor( 100 / totalReq * totalCmp )

                if percentage > 0 and percentage % ChatAnnouncements.SV.Achievement.AchievementStep == 0 and g_achievementLastPercentage[id] ~= percentage then
                    showInfo = true
                    g_achievementLastPercentage[id] = percentage
                end
            end
        end

        -- Bail out here if this achievement update event is not going to be printed to chat
        if not showInfo then
            return
        end

        local link = zo_strformat(GetAchievementLink(id, linkBrackets[ChatAnnouncements.SV.BracketOptionAchievement]))
        local name = zo_strformat(GetAchievementNameFromLink(link))

        if ChatAnnouncements.SV.Achievement.AchievementUpdateCA then
            local catName = GetAchievementCategoryInfo(topLevelIndex)
            local subcatName = categoryIndex ~= nil and GetAchievementSubCategoryInfo(topLevelIndex, categoryIndex) or "General"
            local _, _, _, icon = GetAchievementInfo(id)
            icon = ChatAnnouncements.SV.Achievement.AchievementIcon and ("|t16:16:" .. icon .. "|t ") or ""

            local stringpart1 = AchievementColorize1:Colorize(string.format("%s%s%s %s%s", bracket1[ChatAnnouncements.SV.Achievement.AchievementBracketOptions], ChatAnnouncements.SV.Achievement.AchievementProgressMsg, bracket2[ChatAnnouncements.SV.Achievement.AchievementBracketOptions], icon, link))

            local stringpart2 = ChatAnnouncements.SV.Achievement.AchievementColorProgress and string.format(" %s|c%s%d%%|r", AchievementColorize2:Colorize("("), AchievementPctToColour(totalCmp/totalReq), math.floor(100*totalCmp/totalReq)) or AchievementColorize2:Colorize(string.format("%d%%", math.floor(100*totalCmp/totalReq)))

            local stringpart3
            if ChatAnnouncements.SV.Achievement.AchievementCategory and ChatAnnouncements.SV.Achievement.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(string.format(") %s%s - %s%s", bracket3[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions], catName, subcatName, bracket4[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions]))
            elseif ChatAnnouncements.SV.Achievement.AchievementCategory and not ChatAnnouncements.SV.Achievement.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(string.format(") %s%s%s", bracket3[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions], catName, bracket4[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions]))
            else
                stringpart3 = AchievementColorize2:Colorize(")")
            end

            -- Prepare details information
            local stringpart4 = ""
            if ChatAnnouncements.SV.Achievement.AchievementDetails then
                -- Skyshards needs separate treatment otherwise text become too long
                -- We also put this short information for achievements that has too many subitems
                if topLevelIndex == 9 or #cmpInfo > 12 then
                    stringpart4 = ChatAnnouncements.SV.Achievement.AchievementColorProgress and string.format( " %s|c%s%d|r%s|c71DE73%d|c87B7CC|r%s", AchievementColorize2:Colorize("("), AchievementPctToColour(totalCmp/totalReq), totalCmp, AchievementColorize2:Colorize("/"), totalReq, AchievementColorize2:Colorize(")") ) or AchievementColorize2:Colorize(string.format( " (%d/%d)", totalCmp, totalReq))
                else
                    for i = 1, #cmpInfo do
                        -- Boolean achievement stage
                        if cmpInfo[i][3] == 1 then
                            cmpInfo[i] = ChatAnnouncements.SV.Achievement.AchievementColorProgress and string.format( "|c%s%s", AchievementPctToColour(cmpInfo[i][2]), cmpInfo[i][1] ) or AchievementColorize2:Colorize(string.format( "%s%s", cmpInfo[i][2], cmpInfo[i][1] ))
                        -- Others
                        else
                            local pct = cmpInfo[i][2] / cmpInfo[i][3]
                            cmpInfo[i] = ChatAnnouncements.SV.Achievement.AchievementColorProgress and string.format( "%s %s|c%s%d|r%s|c71DE73%d|r%s", AchievementColorize2:Colorize(cmpInfo[i][1]), AchievementColorize2:Colorize("("), AchievementPctToColour(pct), cmpInfo[i][2], AchievementColorize2:Colorize("/"), cmpInfo[i][3], AchievementColorize2:Colorize(")") ) or AchievementColorize2:Colorize(string.format( "%s (%d/%d)", cmpInfo[i][1], cmpInfo[i][2], cmpInfo[i][3] ))
                        end
                    end
                    stringpart4 = " " .. table.concat(cmpInfo, AchievementColorize2:Colorize(", ")) .. ""
                end
            end
            local finalString = string.format("%s%s%s%s", stringpart1, stringpart2, stringpart3, stringpart4)
            g_queuedMessages[g_queuedMessagesCounter] = { message = finalString, type = "ACHIEVEMENT" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )

        end

        if ChatAnnouncements.SV.Achievement.AchievementUpdateAlert then
            local alertMessage = zo_strformat("<<1>>: <<2>>", ChatAnnouncements.SV.Achievement.AchievementProgressMsg, name)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
        end
    end
end

function ChatAnnouncements.GuildBankItemAdded(eventCode, slotId)
    zo_callLater(ChatAnnouncements.LogGuildBankChange, 50)
end

function ChatAnnouncements.GuildBankItemRemoved(eventCode, slotId)
    zo_callLater(ChatAnnouncements.LogGuildBankChange, 50)
end

function ChatAnnouncements.LogGuildBankChange()
    if g_guildBankCarry ~= nil then
        ChatAnnouncements.ItemPrinter(g_guildBankCarry.icon, g_guildBankCarry.stack, g_guildBankCarry.itemType, g_guildBankCarry.itemId, g_guildBankCarry.itemLink, g_guildBankCarry.receivedBy, g_guildBankCarry.logPrefix, g_guildBankCarry.gainOrLoss, false)
    end
    g_guildBankCarry = nil
end

function ChatAnnouncements.IndexInventory()
    --d("Debug - Inventory Indexed!")
    local bagsize = GetBagSize(1)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(1, i)
        local itemType = GetItemType(1, i)
        local itemId = GetItemId(1, i)
        local itemLink = GetItemLink(1, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        if itemLink ~= "" then
            g_inventoryStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end
end

function ChatAnnouncements.IndexEquipped()
    --d("Debug - Equipped Items Indexed!")
    local bagsize = GetBagSize(0)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(0, i)
        local itemType = GetItemType(0, i)
        local itemId = GetItemId(0, i)
        local itemLink = GetItemLink(0, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        if itemLink ~= "" then
            g_equippedStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end
end

function ChatAnnouncements.IndexBank()
    --("Debug - Bank Indexed!")
    local bagsizebank = GetBagSize(2)
    local bagsizesubbank = GetBagSize(6)

    for i = 0,bagsizebank do
        local icon, stack = GetItemInfo(2, i)
        local bagitemlink = GetItemLink(2, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        local itemId = GetItemId(2, i)
        local itemLink = GetItemLink(2, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        if bagitemlink ~= "" then
            g_bankStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end

    for i = 0,bagsizesubbank do
        local icon, stack = GetItemInfo(6, i)
        local bagitemlink = GetItemLink(6, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        local itemId = GetItemId(6, i)
        local itemLink = GetItemLink(6, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        if bagitemlink ~= "" then
            g_banksubStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end
end

local HouseBags = {
    [1] = BAG_HOUSE_BANK_ONE,
    [2] = BAG_HOUSE_BANK_TWO,
    [3] = BAG_HOUSE_BANK_THREE,
    [4] = BAG_HOUSE_BANK_FOUR,
    [5] = BAG_HOUSE_BANK_FIVE,
    [6] = BAG_HOUSE_BANK_SIX,
    [7] = BAG_HOUSE_BANK_SEVEN,
    [8] = BAG_HOUSE_BANK_EIGHT,
    [9] = BAG_HOUSE_BANK_NINE,
    [10] = BAG_HOUSE_BANK_TEN,
}

function ChatAnnouncements.IndexHouseBags()
    for bagIndex = 1, 10 do
        local bag = HouseBags[bagIndex]
        local bagsize = GetBagSize(bag)
        g_houseBags[bag] = { }

        for i = 0, bagsize do
            local icon, stack = GetItemInfo(bag, i)
            local bagitemlink = GetItemLink(bag, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            local itemId = GetItemId(bag, i)
            local itemLink = GetItemLink(bag, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if bagitemlink ~= "" then
                g_houseBags[bag][i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end
end

function ChatAnnouncements.CraftingOpen(eventCode, craftSkill, sameStation)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.LootCraft then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdateCraft)
        g_inventoryStacks = {}
        g_bankStacks = {}
        g_banksubStacks = {}
        ChatAnnouncements.IndexInventory() -- Index Inventory
        ChatAnnouncements.IndexBank() -- Index Bank
    end
end

function ChatAnnouncements.CraftingClose(eventCode, craftSkill)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
    end
    if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_bankStacks = {}
    g_banksubStacks = {}
end

function ChatAnnouncements.BankOpen(eventCode, bankBag)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.LootBank then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdateBank)
        g_inventoryStacks = {}
        g_bankStacks = {}
        g_banksubStacks = {}
        g_houseBags = {}
        ChatAnnouncements.IndexInventory() -- Index Inventory
        ChatAnnouncements.IndexBank() -- Index Bank
        ChatAnnouncements.IndexHouseBags() -- Index House Bags
    end
    g_bankBag = bankBag > 6 and 2 or 1
end

function ChatAnnouncements.BankClose(eventCode)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
    end
    if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_bankStacks = {}
    g_banksubStacks = {}
    g_houseBags = {}
end

function ChatAnnouncements.GuildBankOpen(eventCode)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.LootBank then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdateGuildBank)
        g_inventoryStacks = {}
        ChatAnnouncements.IndexInventory() -- Index Inventory
    end
end

function ChatAnnouncements.GuildBankClose(eventCode)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
    end
    if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
        g_inventoryStacks = {}
    end
end

function ChatAnnouncements.FenceOpen(eventCode, allowSell, allowLaunder)
    g_weAreInAFence = true
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.LootVendor then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdateFence)
        g_inventoryStacks = {}
        ChatAnnouncements.IndexInventory() -- Index Inventory
    end
end

function ChatAnnouncements.StoreOpen(eventCode)
    g_weAreInAStore = true
end

function ChatAnnouncements.StoreClose(eventCode)
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
    end
    if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    zo_callLater(function() g_weAreInAStore = false g_weAreInAFence = false end, 1000)
end

function ChatAnnouncements.FenceSuccess(eventCode, result)
    if result == ITEM_LAUNDER_RESULT_SUCCESS then
        if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
            if g_savedPurchase.formattedValue ~= nil and g_savedPurchase.formattedValue ~= "" then
                ChatAnnouncements.CurrencyPrinter(g_savedPurchase.formattedValue, g_savedPurchase.changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, g_savedPurchase.messageChange, g_savedPurchase.messageTotal, g_savedPurchase.type, g_savedPurchase.carriedItem, g_savedPurchase.carriedItemTotal)
            end
        else
            if g_savedLaunder.itemId ~= nil and g_savedLaunder.itemId ~= "" then
                ChatAnnouncements.ItemPrinter(g_savedLaunder.icon, g_savedLaunder.stack, g_savedLaunder.itemType, g_savedLaunder.itemId, g_savedLaunder.itemLink, "", g_savedLaunder.logPrefix, g_savedLaunder.gainOrLoss, false)
            end
        end
        g_savedLaunder = { }
        g_savedPurchase = { }
    end
end

-- Only active if destroyed items is enabled, flags the next item that is removed from inventory as destroyed.
function ChatAnnouncements.DestroyItem(eventCode, itemSoundCategory)
    g_itemWasDestroyed = true
end

-- Helper function for Craft Bag
function ChatAnnouncements.GetItemLinkFromItemId(itemId)
    local name = GetItemLinkName(ZO_LinkHandler_CreateLink("Test Trash", nil, ITEM_LINK_TYPE,itemId, 1, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 10000, 0))
    if ChatAnnouncements.SV.BracketOptionItem == 1 then
        return ZO_LinkHandler_CreateLinkWithoutBrackets(zo_strformat("<<t:1>>", name), nil, ITEM_LINK_TYPE,itemId, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        return ZO_LinkHandler_CreateLink(zo_strformat("<<t:1>>", name), nil, ITEM_LINK_TYPE,itemId, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
end

local questItemIndex = { }

function ChatAnnouncements.AddQuestItemsToIndex()
    questItemIndex = { }

    local function AddQuests(questIndex)

        local inventory = PLAYER_INVENTORY.inventories[INVENTORY_QUEST_ITEM]
        local itemTable = inventory.slots[questIndex]
        if itemTable then
            --remove all quest items from search
            for i = 1, #itemTable do
                local itemId = itemTable[i].questItemId
                local stackCount = itemTable[i].stackCount
                local icon = itemTable[i].iconFile
                questItemIndex[itemId] = { stack = stackCount, counter = 0, icon = icon }
            end
        end
    end

    for questIndex = 1, MAX_JOURNAL_QUESTS do
        AddQuests(questIndex)
    end
end

function ChatAnnouncements.ResolveQuestItemChange()
    for itemId, _ in pairs(questItemIndex) do

        local countChange = nil
        local newValue = questItemIndex[itemId].stack + questItemIndex[itemId].counter

        -- Only if the value changes
        if newValue > questItemIndex[itemId].stack or newValue < questItemIndex[itemId].stack then
            local icon = questItemIndex[itemId].icon
            local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

            local itemlink
            if ChatAnnouncements.SV.BracketOptionItem == 1 then
                itemLink = string.format("|H0:quest_item:" .. itemId .. "|h|h")
            else
                itemLink = string.format("|H1:quest_item:" .. itemId .. "|h|h")
            end


            local color
            local logPrefix
            local total = questItemIndex[itemId].stack + questItemIndex[itemId].counter
            local totalString

            local formattedMessageP1
            local formattedMessageP2
            local finalMessage

            -- Lower
            if newValue < questItemIndex[itemId].stack then
                -- Easy temporary debug for my accounts only
                local displayName = GetDisplayName()
                if displayName == "@ArtOfShred" or displayName == "@ArtOfShredLegacy" then
                    d(itemId .. " Removed")
                end
                --

                countChange = newValue + questItemIndex[itemId].counter
                g_questItemRemoved[itemId] = true
                zo_callLater(function() g_questItemRemoved[itemId] = false end, 100)

                if not Quests.QuestItemHideRemove[itemId] and not g_loginHideQuestLoot then
                    if ChatAnnouncements.SV.Inventory.LootQuestRemove then
                        if ChatAnnouncements.SV.Currency.CurrencyContextColor then
                            color = CurrencyDownColorize:ToHex()
                        else
                            color = CurrencyColorize:ToHex()
                        end

                        logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageRemove

                        if Quests.ItemRemovedMessage[itemId] then
                            logPrefix = Quests.ItemRemovedMessage[itemId] == LUIE_QUEST_MESSAGE_TURNIN and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestTurnIn or
                            Quests.ItemRemovedMessage[itemId] == LUIE_QUEST_MESSAGE_USE and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestUse or
                            Quests.ItemRemovedMessage[itemId] == LUIE_QUEST_MESSAGE_EXHAUST and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestExhaust or
                            Quests.ItemRemovedMessage[itemId] == LUIE_QUEST_MESSAGE_OFFER and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestOffer or
                            Quests.ItemRemovedMessage[itemId] == LUIE_QUEST_MESSAGE_DISCARD and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestDiscard or
                            Quests.ItemRemovedMessage[itemId] == LUIE_QUEST_MESSAGE_CONFISCATE and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestConfiscate
                        end

                        -- Any items that are removed at the same time a quest is turned or advanced in will be flagged to display as "Turned In."
                        if g_itemReceivedIsQuestReward then
                            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestTurnIn
                        end

                        -- Any items that are removed at the same time a quest is abandoned will be flagged to display as "Removed."
                        if g_itemReceivedIsQuestAbandon then
                            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageRemove
                        end

                        local quantity = (countChange * -1) > 1 and (" |cFFFFFFx" .. (countChange * -1) .. "|r") or ""

                        formattedMessageP1 = ("|r" .. formattedIcon .. itemLink .. quantity .. "|c" .. color)
                        formattedMessageP2 = string.format(logPrefix, formattedMessageP1)

                        if ChatAnnouncements.SV.Inventory.LootTotal and total > 1 then
                            totalString = string.format(" |c%s%s|r %s|cFEFEFE%s|r", color, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                        else
                            totalString = ""
                        end

                        finalMessage = string.format("|c%s%s|r%s", color, formattedMessageP2, totalString)

                        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "QUEST LOOT REMOVE", itemId = itemId }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        eventManager:RegisterForUpdate(moduleName .. "Printer", 25, ChatAnnouncements.PrintQueuedMessages )
                    end
                end

                if Quests.QuestItemModifyOnRemove[itemId] then
                    Quests.QuestItemModifyOnRemove[itemId]()
                end
            end

            -- Higher
            if newValue > questItemIndex[itemId].stack then
                -- Easy temporary debug for my accounts only
                local displayName = GetDisplayName()
                if displayName == "@ArtOfShred" or displayName == "@ArtOfShredLegacy" then
                    d(itemId .. " Added")
                end
                --
                countChange = newValue - questItemIndex[itemId].stack
                g_questItemAdded[itemId] = true
                zo_callLater(function() g_questItemAdded[itemId] = false end, 100)

                if not Quests.QuestItemHideLoot[itemId] and not g_loginHideQuestLoot then
                    if ChatAnnouncements.SV.Inventory.LootQuestAdd then
                        if ChatAnnouncements.SV.Currency.CurrencyContextColor then
                            color = CurrencyUpColorize:ToHex()
                        else
                            color = CurrencyColorize:ToHex()
                        end

                        if g_isLooted and not g_itemReceivedIsQuestReward and not g_isPickpocketed and not g_isStolen then
                            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
                            -- reset variables that control looted, or at least ZO_CallLater them
                        elseif g_isPickpocketed then
                            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessagePickpocket
                        elseif g_isStolen and not g_isPickpocketed then
                            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSteal
                        else
                            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
                        end
                        if Quests.ItemReceivedMessage[itemId] then
                            logPrefix = Quests.ItemReceivedMessage[itemId] == LUIE_QUEST_MESSAGE_COMBINE and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestCombine or
                            Quests.ItemReceivedMessage[itemId] == LUIE_QUEST_MESSAGE_MIX and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestMix or
                            Quests.ItemReceivedMessage[itemId] == LUIE_QUEST_MESSAGE_BUNDLE and ChatAnnouncements.SV.ContextMessages.CurrencyMessageQuestBundle or
                            Quests.ItemReceivedMessage[itemId] == LUIE_QUEST_MESSAGE_LOOT and ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
                        end

                        -- Some quest items we want to limit the maximum possible quantity displayed when looted (for wierd item swapping) so replace the actual quantity with this value.
                        if Quests.QuestItemMaxQuantityAdd[itemId] then
                            countChange = Quests.QuestItemMaxQuantityAdd[itemId]
                        end
                        local quantity = countChange > 1 and (" |cFFFFFFx" .. countChange .. "|r") or ""

                        formattedMessageP1 = ("|r" .. formattedIcon .. itemLink .. quantity .. "|c" .. color)
                        formattedMessageP2 = string.format(logPrefix, formattedMessageP1)

                        -- Message for items being merged.
                        if Quests.QuestItemMerge[itemId] then

                            local line = ""
                            for i = 1, #Quests.QuestItemMerge[itemId] do
                                local comma
                                if #Quests.QuestItemMerge[itemId] > 2 then
                                    comma = i == #Quests.QuestItemMerge[itemId] and ", and " or i > 1 and ", " or ""
                                else
                                    comma = i > 1 and " and " or ""
                                end
                                local icon = GetQuestItemIcon(Quests.QuestItemMerge[itemId][i])
                                local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
                                local usedId = Quests.QuestItemMerge[itemId][i]
                                local usedLink = ""
                                if ChatAnnouncements.SV.BracketOptionItem == 1 then
                                    usedLink = string.format("|H0:quest_item:" .. usedId .. "|h|h")
                                else
                                    usedLink = string.format("|H1:quest_item:" .. usedId .. "|h|h")
                                end
                                line = (line .. comma .. "|r" .. formattedIcon .. usedLink .. quantity .. "|c" .. color)
                            end
                            formattedMessageP2 = string.format(logPrefix, line, formattedMessageP1)
                        end

                        if ChatAnnouncements.SV.Inventory.LootTotal and total > 1 then
                            totalString = string.format(" |c%s%s|r %s|cFEFEFE%s|r", color, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                        else
                            totalString = ""
                        end

                        finalMessage = string.format("|c%s%s|r%s", color, formattedMessageP2, totalString)

                        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "QUEST LOOT ADD", itemId = itemId }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        eventManager:RegisterForUpdate(moduleName .. "Printer", 25, ChatAnnouncements.PrintQueuedMessages )
                    end
                end

                if Quests.QuestItemModifyOnAdd[itemId] then
                    Quests.QuestItemModifyOnAdd[itemId]()
                end
            end
        end

        -- If count changed, update it
        if countChange then
            questItemIndex[itemId].stack = newValue
            questItemIndex[itemId].counter = 0
            --d("New Stack Value = " .. questItemIndex[itemId].stack)
            if questItemIndex[itemId].stack < 1 then
                questItemIndex[itemId] = nil
                --d("Item reached 0 or below stacks, removing")
            end
        end
    end

    eventManager:UnregisterForUpdate(moduleName .. "QuestItemUpdater")
end

local function DisplayQuestItem(itemId, stackCount, icon, reset)
    if not questItemIndex[itemId] then
        questItemIndex[itemId] = { stack = 0, counter = 0, icon = icon }
        --d("New item created with 0 stack")
    end

    if reset then
        --d(itemId .. " - Decrement by: " .. stackCount)
        questItemIndex[itemId].counter = questItemIndex[itemId].counter - stackCount
    else
        --d(itemId .. " - Increment by: " .. stackCount)
        questItemIndex[itemId].counter = questItemIndex[itemId].counter + stackCount
    end
    eventManager:RegisterForUpdate(moduleName .. "QuestItemUpdater", 25, ChatAnnouncements.ResolveQuestItemChange )
end

function ChatAnnouncements.OnLootReceived(eventCode, receivedBy, itemLink, quantity, itemSound, lootType, lootedBySelf, isPickpocketLoot, questItemIcon, itemId, isStolen)
    -- If the player loots an item
    if not isPickpocketLoot and lootedBySelf then
        g_isLooted = true

        local function ResetIsLooted()
            g_isLooted = false
            eventManager:UnregisterForUpdate(moduleName .. "ResetLooted")
        end
        eventManager:UnregisterForUpdate(moduleName .. "ResetLooted")
        eventManager:RegisterForUpdate(moduleName .. "ResetLooted", 150, ResetIsLooted )
    end

    -- If the player pickpockets an item
    if isPickpocketLoot and lootedBySelf then
        g_isPickpocketed = true

        local function ResetIsPickpocketed()
            g_isPickpocketed = false
            eventManager:UnregisterForUpdate(moduleName .. "ResetPickpocket")
        end
        eventManager:UnregisterForUpdate(moduleName .. "ResetPickpocket")
        eventManager:RegisterForUpdate(moduleName .. "ResetPickpocket", 150, ResetIsPickpocketed )
    end

    -- Return right now if we don't have group loot set to display
    if not ChatAnnouncements.SV.Inventory.LootGroup then
        return
    end

    -- Group loot handling
    if not lootedBySelf then
        local itemType = GetItemLinkItemType(itemLink)
        -- Check filter and if this item isn't included bail out now
        if not ChatAnnouncements.ItemFilter(itemType, itemId, itemLink, true) then return end

        local icon = GetItemLinkIcon(itemLink)
        local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
        local logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageGroup

        local formatName = zo_strformat(SI_UNIT_NAME, receivedBy)

        local recipient
        if g_groupLootIndex[formatName] then
            recipient = ZO_SELECTED_TEXT:Colorize(ChatAnnouncements.ResolveNameLink( g_groupLootIndex[formatName].characterName, g_groupLootIndex[formatName].displayName ))
        else
            local nameLink
            if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(formatName, nil, CHARACTER_LINK_TYPE, formatName)
            else
                nameLink = ZO_LinkHandler_CreateLink(formatName, nil, CHARACTER_LINK_TYPE, formatName)
            end
            recipient = ZO_SELECTED_TEXT:Colorize(nameLink)
        end
        ChatAnnouncements.ItemPrinter(icon, quantity, itemType, itemId, itemLink, recipient, logPrefix, gainOrLoss, false, true)
    end
end

-- If filter is true, we run the item through this function to determine if we should display it. Filter only gets set to true for group loot and relevant loot functions. Mail, trade, stores, etc don't apply the filter.
function ChatAnnouncements.ItemFilter(itemType, itemId, itemLink, groupLoot)
    if ( ChatAnnouncements.SV.Inventory.LootBlacklist and g_blacklistIDs[itemId] ) then
        return false
    end

    local _, specializedItemType = GetItemLinkItemType(itemLink)
    local itemQuality = GetItemLinkQuality(itemLink)
    local itemIsSet = GetItemLinkSetInfo(itemLink)

    local itemIsKeyFragment = (itemType == ITEMTYPE_TROPHY) and (specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT)
    local itemIsSpecial = (itemType == ITEMTYPE_TROPHY and not itemIsKeyFragment) or (itemType == ITEMTYPE_COLLECTIBLE) or IsItemLinkConsumable(itemLink)

    if ChatAnnouncements.SV.Inventory.LootOnlyNotable or groupLoot then
        -- Notable items are: any set items, any purple+ items, blue+ special items (e.g., treasure maps)
        if ( (itemIsSet) or
             (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
             (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
             (itemType == ITEMTYPE_COSTUME) or
             (itemType == ITEMTYPE_DISGUISE) or
             (g_notableIDs[itemId]) ) then

            return true
        end
    elseif ChatAnnouncements.SV.Inventory.LootNotTrash and ( itemQuality == ITEM_QUALITY_TRASH ) and not ( ( itemType == ITEMTYPE_ARMOR) or (itemType == ITEMTYPE_COSTUME) or (itemType == ITEMTYPE_DISGUISE) ) then
        return false
    else
        return true
    end
end

function ChatAnnouncements.ItemPrinter(icon, stack, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, filter, groupLoot, delayValue)
    if filter then
        -- If filter returns false then bail out right now, we're not displaying this item.
        if not ChatAnnouncements.ItemFilter(itemType, itemId, itemLink, false) then return end
    end

    local formattedIcon = (ChatAnnouncements.SV.Inventory.LootIcons and icon ~= "") and zo_strformat("<<1>> ", zo_iconFormat(icon, 16, 16)) or ""
    local color
    if gainOrLoss == 1 then
        color = CurrencyUpColorize:ToHex()
    elseif gainOrLoss == 2 then
        color = CurrencyDownColorize:ToHex()
    -- 3 = Gain no color, 4 = Loss no color (differentiation only exists for Crafting Strings)
    elseif gainOrLoss == 3 or gainOrLoss == 4 then
        color = CurrencyColorize:ToHex()
    end

    local formattedRecipient
    local formattedQuantity
    local formattedTrait
    local formattedArmorType
    local formattedStyle

    if (receivedBy == "" or receivedBy == nil or receivedBy == "LUIE_RECEIVE_CRAFT" or receivedBy == "LUIE_INVENTORY_UPDATE_DISGUISE") then
        -- Don't display yourself
        formattedRecipient = ""
    else
        formattedRecipient = receivedBy
    end

    if (stack > 1) then
        formattedQuantity = string.format(" |cFFFFFFx%d|r", stack)
    else
        formattedQuantity = ""
    end

    local armorType = GetItemLinkArmorType(itemLink) -- Get Armor Type of item
    formattedArmorType = (ChatAnnouncements.SV.Inventory.LootShowArmorType and armorType ~= ARMORTYPE_NONE and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail ) and string.format(" |cFFFFFF(%s)|r", GetString("SI_ARMORTYPE", armorType)) or ""

    local traitType = GetItemLinkTraitInfo(itemLink) -- Get Trait type of item
    formattedTrait = (ChatAnnouncements.SV.Inventory.LootShowTrait and traitType ~= ITEM_TRAIT_TYPE_NONE and itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT and itemType ~= ITEMTYPE_JEWELRY_TRAIT and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail ) and string.format(" |cFFFFFF(%s)|r", GetString("SI_ITEMTRAITTYPE", traitType)) or ""

    local styleType = GetItemLinkItemStyle(itemLink) -- Get Style of the item
    local unformattedStyle = zo_strformat("<<1>>", GetItemStyleName(styleType))
    formattedStyle = (ChatAnnouncements.SV.Inventory.LootShowStyle
        and styleType ~= ITEMSTYLE_NONE
        and styleType ~= ITEMSTYLE_UNIQUE
        and styleType ~= ITEMSTYLE_UNIVERSAL
        and itemType ~= ITEMTYPE_STYLE_MATERIAL
        and itemType ~= ITEMTYPE_GLYPH_ARMOR
        and itemType ~= ITEMTYPE_GLYPH_JEWELRY
        and itemType ~= ITEMTYPE_GLYPH_WEAPON
        and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail )
    and string.format(" |cFFFFFF(%s)|r", unformattedStyle) or ""

    local formattedTotal = ""
    if ChatAnnouncements.SV.Inventory.LootTotal and receivedBy ~= "LUIE_INVENTORY_UPDATE_DISGUISE" and receivedBy ~= "LUIE_RECEIVE_CRAFT" and not groupLoot then
        local total1, total2, total3 = GetItemLinkStacks(itemLink)
        local total = total1 + total2 + total3
        if total > 1 then
            formattedTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", color, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end

    local itemString = string.format("%s%s%s%s%s%s", formattedIcon, itemLink, formattedQuantity, formattedArmorType, formattedTrait, formattedStyle)

    -- Set delay to 25 or 50 ms depending on source
    local callDelay
    callDelay = delayValue == 25 and 25 or 50

    -- Printer function, seperate handling for listed entires (from crafting) or simple function that sends a message over to the printer.
    if receivedBy == "LUIE_RECEIVE_CRAFT" and (gainOrLoss == 1 or gainOrLoss == 3) and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail then
        local itemString2 = itemString

        if g_itemStringGain ~= "" then
            g_itemStringGain = string.format("%s|c%s,|r %s", g_itemStringGain, color, itemString2)
        end
        if g_itemStringGain == "" then
            g_itemStringGain = itemString
        end

        if g_itemCounterGain == 0 then g_itemCounterGain = g_queuedMessagesCounter end
        if g_queuedMessagesCounter -1 == g_itemCounterGain then g_queuedMessagesCounter = g_itemCounterGain end
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        g_queuedMessages[g_itemCounterGain] = { message=g_itemStringGain, type = "LOOT", formattedRecipient=formattedRecipient, color=color, logPrefix=logPrefix, totalString= "", groupLoot=groupLoot }
        eventManager:RegisterForUpdate(moduleName .. "Printer", delayValue, ChatAnnouncements.PrintQueuedMessages )
    elseif receivedBy == "LUIE_RECEIVE_CRAFT" and (gainOrLoss == 2 or gainOrLoss == 4) and logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail then
        local itemString2 = itemString
        if g_itemStringLoss ~= "" then
            g_itemStringLoss = string.format("%s|c%s,|r %s", g_itemStringLoss, color, itemString2)
        end
        if g_itemStringLoss == "" then
            g_itemStringLoss = itemString
        end
        if g_itemCounterLoss == 0 then g_itemCounterLoss = g_queuedMessagesCounter end
        if g_queuedMessagesCounter -1 == g_itemCounterLoss then g_queuedMessagesCounter = g_itemCounterLoss end
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        g_queuedMessages[g_itemCounterLoss] = { message=g_itemStringLoss, type = "LOOT", formattedRecipient=formattedRecipient, color=color, logPrefix=logPrefix, totalString= "", groupLoot=groupLoot }
        eventManager:RegisterForUpdate(moduleName .. "Printer", delayValue, ChatAnnouncements.PrintQueuedMessages )
    else
        local totalString = formattedTotal
        g_queuedMessages[g_queuedMessagesCounter] = { message=itemString, type = "LOOT", formattedRecipient=formattedRecipient, color=color, logPrefix=logPrefix, totalString=totalString, groupLoot=groupLoot }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        eventManager:RegisterForUpdate(moduleName .. "Printer", delayValue, ChatAnnouncements.PrintQueuedMessages )
    end
end

-- Simple function combines our strings or modifies the prefix if RECEIEVED instead of looted
function ChatAnnouncements.ResolveItemMessage(message, formattedRecipient, color, logPrefix, totalString, groupLoot)
    -- Conditions for looted/quest item rewards to adjust string prefix.
    if logPrefix == "" then
        if g_isLooted and not g_itemReceivedIsQuestReward and not g_isPickpocketed and not g_isStolen then
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot
            -- reset variables that control looted, or at least ZO_CallLater them
        elseif g_isPickpocketed then
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessagePickpocket
        elseif g_isStolen and not g_isPickpocketed then
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageSteal
        else
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive
        end
    end

    local formattedMessageP1
    local formattedMessageP2

    -- Handle non group loot messages
    if not groupLoot then
        -- Adds additional string for previous variant of an item when an item is upgraded.
        if logPrefix == ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade and g_oldItem ~= nil and (g_oldItem.itemLink ~= "" and g_oldItem.itemLink ~= nil) and g_oldItem.icon ~= nil then
            local formattedIcon = (ChatAnnouncements.SV.Inventory.LootIcons and g_oldItem.icon ~= "") and zo_strformat("<<1>> ", zo_iconFormat(g_oldItem.icon, 16, 16)) or ""
            local formattedMessageUpgrade = ("|r" .. formattedIcon .. g_oldItem.itemLink .. "|c" .. color)
            formattedMessageP1 = ("|r" .. message .. "|c" .. color)
            formattedMessageP2 = string.format(logPrefix, formattedMessageUpgrade, formattedMessageP1)
            g_oldItem = { }
        else
            formattedMessageP1 = ("|r" .. message .. "|c" .. color)
            if formattedRecipient == "" then
                formattedMessageP2 = string.format(logPrefix, formattedMessageP1, "")
            else
                local recipient = ("|r" .. formattedRecipient .. "|c" .. color)
                formattedMessageP2 = string.format(logPrefix, formattedMessageP1, recipient)
            end
        end
    -- Handle group loot messages
    else
        formattedMessageP1 = ("|r" .. message .. "|c" .. color)
        local recipient = ("|r" .. formattedRecipient .. "|c" .. color)
        formattedMessageP2 = string.format(logPrefix, recipient, formattedMessageP1)
    end

    local finalMessage = string.format("|c%s%s|r%s", color, formattedMessageP2, totalString)

    printToChat(finalMessage)

    -- Reset variables for crafted item counter
    g_itemCounterGain = 0
    g_itemCounterLoss = 0
    g_itemStringGain = ""
    g_itemStringLoss = ""

   -- "You loot %s."
   -- "You receive %s."
end


-- Simple posthook into ZOS crafting mode functions, based off MultiCraft, thanks Ayantir!
function ChatAnnouncements.CraftModeOverrides()
    -- Get SMITHING mode
    g_smithing.GetMode = function()
        return SMITHING.mode
    end

    -- Get ENCHANTING mode
    g_enchanting.GetMode = function()
        return ENCHANTING:GetEnchantingMode()
    end

    -- NOTE: Alchemy and provisioning don't matter, as the only options are to craft and use materials.

    -- Crafting Mode Syntax (Enchanting - Item Gain)
    g_enchant_prefix_pos = {
        [1] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft,
        [2] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive,
        [3] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft,
    }

    -- Crafting Mode Syntax (Enchanting - Item Loss)
    g_enchant_prefix_neg = {
        [1] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse,
        [2] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageExtract,
        [3] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse,
    }

    -- Crafting Mode Syntax (Blacksmithing - Item Gain)
    g_smithing_prefix_pos = {
        [1] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive,
        [2] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft,
        [3] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive,
        [4] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade,
        [5] = "",
        [6] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft,
    }

    -- Crafting Mode Syntax (Blacksmithing - Item Loss)
    g_smithing_prefix_neg = {
        [1] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageRefine,
        [2] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse,
        [3] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeconstruct,
        [4] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail,
        [5] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageResearch,
        [6] = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse,
    }
end

local delayedItemPool = { } -- Store items we are counting up when the player loots multiple bodies at once to print combined counts for any duplicate items

function ChatAnnouncements.ItemCounterDelay(icon, stack, itemType, itemId, itemLink)
    if delayedItemPool[itemId] then
        stack = delayedItemPool[itemId].stack + stack -- Add stack count first, only if item already exists.
    end
    delayedItemPool[itemId] = { icon = icon, itemType = itemType, itemLink = itemLink, stack = stack } -- Save relevant parameters

    -- Pass along all values to SendDelayedItems()
    eventManager:UnregisterForUpdate(moduleName .. "SendDelayedItems")
    eventManager:RegisterForUpdate(moduleName .. "SendDelayedItems", 25, ChatAnnouncements.SendDelayedItems)
end

function ChatAnnouncements.SendDelayedItems()
    for id, data in pairs(delayedItemPool) do
        if id then
            ChatAnnouncements.ItemPrinter(data.icon, data.stack, data.itemType, id, data.itemLink, "", "", ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3, true, nil, 25)
        end
    end
    delayedItemPool = { }
end

function ChatAnnouncements.InventoryUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end

    if IsItemStolen(bagId, slotId) then
        g_isStolen = true
        local function ResetIsStolen()
            g_isStolen = false
            eventManager:UnregisterForUpdate(moduleName .. "ResetStolen")
        end
        eventManager:UnregisterForUpdate(moduleName .. "ResetStolen")
        eventManager:RegisterForUpdate(moduleName .. "ResetStolen", 150, ResetIsStolen )
    end

    local receivedBy = ""
    if bagId == BAG_WORN then

        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_equippedStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            if ChatAnnouncements.SV.Inventory.LootShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                gainOrLoss = 3
                receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseEquip
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM
        elseif g_equippedStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_equippedStacks[slotId].icon
                stack = g_equippedStacks[slotId].stack
                itemType = g_equippedStacks[slotId].itemType
                itemId = g_equippedStacks[slotId].itemId
                itemLink = g_equippedStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT REMAINED THE SAME (GEAR SWAPPED)
            if stackCountChange == 0 then
                if ChatAnnouncements.SV.Inventory.LootShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                    gainOrLoss = 3
                    receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseEquip
                    ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if g_removeableIDs[itemId] and not g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowRemove and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageRemove
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if ChatAnnouncements.SV.Inventory.LootShowDisguise and not g_itemWasDestroyed and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                    if IsUnitInCombat("player") then
                        logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseDestroy
                        receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                        gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    else
                        logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseRemove
                        receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                        gainOrLoss = 3
                    end
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_equippedStacks[slotId] then
                    g_equippedStacks[slotId] = nil
                end
            else
                g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId =itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_BACKPACK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            if g_inMail then
                logPrefix = g_mailTarget ~= "" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailIn or ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailInNoName
            else
                logPrefix = ""
            end
            if not g_weAreInAStore and ChatAnnouncements.SV.Inventory.Loot and isNewItem and not g_inTrade and not g_inMail then
                ChatAnnouncements.ItemCounterDelay(icon, stackCountChange, itemType, itemId, itemLink)
            end
            if g_inMail and isNewItem then
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                if g_inMail then
                    logPrefix = g_mailTarget ~= "" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailIn or ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailInNoName
                else
                    logPrefix = ""
                end
                if not g_weAreInAStore and ChatAnnouncements.SV.Inventory.Loot and isNewItem and not g_inTrade and not g_inMail then
                    ChatAnnouncements.ItemCounterDelay(icon, stackCountChange, itemType, itemId, itemLink)
                end
                if g_inMail and isNewItem then
                    ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if g_removeableIDs[itemId] and not g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowRemove and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageRemove
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if ChatAnnouncements.SV.Inventory.LootShowLockpick and g_lockpickBroken then
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageLockpick
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_inventoryStacks[slotId] then
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_VIRTUAL then
        local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
        local logPrefix
        if g_inMail then
            logPrefix = g_mailTarget ~= "" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailIn or ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailInNoName
        else
            logPrefix = ""
        end
        local itemLink = ChatAnnouncements.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink)
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)

        if not g_weAreInAStore and ChatAnnouncements.SV.Inventory.Loot and isNewItem and not g_inTrade and not g_inMail then
            ChatAnnouncements.ItemCounterDelay(icon, stackCountChange, itemType, itemId, itemLink)
        end
        if g_inMail and isNewItem then
            ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
        end
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function ChatAnnouncements.InventoryUpdateCraft(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end

    local function ResolveCraftingUsed(itemType)
        if (GetCraftingInteractionType() == CRAFTING_TYPE_BLACKSMITHING or GetCraftingInteractionType() == CRAFTING_TYPE_CLOTHIER or GetCraftingInteractionType() == CRAFTING_TYPE_WOODWORKING or GetCraftingInteractionType() == CRAFTING_TYPE_JEWELRYCRAFTING) and g_smithing.GetMode() == 4 then
            if itemType == ITEMTYPE_ADDITIVE
            or itemType == ITEMTYPE_ARMOR_BOOSTER
            or itemType == ITEMTYPE_ARMOR_TRAIT
            or itemType == ITEMTYPE_BLACKSMITHING_BOOSTER
            or itemType == ITEMTYPE_BLACKSMITHING_MATERIAL
            or itemType == ITEMTYPE_CLOTHIER_BOOSTER
            or itemType == ITEMTYPE_CLOTHIER_MATERIAL
            or itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT
            or itemType == ITEMTYPE_ENCHANTING_RUNE_ESSENCE
            or itemType == ITEMTYPE_ENCHANTING_RUNE_POTENCY
            or itemType == ITEMTYPE_ENCHANTMENT_BOOSTER
            or itemType == ITEMTYPE_JEWELRYCRAFTING_BOOSTER
            or itemType == ITEMTYPE_JEWELRYCRAFTING_MATERIAL
            or itemType == ITEMTYPE_INGREDIENT
            or itemType == ITEMTYPE_POISON_BASE
            or itemType == ITEMTYPE_POTION_BASE
            or itemType == ITEMTYPE_REAGENT
            or itemType == ITEMTYPE_STYLE_MATERIAL
            or itemType == ITEMTYPE_WEAPON_BOOSTER
            or itemType == ITEMTYPE_WEAPON_TRAIT
            or itemType == ITEMTYPE_JEWELRY_TRAIT
            or itemType == ITEMTYPE_WOODWORKING_BOOSTER
            or itemType == ITEMTYPE_WOODWORKING_MATERIAL
            or itemType == ITEMTYPE_GLYPH_ARMOR
            or itemType == ITEMTYPE_GLYPH_JEWELRY
            or itemType == ITEMTYPE_GLYPH_WEAPON then
                return true
            end
        end
    end

    local receivedBy = "LUIE_RECEIVE_CRAFT" -- This keyword tells our item printer to print the items in a list separated by commas, to conserve space for the display of crafting mats consumed.
    local logPrefixPos = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft
    local logPrefixNeg = ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse

    -- Get string values from our crafting hook function
    if GetCraftingInteractionType() == CRAFTING_TYPE_ENCHANTING then
        logPrefixPos = g_enchant_prefix_pos[g_enchanting.GetMode()]
        logPrefixNeg = g_enchant_prefix_neg[g_enchanting.GetMode()]
    end
    if (GetCraftingInteractionType() == CRAFTING_TYPE_BLACKSMITHING or GetCraftingInteractionType() == CRAFTING_TYPE_CLOTHIER or GetCraftingInteractionType() == CRAFTING_TYPE_WOODWORKING or GetCraftingInteractionType() == CRAFTING_TYPE_JEWELRYCRAFTING) then
        logPrefixPos = g_smithing_prefix_pos[g_smithing.GetMode()]
        logPrefixNeg = g_smithing_prefix_neg[g_smithing.GetMode()]
    end

    -- If the hook function didn't return a string value (for example because the player was in Gamepad mode), then we use a default override.
    if logPrefixPos == nil then logPrefixPos = ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft end
    if logPrefixNeg == nil then logPrefixNeg = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeconstruct end

    if bagId == BAG_WORN then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_equippedStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM
        elseif g_equippedStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_equippedStacks[slotId].icon
                stack = g_equippedStacks[slotId].stack
                itemType = g_equippedStacks[slotId].itemType
                itemId = g_equippedStacks[slotId].itemId
                itemLink = g_equippedStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_equippedStacks[slotId].itemLink, icon=icon }
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or logPrefixNeg
                if logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or ChatAnnouncements.SV.Inventory.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_equippedStacks[slotId] then
                    g_equippedStacks[slotId] = nil
                end
            else
                g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_BACKPACK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_inventoryStacks[slotId].itemLink, icon=icon }
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or logPrefixNeg
                if logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or ChatAnnouncements.SV.Inventory.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_inventoryStacks[slotId] then
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_BANK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_bankStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM
        elseif g_bankStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_bankStacks[slotId].icon
                stack = g_bankStacks[slotId].stack
                itemType = g_bankStacks[slotId].itemType
                itemId = g_bankStacks[slotId].itemId
                itemLink = g_bankStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_bankStacks[slotId].itemLink, icon=icon }
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or logPrefixNeg
                if logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or ChatAnnouncements.SV.Inventory.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_bankStacks[slotId] then
                    g_bankStacks[slotId] = nil
                end
            else
                g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_SUBSCRIBER_BANK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_banksubStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM
        elseif g_banksubStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_banksubStacks[slotId].icon
                stack = g_banksubStacks[slotId].stack
                itemType = g_banksubStacks[slotId].itemType
                itemId = g_banksubStacks[slotId].itemId
                itemLink = g_banksubStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_banksubStacks[slotId].itemLink, icon=icon }
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or logPrefixNeg
                if logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or ChatAnnouncements.SV.Inventory.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_banksubStacks[slotId] then
                    g_banksubStacks[slotId] = nil
                end
            else
                g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_VIRTUAL then
        local gainOrLoss
        local localPrefix
        local itemLink = ChatAnnouncements.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink)
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        local change

        if stackCountChange > 0 then
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = ResolveCraftingUsed(itemType) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive or logPrefixPos
            change = stackCountChange
        end

        if stackCountChange < 0 then
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
            logPrefix = ResolveCraftingUsed(itemType) and ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or logPrefixNeg
            change = stackCountChange * -1
        end

        if logPrefix ~= ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse or ChatAnnouncements.SV.Inventory.LootShowCraftUse then
            ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        end
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function ChatAnnouncements.InventoryUpdateBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
-- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then
        return
    end

    local receivedBy = ""
    if bagId == BAG_BACKPACK then

        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = g_bankBag == 1 and ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdraw or ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawStorage
            if InventoryOn then
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = g_bankBag == 1 and ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdraw or ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawStorage
                if InventoryOn then
                    ChatAnnouncements.ItemPrinter(icon, stack, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if InventoryOn and not g_itemWasDestroyed then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = g_bankBag == 1 and ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit or ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_inventoryStacks[slotId] then
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end

            if not g_itemWasDestroyed then
                BankOn = true
            end
            if not g_itemWasDestroyed then
                InventoryOn = false
            end
            if not g_itemWasDestroyed then
                zo_callLater(ChatAnnouncements.BankFixer, 50)
            end
        end
    end

    if bagId == BAG_BANK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_bankStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
            if BankOn then
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM
        elseif g_bankStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_bankStacks[slotId].icon
                stack = g_bankStacks[slotId].stack
                itemType = g_bankStacks[slotId].itemType
                itemId = g_bankStacks[slotId].itemId
                itemLink = g_bankStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
                if BankOn then
                    ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if BankOn and not g_itemWasDestroyed then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_bankStacks[slotId] then
                    g_bankStacks[slotId] = nil
                end
            else
                g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end

            if not g_itemWasDestroyed then
                InventoryOn = true
            end
            if not g_itemWasDestroyed then
                BankOn = false
            end
            if not g_itemWasDestroyed then
                zo_callLater(ChatAnnouncements.BankFixer, 50)
            end
        end
    end

    if bagId == BAG_SUBSCRIBER_BANK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_banksubStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
            if BankOn then
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM
        elseif g_banksubStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_banksubStacks[slotId].icon
                stack = g_banksubStacks[slotId].stack
                itemType = g_banksubStacks[slotId].itemType
                itemId = g_banksubStacks[slotId].itemId
                itemLink = g_banksubStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
                if BankOn then
                    ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if BankOn and not g_itemWasDestroyed then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_banksubStacks[slotId] then
                    g_banksubStacks[slotId] = nil
                end
            else
                g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end

            if not g_itemWasDestroyed then
                InventoryOn = true
            end
            if not g_itemWasDestroyed then
                BankOn = false
            end
            if not g_itemWasDestroyed then
                zo_callLater(ChatAnnouncements.BankFixer, 50)
            end
        end
    end

    if bagId > 6 and bagId < 16 then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_houseBags[bagId][slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_houseBags[bagId][slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage
            if BankOn then
                ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM
        elseif g_houseBags[bagId][slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_houseBags[bagId][slotId].icon
                stack = g_houseBags[bagId][slotId].stack
                itemType = g_houseBags[bagId][slotId].itemType
                itemId = g_houseBags[bagId][slotId].itemId
                itemLink = g_houseBags[bagId][slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage
                if BankOn then
                    ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if BankOn and not g_itemWasDestroyed then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end

            if removed then
                if g_houseBags[bagId][slotId] then
                    g_houseBags[bagId][slotId] = nil
                end
            else
                g_houseBags[bagId][slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end

            if not g_itemWasDestroyed then
                InventoryOn = true
            end
            if not g_itemWasDestroyed then
                BankOn = false
            end
            if not g_itemWasDestroyed then
                zo_callLater(ChatAnnouncements.BankFixer, 50)
            end
        end
    end

    if bagId == BAG_VIRTUAL then
        local gainOrLoss
        local stack
        local logPrefix
        local itemLink = ChatAnnouncements.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink)
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)

        if stackCountChange < 1 then
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
            logPrefix = g_bankBag == 1 and ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit or ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage
            stack = stackCountChange * -1
        else
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = g_bankBag == 1 and ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdraw or ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawStorage
            stack = stackCountChange
        end

        ChatAnnouncements.ItemPrinter(icon, stack, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function ChatAnnouncements.InventoryUpdateGuildBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local receivedBy = ""
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed

        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawGuild
            g_guildBankCarry = { }
            g_guildBankCarry.icon = icon
            g_guildBankCarry.stack = stack
            g_guildBankCarry.gainOrLoss = gainOrLoss
            g_guildBankCarry.logPrefix = logPrefix
            g_guildBankCarry.receivedBy = receivedBy
            g_guildBankCarry.itemLink = itemLink
            g_guildBankCarry.itemId = itemId
            g_guildBankCarry.itemType = itemType

        elseif g_inventoryStacks[slotId] then -- EXISTING ITEM
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            if stackCountChange > 0 then -- STACK COUNT INCREMENTED UP
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawGuild
                g_guildBankCarry = { }
                g_guildBankCarry.icon = icon
                g_guildBankCarry.stack = stack
                g_guildBankCarry.gainOrLoss = gainOrLoss
                g_guildBankCarry.logPrefix = logPrefix
                g_guildBankCarry.receivedBy = receivedBy
                g_guildBankCarry.itemLink = itemLink
                g_guildBankCarry.itemId = itemId
                g_guildBankCarry.itemType = itemType
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if not g_itemWasDestroyed then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositGuild
                    g_guildBankCarry = { }
                    g_guildBankCarry.icon = icon
                    g_guildBankCarry.stack = stack
                    g_guildBankCarry.gainOrLoss = gainOrLoss
                    g_guildBankCarry.logPrefix = logPrefix
                    g_guildBankCarry.receivedBy = receivedBy
                    g_guildBankCarry.itemLink = itemLink
                    g_guildBankCarry.itemId = itemId
                    g_guildBankCarry.itemType = itemType
                end
            end

            if removed then
                if g_inventoryStacks[slotId] then
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    ---------------------------------- CRAFTING BAG ----------------------------------
    if bagId == BAG_VIRTUAL then
        local gainOrLoss
        local stack
        local logPrefix
        local itemLink = ChatAnnouncements.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink)
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)

        if stackCountChange < 1 then
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositGuild
            stack = stackCountChange * -1
        else
            gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
            logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawGuild
            stack = stackCountChange
        end

        g_guildBankCarry = { }
        g_guildBankCarry.icon = icon
        g_guildBankCarry.stack = stack
        g_guildBankCarry.gainOrLoss = gainOrLoss
        g_guildBankCarry.logPrefix = logPrefix
        g_guildBankCarry.receivedBy = receivedBy
        g_guildBankCarry.itemLink = itemLink
        g_guildBankCarry.itemId = itemId
        g_guildBankCarry.itemType = itemType
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function ChatAnnouncements.InventoryUpdateFence(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end

    local receivedBy = ""
    if bagId == BAG_BACKPACK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        -- EXISTING ITEM
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            if stackCountChange == 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = ChatAnnouncements.SV.Inventory.LootVendorCurrency and ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunder or ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunderNoV
                if not g_weAreInAStore and ChatAnnouncements.SV.Inventory.Loot then
                    local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
                    local type = "LUIE_CURRENCY_VENDOR"

                    local parts = {ZO_LinkHandler_ParseLink(itemLink)}
                    parts[22] = "1"
                    parts = table.concat(parts, ":"):sub(2, -1)
                    itemLink = zo_strformat("|H<<1>>|h|h", parts)

                    local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
                    local itemCount = stack > 1 and (" |cFFFFFFx" .. stack .. "|r") or ""
                    local carriedItem = ( formattedIcon .. itemLink ..  itemCount )
                    local carriedItemTotal = ""
                    if ChatAnnouncements.SV.Inventory.LootVendorTotalItems then
                        local total1, total2, total3 = GetItemLinkStacks(itemLink)
                        local total = total1 + total2 + total3
                        if total > 1 then
                            carriedItemTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                        end
                    end

                    if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
                        g_savedPurchase.changeColor = changeColor
                        g_savedPurchase.messageChange = logPrefix
                        g_savedPurchase.type = type
                        g_savedPurchase.carriedItem = carriedItem
                        g_savedPurchase.carriedItemTotal = carriedItemTotal
                    else
                        g_savedLaunder = { icon = icon, stack = 0, itemType = itemType, itemId = itemId, itemLink = itemLink, logPrefix = logPrefix, gainOrLoss = gainOrLoss }
                    end
                end
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                logPrefix = ChatAnnouncements.SV.Inventory.LootVendorCurrency and ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunder or ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunderNoV
                if not g_weAreInAStore and ChatAnnouncements.SV.Inventory.Loot then
                    --ChatAnnouncements.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and ChatAnnouncements.SV.Inventory.LootShowDestroy then
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy
                    ChatAnnouncements.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                else
                    gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                    logPrefix = ChatAnnouncements.SV.Inventory.LootVendorCurrency and ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunder or ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunderNoV
                    local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
                    local type = "LUIE_CURRENCY_VENDOR"

                    local parts = {ZO_LinkHandler_ParseLink(itemLink)}
                    parts[22] = "1"
                    parts = table.concat(parts, ":"):sub(2, -1)
                    itemLink = zo_strformat("|H<<1>>|h|h", parts)

                    local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
                    local itemCount = stack > 1 and (" |cFFFFFFx" .. stack .. "|r") or ""
                    local carriedItem = ( formattedIcon .. itemLink ..  itemCount )
                    local carriedItemTotal = ""
                    if ChatAnnouncements.SV.Inventory.LootVendorTotalItems then
                        local total1, total2, total3 = GetItemLinkStacks(itemLink)
                        local total = total1 + total2 + total3
                        if total > 1 then
                            carriedItemTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                        end
                    end

                    if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
                        g_savedPurchase.changeColor = changeColor
                        g_savedPurchase.messageChange = logPrefix
                        g_savedPurchase.type = type
                        g_savedPurchase.carriedItem = carriedItem
                        g_savedPurchase.carriedItemTotal = carriedItemTotal
                    else
                        g_savedLaunder = { icon = icon, stack = change, itemType = itemType, itemId = itemId, itemLink = itemLink, logPrefix = logPrefix, gainOrLoss = gainOrLoss }
                    end
                end
            end

            if removed then
                if g_inventoryStacks[slotId] then
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_VIRTUAL then
        local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
        local logPrefix = ChatAnnouncements.SV.Inventory.LootVendorCurrency and ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunder or ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunderNoV
        local itemLink = GetItemLink(bagId, slotId, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink)
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)

        if not g_weAreInAStore and ChatAnnouncements.SV.Inventory.Loot then
            local change = stackCountChange > 0 and stackCountChange or stackCountChange*-1
            local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
            local type = "LUIE_CURRENCY_VENDOR"

            local parts = {ZO_LinkHandler_ParseLink(itemLink)}
            parts[22] = "1"
            parts = table.concat(parts, ":"):sub(2, -1)
            itemLink = zo_strformat("|H<<1>>|h|h", parts)

            local formattedIcon = ( ChatAnnouncements.SV.Inventory.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
            local itemCount = stackCountChange > 1 and (" |cFFFFFFx" .. stackCountChange .. "|r") or ""
            local carriedItem = ( formattedIcon .. itemLink ..  itemCount )
            local carriedItemTotal = ""
            if ChatAnnouncements.SV.Inventory.LootVendorTotalItems then
                local total1, total2, total3 = GetItemLinkStacks(itemLink)
                local total = total1 + total2 + total3
                if total > 1 then
                    carriedItemTotal = string.format(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, ChatAnnouncements.SV.Inventory.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                end
            end

            if ChatAnnouncements.SV.Inventory.LootVendorCurrency then
                g_savedPurchase.changeColor = changeColor
                g_savedPurchase.messageChange = logPrefix
                g_savedPurchase.type = type
                g_savedPurchase.carriedItem = carriedItem
                g_savedPurchase.carriedItemTotal = carriedItemTotal
            else
                g_savedLaunder = { icon = icon, stack = change, itemType = itemType, itemId = itemId, itemLink = itemLink, logPrefix = logPrefix, gainOrLoss = gainOrLoss }
            end
        end
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

-- Makes it so bank withdraw/deposit events only occur when we can confirm the item is crossing over.
function ChatAnnouncements.BankFixer()
    InventoryOn = false
    BankOn = false
end

function ChatAnnouncements.JusticeStealRemove(eventCode)
    zo_callLater(ChatAnnouncements.JusticeRemovePrint, 50)
end

function ChatAnnouncements.JusticeDisplayConfiscate()
    if ChatAnnouncements.SV.Notify.NotificationConfiscateCA or ChatAnnouncements.SV.Notify.NotificationConfiscateAlert then
        local ConfiscateMessage
        if g_itemsConfiscated then
            ConfiscateMessage = GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_BOUNTY_ITEMS_MSG)
        else
            ConfiscateMessage = GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_MSG)
        end

        if ChatAnnouncements.SV.Notify.NotificationConfiscateCA then
            g_queuedMessages[g_queuedMessagesCounter] = { message = ConfiscateMessage, type = "NOTIFICATION", isSystem = true }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        else
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, ConfiscateMessage)
        end
    end
    g_itemsConfiscated = false
end

function ChatAnnouncements.JusticeRemovePrint()
    g_itemsConfiscated = true

    -- PART 1 -- INVENTORY
    if ChatAnnouncements.SV.Inventory.LootConfiscate then
        local bagsize = GetBagSize(1)

        for i = 0,bagsize do
            local icon, stack = GetItemInfo(1, i)
            local itemType = GetItemType(1, i)
            local itemId = GetItemId(1, i)
            local itemLink = GetItemLink(1, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])

            if itemLink ~= "" then
                g_JusticeStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end

        for i = 0,bagsize do
            local inventoryitem = g_inventoryStacks[i]
            local justiceitem = g_JusticeStacks[i]
            if inventoryitem ~= nil then
                if justiceitem == nil then
                    local receivedBy = ""
                    local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    local logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageConfiscate
                    if ChatAnnouncements.SV.Inventory.LootConfiscate then
                        ChatAnnouncements.ItemPrinter(inventoryitem.icon, inventoryitem.stack, inventoryitem.itemType, inventoryitem.itemId, inventoryitem.itemLink, receivedBy, logPrefix, gainOrLoss, false)
                    end
                end
            end
        end

        -- Reset Justice Stacks to reuse for equipped
        g_JusticeStacks = {}

        -- PART 2 -- EQUIPPED
        bagsize = GetBagSize(0)

        -- We have to determine the currently active weapon, and swap the slots because of some wierd interaction when your equipped weapon is confiscated.
        -- This works even if the other weapon slot is empty or both slots have a stolen weapon.
        local weaponInfo = GetActiveWeaponPairInfo()

        -- Save weapons
        local W1 = g_equippedStacks[4]
        local W2 = g_equippedStacks[5]
        local W3 = g_equippedStacks[20]
        local W4 = g_equippedStacks[21]

        -- Swap weapons depending on currently equipped pair
        if WeaponInfo == 1 then
            g_equippedStacks[4] = W3
            g_equippedStacks[5] = W4
        end

        if WeaponInfo == 2 then
            g_equippedStacks[20] = W1
            g_equippedStacks[21] = W2
        end

        for i = 0,bagsize do
            local icon, stack = GetItemInfo(0, i)
            local itemType = GetItemType(0, i)
            local itemId = GetItemId(0, i)
            local itemLink = GetItemLink(0, i, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])

            if itemLink ~= "" then
                g_JusticeStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end

        for i = 0,bagsize do
            local inventoryitem = g_equippedStacks[i]
            local justiceitem = g_JusticeStacks[i]
            if inventoryitem ~= nil then
                if justiceitem == nil then
                    local receivedBy = ""
                    local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    local logPrefix = ChatAnnouncements.SV.ContextMessages.CurrencyMessageConfiscate
                    if ChatAnnouncements.SV.Inventory.LootConfiscate then
                        ChatAnnouncements.ItemPrinter(inventoryitem.icon, inventoryitem.stack, inventoryitem.itemType, inventoryitem.itemId, inventoryitem.itemLink, receivedBy, logPrefix, gainOrLoss, false)
                    end
                end
            end
        end
    end

    g_JusticeStacks = {} -- Clear the Justice Item Stacks since we don't need this for anything else!
    g_equippedStacks = {}
    g_inventoryStacks = {}
    ChatAnnouncements.IndexEquipped()
    ChatAnnouncements.IndexInventory() -- Reindex the inventory with the correct values!
end

function ChatAnnouncements.DisguiseState(eventCode, unitTag, disguiseState)
    if disguiseState == DISGUISE_STATE_DANGER then
        if ChatAnnouncements.SV.Notify.DisguiseWarnCA then
            local message = GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER)
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "MESSAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.DisguiseWarnCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.GROUP_ELECTION_REQUESTED)
            messageParams:SetText(DisguiseAlertColorize:Colorize(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER)))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        if ChatAnnouncements.SV.Notify.DisguiseWarnAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER))
        end

        if (ChatAnnouncements.SV.Notify.DisguiseWarnCA or ChatAnnouncements.SV.Notify.DisguiseWarnAlert) and not ChatAnnouncements.SV.Notify.DisguiseWarnCSA then
            PlaySound(SOUNDS.GROUP_ELECTION_REQUESTED)
        end
    end

    if disguiseState == DISGUISE_STATE_SUSPICIOUS then
        if ChatAnnouncements.SV.Notify.DisguiseWarnCA then
            local message = GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS)
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "MESSAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.DisguiseWarnCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.GROUP_ELECTION_REQUESTED)
            messageParams:SetText(DisguiseAlertColorize:Colorize(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS)))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        if ChatAnnouncements.SV.Notify.DisguiseWarnAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS))
        end
        if (ChatAnnouncements.SV.Notify.DisguiseWarnCA or ChatAnnouncements.SV.Notify.DisguiseWarnAlert) and not ChatAnnouncements.SV.Notify.DisguiseWarnCSA then
            PlaySound(SOUNDS.GROUP_ELECTION_REQUESTED)
        end
    end

    -- If we're still disguised and g_disguiseState is true then don't waste resources and end the function
    if g_disguiseState == 1 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        return
    end

    if g_disguiseState == 1 and (disguiseState == DISGUISE_STATE_NONE) then
        local message = zo_strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), Effects.DisguiseIcons[g_currentDisguise].description)
        if ChatAnnouncements.SV.Notify.DisguiseCA then
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "MESSAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.DisguiseAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        if ChatAnnouncements.SV.Notify.DisguiseCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetText(message)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    if g_disguiseState == 0 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        g_currentDisguise = GetItemId(0, 10) or 0
        local message = zo_strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), Effects.DisguiseIcons[g_currentDisguise].description)
        if ChatAnnouncements.SV.Notify.DisguiseCA then
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "MESSAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.DisguiseAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        if ChatAnnouncements.SV.Notify.DisguiseCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetText(message)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    g_disguiseState = GetUnitDisguiseState("player")

    if g_disguiseState > 0 then
        g_disguiseState = 1
    end
end

function ChatAnnouncements.OnPlayerActivated(eventCode, initial)
    -- Get current trades if UI is reloaded
    local characterName, _, displayName = GetTradeInviteInfo()

    if characterName ~= "" and displayName ~= "" then
        local tradeName = ChatAnnouncements.ResolveNameLink(characterName, displayName)
        g_tradeTarget = ZO_SELECTED_TEXT:Colorize(zo_strformat(SI_UNIT_NAME, tradeName))
    end

    zo_callLater(function() g_loginHideQuestLoot = false end, 3000)

    if ChatAnnouncements.SV.Notify.DisguiseCA or ChatAnnouncements.SV.Notify.DisguiseCSA or ChatAnnouncements.SV.Notify.DisguiseAlert or ChatAnnouncements.SV.Notify.DisguiseWarnCA or ChatAnnouncements.SV.Notify.DisguiseWarnCSA or ChatAnnouncements.SV.Notify.DisguiseWarnAlert then
        if g_disguiseState == 0 then
            g_disguiseState = GetUnitDisguiseState("player")
            if g_disguiseState == 0 then
                return
            elseif g_disguiseState ~= 0 then
                g_disguiseState = 1
                g_currentDisguise = GetItemId(0, 10) or 0
                local message = zo_strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), Effects.DisguiseIcons[g_currentDisguise].description)
                if ChatAnnouncements.SV.Notify.DisguiseCA then
                    g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "MESSAGE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end
                if ChatAnnouncements.SV.Notify.DisguiseAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
                end
                if ChatAnnouncements.SV.Notify.DisguiseCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
                    messageParams:SetText(message)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                return
            end
        elseif g_disguiseState == 1 then
            g_disguiseState = GetUnitDisguiseState("player")
            if g_disguiseState == 0 then
                local message = zo_strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), Effects.DisguiseIcons[g_currentDisguise].description)
                if ChatAnnouncements.SV.Notify.DisguiseCA then
                    g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "MESSAGE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end
                if ChatAnnouncements.SV.Notify.DisguiseAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
                end
                if ChatAnnouncements.SV.Notify.DisguiseCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
                    messageParams:SetText(message)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                return
            elseif g_disguiseState ~= 0 then
                g_disguiseState = 1
                g_currentDisguise = GetItemId(0, 10) or 0
                return
            end
        end
    end
end

--[[ STUCK REFERENCE
function ChatAnnouncements.StuckOnCooldown(eventCode)
    local cooldownText = ZO_FormatTime(GetStuckCooldown(), TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)
    local cooldownRemainingText = ZO_FormatTimeMilliseconds(GetTimeUntilStuckAvailable(), TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)
    printToChat(zo_strformat(GetString(SI_STUCK_ERROR_ON_COOLDOWN), cooldownText, cooldownRemainingText ))
end
]]

-- TODO: Replace/Remove

--[[
function ChatAnnouncements.InventoryFullQuest(eventCode)
    printToChat(GetString(SI_INVENTORY_ERROR_INVENTORY_FULL))
end

function ChatAnnouncements.InventoryFull(eventCode, numSlotsRequested, numSlotsFree)
    local function DisplayItemFailed()
        if numSlotsRequested == 1 then
            printToChat(GetString(SI_INVENTORY_ERROR_INVENTORY_FULL))
        else
            printToChat(zo_strformat(GetString(SI_INVENTORY_ERROR_INSUFFICIENT_SPACE), (numSlotsRequested - numSlotsFree) ))
        end
    end

    zo_callLater(DisplayItemFailed, 100)
end

function ChatAnnouncements.LootItemFailed(eventCode, reason, itemName)
    -- Stop Spam
    eventManager:UnregisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED)

    local function ReactivateLootItemFailed()
    printToChat(zo_strformat(GetString("SI_LOOTITEMRESULT", reason), itemName))
        eventManager:RegisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED, ChatAnnouncements.LootItemFailed)
    end

    zo_callLater(ReactivateLootItemFailed, 100)
end
]]

-------------------------------------------------------------------------
-- UPDATED CODE
-------------------------------------------------------------------------

-- LINK_HANDLER.LINK_MOUSE_UP_EVENT
-- LINK_HANDLER.LINK_CLICKED_EVENT
-- Custom Link Handlers to deal with when a book link in chat is clicked, this will open the book rather than the default link that only shows whether a lore entry has been read or not.
function LUIE.HandleClickEvent(rawLink, mouseButton, linkText, linkStyle, linkType, categoryIndex, collectionIndex, bookIndex)
  if linkType == "LINK_TYPE_LUIBOOK" then
    -- Read the book
    ZO_LoreLibrary_ReadBook(categoryIndex, collectionIndex, bookIndex)
    return true
  end
end

-- Function needed to display XP bar updates
local function GetRelevantBarParams(level, previousExperience, currentExperience, championPoints)
    local championXpToNextPoint
    if CanUnitGainChampionPoints("player") then
        championXpToNextPoint = GetNumChampionXPInChampionPoint(championPoints)
    end
    if(championXpToNextPoint ~= nil and currentExperience > previousExperience) then
        return CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, previousExperience, currentExperience)
    else
        local levelSize
        if(level) then
            levelSize = GetNumExperiencePointsInLevel(level)
        end
        if(levelSize ~= nil and currentExperience >  previousExperience) then
            return CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_XP, level, previousExperience, currentExperience)
        end
    end
end

local function GetCurrentChampionPointsBarParams()
    local championPoints = GetPlayerChampionPointsEarned()
    local currentChampionXP = GetPlayerChampionXP()
    local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, currentChampionXP, currentChampionXP)
    barParams:SetShowNoGain(true)
    return barParams
end

-- local vars for EVENT_SKILL_XP

local GUILD_SKILL_SHOW_REASONS = {
    [PROGRESS_REASON_DARK_ANCHOR_CLOSED] = true,
    [PROGRESS_REASON_DARK_FISSURE_CLOSED] = true,
    [PROGRESS_REASON_BOSS_KILL] = true,
}

local GUILD_SKILL_SHOW_SOUNDS = {
    [PROGRESS_REASON_DARK_ANCHOR_CLOSED] = SOUNDS.SKILL_XP_DARK_ANCHOR_CLOSED,
    [PROGRESS_REASON_DARK_FISSURE_CLOSED] = SOUNDS.SKILL_XP_DARK_FISSURE_CLOSED,
    [PROGRESS_REASON_BOSS_KILL] = SOUNDS.SKILL_XP_BOSS_KILLED,
}

local GUILD_SKILL_ICONS = {
    [45] = "esoui/art/icons/mapkey/mapkey_fightersguild.dds",
    [44] = "esoui/art/icons/mapkey/mapkey_magesguild.dds",
    [55] = "esoui/art/icons/mapkey/mapkey_undaunted.dds",
    [117] = "esoui/art/icons/mapkey/mapkey_thievesguild.dds",
    [118] = "esoui/art/icons/mapkey/mapkey_darkbrotherhood.dds",
    [130] = "LuiExtended/media/unitframes/mapkey_psijicorder.dds",
}

-- Alert Prehooks
function ChatAnnouncements.HookFunction()
    local alertHandlers = ZO_AlertText_GetHandlers()

    -- Style book learned
    --[[
    local function StyleLearnedHook(styleIndex, chapterIndex, isDefaultRacialStyle)
        if not isDefaultRacialStyle then
            local itemStyle = select(5, GetSmithingStyleItemInfo(styleIndex))
            if chapterIndex == ITEM_STYLE_CHAPTER_ALL then
                printToChat(zo_strformat(SI_NEW_STYLE_LEARNED, GetString("SI_ITEMSTYLE", itemStyle)))
                return ALERT, zo_strformat(SI_NEW_STYLE_LEARNED, GetString("SI_ITEMSTYLE", itemStyle))
            else
                printToChat(zo_strformat(SI_NEW_STYLE_CHAPTER_LEARNED, GetString("SI_ITEMSTYLE", itemStyle), GetString("SI_ITEMSTYLECHAPTER", chapterIndex)))
                return ALERT, zo_strformat(SI_NEW_STYLE_CHAPTER_LEARNED, GetString("SI_ITEMSTYLE", itemStyle), GetString("SI_ITEMSTYLECHAPTER", chapterIndex))

            end
        end
    end
    ZO_PreHook(alertHandlers, EVENT_STYLE_LEARNED, StyleLearnedHook)
    ]]--

    -- Hide this alert because its really pretty much pointless. Only time I've ever seen it trigger is when the server lagged.
    local function AlreadyKnowBookHook(bookTitle)
        return true
    end

    local function RidingSkillImprovementAlertHook(ridingSkill, previous, current, source)
        if source == RIDING_TRAIN_SOURCE_STABLES then
            -- If we purchased from the stables, display a currency announcement if relevant
            if ChatAnnouncements.SV.Currency.CurrencyGoldChange then
                local type
                if ridingSkill == 1 then
                    type = "LUIE_CURRENCY_RIDING_SPEED"
                elseif ridingSkill == 2 then
                    type = "LUIE_CURRENCY_RIDING_CAPACITY"
                elseif ridingSkill == 3 then
                    type = "LUIE_CURRENCY_RIDING_STAMINA"
                end
                local formattedValue = ZO_LocalizeDecimalNumber(GetCarriedCurrencyAmount(1) + 250)
                local changeColor = ChatAnnouncements.SV.Currency.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
                local changeType = ZO_LocalizeDecimalNumber(250)
                local currencyTypeColor = CurrencyGoldColorize:ToHex()
                local currencyIcon = ChatAnnouncements.SV.Currency.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
                local currencyName = zo_strformat(ChatAnnouncements.SV.Currency.CurrencyGoldName, 250)
                local currencyTotal = ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal
                local messageTotal = ChatAnnouncements.SV.Currency.CurrencyMessageTotalGold
                local messageChange = ChatAnnouncements.SV.ContextMessages.CurrencyMessageStable
                ChatAnnouncements.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
            end

            if ChatAnnouncements.SV.Notify.StorageRidingCA then
                local formattedString = StorageRidingColorize:Colorize(zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "MESSAGE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.Notify.StorageRidingCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_RIDING_SKILL_ANNOUCEMENT_BANNER), zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RIDING_SKILL_IMPROVEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        -- Display Alert (Detailed alert if purchased at the stables, simple alert if using skill upgrade books to avoid spam)
        if ChatAnnouncements.SV.Notify.StorageRidingAlert then
            local text
            if source == RIDING_TRAIN_SOURCE_ITEM then
                text = zo_strformat(SI_RIDING_SKILL_IMPROVEMENT_ALERT, GetString("SI_RIDINGTRAINTYPE", ridingSkill))
            else
                text = zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current)
            end
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end

        return true
    end

    local function LoreBookLearnedAlertHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, isMaxRank)
        if guildReputationIndex == 0 or isMaxRank then
            -- We only want to fire this event if a player is not part of the guild or if they've reached max level in the guild.
            -- Otherwise, the _SKILL_EXPERIENCE version of this event will send a center screen message instead.

            local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)

            if not hidden or ChatAnnouncements.SV.Lorebooks.LorebookShowHidden then

                local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
                local bookName
                local bookLink
                if ChatAnnouncements.SV.BracketOptionLorebook == 1 then
                    bookName = string.format("%s", title)
                    bookLink = string.format("|H0:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
                else
                    bookName = string.format("[%s]", title)
                    bookLink = string.format("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
                end

                local stringPrefix
                local csaPrefix
                if categoryIndex == 1 then
                    -- Is a lore book
                    stringPrefix = ChatAnnouncements.SV.Lorebooks.LorebookPrefix1
                    csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED)
                else
                    -- Is a normal book
                    stringPrefix = ChatAnnouncements.SV.Lorebooks.LorebookPrefix2
                    csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LUIE_CA_LOREBOOK_BOOK)
                end

                -- Chat Announcement
                if ChatAnnouncements.SV.Lorebooks.LorebookCA then
                    local formattedIcon = ChatAnnouncements.SV.Lorebooks.LorebookIcon and ("|t16:16:" .. icon .. "|t ") or ""
                    local stringPart1
                    local stringPart2
                    if stringPrefix ~= "" then
                        stringPart1 = LorebookColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Lorebooks.LorebookBracket], stringPrefix, bracket2[ChatAnnouncements.SV.Lorebooks.LorebookBracket]))
                    else
                        stringPart1 = ""
                    end
                    if ChatAnnouncements.SV.Lorebooks.LorebookCategory then
                        stringPart2 = collectionName ~= "" and LorebookColorize2:Colorize(zo_strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName)) or LorebookColorize2:Colorize(zo_strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                    else
                        stringPart2 = ""
                    end

                    local finalMessage = zo_strformat("<<1>><<2>><<3>><<4>>", stringPart1, formattedIcon, bookLink, stringPart2)
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "COLLECTIBLE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end

                -- Alert Announcement
                if ChatAnnouncements.SV.Lorebooks.LorebookAlert then
                    local text = collectionName ~= "" and zo_strformat("<<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName) or zo_strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY))
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat("<<1>> <<2>>", title, text))
                end

                -- Center Screen Announcement
                if ChatAnnouncements.SV.Lorebooks.LorebookCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_ACQUIRED)
                    if collectionName ~= "" then
                        messageParams:SetText(csaPrefix, zo_strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, collectionName))
                    else
                        messageParams:SetText(csaPrefix, zo_strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                    end
                    messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_BOOK_LEARNED)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                if not ChatAnnouncements.SV.Lorebooks.LorebookCSA then
                    PlaySound(SOUNDS.BOOK_ACQUIRED)
                end
            end
        end
        return true
    end

        -----------------------------
    -- DUEL ALERTS --------------
    -----------------------------

    -- EVENT_DUEL_INVITE_RECEIVED - ALERT HANDLER
    local function DuelInviteReceivedAlert(inviterCharacterName, inviterDisplayName)
        -- Display CA
        if ChatAnnouncements.SV.Social.DuelCA then
            local finalName = ChatAnnouncements.ResolveNameLink(inviterCharacterName, inviterDisplayName)
            printToChat(zo_strformat(GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), finalName), true)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Social.DuelAlert then
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(inviterCharacterName, inviterDisplayName)
            local formattedString = zo_strformat(GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), finalAlertName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
        end

        return true
    end

    -- EVENT_DUEL_INVITE_ACCEPTED - ALERT HANDLER
    local function DuelInviteAcceptedAlert()
        -- Display CA
        if ChatAnnouncements.SV.Social.DuelCA then
            printToChat(GetString(SI_LUIE_CA_DUEL_INVITE_ACCEPTED), true)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Social.DuelAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.DUEL_ACCEPTED, GetString(SI_LUIE_CA_DUEL_INVITE_ACCEPTED) )
        end

        -- Play sound if we don't have the Alert turned on
        if not ChatAnnouncements.SV.Social.DuelAlert then
            PlaySound(SOUNDS.DUEL_ACCEPTED)
        end
        return true
    end

    -- EVENT_DUEL_INVITE_SENT - ALERT HANDLER
    local function DuelInviteSentAlert(inviteeCharacterName, inviteeDisplayName)
        -- Display CA
        if ChatAnnouncements.SV.Social.DuelCA then
            local finalName = ChatAnnouncements.ResolveNameLink(inviteeCharacterName, inviteeDisplayName)
            printToChat(zo_strformat(GetString(SI_LUIE_CA_DUEL_INVITE_SENT), finalName), true)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Social.DuelAlert then
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(inviteeCharacterName, inviteeDisplayName)
            local formattedString = zo_strformat(GetString(SI_LUIE_CA_DUEL_INVITE_SENT), finalAlertName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
        end
        return true
    end

    -- Register Strings here for Alert and CSA Handlers

    -- Player to Player replacement strings for Duels
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_DUEL, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 5)
    SafeAddString(SI_DUEL_INVITE_MESSAGE, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 5)
    SafeAddString(SI_PLAYER_TO_PLAYER_INVITE_DUEL, GetString(SI_LUIE_CA_DUEL_INVITE_PLAYER), 5)
    -- TODO - These are likely a standard error response string for Duels
    SafeAddString(SI_DUELSTATE1, GetString(SI_LUIE_CA_DUEL_STATE1), 5)
    SafeAddString(SI_DUELSTATE1, GetString(SI_LUIE_CA_DUEL_STATE2), 5)
    -- Group Player to Player notification replacement
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GROUP, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), 5)
    -- Guild Invite Player to Player notification replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GUILD_REQUEST, GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), 1)
    SafeAddString(SI_GUILD_INVITE_MESSAGE, GetString(SI_LUIE_CA_GUILD_INVITE_MESSAGE), 3)
    -- Friend Invite String Replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_FRIEND_REQUEST, GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST), 5)
    -- Quest Share String Replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_QUEST_SHARE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P), 5)
    SafeAddString(SI_QUEST_SHARE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P), 5)
    -- Trade String Replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_TRADE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
    SafeAddString(SI_TRADE_INVITE_MESSAGE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
    -- Mail String Replacements
    SafeAddString(SI_SENDMAILRESULT2, GetString(SI_LUIE_CA_MAIL_SENDMAILRESULT2), 5)
    SafeAddString(SI_SENDMAILRESULT3, GetString(SI_LUIE_CA_MAIL_SENDMAILRESULT3), 5)

    -- EVENT_DUEL_INVITE_FAILED -- ALERT HANDLER
    local function DuelInviteFailedAlert(reason, targetCharacterName, targetDisplayName)
        local userFacingName = ZO_GetPrimaryPlayerNameWithSecondary(targetDisplayName, targetCharacterName)
        -- Display CA
        if ChatAnnouncements.SV.Social.DuelCA then
            local reasonName
            local finalName = ChatAnnouncements.ResolveNameLink(targetDisplayName, targetCharacterName)
            if userFacingName then
                printToChat(zo_strformat(GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason), finalName), true)
            else
                printToChat(zo_strformat(GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason)), true)
            end
        end

        -- Display Alert
        if ChatAnnouncements.SV.Social.DuelAlert then
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(targetDisplayName, targetCharacterName)
            local formattedString = zo_strformat(GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason), finalAlertName)
            if userFacingName then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, formattedString)
            else
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason)))
            end
        end

        -- Play sound if we don't have the Alert turned on
        if not ChatAnnouncements.SV.Social.DuelAlert then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_DUEL_INVITE_DECLINED -- ALERT HANDLER
    local function DuelInviteDeclinedAlert()
        -- Display CA
        if ChatAnnouncements.SV.Social.DuelCA then
            printToChat(GetString(SI_LUIE_CA_DUEL_INVITE_DECLINED), true)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Social.DuelAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, GetString(SI_LUIE_CA_DUEL_INVITE_DECLINED))
        end

        -- Play sound if we don't have the Alert turned on
        if not ChatAnnouncements.SV.Social.DuelAlert then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_DUEL_INVITE_CANCELED -- ALERT HANDLER
    local function DuelInviteCanceledAlert()
        -- Display CA
        if ChatAnnouncements.SV.Social.DuelCA then
            printToChat(GetString(SI_LUIE_CA_DUEL_INVITE_CANCELED), true)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Social.DuelAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, GetString(SI_LUIE_CA_DUEL_INVITE_CANCELED))
        end

        -- Play sound if we don't have the Alert turned on
        if not ChatAnnouncements.SV.Social.DuelAlert then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_PLEDGE_OF_MARA_RESULT -- ALERT HANDLER
    local function PledgeOfMaraResultAlert(result, characterName, displayName)
        -- Replace everything here and move it all into the CSA handler event
        return true
    end

    -- EVENT_GROUP_INVITE_RESPONSE -- ALERT HANDLER
    local function GroupInviteResponseAlert(characterName, response, displayName)
        local finalName
        local finalAlertName

        local nameCheck1 = ZO_GetPrimaryPlayerName(displayName, characterName)
        local nameCheck2 = ZO_GetSecondaryPlayerName(displayName, characterName)

        if nameCheck1 == "" then
            finalName = displayName
            finalAlertName = displayName
        elseif nameCheck2 == "" then
            finalName = characterName
            finalAlertName = characterName
        elseif nameCheck1 ~= "" and nameCheck2 ~= "" then
            finalName = ChatAnnouncements.ResolveNameLink(characterName, displayName)
            finalAlertName = ChatAnnouncements.ResolveNameNoLink(characterName, displayName)
        else
            finalName = ""
            finalAlertName = ""
        end

        if(response ~= GROUP_INVITE_RESPONSE_ACCEPTED and response ~= GROUP_INVITE_RESPONSE_CONSIDERING_OTHER) then
            local message
            local alertMessage

            if response == GROUP_INVITE_RESPONSE_ALREADY_GROUPED and (LUIE.PlayerNameFormatted == characterName or LUIE.PlayerDisplayName == displayName) then
                message = zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_SELF_INVITE))
                alertMessage = zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_SELF_INVITE))
            elseif response == GROUP_INVITE_RESPONSE_ALREADY_GROUPED and (IsPlayerInGroup(characterName) or IsPlayerInGroup(displayName)) then
                message = GetString(SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER)
                alertMessage = GetString(SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER)
            elseif response == GROUP_INVITE_RESPONSE_IGNORED then
                message = finalName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalName) or GetString(SI_PLAYER_BUSY)
                alertMessage = finalAlertName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalAlertName) or GetString(SI_PLAYER_BUSY)
            else
                message = finalName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalName) or characterName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), characterName) or GetString(SI_PLAYER_BUSY)
                alertMessage = finalAlertName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalAlertName) or characterName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), characterName) or GetString(SI_PLAYER_BUSY)
            end

            if ChatAnnouncements.SV.Group.GroupCA or response == GROUP_INVITE_RESPONSE_ALREADY_GROUPED or response == GROUP_INVITE_RESPONSE_IGNORED or response == GROUP_INVITE_RESPONSE_PLAYER_NOT_FOUND then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)

        end
        return true
    end

    -- EVENT_GROUP_INVITE_ACCEPT_RESPONSE_TIMEOUT -- ALERT HANDLER
    local function GroupInviteTimeoutAlert()
        printToChat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_GENERIC_JOIN_FAILURE), true)
        if ChatAnnouncements.SV.Group.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_GENERIC_JOIN_FAILURE))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return true
    end

    -- EVENT_GROUP_NOTIFICATION_MESSAGE -- ALERT HANDLER
    local function GroupNotificationMessageAlert(groupMessageCode)
        if groupMessageCode == GROUP_MSG_YOU_ARE_NOT_IN_A_GROUP then
            printToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP), true)
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        elseif groupMessageCode == GROUP_MSG_YOU_ARE_NOT_THE_LEADER then
            printToChat(GetString(SI_GROUP_NOTIFICATION_GROUP_MSG_INVALID_MEMBER), true)
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        elseif groupMessageCode == GROUP_MSG_INVALID_MEMBER then
            printToChat(GetString(SI_GROUP_NOTIFICATION_GROUP_MSG_INVALID_MEMBER), true)
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_GROUP_NOTIFICATION_GROUP_MSG_INVALID_MEMBER))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_GROUP_UPDATE -- ALERT HANDLER
    local function GroupUpdateAlert()
        currentGroupLeaderRawName = ""
        currentGroupLeaderDisplayName = ""

        if g_groupJoinFudger then
            zo_callLater(ChatAnnouncements.CheckLFGStatusJoin, 100)
        end
        g_groupJoinFudger = false
    end

    -- EVENT_GROUP_MEMBER_LEFT -- ALERT HANDLER
    local function GroupMemberLeftAlert(characterName, reason, isLocalPlayer, isLeader, displayName, actionRequiredVote)
        ChatAnnouncements.IndexGroupLoot()

        local message = nil
        local alert = nil
        local message2 = nil
        local alert2 = nil
        local sound = nil

        local finalName = ChatAnnouncements.ResolveNameLink(characterName, displayName)
        local finalAlertName = ChatAnnouncements.ResolveNameNoLink(characterName, displayName)

        -- Used to check for valid links
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(characterName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)

        local hasValidNames = characterNameLink ~= "" and displayNameLink ~= ""
        local useDefaultReasonText = false
        if reason == GROUP_LEAVE_REASON_DISBAND then
            if isLeader and not isLocalPlayer then
                useDefaultReasonText = true
            elseif isLeader and isLocalPlayer then
                message = zo_strformat(SI_LUIE_GROUPDISBANDLEADER)
                alert = zo_strformat(SI_LUIE_GROUPDISBANDLEADER)
                g_LFGJoinAntiSpam = false
                zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(false) end , 100)
            elseif isLocalPlayer then
            --
            g_LFGJoinAntiSpam = false
            zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(false) end , 100)
            --
            end

            sound = SOUNDS.GROUP_DISBAND
        elseif reason == GROUP_LEAVE_REASON_KICKED then
            if actionRequiredVote then
                if isLocalPlayer then
                    --
                    g_LFGJoinAntiSpam = false
                    zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(true) end , 100)
                    --
                    message = zo_strformat(SI_GROUP_ELECTION_KICK_PLAYER_PASSED)
                    alert = zo_strformat(SI_GROUP_ELECTION_KICK_PLAYER_PASSED)
                elseif hasValidNames then
                    --
                    zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(false) end , 100)
                    --
                    message = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED, finalName)
                    alert = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED, finalAlertName)
                    message2 = (zo_strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED), finalName))
                    alert2 =  (zo_strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED), finalAlertName))
                end
            else
                if isLocalPlayer then
                    --
                    g_LFGJoinAntiSpam = false
                    zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(true) end , 100)
                    --
                    message = zo_strformat(SI_GROUP_NOTIFICATION_GROUP_SELF_KICKED)
                    alert = zo_strformat(SI_GROUP_NOTIFICATION_GROUP_SELF_KICKED)
                else
                    --
                    zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(false) end , 100)
                    --
                    useDefaultReasonText = true
                end
            end

            sound = SOUNDS.GROUP_KICK
        elseif reason == GROUP_LEAVE_REASON_VOLUNTARY or reason == GROUP_LEAVE_REASON_LEFT_BATTLEGROUND then
            if not isLocalPlayer then
                useDefaultReasonText = true
                --
                zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(false) end , 100)
                --
            else
                --
                g_LFGJoinAntiSpam = false
                message = (zo_strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF), finalName))
                alert = (zo_strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF), finalAlertName))
                zo_callLater(function() ChatAnnouncements.CheckLFGStatusLeave(false) end , 100)
                --
            end

            sound = SOUNDS.GROUP_LEAVE
        elseif reason == GROUP_LEAVE_REASON_DESTROYED then
            --do nothing, we don't want to show additional alerts for this case
        end

        if useDefaultReasonText and hasValidNames then
            message = zo_strformat(GetString("SI_LUIE_GROUPLEAVEREASON", reason), finalName)
            alert = zo_strformat(GetString("SI_LUIE_GROUPLEAVEREASON", reason), finalAlertName)
        end

        if isLocalPlayer then
            currentGroupLeaderRawName = ""
            currentGroupLeaderDisplayName = ""
        end

        if message ~= nil then
            if ChatAnnouncements.SV.Group.GroupCA then
                printToChat(message, true)
            end
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alert)
            end
            if sound ~= nil then PlaySound(sound) end
        end

        if message2 ~= nil then
            if ChatAnnouncements.SV.Group.GroupCA then
                printToChat(message2, true)
            end
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alert2)
            end
        end

        return true
    end

    -- EVENT_LEADER_UPDATE -- ALERT HANDLER
    -- This event only fires if the characterId of the leader has changed (it's a new leader)
    local function LeaderUpdateAlert(leaderTag)
        local leaderRawName = GetRawUnitName(leaderTag)
        local showAlert = leaderRawName ~= "" and currentGroupLeaderRawName ~= ""
        currentGroupLeaderRawName = leaderRawName
        currentGroupLeaderDisplayName = GetUnitDisplayName(leaderTag)

        -- If for some reason we don't have a valid leader name, bail out now.
        if currentGroupLeaderRawName == "" or currentGroupLeaderRawName == nil or currentGroupLeaderDisplayName == "" or currentGroupLeaderDisplayName == nil then
            return
        end

        local displayString
        local alertString
        local finalName = ChatAnnouncements.ResolveNameLink(currentGroupLeaderRawName, currentGroupLeaderDisplayName)
        local finalAlertName = ChatAnnouncements.ResolveNameNoLink(currentGroupLeaderRawName, currentGroupLeaderDisplayName)

        if LUIE.PlayerNameRaw ~= currentGroupLeaderRawName then -- If another player became the leader
            displayString = (zo_strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), finalName))
            alertString = (zo_strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), finalAlertName))
        elseif LUIE.PlayerNameRaw == currentGroupLeaderRawName then -- If the player character became the leader
            displayString = (GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF))
            alertString = (GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF))
        end

        if showAlert then
            if ChatAnnouncements.SV.Group.GroupCA then
                printToChat(displayString, true)
            end
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
            end
            PlaySound(SOUNDS.GROUP_PROMOTE)
        end
        return true
    end

    -- EVENT_GROUPING_TOOLS_LFG_JOINED -- ALERT HANDLER
    local function GroupingToolsLFGJoinedAlert(locationName)
        if not g_LFGJoinAntiSpam then
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(zo_strformat(SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED, locationName), true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED, locationName))
            end
            zo_callLater (function() g_rcUpdateDeclineOverride = false end, 5000)
            g_lfgDisableGroupEvents = true
            zo_callLater (function() g_lfgDisableGroupEvents = false end, 2500)
        end
        g_joinLFGOverride = true
        g_LFGJoinAntiSpam = true
        g_rcUpdateDeclineOverride = true

        return true
    end

    -- EVENT_ACTIVITY_QUEUE_RESULT -- ALERT HANDLER
    local function ActivityQueueResultAlert(result)
        if result ~= ACTIVITY_QUEUE_RESULT_SUCCESS then
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(GetString("SI_ACTIVITYQUEUERESULT", result), true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_ACTIVITYQUEUERESULT", result))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        g_showRCUpdates = true

        return true
    end

    -- EVENT_GROUP_ELECTION_FAILED -- ALERT HANDLER
    local function GroupElectionFailedAlert(failureType, descriptor)
        if failureType ~= GROUP_ELECTION_FAILURE_NONE then
            if ChatAnnouncements.SV.Group.GroupVoteCA then
                printToChat(GetString("SI_GROUPELECTIONFAILURE", failureType), true)
            end
            if ChatAnnouncements.SV.Group.GroupVoteAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_GROUPELECTIONFAILURE", failureType))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- Variables for EVENT_GROUP_ELECTION_RESULT
    local GroupElectionResultToSoundId = {
        [GROUP_ELECTION_RESULT_ELECTION_WON] = SOUNDS.GROUP_ELECTION_RESULT_WON,
        [GROUP_ELECTION_RESULT_ELECTION_LOST] = SOUNDS.GROUP_ELECTION_RESULT_LOST,
        [GROUP_ELECTION_RESULT_ABANDONED] = SOUNDS.GROUP_ELECTION_RESULT_LOST,
    }

    -- EVENT_GROUP_ELECTION_RESULT -- ALERT HANDLER
    local function GroupElectionResultAlert(resultType, descriptor)
        if resultType ~= GROUP_ELECTION_RESULT_IN_PROGRESS and resultType ~= GROUP_ELECTION_RESULT_NOT_APPLICABLE then
            resultType = ZO_GetSimplifiedGroupElectionResultType(resultType)
            local alertText
            local message

            --Try to find override messages based on the descriptor
            local alertTextOverrideLookup = ZO_GroupElectionResultToAlertTextOverrides[resultType]
            if alertTextOverrideLookup then
                message = alertTextOverrideLookup[descriptor]
                alertText = alertTextOverrideLookup[descriptor]
            end

            --No override found
            if not alertText then
                local electionType, _, _, targetUnitTag = GetGroupElectionInfo()
                if electionType == GROUP_ELECTION_TYPE_KICK_MEMBER then
                    if resultType == GROUP_ELECTION_RESULT_ELECTION_LOST then
                        local kickMemberName = GetUnitName(targetUnitTag)
                        local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)

                        local kickFinalName = ChatAnnouncements.ResolveNameLink(kickMemberName, kickMemberAccountName)
                        local kickfinalAlertName = ChatAnnouncements.ResolveNameNoLink(kickMemberName, kickMemberAccountName)

                        message = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL, kickFinalName)
                        alertText = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL, kickfinalAlertName)
                    else
                        --Successful kicks are handled in the GROUP_MEMBER_LEFT alert
                        return true
                    end
                end
            end

            --No specific behavior found, so just do the generic alert for the result
            if not alertText then
                message = GetString("SI_GROUPELECTIONRESULT", resultType)
                alertText = GetString("SI_GROUPELECTIONRESULT", resultType)
            end

            if alertText ~= "" then
                if type(alertText) == "function" then
                    alertText = alertText()
                    message = message()
                end

                if ChatAnnouncements.SV.Group.GroupVoteCA then
                    printToChat(message, true)
                end
                if ChatAnnouncements.SV.Group.GroupVoteAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
                end
                PlaySound(GroupElectionResultToSoundId[resultType])
            end
        end
        return true
    end

    -- EVENT_GROUP_ELECTION_REQUESTED -- ALERT HANDLER
    local function GroupElectionRequestedAlert(descriptor)
        local alertText
        if descriptor then
            alertText = ZO_GroupElectionDescriptorToRequestAlertText[descriptor]
        end

        if not alertText then
            alertText = ZO_GroupElectionDescriptorToRequestAlertText[ZO_GROUP_ELECTION_DESCRIPTORS.NONE]
        end

        if ChatAnnouncements.SV.Group.GroupVoteCA then
            printToChat(alertText, true)
        end
        if ChatAnnouncements.SV.Group.GroupVoteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
        end
        PlaySound(SOUNDS.GROUP_ELECTION_REQUESTED)
        return true
    end

    -- EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED -- ALERT HANDLER
    local function GroupReadyCheckCancelAlert(reason)
        --[[
        if reason ~= LFG_READY_CHECK_CANCEL_REASON_NOT_IN_READY_CHECK then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LFGREADYCHECKCANCELREASON", reason))
            d(GetString("SI_LFGREADYCHECKCANCELREASON", reason))
        end]]--

        if reason ~= LFG_READY_CHECK_CANCEL_REASON_NOT_IN_READY_CHECK and reason ~= LFG_READY_CHECK_CANCEL_REASON_GROUP_FORMED_SUCCESSFULLY then
            if ChatAnnouncements.SV.Group.GroupLFGCA then
                printToChat(GetString("SI_LFGREADYCHECKCANCELREASON", reason), true)
            end
            if ChatAnnouncements.SV.Group.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LFGREADYCHECKCANCELREASON", reason))
            end
        end

        -- Sometimes if another player cancels slightly before a player in your group cancels, the "you have been placed in the front of the queue message displays. If this is the case, we want to show queue left for that event."
        if reason ~= LFG_READY_CHECK_CANCEL_REASON_GROUP_REPLACED_IN_QUEUE then
            g_showActivityStatus = false
            zo_callLater(function() g_showActivityStatus = true end, 1000)
        end

        g_showRCUpdates = true
    end

    -- EVENT_GROUP_VETERAN_DIFFICULTY_CHANGED -- ALERT HANDLER
    local function GroupDifficultyChangeAlert(isVeteranDifficulty)
        local message
        local sound
        if isVeteranDifficulty then
            message = GetString(SI_DUNGEON_DIFFICULTY_CHANGED_TO_VETERAN)
            sound = SOUNDS.DUNGEON_DIFFICULTY_VETERAN
        else
            message = GetString(SI_DUNGEON_DIFFICULTY_CHANGED_TO_NORMAL)
            sound = SOUNDS.DUNGEON_DIFFICULTY_NORMAL
        end

        if ChatAnnouncements.SV.Group.GroupCA then
            printToChat(message, true)
        end
        if ChatAnnouncements.SV.Group.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        PlaySound(sound)

        return true
    end

    -- EVENT_GUILD_SELF_LEFT_GUILD -- ALERT HANDLER
    local function GuildSelfLeftAlert(guildId, guildName)
        local GuildIndexData = LUIE.GuildIndexData
        for i = 1,5 do
            local guild = GuildIndexData[i]
            if guild.name == guildName then
                local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guild.guildAlliance) or GuildColorize
                local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guild.guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
                local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guild.guildAlliance), "100%", "100%", guildName) or guildName
                local messageString = (ShouldDisplaySelfKickedFromGuildAlert(guildId)) and SI_GUILD_SELF_KICKED_FROM_GUILD or SI_LUIE_CA_GUILD_LEAVE_SELF
                local sound = (ShouldDisplaySelfKickedFromGuildAlert(guildId)) and SOUNDS.GENERAL_ALERT_ERROR or SOUNDS.GUILD_SELF_LEFT
                if ChatAnnouncements.SV.Social.GuildCA then
                    printToChat(zo_strformat(GetString(messageString), guildNameAlliance), true)
                end
                if ChatAnnouncements.SV.Social.GuildAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(messageString), guildNameAllianceAlert))
                end
                PlaySound(sound)
                break
            end
        end

        -- Reindex Guild Ranks
        g_guildRankData = {}
        for i = 1,5 do
            local guildId = GetGuildId(i)
            local memberIndex = GetPlayerGuildMemberIndex(guildId)
            local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
            g_guildRankData[guildId] = rankIndex
        end
        return true
    end

    -- EVENT_SAVE_GUILD_RANKS_RESPONSE -- ALERT HANDLER
    local function GuildRanksResponseAlert(guildId, result)
        if result ~= SOCIAL_RESULT_NO_ERROR then
            if ChatAnnouncements.SV.Social.GuildCA then
                printToChat(GetString("SI_SOCIALACTIONRESULT", result), true)
            elseif ChatAnnouncements.SV.Social.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_SOCIALACTIONRESULT", result))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    local function LockpickFailedAlert(result)
        if ChatAnnouncements.SV.Notify.NotificationLockpickCA then
            local message = GetString(SI_LUIE_CA_LOCKPICK_FAILED)
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "NOTIFICATION" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.NotificationLockpickAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_LOCKPICK_FAILED))
        end
        g_lockpickBroken = true
        zo_callLater (function() g_lockpickBroken = false end, 200)
        return true
    end

    local function LockpickLockedAlert(interactableName)
        printToChat(zo_strformat(SI_LOCKPICK_NO_KEY_AND_NO_LOCK_PICKS, interactableName))
        if ChatAnnouncements.SV.Notify.NotificationLockpickAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, zo_strformat(SI_LOCKPICK_NO_KEY_AND_NO_LOCK_PICKS, interactableName))
        end
        PlaySound(SOUNDS.LOCKPICKING_NO_LOCKPICKS)
        return true
    end

    local function LockpickImpossibleAlert(interactableName)
        printToChat(zo_strformat(SI_LOCKPICK_IMPOSSIBLE_LOCK, interactableName))
        if ChatAnnouncements.SV.Notify.NotificationLockpickAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, zo_strformat(SI_LOCKPICK_IMPOSSIBLE_LOCK, interactableName))
        end
        PlaySound(SOUNDS.LOCKPICKING_NO_LOCKPICKS)
        return true
    end

    -- EVENT_TRADE_INVITE_FAILED
    local function TradeInviteFailedAlert(errorReason, inviteeCharacterName, inviteeDisplayName)
        if ChatAnnouncements.SV.Notify.NotificationTradeCA or ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            local finalName = ChatAnnouncements.ResolveNameLink(inviteeCharacterName, inviteeDisplayName)
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(inviteeCharacterName, inviteeDisplayName)

            if ChatAnnouncements.SV.Notify.NotificationTradeCA then
                printToChat(zo_strformat(GetString("SI_LUIE_CA_TRADEACTIONRESULT", errorReason), finalName), true)
            end

            if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString("SI_LUIE_CA_TRADEACTIONRESULT", errorReason), finalAlertName))
            end
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        g_tradeTarget = ""
        return true
    end

    -- EVENT_TRADE_INVITE_CONSIDERING
    local function TradeInviteConsideringAlert(inviterCharacterName, inviterDisplayName)
        if ChatAnnouncements.SV.Notify.NotificationTradeCA or ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            local finalName = ChatAnnouncements.ResolveNameLink(inviterCharacterName, inviterDisplayName)
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(inviterCharacterName, inviterDisplayName)
            g_tradeTarget = ZO_SELECTED_TEXT:Colorize(zo_strformat(SI_UNIT_NAME, finalName))

            if ChatAnnouncements.SV.Notify.NotificationTradeCA then
                printToChat(zo_strformat(GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), finalName), true)
            end
            if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), finalAlertName))
            end
        end
       return true
    end

    -- EVENT_TRADE_INVITE_WAITING
    local function TradeInviteWaitingAlert(inviteeCharacterName, inviteeDisplayName)

        if ChatAnnouncements.SV.Notify.NotificationTradeCA or ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            local finalName = ChatAnnouncements.ResolveNameLink(inviteeCharacterName, inviteeDisplayName)
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(inviteeCharacterName, inviteeDisplayName)
            g_tradeTarget = ZO_SELECTED_TEXT:Colorize(zo_strformat(SI_UNIT_NAME, finalName))

            if ChatAnnouncements.SV.Notify.NotificationTradeCA then
                printToChat(zo_strformat(GetString(SI_LUIE_CA_TRADE_INVITE_CONFIRM), finalName), true)
            end
            if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_TRADE_INVITE_CONFIRM), finalAlertName))
            end

        end
        return true
    end

    -- EVENT_TRADE_INVITE_DECLINED
    local function TradeInviteDeclinedAlert()
        if ChatAnnouncements.SV.Notify.NotificationTradeCA then
            printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_DECLINED), true)
        end
        if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_TRADE_INVITE_DECLINED))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        g_tradeTarget = ""
        g_tradeStacksIn = {}
        g_tradeStacksOut = {}
        return true
    end

    -- EVENT_TRADE_INVITE_CANCELED
    local function TradeInviteCanceledAlert()
        if ChatAnnouncements.SV.Notify.NotificationTradeCA then
            printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_CANCELED), true)
        end
        if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_TRADE_INVITE_CANCELED))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        g_tradeTarget = ""
        g_tradeStacksIn = {}
        g_tradeStacksOut = {}
        return true
    end

    -- EVENT_TRADE_CANCELED
    local function TradeCanceledAlert()
        if ChatAnnouncements.SV.Notify.NotificationTradeCA then
            printToChat(GetString(SI_TRADE_CANCELED), true)
        end
        if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_TRADE_CANCELED))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)

        eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
        if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
            eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
        end
        if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
            g_inventoryStacks = {}
        end

        g_tradeTarget = ""
        g_tradeStacksIn = {}
        g_tradeStacksOut = {}
        g_inTrade = false
        return true
    end

    -- EVENT_TRADE_FAILED
    local function TradeFailedAlert(reason)
        if ChatAnnouncements.SV.Notify.NotificationTradeCA then
            printToChat(GetString("SI_LUIE_CA_TRADEACTIONRESULT", reason), true)
        end
        if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LUIE_CA_TRADEACTIONRESULT", reason))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)

        g_tradeTarget = ""
        return true
    end

    -- EVENT_TRADE_SUCCEEDED
    local function TradeSucceededAlert()
        if ChatAnnouncements.SV.Notify.NotificationTradeCA then
            local message = GetString(SI_TRADE_COMPLETE)
            g_queuedMessages[g_queuedMessagesCounter] = { message = message, type = "NOTIFICATION", isSystem = true }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end
        if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_TRADE_COMPLETE))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)

        if ChatAnnouncements.SV.Inventory.LootTrade then
            for indexOut = 1,5 do
                if g_tradeStacksOut[indexOut] ~= nil then
                    local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 2 or 4
                    local logPrefix = g_tradeTarget ~= "" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOut or ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOutNoName
                    local item = g_tradeStacksOut[indexOut]
                    ChatAnnouncements.ItemPrinter(item.icon, item.stack, item.itemType, item.itemId, item.itemLink, g_tradeTarget, logPrefix, gainOrLoss, false)
                end
            end

            for indexIn = 1,5 do
                if g_tradeStacksIn[indexIn] ~= nil then
                    local gainOrLoss = ChatAnnouncements.SV.Currency.CurrencyContextColor and 1 or 3
                    local logPrefix = g_tradeTarget ~= "" and ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeIn or ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeInNoName
                    local item = g_tradeStacksIn[indexIn]
                    ChatAnnouncements.ItemPrinter(item.icon, item.stack, item.itemType, item.itemId, item.itemLink, g_tradeTarget, logPrefix, gainOrLoss, false)
                end
            end
        end

        eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
        if ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise then
            eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
        end
        if not (ChatAnnouncements.SV.Inventory.Loot or ChatAnnouncements.SV.Inventory.LootShowDisguise) then
            g_inventoryStacks = {}
        end

        g_tradeTarget = ""
        g_tradeStacksIn = {}
        g_tradeStacksOut = { }
        g_inTrade = false
        return true
    end

    local function MailSendFailedAlert(reason)
        local function RestoreMailBackupValues()
            g_postageAmount = GetQueuedMailPostage()
            g_mailCOD = GetQueuedCOD()
        end

        -- Stop currency messages from printing here
        if reason == 2 then
            for i=1, #g_queuedMessages do
                if g_queuedMessages[i].type == "CURRENCY" then
                    g_queuedMessages[i].type = "GARBAGE"
                end
            end
            eventManager:UnregisterForEvent(moduleName, EVENT_CURRENCY_UPDATE)
            zo_callLater(function() eventManager:RegisterForEvent(moduleName, EVENT_CURRENCY_UPDATE, ChatAnnouncements.OnCurrencyUpdate) end, 500)
        end

        if ChatAnnouncements.SV.Notify.NotificationMailCA then
            printToChat(GetString("SI_SENDMAILRESULT", reason), true)
        end
        if ChatAnnouncements.SV.Notify.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_SENDMAILRESULT", reason))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)

        zo_callLater(RestoreMailBackupValues, 50) -- Prevents values from being cleared by failed message (when inbox is full, the currency change fires first regardless and then is refunded)
        return true
    end

    ZO_PreHook(alertHandlers, EVENT_LORE_BOOK_ALREADY_KNOWN, AlreadyKnowBookHook)
    ZO_PreHook(alertHandlers, EVENT_RIDING_SKILL_IMPROVEMENT, RidingSkillImprovementAlertHook)
    ZO_PreHook(alertHandlers, EVENT_LORE_BOOK_LEARNED, LoreBookLearnedAlertHook)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_RECEIVED, DuelInviteReceivedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_SENT, DuelInviteSentAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_ACCEPTED, DuelInviteAcceptedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_FAILED, DuelInviteFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_DECLINED, DuelInviteDeclinedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_CANCELED, DuelInviteCanceledAlert)
    ZO_PreHook(alertHandlers, EVENT_PLEDGE_OF_MARA_RESULT, PledgeOfMaraResultAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_INVITE_RESPONSE, GroupInviteResponseAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_INVITE_ACCEPT_RESPONSE_TIMEOUT, GroupInviteTimeoutAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_NOTIFICATION_MESSAGE, GroupNotificationMessageAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_UPDATE, GroupUpdateAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_MEMBER_LEFT, GroupMemberLeftAlert)
    ZO_PreHook(alertHandlers, EVENT_LEADER_UPDATE, LeaderUpdateAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUPING_TOOLS_LFG_JOINED, GroupingToolsLFGJoinedAlert)
    ZO_PreHook(alertHandlers, EVENT_ACTIVITY_QUEUE_RESULT, ActivityQueueResultAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_ELECTION_FAILED, GroupElectionFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_ELECTION_RESULT, GroupElectionResultAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_ELECTION_REQUESTED, GroupElectionRequestedAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED, GroupReadyCheckCancelAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_VETERAN_DIFFICULTY_CHANGED, GroupDifficultyChangeAlert)

    eventManager:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_REMOVED, ChatAnnouncements.GroupInviteRemoved)
    eventManager:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED, ChatAnnouncements.OnGroupMemberJoined)
    eventManager:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_RECEIVED, ChatAnnouncements.OnGroupInviteReceived)
    eventManager:RegisterForEvent(moduleName, EVENT_GROUP_TYPE_CHANGED, ChatAnnouncements.OnGroupTypeChanged)
    eventManager:RegisterForEvent(moduleName, EVENT_GROUP_ELECTION_NOTIFICATION_ADDED, ChatAnnouncements.VoteNotify)
    eventManager:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_NO_LONGER_LFG, ChatAnnouncements.LFGLeft)
    eventManager:RegisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, ChatAnnouncements.ActivityStatusUpdate)
    eventManager:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED, ChatAnnouncements.ReadyCheckUpdate)

    ZO_PreHook(alertHandlers, EVENT_GUILD_SELF_LEFT_GUILD, GuildSelfLeftAlert)
    ZO_PreHook(alertHandlers, EVENT_SAVE_GUILD_RANKS_RESPONSE, GuildRanksResponseAlert)
    ZO_PreHook(alertHandlers, EVENT_LOCKPICK_FAILED, LockpickFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_INTERACTABLE_LOCKED, LockpickLockedAlert)
    ZO_PreHook(alertHandlers, EVENT_INTERACTABLE_IMPOSSIBLE_TO_PICK, LockpickImpossibleAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_FAILED, TradeInviteFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_CONSIDERING, TradeInviteConsideringAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_WAITING, TradeInviteWaitingAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_DECLINED, TradeInviteDeclinedAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_CANCELED, TradeInviteCanceledAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_CANCELED, TradeCanceledAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_FAILED, TradeFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_SUCCEEDED, TradeSucceededAlert)
    ZO_PreHook(alertHandlers, EVENT_MAIL_SEND_FAILED, MailSendFailedAlert)

    local csaHandlers = ZO_CenterScreenAnnounce_GetEventHandlers()
    local csaCallbackHandlers = ZO_CenterScreenAnnounce_GetCallbackHandlers()

    local chatHandlers = ZO_ChatSystem_GetEventHandlers()

    local function LoreBookXPHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, skillType, skillIndex, rank, previousXP, currentXP)
        if guildReputationIndex > 0 then
            local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
            local bookName
            local bookLink
            if ChatAnnouncements.SV.BracketOptionLorebook == 1 then
                bookName = string.format("%s", title)
                bookLink = string.format("|H0:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
            else
                bookName = string.format("[%s]", title)
                bookLink = string.format("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
            end

            local stringPrefix
            local csaPrefix
            if categoryIndex == 1 then
                -- Is a lore book
                stringPrefix = ChatAnnouncements.SV.Lorebooks.LorebookPrefix1
                csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED)
            else
                -- Is a normal book
                stringPrefix = ChatAnnouncements.SV.Lorebooks.LorebookPrefix2
                csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LUIE_CA_LOREBOOK_BOOK)
            end

            -- Chat Announcement
            if ChatAnnouncements.SV.Lorebooks.LorebookCA then
                local formattedIcon = ChatAnnouncements.SV.Lorebooks.LorebookIcon and ("|t16:16:" .. icon .. "|t ") or ""
                local stringPart1
                local stringPart2
                if stringPrefix ~= "" then
                    stringPart1 = LorebookColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Lorebooks.LorebookBracket], stringPrefix, bracket2[ChatAnnouncements.SV.Lorebooks.LorebookBracket]))
                else
                    stringPart1 = ""
                end
                if ChatAnnouncements.SV.Lorebooks.LorebookCategory then
                    stringPart2 = collectionName ~= "" and LorebookColorize2:Colorize(zo_strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName)) or LorebookColorize2:Colorize(zo_strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                else
                    stringPart2 = ""
                end

                local finalMessage = zo_strformat("<<1>><<2>><<3>><<4>>", stringPart1, formattedIcon, bookLink, stringPart2)
                g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "COLLECTIBLE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            -- Alert Announcement
            if ChatAnnouncements.SV.Lorebooks.LorebookAlert then
                local text = collectionName ~= "" and zo_strformat("<<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName) or zo_strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY))
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat("<<1>> <<2>>", title, text))
            end

            -- Center Screen Announcement
            if ChatAnnouncements.SV.Lorebooks.LorebookCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_ACQUIRED)
                if not LUIE.SV.HideXPBar then
                    local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                    local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                    messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP))
                end
                if collectionName ~= "" then
                    messageParams:SetText(csaPrefix, zo_strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, collectionName))
                else
                    messageParams:SetText(csaPrefix, zo_strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                end
                messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_BOOK_LEARNED_SKILL_EXPERIENCE)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            if not ChatAnnouncements.SV.Lorebooks.LorebookCSA then
                PlaySound(SOUNDS.BOOK_ACQUIRED)
            end
        end
        return true
    end

    local function LoreCollectionHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, isMaxRank)
        if guildReputationIndex == 0 or isMaxRank then
            -- Only fire this message if we're not part of the guild or at max level within the guild.
            -- TODO: Fix, this condition doesn't work
            local collectionName, description, numKnownBooks, totalBooks, hidden , textureName = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local stringPrefix = ChatAnnouncements.SV.Lorebooks.LorebookCollectionPrefix
            local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE)
            if not hidden or ChatAnnouncements.SV.Lorebooks.LorebookShowHidden then

                if ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA then
                    local formattedIcon
                    local stringPart1
                    local stringPart2
                    if stringPrefix ~= "" then
                        stringPart1 = LorebookColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Lorebooks.LorebookBracket], stringPrefix, bracket2[ChatAnnouncements.SV.Lorebooks.LorebookBracket]))
                    else
                        stringPart1 = ""
                    end
                    if textureName ~= "" and textureName ~= nil then
                        formattedIcon = ChatAnnouncements.SV.Lorebooks.LorebookIcon and ("|t16:16:" .. textureName .. "|t ") or ""
                    end
                    if ChatAnnouncements.SV.Lorebooks.LorebookCategory then
                        stringPart2 = LorebookColorize2:Colorize(zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    else
                        stringPart2 = ""
                    end

                    local finalMessage = zo_strformat("<<1>><<2>><<3>>", stringPart1, formattedIcon, stringPart2)
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "COLLECTIBLE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end

                if ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_COLLECTION_COMPLETED)
                    messageParams:SetText(csaPrefix, zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    messageParams:SetIconData(textureName)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_COLLECTION_COMPLETED)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end

                if ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert then
                   local text = zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName)
                   ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
                end
                if not ChatAnnouncements.SV.Lorebooks.LorebookCSA then
                    PlaySound(SOUNDS.BOOK_COLLECTION_COMPLETED)
                end
            end
        end
        return true
    end

    local function LoreCollectionXPHook(categoryIndex, collectionIndex, guildReputationIndex, skillType, skillIndex, rank, previousXP, currentXP)
        if guildReputationIndex > 0 then
            local collectionName, description, numKnownBooks, totalBooks, hidden, textureName = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local stringPrefix = ChatAnnouncements.SV.Lorebooks.LorebookCollectionPrefix
            local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE)
            if not hidden or ChatAnnouncements.SV.Lorebooks.LorebookShowHidden then

                if ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA then
                    local formattedIcon
                    local stringPart1
                    local stringPart2
                    if stringPrefix ~= "" then
                        stringPart1 = LorebookColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Lorebooks.LorebookBracket], stringPrefix, bracket2[ChatAnnouncements.SV.Lorebooks.LorebookBracket]))
                    else
                        stringPart1 = ""
                    end
                    if textureName ~= "" and textureName ~= nil then
                        formattedIcon = ChatAnnouncements.SV.Lorebooks.LorebookIcon and zo_strformat("<<1>> ", zo_iconFormatInheritColor(textureName, 16, 16)) or ""
                    end
                    if ChatAnnouncements.SV.Lorebooks.LorebookCategory then
                        stringPart2 = LorebookColorize2:Colorize(zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    else
                        stringPart2 = ""
                    end

                    local finalMessage = zo_strformat("<<1>><<2>><<3>>", stringPart1, formattedIcon, stringPart2)
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "COLLECTIBLE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end

                if ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_COLLECTION_COMPLETED)
                    if not LUIE.SV.HideXPBar then
                        local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                        local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                        messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP))
                    end
                    messageParams:SetText(csaPrefix, zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    messageParams:SetIconData(textureName)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end

                if ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert then
                   local text = zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName)
                   ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
                end
                if not ChatAnnouncements.SV.Lorebooks.LorebookCSA then
                    PlaySound(SOUNDS.BOOK_COLLECTION_COMPLETED)
                end
            end
        end
        return true
    end

	local function SkillPointsChangedHook(oldPoints, newPoints, oldPartialPoints, newPartialPoints, changeReason)
		local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
		local numSkillPointsGained = newPoints - oldPoints
		local stringPrefix = ChatAnnouncements.SV.Skills.SkillPointSkyshard
		local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_SKYSHARD_GAINED)

		local stringPart1 -- CA
		local stringPart2 -- CA
		local finalMessage -- CA
		local finalText -- Alert
		local sound -- All
		local flagDisplay -- Flag to display a message

		-- check if the skill point change was due to skyshards
		if oldPartialPoints ~= newPartialPoints or changeReason == SKILL_POINT_CHANGE_REASON_SKYSHARD_INSTANT_UNLOCK then
			flagDisplay = true
			sound = SOUNDS.SKYSHARD_GAINED
			if numSkillPointsGained < 0 then
				return
			end
			local numSkyshardsGained = (newPoints * NUM_PARTIAL_SKILL_POINTS_FOR_FULL + newPartialPoints) - (oldPoints * NUM_PARTIAL_SKILL_POINTS_FOR_FULL + oldPartialPoints)
			local largeText = zo_strformat(csaPrefix, numSkyshardsGained)
			-- if only the partial points changed, message out the new count of skyshard pieces
			if newPoints == oldPoints then
				messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_PARTIAL_GAINED)
				messageParams:SetText(largeText, zo_strformat(SI_SKYSHARD_GAINED_POINTS, newPartialPoints, NUM_PARTIAL_SKILL_POINTS_FOR_FULL))
				textPart1 = (stringPrefix .. ": ")
				finalText = zo_strformat("<<1>> (<<2>>/<<3>>)", largeText, newPartialPoints, NUM_PARTIAL_SKILL_POINTS_FOR_FULL)

				if stringPrefix ~= "" then
					if ChatAnnouncements.SV.Skills.SkillPointsPartial then
						stringPart1 = SkillPointColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Skills.SkillPointBracket], largeText, bracket2[ChatAnnouncements.SV.Skills.SkillPointBracket]))
					else
						stringPart1 = SkillPointColorize1:Colorize(zo_strformat("<<1>>!", largeText))
					end
				else
					stringPart1 = ""
				end
				if ChatAnnouncements.SV.Skills.SkillPointsPartial then
					stringPart2 = SkillPointColorize2:Colorize(zo_strformat(SI_SKYSHARD_GAINED_POINTS, newPartialPoints, NUM_PARTIAL_SKILL_POINTS_FOR_FULL))
				else
					stringPart2 = ""
				end
				finalMessage = zo_strformat("<<1>><<2>>", stringPart1, stringPart2)

			else
				local messageText
				-- if there are no leftover skyshard pieces, don't include them in the message
				if newPartialPoints == 0 then
					messageText = zo_strformat(SI_SKILL_POINT_GAINED, numSkillPointsGained)
				else
					messageText = zo_strformat(SI_SKILL_POINT_AND_SKYSHARD_PIECES_GAINED, numSkillPointsGained, newPartialPoints, NUM_PARTIAL_SKILL_POINTS_FOR_FULL)
				end
				messageParams:SetText(largeText, messageText)
				messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_GAINED)
				finalText = messageText

				if stringPrefix ~= "" then
					stringPart1 = SkillPointColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Skills.SkillPointBracket], largeText, bracket2[ChatAnnouncements.SV.Skills.SkillPointBracket]))
				else
					stringPart1 = ""
				end
				stringPart2 = SkillPointColorize2:Colorize(messageText)
				finalMessage = zo_strformat("<<1>><<2>>.", stringPart1, stringPart2)
			end
		elseif numSkillPointsGained > 0 then
			flagDisplay = true
			sound = SOUNDS.SKILL_GAINED
			messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_GAINED)
			messageParams:SetText(zo_strformat(SI_SKILL_POINT_GAINED, numSkillPointsGained))
			finalMessage = SkillPointColorize2:Colorize(zo_strformat(SI_SKILL_POINT_GAINED, numSkillPointsGained) .. ".")
			finalText = zo_strformat(SI_SKILL_POINT_GAINED, numSkillPointsGained) .. "."
		end
		if flagDisplay then
				if ChatAnnouncements.SV.Skills.SkillPointCA then
					if finalMessage ~= "" then
						g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "SKILL" }
						g_queuedMessagesCounter = g_queuedMessagesCounter + 1
						eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
					end
				end
				if ChatAnnouncements.SV.Skills.SkillPointCSA then
					messageParams:SetSound(sound)
					CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
				end
				if ChatAnnouncements.SV.Skills.SkillPointAlert then
					callAlert(UI_ALERT_CATEGORY_ALERT, nil, finalText)
				end
				if not ChatAnnouncements.SV.Skills.SkillPointCSA then
					PlaySound(Sound)
				end
		end
		return true
	end

    local function SkillLineAddedHook(skillType, lineIndex)
        local lineName = GetSkillLineInfo(skillType, lineIndex)
        local icon = select(4, ZO_Skills_GetIconsForSkillType(skillType))

        if ChatAnnouncements.SV.Skills.SkillLineUnlockCA then
            local formattedIcon = ChatAnnouncements.SV.Skills.SkillLineIcon and zo_strformat("<<1>> ", zo_iconFormatInheritColor(icon, 16, 16)) or ""
            local formattedString = SkillLineColorize:Colorize(zo_strformat(SI_LUIE_CA_SKILL_LINE_ADDED, formattedIcon, lineName))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL GAIN" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )

        end

        local discoverIcon = zo_iconFormat(icon, 32, 32)
        if ChatAnnouncements.SV.Skills.SkillLineUnlockCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.SKILL_LINE_ADDED)
            local formattedIcon = zo_iconFormat(icon, 32, 32)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_PARTIAL_GAINED)
            messageParams:SetText(zo_strformat(SI_SKILL_LINE_ADDED, formattedIcon, lineName))
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Skills.SkillLineUnlockAlert then
            local formattedIcon = zo_iconFormat(icon, "75%", "75%")
            local text = zo_strformat(SI_SKILL_LINE_ADDED, formattedIcon, lineName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
        if not ChatAnnouncements.SV.Skills.SkillLineUnlockCSA then
            PlaySound(SOUNDS.SKILL_LINE_ADDED)
        end
        return true
    end

    local function AbilityProgressionRankHook(progressionIndex, rank, maxRank, morph)
        local _, _, _, atMorph = GetAbilityProgressionXPInfo(progressionIndex)
        local name = GetAbilityProgressionAbilityInfo(progressionIndex, morph, rank)

        if atMorph then
            if ChatAnnouncements.SV.Skills.SkillAbilityCA then
                local formattedString = SkillLineColorize:Colorize(zo_strformat(SI_MORPH_AVAILABLE_ANNOUNCEMENT, name) .. ".")
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL MORPH" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.Skills.SkillAbilityCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ABILITY_MORPH_AVAILABLE)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ABILITY_PROGRESSION_RANK_MORPH)
                messageParams:SetText(zo_strformat(SI_MORPH_AVAILABLE_ANNOUNCEMENT, name))
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.Skills.SkillAbilityAlert then
                local text = zo_strformat(SI_MORPH_AVAILABLE_ANNOUNCEMENT, name) .. "."
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end

            if not ChatAnnouncements.SV.Skills.SkillAbilityCSA then
                PlaySound(SOUNDS.ABILITY_MORPH_AVAILABLE)
            end
        else
            if ChatAnnouncements.SV.Skills.SkillAbilityCA then
                local formattedString = SkillLineColorize:Colorize(zo_strformat(SI_LUIE_CA_ABILITY_RANK_UP, name, rank) .. ".")
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.Skills.SkillAbilityCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.ABILITY_RANK_UP)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ABILITY_PROGRESSION_RANK_UPDATE)
                messageParams:SetText(zo_strformat(SI_LUIE_CA_ABILITY_RANK_UP, name, rank))
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.Skills.SkillAbilityAlert then
                local text = zo_strformat(SI_LUIE_CA_ABILITY_RANK_UP, name, rank) .. "."
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end

            if not ChatAnnouncements.SV.Skills.SkillAbilityCSA then
                PlaySound(SOUNDS.ABILITY_RANK_UP)
            end
        end
        return true
    end

    local function SkillRankUpdateHook(skillType, lineIndex, rank)
        -- crafting skill updates get deferred if they're increased while crafting animations are in progress
        -- ZO_Skills_TieSkillInfoHeaderToCraftingSkill handles triggering the deferred center screen announce in that case
        if skillType ~= SKILL_TYPE_RACIAL and (skillType ~= SKILL_TYPE_TRADESKILL or not ZO_CraftingUtils_IsPerformingCraftProcess()) then
            local lineName, _, discovered = GetSkillLineInfo(skillType, lineIndex)
            if discovered then

                if ChatAnnouncements.SV.Skills.SkillLineCA then
                    local formattedString = SkillLineColorize:Colorize(zo_strformat(SI_SKILL_RANK_UP, lineName, rank) .. ".")
                    g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL LINE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end

                if ChatAnnouncements.SV.Skills.SkillLineCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.SKILL_LINE_LEVELED_UP)
                    messageParams:SetText(zo_strformat(SI_SKILL_RANK_UP, lineName, rank))
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_RANK_UPDATE)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end

                if ChatAnnouncements.SV.Skills.SkillLineAlert then
                    local formattedText = zo_strformat(SI_SKILL_RANK_UP, lineName, rank) .. "."
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedText)
                end

                if not ChatAnnouncements.SV.Skills.SkillLineCSA then
                    PlaySound(SOUNDS.SKILL_LINE_LEVELED_UP)
                end
            end
        end
        return true
    end

    local function SkillXPUpdateHook(skillType, skillIndex, reason, rank, previousXP, currentXP)
        if (skillType == SKILL_TYPE_GUILD and GUILD_SKILL_SHOW_REASONS[reason]) or reason == PROGRESS_REASON_JUSTICE_SKILL_EVENT then
            if not LUIE.SV.HideXPBar then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_NO_TEXT)
                local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                local sound = GUILD_SKILL_SHOW_SOUNDS[reason]
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_XP_UPDATE)
                messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP, sound))
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        return true
    end

    local function CollectibleUnlockedHook(collectionUpdateType, collectiblesByUnlockState)
        if collectionUpdateType == ZO_COLLECTION_UPDATE_TYPE.UNLOCK_STATE_CHANGES then
            local nowOwnedCollectibles = collectiblesByUnlockState[COLLECTIBLE_UNLOCK_STATE_UNLOCKED_OWNED]
            if nowOwnedCollectibles then
                if #nowOwnedCollectibles > MAX_INDIVIDUAL_COLLECTIBLE_UPDATES then

                    local stringPrefix = ChatAnnouncements.SV.Collectibles.CollectiblePrefix
                    local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_TITLE)

                    if ChatAnnouncements.SV.Collectibles.CollectibleCA then
                        local string1
                        if stringPrefix ~= "" then
                            string1 = CollectibleColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Collectibles.CollectibleBracket], stringPrefix, bracket2[ChatAnnouncements.SV.Collectibles.CollectibleBracket]))
                        else
                            string1 = ""
                        end
                        local string2 = CollectibleColorize2:Colorize(zo_strformat(SI_COLLECTIBLES_UPDATED_ANNOUNCEMENT_BODY, #nowOwnedCollectibles) .. ".")
                        finalString = zo_strformat("<<1>><<2>>", string1, string2)
                        g_queuedMessages[g_queuedMessagesCounter] = { message = finalString, type = "COLLECTIBLE" }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                    end

                    -- Set message params even if CSA is disabled, we just send a dummy event so the callback handler works correctly.
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.COLLECTIBLE_UNLOCKED)
                    if ChatAnnouncements.SV.Collectibles.CollectibleCSA then
                        messageParams:SetText(csaPrefix, zo_strformat(SI_COLLECTIBLES_UPDATED_ANNOUNCEMENT_BODY, #nowOwnedCollectibles))
                        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COLLECTIBLES_UPDATED)
                        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                    end

                    if ChatAnnouncements.SV.Collectibles.CollectibleAlert then
                        local text = zo_strformat(SI_COLLECTIBLES_UPDATED_ANNOUNCEMENT_BODY, #nowOwnedCollectibles) .. "."
                        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
                    end
                    return true
                else
                    --local messageParamsObjects = {}
                    for _, collectibleData in ipairs(nowOwnedCollectibles) do
                        local collectibleName = collectibleData:GetName()
                        local icon = collectibleData:GetIcon()
                        local categoryData = collectibleData:GetCategoryData()
                        local categoryName = categoryData:GetName()
                        local collectibleId = collectibleData:GetId()

                        local stringPrefix = ChatAnnouncements.SV.Collectibles.CollectiblePrefix
                        local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_TITLE)

                        if ChatAnnouncements.SV.Collectibles.CollectibleCA then
                            local link = GetCollectibleLink(collectibleId, linkBrackets[ChatAnnouncements.SV.BracketOptionCollectible])
                            local formattedIcon = ChatAnnouncements.SV.Collectibles.CollectibleIcon and string.format("|t16:16:%s|t ", icon) or ""

                            local string1
                            if stringPrefix ~= "" then
                                string1 = CollectibleColorize1:Colorize(zo_strformat("<<1>><<2>><<3>> ", bracket1[ChatAnnouncements.SV.Collectibles.CollectibleBracket], stringPrefix, bracket2[ChatAnnouncements.SV.Collectibles.CollectibleBracket]))
                            else
                                string1 = ""
                            end
                            local string2
                            if ChatAnnouncements.SV.Collectibles.CollectibleCategory then
                                string2 = CollectibleColorize2:Colorize(zo_strformat(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_BODY, link, categoryName) .. ".")
                            else
                                string2 = link
                            end
                            finalString = zo_strformat("<<1>><<2>><<3>>", string1, formattedIcon, string2)
                            g_queuedMessages[g_queuedMessagesCounter] = { message = finalString, type = "COLLECTIBLE" }
                            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                        end

                        -- Set message params even if CSA is disabled, we just send a dummy event so the callback handler works correctly.
                        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.COLLECTIBLE_UNLOCKED)
                        if ChatAnnouncements.SV.Collectibles.CollectibleCSA then
                            messageParams:SetText(csaPrefix, zo_strformat(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_BODY, collectibleName, categoryName))
                            messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
                            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SINGLE_COLLECTIBLE_UPDATED)
                            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                        end

                        if ChatAnnouncements.SV.Collectibles.CollectibleAlert then
                            local text = zo_strformat(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_BODY, collectibleName, categoryName .. ".")
                            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
                        end
                    end
                    return true
                end
            end
        end
    end

    local function ResetQuestRewardStatus()
        g_itemReceivedIsQuestReward = false
    end

    local function ResetQuestAbandonStatus()
        g_itemReceivedIsQuestAbandon = false
    end

    local function QuestAddedHook(journalIndex, questName, objectiveName)
        eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
        ChatAnnouncements.PrintBufferedXP()

        local questType = GetJournalQuestType(journalIndex)
        local instanceDisplayType = GetJournalInstanceDisplayType(journalIndex)
        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)

        local questType = GetJournalQuestType(journalIndex)
        local instanceDisplayType = GetJournalInstanceDisplayType(journalIndex)
        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)

        -- Add quest to index
        g_questIndex[questName] = {
            questType = questType,
            instanceDisplayType = instanceDisplayType
        }

        if ChatAnnouncements.SV.Quests.QuestAcceptCA then
            local questNameFormatted
            local stepText = GetJournalQuestStepInfo(journalIndex, 1)
            local formattedString

            if ChatAnnouncements.SV.Quests.QuestLong then
                questNameFormatted = (zo_strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorQuestNameColorize:ToHex(), questName, QuestColorQuestDescriptionColorize, stepText))
            else
                questNameFormatted = (zo_strformat("|c<<1>><<2>>|r", QuestColorQuestNameColorize:ToHex(), questName))
            end
            if iconTexture and ChatAnnouncements.SV.Quests.QuestIcon then
                formattedString = string.format(GetString(SI_LUIE_CA_QUEST_ACCEPT) .. zo_iconFormat(iconTexture, 16, 16) .. " " .. questNameFormatted)
            else
                formattedString = string.format("%s%s", GetString(SI_LUIE_CA_QUEST_ACCEPT), questNameFormatted)
            end

            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        if ChatAnnouncements.SV.Quests.QuestAcceptCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.QUEST_ACCEPTED)
            if iconTexture then
                messageParams:SetText(zo_strformat(SI_LUIE_CA_QUEST_ACCEPT_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName))
            else
                messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_QUEST_ACCEPT, questName))
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_ADDED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Quests.QuestAcceptAlert then
            local alertString
            if iconTexture and ChatAnnouncements.SV.Quests.QuestIcon then
                alertString = zo_strformat(SI_LUIE_CA_QUEST_ACCEPT_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
            else
                alertString = zo_strformat(SI_NOTIFYTEXT_QUEST_ACCEPT, questName)
            end
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
        end

        -- If we don't have either CSA or Alert on (then we want to play a sound here)
        if not ChatAnnouncements.SV.Quests.QuestAcceptCSA then
            PlaySound(SOUNDS.QUEST_ACCEPTED)
        end
        return true
    end

    local function QuestCompleteHook(questName, level, previousExperience, currentExperience, championPoints, questType, instanceDisplayType)
        eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
        ChatAnnouncements.PrintBufferedXP()

        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)

        if ChatAnnouncements.SV.Quests.QuestCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.QUEST_COMPLETED)
            if iconTexture then
                messageParams:SetText(zo_strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName))
            else
                messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questName))
            end
            if not LUIE.SV.HideXPBar then
                messageParams:SetBarParams(GetRelevantBarParams(level, previousExperience, currentExperience, championPoints))
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_COMPLETE)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Quests.QuestCompleteAlert then
            local alertString
            if iconTexture and ChatAnnouncements.SV.Quests.QuestIcon then
                alertString = zo_strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
            else
                alertString = zo_strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questName)
            end
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
        end

        if ChatAnnouncements.SV.Quests.QuestCompleteCA then
            local questNameFormatted = (zo_strformat("|cFFA500<<1>>|r", questName))
            local formattedString
            if iconTexture and ChatAnnouncements.SV.Quests.QuestIcon then
                formattedString = zo_strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON, zo_iconFormat(iconTexture, 16, 16), questNameFormatted)
            else
                formattedString = zo_strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questNameFormatted)
            end
            -- This event double fires on quest completion, if an equivalent message is already detected in queue, then abort!
            for i = 1, #g_queuedMessages do
                if g_queuedMessages[i].message == formattedString then
                    return true
                end
            end
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        -- If we don't have either CSA or Alert on (then we want to play a sound here)
        if not ChatAnnouncements.SV.Quests.QuestCompleteCSA then
            PlaySound(SOUNDS.QUEST_COMPLETED)
        end

        -- We set this variable to true in order to override the [Looted] message syntax that would be applied to a quest reward normally.
        if ChatAnnouncements.SV.Inventory.Loot then
            g_itemReceivedIsQuestReward = true
            zo_callLater(ResetQuestRewardStatus, 500)
        end

        return true
    end

    local function ObjectiveCompletedHook(zoneIndex, poiIndex, level, previousExperience, currentExperience, championPoints)
        local name, _, _, finishedDescription = GetPOIInfo(zoneIndex, poiIndex)
        local nameFormatted
        local formattedText

        if ChatAnnouncements.SV.Quests.QuestLocLong and finishedDescription ~= "" then
            nameFormatted = (zo_strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorLocNameColorize, name, QuestColorLocDescriptionColorize, finishedDescription))
        else
            nameFormatted = (zo_strformat("|c<<1>><<2>>|r", QuestColorLocNameColorize, name))
        end
        formattedText = zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, nameFormatted)

        if ChatAnnouncements.SV.Quests.QuestCompleteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, name))
        end

        if ChatAnnouncements.SV.Quests.QuestCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.OBJECTIVE_COMPLETED)
            if not LUIE.SV.HideXPBar then
                messageParams:SetBarParams(GetRelevantBarParams(level, previousExperience, currentExperience, championPoints))
            end
            messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, name), finishedDescription)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_OBJECTIVE_COMPLETED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Quests.QuestCompleteCA then
            -- This event double fires on quest completion, if an equivalent message is already detected in queue, then abort!
            for i = 1, #g_queuedMessages do
                if g_queuedMessages[i].message == formattedText then
                    return true
                end
            end
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedText, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        return true
    end

    -- For failure and updates (gonna need to punch a bunch of stuff in here to divide it up)
    local function ConditionCounterHook(journalIndex, questName, conditionText, conditionType, currConditionVal, newConditionVal, conditionMax, isFailCondition, stepOverrideText, isPushed, isComplete, isConditionComplete, isStepHidden)
        if isStepHidden or (isPushed and isComplete) or (currConditionVal >= newConditionVal) then
            return true
        end

        local type -- This variable represents whether this message is an objective update or failure state message (1 = update, 2 = failure) There are too many conditionals to resolve what we need to print inside them so we do it after setting the formatting.
        local alertMessage -- Variable for alert message
        local formattedMessage -- Variable for CA Message
        local sound -- Set correct sound based off context
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)

        if newConditionVal ~= currConditionVal and not isFailCondition then
            sound = isConditionComplete and SOUNDS.QUEST_OBJECTIVE_COMPLETE or SOUNDS.QUEST_OBJECTIVE_INCREMENT
            messageParams:SetSound(sound)
        end

        d(conditionType)
        if isConditionComplete and conditionType == QUEST_CONDITION_TYPE_GIVE_ITEM or conditionType == QUEST_CONDITION_TYPE_TALK_TO then
            -- We set this variable to true in order to override the [Looted] message syntax that would be applied to a quest reward normally.
            if ChatAnnouncements.SV.Inventory.Loot then
                g_itemReceivedIsQuestReward = true
                zo_callLater(ResetQuestRewardStatus, 500)
            end
        end

        if isConditionComplete and conditionType == QUEST_CONDITION_TYPE_GIVE_ITEM then
             messageParams:SetText(zo_strformat(SI_TRACKED_QUEST_STEP_DONE, conditionText))
             alertMessage = zo_strformat(SI_TRACKED_QUEST_STEP_DONE, conditionText)
             formattedMessage = zo_strformat(SI_TRACKED_QUEST_STEP_DONE, conditionText)
             type = 1
        elseif stepOverrideText == "" then
            if isFailCondition then
                if conditionMax > 1 then
                    messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax))
                    alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax)
                    formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax)
                else
                   messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText))
                   alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText)
                   formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText)
                end
                type = 2
            else
                if conditionMax > 1 and newConditionVal < conditionMax then
                    messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE, conditionText, newConditionVal, conditionMax))
                    alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE, conditionText, newConditionVal, conditionMax)
                    formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE, conditionText, newConditionVal, conditionMax)
                else
                    messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, conditionText))
                    alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, conditionText)
                    formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, conditionText)
                end
                type = 1
            end
        else
            if isFailCondition then
                messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText))
                alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText)
                formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText)
                type = 2
            else
                messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, stepOverrideText))
                alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, stepOverrideText)
                formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, stepOverrideText)
                type = 1
            end
        end

        -- Override text if its listed in the override table.
        if Quests.QuestObjectiveCompleteOverride[formattedMessage] then
            messageParams:SetText(Quests.QuestObjectiveCompleteOverride[formattedMessage])
            alertMessage = Quests.QuestObjectiveCompleteOverride[formattedMessage]
            formattedMessage = Quests.QuestObjectiveCompleteOverride[formattedMessage]
        end

        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_CONDITION_COUNTER_CHANGED)

        if type == 1 then
            if ChatAnnouncements.SV.Quests.QuestObjCompleteCA then
                -- This event double fires on quest completion, if an equivalent message is already detected in queue, then abort!
                for i = 1, #g_queuedMessages do
                    if g_queuedMessages[i].message == formattedMessage then
                        return true
                    end
                end
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedMessage, type = "MESSAGE" } -- We set the message type to MESSAGE so if we loot a quest item that progresses the quest this comes after.
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end
            if ChatAnnouncements.SV.Quests.QuestObjCompleteCSA then
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            if ChatAnnouncements.SV.Quests.QuestObjCompleteAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
            end
            if not ChatAnnouncements.SV.Quests.QuestObjCompleteCSA then
                PlaySound(sound)
            end
        end

        if type == 2 then
            if ChatAnnouncements.SV.Quests.QuestFailCA then
                -- This event double fires on quest completion, if an equivalent message is already detected in queue, then abort!
                for i = 1, #g_queuedMessages do
                    if g_queuedMessages[i].message == formattedMessage then
                        return true
                    end
                end
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedMessage, type = "MESSAGE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end
            if ChatAnnouncements.SV.Quests.QuestFailCSA then
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            if ChatAnnouncements.SV.Quests.QuestFailAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
            end
            if not ChatAnnouncements.SV.Quests.QuestFailCSA then
                PlaySound(sound)
            end
        end

        return true
    end

    local function OptionalStepHook(text)
        if text ~= "" then

            local message = zo_strformat ("|c<<1>><<2>>|r", QuestColorQuestDescriptionColorize, text)
            local formattedString = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, message)

            if ChatAnnouncements.SV.Quests.QuestObjCompleteCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "MESSAGE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.Quests.QuestObjCompleteCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.QUEST_OBJECTIVE_COMPLETE)
                messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, text))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_OPTIONAL_STEP_ADVANCED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.Quests.QuestObjCompleteAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
            end
            if not ChatAnnouncements.SV.Quests.QuestObjCompleteCSA then
                PlaySound(SOUNDS.QUEST_OBJECTIVE_COMPLETE)
            end
        end
        return true
    end

    local function OnQuestRemoved(eventId, isCompleted, journalIndex, questName, zoneIndex, poiIndex)
        if not isCompleted then
            if ChatAnnouncements.SV.Quests.QuestAbandonCA or ChatAnnouncements.SV.Quests.QuestAbandonCSA or ChatAnnouncements.SV.Quests.QuestAbandonAlert then

                local iconTexture

                if g_questIndex[questName] then
                    local questJournalObject = SYSTEMS:GetObject("questJournal")
                    local questType = g_questIndex[questName].questType
                    local instanceDisplayType = g_questIndex[questName].instanceDisplayType
                    iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
                end

                if ChatAnnouncements.SV.Quests.QuestAbandonCA then
                    local questNameFormatted = (zo_strformat("|cFFA500<<1>>|r", questName))
                    local formattedString
                    if iconTexture and ChatAnnouncements.SV.Quests.QuestIcon then
                        formattedString = zo_strformat(SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON, zo_iconFormat(iconTexture, 16, 16), questNameFormatted)
                    else
                        formattedString = zo_strformat(SI_LUIE_CA_QUEST_ABANDONED, questNameFormatted)
                    end
                    g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "MESSAGE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end

                if ChatAnnouncements.SV.Quests.QuestAbandonCSA then
                    local formattedString
                    if iconTexture then
                        formattedString = zo_strformat(SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
                    else
                        formattedString = zo_strformat(SI_LUIE_CA_QUEST_ABANDONED, questName)
                    end
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.QUEST_ABANDONED)
                    messageParams:SetText(formattedString)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_ADDED)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end

                if ChatAnnouncements.SV.Quests.QuestAbandonAlert then
                    local formattedString
                    if iconTexture and ChatAnnouncements.SV.Quests.QuestIcon then
                        formattedString = zo_strformat(SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
                    else
                        formattedString = zo_strformat(SI_LUIE_CA_QUEST_ABANDONED, questName)
                    end
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
                end

            end
            if not ChatAnnouncements.SV.Quests.QuestAbandonCSA then
                PlaySound(SOUNDS.QUEST_ABANDONED)
            end

            -- We set this variable to true in order to override the message syntax that would be applied to a quest reward normally with [Removed] instead.
            if ChatAnnouncements.SV.Inventory.Loot then
                g_itemReceivedIsQuestAbandon = true
                zo_callLater(ResetQuestAbandonStatus, 500)
            end

        end
        g_questIndex[questName] = nil

    end

    -- Quest Advancement displays all the "appropriate" conditions that the player needs to do to advance the current step
    local function OnQuestAdvanced(eventId, questIndex, questName, isPushed, isComplete, mainStepChanged, soundOverride)
        if(not mainStepChanged) then return end

        local sound = SOUNDS.QUEST_OBJECTIVE_STARTED

        for stepIndex = QUEST_MAIN_STEP_INDEX, GetJournalQuestNumSteps(questIndex) do
            local _, visibility, stepType, stepOverrideText, conditionCount = GetJournalQuestStepInfo(questIndex, stepIndex)

            -- Override text if its listed in the override table.
            if Quests.QuestAdvancedOverride[stepOverrideText] then stepOverrideText = Quests.QuestAdvancedOverride[stepOverrideText] end

            if visibility == nil or visibility == QUEST_STEP_VISIBILITY_OPTIONAL then
                if stepOverrideText ~= "" then
                    if ChatAnnouncements.SV.Quests.QuestObjUpdateCA then
                        g_queuedMessages[g_queuedMessagesCounter] = { message = stepOverrideText, type = "MESSAGE" }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                    end
                    if ChatAnnouncements.SV.Quests.QuestObjUpdateCSA then
                        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, sound)
                        messageParams:SetText(stepOverrideText)
                        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_OPTIONAL_STEP_ADVANCED)
                        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                        sound = nil -- no longer needed, we played it once
                    end
                    if ChatAnnouncements.SV.Quests.QuestObjUpdateAlert then
                        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, stepOverrideText)
                    end
                else
                    for conditionIndex = 1, conditionCount do
                        local conditionText, curCount, maxCount, isFailCondition, isConditionComplete, _, isVisible  = GetJournalQuestConditionInfo(questIndex, stepIndex, conditionIndex)

                        if not (isFailCondition or isConditionComplete) and isVisible then
                            if ChatAnnouncements.SV.Quests.QuestObjUpdateCA then
                                g_queuedMessages[g_queuedMessagesCounter] = { message = conditionText, type = "MESSAGE" }
                                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                            end
                            if ChatAnnouncements.SV.Quests.QuestObjUpdateCSA then
                                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, sound)
                                messageParams:SetText(conditionText)
                                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_OPTIONAL_STEP_ADVANCED)
                                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                                sound = nil -- no longer needed, we played it once
                            end
                            if ChatAnnouncements.SV.Quests.QuestObjUpdateAlert then
                                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, conditionText)
                            end
                        end
                    end
                end
                -- We send soundOverride = true from OnQuestAdded in order to stop the sound from spamming if CSA isn't on and a quest is accepted.
                if not ChatAnnouncements.SV.Quests.QuestObjUpdateCSA and not soundOverride then
                    PlaySound(SOUNDS.QUEST_OBJECTIVE_STARTED)
                end
            end
        end
    end

    local function OnQuestAdded(eventId, questIndex)
        OnQuestAdvanced(EVENT_QUEST_ADVANCED, questIndex, nil, nil, nil, true, true)
    end

    local function DiscoveryExperienceHook(subzoneName, level, previousExperience, currentExperience, championPoints)
        eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
        ChatAnnouncements.PrintBufferedXP()

        if ChatAnnouncements.SV.Quests.QuestLocDiscoveryCA then
            local nameFormatted = (zo_strformat("|c<<1>><<2>>|r", QuestColorLocNameColorize, subzoneName))
            local formattedString = zo_strformat(SI_LUIE_CA_QUEST_DISCOVER, nameFormatted)
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        if ChatAnnouncements.SV.Quests.QuestLocDiscoveryCSA and not INTERACT_WINDOW:IsShowingInteraction() then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.OBJECTIVE_DISCOVERED)
            if currentExperience > previousExperience then
                if not LUIE.SV.HideXPBar then
                    messageParams:SetBarParams(GetRelevantBarParams(level, previousExperience, currentExperience, championPoints))
                end
            end
            messageParams:SetText(zo_strformat(SI_LUIE_CA_QUEST_DISCOVER, subzoneName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISCOVERY_EXPERIENCE)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Quests.QuestLocDiscoveryAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_QUEST_DISCOVER, subzoneName))
        end

        if not ChatAnnouncements.SV.Quests.QuestLocDiscoveryCSA then
            PlaySound(SOUNDS.OBJECTIVE_DISCOVERED)
        end
        return true
    end

    local function PoiDiscoveredHook(zoneIndex, poiIndex)
        eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
        ChatAnnouncements.PrintBufferedXP()

        local name, _, startDescription = GetPOIInfo(zoneIndex, poiIndex)

        if ChatAnnouncements.SV.Quests.QuestLocObjectiveCA then
            local formattedString = (zo_strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorLocNameColorize, name, QuestColorLocDescriptionColorize, startDescription))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST_POI" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )

        end

        if ChatAnnouncements.SV.Quests.QuestLocObjectiveCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.OBJECTIVE_ACCEPTED)
            messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_DISCOVERED, name), startDescription)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_POI_DISCOVERED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Quests.QuestLocObjectiveAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_DISCOVERED, name), startDescription)
        end
        return true
    end

    local XP_GAIN_SHOW_REASONS = {
        [PROGRESS_REASON_PVP_EMPEROR] = true,
        [PROGRESS_REASON_DUNGEON_CHALLENGE] = true,
        [PROGRESS_REASON_OVERLAND_BOSS_KILL] = true,
        [PROGRESS_REASON_SCRIPTED_EVENT] = true,
        [PROGRESS_REASON_LOCK_PICK] = true,
        [PROGRESS_REASON_LFG_REWARD] = true,
    }

    local XP_GAIN_SHOW_SOUNDS = {
        [PROGRESS_REASON_OVERLAND_BOSS_KILL] = SOUNDS.OVERLAND_BOSS_KILL,
        [PROGRESS_REASON_LOCK_PICK] = SOUNDS.LOCKPICKING_SUCCESS_CELEBRATION,
    }

    -- This function is prehooked in order to allow the XP bar popup to be hidden. In addition we shift the sound over
    local function ExperienceGainHook(reason, level, previousExperience, currentExperience, championPoints)
        local sound = XP_GAIN_SHOW_SOUNDS[reason]

        if XP_GAIN_SHOW_REASONS[reason] and not LUIE.SV.HideXPBar then
            local barParams = GetRelevantBarParams(level, previousExperience, currentExperience, championPoints)
            if barParams then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_NO_TEXT)
                barParams:SetSound(sound)
                messageParams:SetBarParams(barParams)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_EXPERIENCE_GAIN)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        -- We want to play a sound still even if the bar popup is hidden, but the delay needs to remain intact so we add a blank CSA with sound.
        if XP_GAIN_SHOW_REASONS[reason] and LUIE.SV.HideXPBar and sound ~= nil then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetSound(sound)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_EXPERIENCE_GAIN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Level up notification
        local levelSize = GetNumExperiencePointsInLevel(level)
        if levelSize ~= nil and currentExperience >= levelSize then
            eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
            ChatAnnouncements.PrintBufferedXP()

            local CurrentLevel = level + 1
            if ChatAnnouncements.SV.XP.ExperienceLevelUpCA then
                local icon
                if ChatAnnouncements.SV.XP.ExperienceLevelColorByLevel then
                    icon = ChatAnnouncements.SV.XP.ExperienceLevelUpIcon and ZO_XP_BAR_GRADIENT_COLORS[2]:Colorize(" " .. zo_iconFormatInheritColor("LuiExtended/media/unitframes/unitframes_level_normal.dds", 16, 16)) or ""
                else
                    icon = ChatAnnouncements.SV.XP.ExperienceLevelUpIcon and (" " .. zo_iconFormat("LuiExtended/media/unitframes/unitframes_level_normal.dds", 16, 16)) or ""
                end

                local CurrentLevelFormatted = ""
                if ChatAnnouncements.SV.XP.ExperienceLevelColorByLevel then
                    CurrentLevelFormatted = ZO_XP_BAR_GRADIENT_COLORS[2]:Colorize(GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL) .. " " .. CurrentLevel)
                else
                    CurrentLevelFormatted = ExperienceLevelUpColorize:Colorize(GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL) .. " " .. CurrentLevel)
                end

                local formattedString
                if ChatAnnouncements.SV.XP.ExperienceLevelColorByLevel then
                    formattedString = zo_strformat("<<1>><<2>> <<3>><<4>>", ExperienceLevelUpColorize:Colorize(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP)), icon, CurrentLevelFormatted, ExperienceLevelUpColorize:Colorize("!"))
                else
                    formattedString = zo_strformat("<<1>><<2>> <<3>><<4>>", ExperienceLevelUpColorize:Colorize(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP)), icon, CurrentLevelFormatted, ExperienceLevelUpColorize:Colorize("!"))
                end
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE LEVEL" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
                local iconCSA = (" " .. zo_iconFormat("LuiExtended/media/unitframes/unitframes_level_up.dds", "100%", "100%")) or ""
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.LEVEL_UP)
                if ChatAnnouncements.SV.XP.ExperienceLevelUpCSAExpand then
                    local levelUpExpanded = zo_strformat("<<1>><<2>> <<3>> <<4>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), iconCSA, GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL), CurrentLevel)
                    messageParams:SetText(zo_strformat(SI_LEVEL_UP_NOTIFICATION), levelUpExpanded)
                else
                    messageParams:SetText(GetString(SI_LEVEL_UP_NOTIFICATION))
                end
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LEVEL_GAIN)
                if not LUIE.SV.HideXPBar then
                    local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_XP, level + 1, currentExperience - levelSize, currentExperience - levelSize)
                    barParams:SetShowNoGain(true)
                    messageParams:SetBarParams(barParams)
                end
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.XP.ExperienceLevelUpAlert then
                local iconAlert = ChatAnnouncements.SV.XP.ExperienceLevelUpIcon and (" " .. zo_iconFormat("LuiExtended/media/unitframes/unitframes_level_up.dds", "75%", "75%")) or ""
                local text = zo_strformat("<<1>><<2>> <<3>> <<4>>!", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), iconAlert, GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL), CurrentLevel)
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end

            -- Play Sound even if CSA is disabled
            if not ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
                PlaySound(SOUNDS.LEVEL_UP)
            end

        end

        return true
    end

    local function EnlightenGainHook()
        if IsEnlightenedAvailableForCharacter() then
            local formattedString = zo_strformat("<<1>>! <<2>>", GetString(SI_ENLIGHTENED_STATE_GAINED_HEADER), GetString(SI_ENLIGHTENED_STATE_GAINED_DESCRIPTION))
            if ChatAnnouncements.SV.XP.ExperienceEnlightenedCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.XP.ExperienceEnlightenedCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ENLIGHTENED_STATE_GAINED)
                messageParams:SetText(zo_strformat(SI_ENLIGHTENED_STATE_GAINED_HEADER), zo_strformat(SI_ENLIGHTENED_STATE_GAINED_DESCRIPTION))
                if not LUIE.SV.HideXPBar then
                    local barParams = GetCurrentChampionPointsBarParams()
                    messageParams:SetBarParams(barParams)
                end
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ENLIGHTENMENT_GAINED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.XP.ExperienceEnlightenedAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
            end

            if not ChatAnnouncements.SV.XP.ExperienceEnlightenedCSA then
                PlaySound(SOUNDS.ENLIGHTENED_STATE_GAINED)
            end
        end

        return true
    end

    local function EnlightenLossHook()
        if IsEnlightenedAvailableForCharacter() then
            local formattedString = zo_strformat("<<1>>!", GetString(SI_ENLIGHTENED_STATE_LOST_HEADER))

            if ChatAnnouncements.SV.XP.ExperienceEnlightenedCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.XP.ExperienceEnlightenedCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ENLIGHTENED_STATE_LOST)
                if not LUIE.SV.HideXPBar then
                    messageParams:SetBarParams(GetCurrentChampionPointsBarParams())
                end
                messageParams:SetText(zo_strformat(SI_ENLIGHTENED_STATE_LOST_HEADER))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ENLIGHTENMENT_LOST)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.XP.ExperienceEnlightenedAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
            end

            if not ChatAnnouncements.SV.XP.ExperienceEnlightenedCSA then
                PlaySound(SOUNDS.ENLIGHTENED_STATE_LOST)
            end

        end

        return true
    end

    local firstActivation = true
    local function PlayerActivatedHook()
        if firstActivation then
            firstActivation = false

            if IsEnlightenedAvailableForCharacter() and GetEnlightenedPool() > 0 then
                EnlightenGainHook()
            end
        end
        return true
    end

    -- Note: This function is effected by a throttle in centerscreenannouncehandlers, we resolve any message that needs to be throttled in this function.
    local function RidingSkillImprovementHook(ridingSkill, previous, current, source)
        if source == RIDING_TRAIN_SOURCE_ITEM then
            if ChatAnnouncements.SV.Notify.StorageRidingCA then
                -- TODO: Switch to using Recipe/Learn variable in the future
                if ChatAnnouncements.SV.Inventory.Loot then
                    local icon
                    local bookString
                    local value = current - previous
                    local learnString = GetString(SI_LUIE_CA_STORAGE_LEARN)

                    if ridingSkill == 1 then
                        if ChatAnnouncements.SV.BracketOptionItem == 1 then
                            bookString = "|H0:item:64700:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        else
                            bookString = "|H1:item:64700:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        end
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_speed.dds|t "
                    elseif ridingSkill == 2 then
                        if ChatAnnouncements.SV.BracketOptionItem == 1 then
                            bookString = "|H0:item:64702:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        else
                            bookString = "|H1:item:64702:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        end
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_capacity.dds|t "
                    elseif ridingSkill == 3 then
                        if ChatAnnouncements.SV.BracketOptionItem == 1 then
                            bookString = "|H0:item:64701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        else
                            bookString = "|H1:item:64701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        end
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_stamina.dds|t "
                    end

                    local formattedColor = StorageRidingBookColorize:ToHex()

                    local messageP1 = ChatAnnouncements.SV.Inventory.LootIcons and (icon .. bookString) or (bookString)
                    local formattedString = (messageP1 .. "|r|cFFFFFF x" .. value .. "|r|c" .. formattedColor)
                    local messageP2 = string.format(learnString, formattedString )
                    local finalMessage = string.format("|c%s%s|r", formattedColor, messageP2)

                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "MESSAGE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
                end

                local formattedString = StorageRidingColorize:Colorize(zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "MESSAGE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
            end

            if ChatAnnouncements.SV.Notify.StorageRidingCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_RIDING_SKILL_ANNOUCEMENT_BANNER), zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RIDING_SKILL_IMPROVEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        return true
    end

    local function InventoryBagCapacityHook(previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
        if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
            if ChatAnnouncements.SV.Notify.StorageBagCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_INVENTORY_BAG_UPGRADE_ANOUNCEMENT_TITLE), zo_strformat(SI_INVENTORY_BAG_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_BAG_CAPACITY_CHANGED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        return true
    end

    local function InventoryBankCapacityHook(previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
        if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
            if ChatAnnouncements.SV.Notify.StorageBagCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_INVENTORY_BANK_UPGRADE_ANOUNCEMENT_TITLE), zo_strformat(SI_INVENTORY_BANK_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_BANK_CAPACITY_CHANGED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        return true
    end

    local function ChampionLevelAchievedHook(wasChampionSystemUnlocked)
        local icon = GetChampionPointsIcon()

        if ChatAnnouncements.SV.XP.ExperienceLevelUpCA then
            local formattedIcon = ChatAnnouncements.SV.XP.ExperienceLevelUpIcon and zo_strformat("<<1>> ", zo_iconFormatInheritColor(icon, 16, 16)) or ""
            local formattedString = ExperienceLevelUpColorize:Colorize(zo_strformat("<<1>>!", GetString(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED), formattedIcon))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE LEVEL" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        if ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.CHAMPION_POINT_GAINED)
            local formattedIcon = zo_strformat("<<1>> ", zo_iconFormat(icon, "100%", "100%"))
            messageParams:SetText(zo_strformat(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED, formattedIcon))
            if not LUIE.SV.HideXPBar then
                if wasChampionSystemUnlocked then
                    local championPoints = GetPlayerChampionPointsEarned()
                    local currentChampionXP = GetPlayerChampionXP()
                    if not LUIE.SV.HideXPBar then
                        local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, currentChampionXP, currentChampionXP)
                        barParams:SetShowNoGain(true)
                        messageParams:SetBarParams(barParams)
                    end
                else
                    local totalChampionPoints = GetPlayerChampionPointsEarned()
                    local championXPGained = 0;
                    for i = 0, (totalChampionPoints - 1) do
                        championXPGained = championXPGained + GetNumChampionXPInChampionPoint(i)
                    end
                    if not LUIE.SV.HideXPBar then
                        messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, 0, 0, championXPGained))
                    end
                    messageParams:SetLifespanMS(12000)
                end
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_CHAMPION_LEVEL_ACHIEVED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.XP.ExperienceLevelUpAlert then
            local formattedIcon = ChatAnnouncements.SV.XP.ExperienceLevelUpIcon and zo_strformat("<<1>> ", zo_iconFormat(icon, "75%", "75%")) or ""
            local text = zo_strformat("<<1>>!", GetString(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED, formattedIcon))
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end

        if not ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
            PlaySound(SOUNDS.CHAMPION_POINT_GAINED)
        end

        return true
    end

    local savedEndingPoints = 0 -- We reset this value after the throttled function sends info to the chat printer
    local savedPointDelta = 0 -- We reset this value after the throttled function sends info to the chat printer

    local function ChampionPointGainedPrinter()
        -- adding one so that we are starting from the first gained point instead of the starting champion points
        local startingPoints = savedEndingPoints - savedPointDelta + 1
        local championPointsByType = { 0, 0, 0 }

        while startingPoints <= savedEndingPoints do
            local pointType = GetChampionPointAttributeForRank(startingPoints)
            championPointsByType[pointType] = championPointsByType[pointType] + 1
            startingPoints = startingPoints + 1
        end

        if ChatAnnouncements.SV.XP.ExperienceLevelUpCA then
            local formattedString = ExperienceLevelUpColorize:Colorize(zo_strformat(SI_CHAMPION_POINT_EARNED, savedPointDelta) .. ": ")
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE LEVEL" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 25, ChatAnnouncements.PrintQueuedMessages )
        end

        local secondLine = ""
        if ChatAnnouncements.SV.XP.ExperienceLevelUpCA or ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
            for pointType,amount in pairs(championPointsByType) do
                if amount > 0 then
                    local formattedString
                    local icon = GetChampionPointAttributeHUDIcon(pointType)
                    local formattedIcon = ChatAnnouncements.SV.XP.ExperienceLevelUpIcon and zo_strformat(" <<1>>", zo_iconFormat(icon, 16, 16)) or ""
                    local constellationGroupName = ZO_Champion_GetUnformattedConstellationGroupNameFromAttribute(pointType)
                    if ChatAnnouncements.SV.XP.ExperienceLevelColorByLevel then
                        formattedString = ZO_CP_BAR_GRADIENT_COLORS[pointType][2]:Colorize(zo_strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, formattedIcon, constellationGroupName))
                    else
                        formattedString = ExperienceLevelUpColorize:Colorize(zo_strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, formattedIcon, constellationGroupName))
                    end
                    if ChatAnnouncements.SV.XP.ExperienceLevelUpCA then
                        g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE LEVEL" }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        eventManager:RegisterForUpdate(moduleName .. "Printer", 25, ChatAnnouncements.PrintQueuedMessages )
                    end
                    if ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
                        secondLine = secondLine .. zo_strformat(SI_CHAMPION_POINT_TYPE, amount, icon, constellationGroupName) .. "\n"
                    end
                end
            end
        end

        if ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.CHAMPION_POINT_GAINED)
            messageParams:SetText(zo_strformat(SI_CHAMPION_POINT_EARNED, savedPointDelta), secondLine)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_CHAMPION_POINT_GAINED)
            messageParams:MarkSuppressIconFrame()
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.XP.ExperienceLevelUpAlert then
            local text = zo_strformat("<<1>>!", GetString(SI_CHAMPION_POINT_EARNED, savedPointDelta))
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end

        if not ChatAnnouncements.SV.XP.ExperienceLevelUpCSA then
            PlaySound(SOUNDS.CHAMPION_POINT_GAINED)
        end

        savedEndingPoints = 0
        savedPointDelta = 0

        eventManager:UnregisterForUpdate(moduleName .. "ChampionPointThrottle")
    end

    local function ChampionPointGainedHook(pointDelta)
        -- Print throttled XP value
        eventManager:UnregisterForUpdate(moduleName .. "BufferedXP")
        ChatAnnouncements.PrintBufferedXP()

        savedEndingPoints = GetPlayerChampionPointsEarned()
        savedPointDelta = savedPointDelta + pointDelta

        eventManager:UnregisterForUpdate(moduleName .. "ChampionPointThrottle")
        eventManager:RegisterForUpdate(moduleName .. "ChampionPointThrottle", 25, ChampionPointGainedPrinter)

        return true
    end

    -- Extra Functions for EVENT_DUEL_NEAR_BOUNDARY
    local DUEL_BOUNDARY_WARNING_LIFESPAN_MS = 2000
    local DUEL_BOUNDARY_WARNING_UPDATE_TIME_MS = 2100
    local lastEventTime = 0
    local function CheckBoundary()
        if IsNearDuelBoundary() then
            -- Display CA
            if ChatAnnouncements.SV.Social.DuelBoundaryCA then
                printToChat(GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA), true)
            end

            -- Display CSA
            if ChatAnnouncements.SV.Social.DuelBoundaryCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.DUEL_BOUNDARY_WARNING)
                messageParams:SetText(GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA))
                messageParams:SetLifespanMS(DUEL_BOUNDARY_WARNING_LIFESPAN_MS)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DUEL_NEAR_BOUNDARY)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            -- Display Alert
            if ChatAnnouncements.SV.Social.DuelBoundaryAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, (GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA)))
            end

            -- Play Sound if CSA if off
            if not ChatAnnouncements.SV.Social.DuelBoundaryCSA then
                PlaySound(SOUNDS.DUEL_BOUNDARY_WARNING)
            end
        end
    end

    -- EVENT_DUEL_NEAR_BOUNDARY -- CSA HANDLER
    local function DuelNearBoundaryHook(isInWarningArea)
        if isInWarningArea then
            local nowEventTime = GetFrameTimeMilliseconds()
            eventManager:RegisterForUpdate("EVENT_DUEL_NEAR_BOUNDARY_LUIE", DUEL_BOUNDARY_WARNING_UPDATE_TIME_MS, CheckBoundary)
            if nowEventTime > lastEventTime + DUEL_BOUNDARY_WARNING_UPDATE_TIME_MS then
                lastEventTime = nowEventTime
                CheckBoundary()
            end
        else
            eventManager:UnregisterForUpdate("EVENT_DUEL_NEAR_BOUNDARY_LUIE")
        end
        return true
    end

    -- EVENT_DUEL_FINISHED -- CSA HANDLER
    local function DuelFinishedHook(result, wasLocalPlayersResult, opponentCharacterName, opponentDisplayName)
        -- Setup result format, name, and result sound
        local resultString = wasLocalPlayersResult and GetString("SI_LUIE_CA_DUEL_SELF_RESULT", result) or GetString("SI_LUIE_CA_DUEL_RESULT", result)

        local localPlayerWonDuel = (result == DUEL_RESULT_WON and wasLocalPlayersResult) or (result == DUEL_RESULT_FORFEIT and not wasLocalPlayersResult)
        local localPlayerForfeitDuel = (result == DUEL_RESULT_FORFEIT and wasLocalPlayersResult)
        local resultSound = nil
        if localPlayerWonDuel then
            resultSound = SOUNDS.DUEL_WON
        elseif localPlayerForfeitDuel then
            resultSound = SOUNDS.DUEL_FORFEIT
        end

        -- Display CA
        if ChatAnnouncements.SV.Social.DuelWonCA then
            local finalName = ChatAnnouncements.ResolveNameLink(opponentCharacterName, opponentDisplayName)
            local resultChatString
            if wasLocalPlayersResult then
                resultChatString = resultString
            else
                resultChatString = zo_strformat(resultString, finalName)
            end
            printToChat(resultChatString, true)
        end

        if ChatAnnouncements.SV.Social.DuelWonCSA or ChatAnnouncements.SV.Social.DuelWonAlert then
            -- Setup String for CSA/Alert
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(opponentCharacterName, opponentDisplayName)
            local resultCSAString
            if wasLocalPlayersResult then
                resultCSAString = resultString
            else
                resultCSAString = zo_strformat(resultString, finalAlertName)
            end

            -- Display CSA
            if ChatAnnouncements.SV.Social.DuelWonCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, resultSound)
                messageParams:SetText(resultCSAString)
                messageParams:MarkShowImmediately()
                messageParams:MarkQueueImmediately()
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DUEL_FINISHED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            -- Display Alert
            if ChatAnnouncements.SV.Social.DuelWonAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, resultCSAString)
            end
        end

        -- Play sound if CSA is not enabled
        if not ChatAnnouncements.SV.Social.DuelWonCSA then
            PlaySound(resultSound)
        end
        return true
    end

    -- EVENT_DUEL_COUNTDOWN -- CSA HANDLER
    local function DuelCountdownHook(startTimeMS)
        -- Display CSA
        if ChatAnnouncements.SV.Social.DuelStartCSA then
            local displayTime = startTimeMS - GetFrameTimeMilliseconds()
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_COUNTDOWN_TEXT, SOUNDS.DUEL_START)
            messageParams:SetLifespanMS(displayTime)
            messageParams:SetIconData("EsoUI/Art/HUD/HUD_Countdown_Badge_Dueling.dds")
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        return true
    end

    -- EVENT_RAID_TRIAL_STARTED -- CSA HANDLER
    local function RaidStartedHook(raidName, isWeekly)
        -- Display CA
        if ChatAnnouncements.SV.Group.GroupRaidCA then
            local formattedName = zo_strformat("|cFEFEFE<<1>>|r", raidName)
            printToChat(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_STARTED, formattedName), true)
        end

        -- Display CSA
        if ChatAnnouncements.SV.Group.GroupRaidCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.RAID_TRIAL_STARTED)
            messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_STARTED, raidName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Group.GroupRaidAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUP_TRIAL_STARTED, raidName) )
        end

        -- Play sound if CSA is not enabled
        if not ChatAnnouncements.SV.Group.GroupRaidCSA then
            PlaySound(SOUNDS.RAID_TRIAL_STARTED)
        end
        return true
    end

    local TRIAL_COMPLETE_LIFESPAN_MS = 10000
    -- EVENT_RAID_TRIAL_COMPLETE -- CSA HANDLER
    local function RaidCompleteHook(raidName, score, totalTime)
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_RAID_COMPLETE_TEXT, SOUNDS.RAID_TRIAL_COMPLETED)
        local wasUnderTargetTime = GetRaidDuration() <= GetRaidTargetTime()
        local formattedTime = ZO_FormatTimeMilliseconds(totalTime, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS)
        local vitalityBonus = GetCurrentRaidLifeScoreBonus()
        local currentCount = GetRaidReviveCountersRemaining()
        local maxCount = GetCurrentRaidStartingReviveCounters()

        -- Display CA
        if ChatAnnouncements.SV.Group.GroupRaidCA then
            local formattedName = zo_strformat("|cFEFEFE<<1>>|r", raidName)
            local vitalityCounterString = zo_strformat("<<1>> <<2>>/<<3>>", zo_iconFormatInheritColor("esoui/art/trials/vitalitydepletion.dds", 16, 16), currentCount, maxCount )
            local finalScore = ZO_DEFAULT_ENABLED_COLOR:Colorize(score)
            vitalityBonus = ZO_DEFAULT_ENABLED_COLOR:Colorize(vitalityBonus)
            if currentCount == 0 then
                vitalityCounterString = ZO_DISABLED_TEXT:Colorize(vitalityCounterString)
            else
                vitalityCounterString = ZO_DEFAULT_ENABLED_COLOR:Colorize(vitalityCounterString)
            end
            if wasUnderTargetTime then
                formattedTime = ZO_DEFAULT_ENABLED_COLOR:Colorize(formattedTime)
            else
                formattedTime = ZO_ERROR_COLOR:Colorize(formattedTime)
            end

            printToChat(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_COMPLETED_LARGE, formattedName), true)
            printToChat(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_SCORETALLY, finalScore, formattedTime, vitalityBonus, vitalityCounterString), true)
        end

        -- Display CSA
        if ChatAnnouncements.SV.Group.GroupRaidCSA then
            messageParams:SetEndOfRaidData({ score, formattedTime, wasUnderTargetTime, vitalityBonus, zo_strformat(SI_REVIVE_COUNTER_REVIVES_USED, currentCount, maxCount) })
            messageParams:SetText(zo_strformat(SI_TRIAL_COMPLETED_LARGE, raidName))
            messageParams:SetLifespanMS(TRIAL_COMPLETE_LIFESPAN_MS)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Group.GroupRaidAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_TRIAL_COMPLETED_LARGE, raidName) )
        end

        -- Play sound if CSA is not enabled
        if not ChatAnnouncements.SV.Group.GroupRaidCSA then
            PlaySound(SOUNDS.RAID_TRIAL_COMPLETE)
        end
        return true
    end

    -- EVENT_RAID_TRIAL_FAILED -- CSA HANDLER
    local function RaidFailedHook(raidName, score)
        -- Display CA
        if ChatAnnouncements.SV.Group.GroupRaidCA then
            local formattedName = zo_strformat("|cFEFEFE<<1>>|r", trialName)
            printToChat(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_FAILED, formattedName), true)
        end

        -- Display CSA
        if ChatAnnouncements.SV.Group.GroupRaidCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.RAID_TRIAL_FAILED)
            messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_FAILED, raidName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Group.GroupRaidAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUP_TRIAL_FAILED, raidName) )
        end

        -- Play sound if CSA is not enabled
        if not ChatAnnouncements.SV.Group.GroupRaidCSA then
            PlaySound(SOUNDS.RAID_TRIAL_FAILED)
        end
        return true
    end

    -- EVENT_RAID_TRIAL_NEW_BEST_SCORE -- CSA HANDLER
    local function RaidBestScoreHook(raidName, score, isWeekly)
        -- Display CA
        if ChatAnnouncements.SV.Group.GroupRaidBestScoreCA then
            local formattedName = zo_strformat("|cFEFEFE<<1>>|r", trialName)
            local formattedString = isWeekly and zo_strformat(SI_TRIAL_NEW_BEST_SCORE_WEEKLY, formattedName) or zo_strformat(SI_TRIAL_NEW_BEST_SCORE_LIFETIME, formattedName)
            printToChat(formattedString, true)
        end

        -- Display CSA
        if ChatAnnouncements.SV.Group.GroupRaidBestScoreCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.RAID_TRIAL_NEW_BEST)
            messageParams:SetText(zo_strformat(isWeekly and SI_TRIAL_NEW_BEST_SCORE_WEEKLY or SI_TRIAL_NEW_BEST_SCORE_LIFETIME, raidName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Display Alert
        if ChatAnnouncements.SV.Group.GroupRaidBestScoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(isWeekly and SI_TRIAL_NEW_BEST_SCORE_WEEKLY or SI_TRIAL_NEW_BEST_SCORE_LIFETIME, raidName) )
        end

        -- Play sound ONLY if normal score is not set to display, otherwise the audio will overlap
        if not ChatAnnouncements.SV.Group.GroupRaidBestScoreCSA and not (ChatAnnouncements.SV.Group.GroupRaidScoreCA and ChatAnnouncements.SV.Group.GroupRaidScoreCSA and ChatAnnouncements.SV.Group.GroupRaidScoreAlert) then
            PlaySound(SOUNDS.RAID_TRIAL_NEW_BEST)
        end
        return true
    end

    -- EVENT_RAID_REVIVE_COUNTER_UPDATE -- CSA HANDLER
    local function RaidReviveCounterHook(currentCount, countDelta)
        if not IsRaidInProgress() then
            return
        end
        if countDelta < 0 then
            if ChatAnnouncements.SV.Group.GroupRaidReviveCA then
                local iconCA = zo_iconFormat("EsoUI/Art/Trials/VitalityDepletion.dds", 16, 16)
                printToChat(zo_strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, iconCA))
            end

            if ChatAnnouncements.SV.Group.GroupRaidReviveCSA then
                local iconCSA = zo_iconFormat("EsoUI/Art/Trials/VitalityDepletion.dds", "100%", "100%")
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.RAID_TRIAL_COUNTER_UPDATE)
                messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, iconCSA))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            if ChatAnnouncements.SV.Group.GroupRaidReviveAlert then
                local iconAlert = zo_iconFormat("EsoUI/Art/Trials/VitalityDepletion.dds", "75%", "75%")
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, iconAlert) )
            end

            -- Play Sound if CSA is not enabled
            if not ChatAnnouncements.SV.Group.GroupRaidReviveCSA then
                PlaySound(SOUNDS.RAID_TRIAL_COUNTER_UPDATE)
            end
        end
        return true
    end

    local TRIAL_SCORE_REASON_TO_ASSETS = {
        [RAID_POINT_REASON_KILL_MINIBOSS]           = { icon = "EsoUI/Art/Trials/trialPoints_normal.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_NORMAL },
        [RAID_POINT_REASON_KILL_BOSS]               = { icon = "EsoUI/Art/Trials/trialPoints_veryHigh.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_HIGH },
        [RAID_POINT_REASON_BONUS_ACTIVITY_LOW]      = { icon = "EsoUI/Art/Trials/trialPoints_veryLow.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_LOW },
        [RAID_POINT_REASON_BONUS_ACTIVITY_MEDIUM]   = { icon = "EsoUI/Art/Trials/trialPoints_low.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_LOW },
        [RAID_POINT_REASON_BONUS_ACTIVITY_HIGH]     = { icon = "EsoUI/Art/Trials/trialPoints_high.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_HIGH },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_ONE]   = { icon = "EsoUI/Art/Trials/trialPoints_veryLow.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_LOW },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_TWO]   = { icon = "EsoUI/Art/Trials/trialPoints_low.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_LOW },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_THREE] = { icon = "EsoUI/Art/Trials/trialPoints_normal.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_NORMAL },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_FOUR]  = { icon = "EsoUI/Art/Trials/trialPoints_high.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_HIGH },
        [RAID_POINT_REASON_SOLO_ARENA_COMPLETE]     = { icon = "EsoUI/Art/Trials/trialPoints_veryHigh.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_HIGH },
    }

    -- EVENT_RAID_TRIAL_SCORE_UPDATE -- CSA HANDLER
    local function RaidScoreUpdateHook(scoreUpdateReason, scoreAmount, totalScore)
        local reasonAssets = TRIAL_SCORE_REASON_TO_ASSETS[scoreUpdateReason]
        if reasonAssets then
            -- Display CA
            if ChatAnnouncements.SV.Group.GroupRaidScoreCA then
                local iconCA = zo_iconFormat(reasonAssets.icon, 16, 16)
                printToChat(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, iconCA, scoreAmount))
            end

            -- Display CSA
            if ChatAnnouncements.SV.Group.GroupRaidScoreCSA then
                local iconCSA = zo_iconFormat(reasonAssets.icon, "100%", "100%")
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, reasonAssets.soundId)
                messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, iconCSA, scoreAmount))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end

            -- Display Alert
            if ChatAnnouncements.SV.Group.GroupRaidScoreAlert then
                local iconAlert = zo_iconFormat(reasonAssets.icon, "75%", "75%")
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, iconAlert, scoreAmount) )
            end

            -- Play Sound if CSA is not enabled
            if not ChatAnnouncements.SV.Group.GroupRaidScoreCSA then
                PlaySound(reasonAssets.soundId)
            end
        end
        return true
    end

    -- EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE -- CSA HANDLER
    local function ActivityFinderCompleteHook()
        local message = GetString(SI_ACTIVITY_FINDER_ACTIVITY_COMPLETE_ANNOUNCEMENT_TEXT)
        if ChatAnnouncements.SV.Group.GroupLFGCompleteCA then
            printToChat(message, true)
        end

        if ChatAnnouncements.SV.Group.GroupLFGCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.LFG_COMPLETE_ANNOUNCEMENT)
            messageParams:SetText(message)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ACTIVITY_COMPLETE)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        if ChatAnnouncements.SV.Group.GroupLFGCompleteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end

        if not ChatAnnouncements.SV.Group.GroupLFGCompleteCSA then
            PlaySound(SOUNDS.LFG_COMPLETE_ANNOUNCEMENT)
        end

        return true
    end

    local overrideDisplayAnnouncementTitle = {
        [GetString(SI_SKILLS_FORCE_RESPEC_TITLE)] = { ca = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS) .. ".", csa = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS), announceType = "RESPEC" },
        [GetString(SI_ATTRIBUTE_FORCE_RESPEC_TITLE)] = { ca = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES) .. ".", csa = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES), announceType = "RESPEC" },
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_D)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_D), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_C), announceType = "GROUPAREA" }, -- Entering Group Area.
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MAELSTROM)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MAELSTROM_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MAELSTROM), announceType = "ARENA"}, -- Maelstrom Arena
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND1)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND1_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND1), announceType = "ROUND" }, -- Round 1
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND2)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND2_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND2), announceType = "ROUND" }, -- Round 2
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND3)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND3_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND3), announceType = "ROUND" }, -- Round 3
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND4)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND4_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND4), announceType = "ROUND" }, -- Round 4
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND5)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND5_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND5), announceType = "ROUND" }, -- Round 5
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUNDF)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUNDF_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUNDF), announceType = "ROUND" }, -- Final Round
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA), announceType = "ARENA" }, -- Dragonstar Arena
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE1)] = { number = 1 }, -- IC (DC 1)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE2)] = { number = 2 }, -- IC (DC 2)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE3)] = { number = 3 }, -- IC (DC 3)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE4)] = { number = 4 }, -- IC (DC 4)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE5)] = { number = 5 }, -- IC (AD 1)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE6)] = { number = 6 }, -- IC (AD 2)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE7)] = { number = 7 }, -- IC (AD 3)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE8)] = { number = 8 }, -- IC (AD 4)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE9)] = { number = 9 }, -- IC (EP 1)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE10)] = { number = 10 }, -- IC (EP 2)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE11)] = { number = 11 }, -- IC (EP 3)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE12)] = { number = 12 }, -- IC (EP 4)
    }

    local overrideDisplayAnnouncementDescription = {
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_D)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_D), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_C), announceType = "GROUPAREA" }, -- Leaving Group Area.
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE1)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE1), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE1), announceType = "ARENA" }, -- Vale of the Surreal
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE2)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE2), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE2), announceType = "ARENA" }, -- Seht's Balcony
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE3)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE3), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE3), announceType = "ARENA" }, -- Drome of Toxic Shock
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE4)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE4), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE4), announceType = "ARENA" }, -- Seht's Flywheel
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE5)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE5), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE5), announceType = "ARENA" }, -- Rink of Frozen Blood
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE6)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE6), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE6), announceType = "ARENA" }, -- Spiral Shadows
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE7)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE7), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE7), announceType = "ARENA" }, -- Vault of Umbrage
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE8)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE8), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE8), announceType = "ARENA" }, -- Igneous Cistern
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE9)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE9), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE9), announceType = "ARENA" }, -- Theater of Despair
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA_DESC)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA_DESC), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA_DESC), announceType = "ARENA" }, -- The arena will begin in 30 seconds!
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_SR)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_SR_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_SR_CA), announceType = "CRAGLORN" }, -- Spell Resistance Increased
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_PR)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_PR_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_PR_CA), announceType = "CRAGLORN" }, -- Physical Resistance Increased
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_PI)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_PI_CA), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_CRAGLORN_PI_CA), announceType = "CRAGLORN" }, -- Power Increased
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC1)] = { number = 1 }, -- IC (DC 1)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC2)] = { number = 2 }, -- IC (DC 2)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC3)] = { number = 3 }, -- IC (DC 3)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC4)] = { number = 4 }, -- IC (DC 4)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC5)] = { number = 5 }, -- IC (AD 1)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC6)] = { number = 6 }, -- IC (AD 2)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC7)] = { number = 7 }, -- IC (AD 3)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC8)] = { number = 8 }, -- IC (AD 4)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC9)] = { number = 9 }, -- IC (EP 1)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC10)] = { number = 10 }, -- IC (EP 2)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC11)] = { number = 11 }, -- IC (EP 3)
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC12)] = { number = 12 }, -- IC (EP 4)
    }

    local function DisplayAnnouncementIC(number)
        -- Don't print the message if display spam is turned off
        if g_stopDisplaySpam == true then return end

        -- Stop messages from spamming if the player bounces around the same trigger multiple times
        if g_stopDisplaySpam == false then
            g_stopDisplaySpam = true
            zo_callLater(function() g_stopDisplaySpam = false end, 5000)
        end

        local flagCA = ChatAnnouncements.SV.Quests.QuestICDiscoveryCA and true or false
        local flagCSA = ChatAnnouncements.SV.Quests.QuestICDiscoveryCSA and true or false
        local flagAlert = ChatAnnouncements.SV.Quests.QuestICDiscoveryAlert and true or false

        -- Setup Strings
        local titleString = number == 8 and GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE8_EDIT) or GetString("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE", number)
        local descriptionString = GetString("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_DESC", number)
        local formatLine1 = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE_PREFIX)
        local formatLine2 = GetString("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_IC_TITLE_CA_", number)

        -- Setup final strings to display
        local titleCA = ChatAnnouncements.SV.Quests.QuestICDescription and string.format("%s|c%s%s: |r", formatLine1, QuestColorLocNameColorize, formatLine2 ) or string.format("%s|c%s%s|r", formatLine1, QuestColorLocNameColorize, formatLine2 )
        local titleAlert = titleCA
        local titleCSA = titleString
        local descriptionCA = ChatAnnouncements.SV.Quests.QuestICDescription and string.format("|c%s%s|r", QuestColorLocDescriptionColorize, descriptionString) or ""
        local descriptionAlert = ChatAnnouncements.SV.Quests.QuestICDescription and descriptionString or ""
        local descriptionCSA = descriptionString

        local messageParams
        local message
        if title ~= "" and description ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        elseif title ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        elseif description ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        end

        if flagCA then
            if title ~= "" and description ~= "" then
                printToChat(titleCA .. descriptionCA)
            elseif title ~= "" then
                printToChat(titleCA)
            elseif description ~= "" then
                printToChat(descriptionCA)
            end
        end

        if flagCSA then
            if messageParams then
                messageParams:SetText(titleCSA, descriptionCSA)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        if flagAlert then
            if title ~= "" and description ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, (titleAlert .. descriptionAlert) )
            elseif title ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, titleAlert)
            elseif description ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, descriptionAlert)
            end
        end

        if (flagCA or flagAlert) and not flagCSA then
            PlaySound(SOUNDS.DISPLAY_ANNOUNCEMENT)
        end
    end

    -- EVENT_DISPLAY_ANNOUNCEMENT -- CSA HANDLER
    local function DisplayAnnouncementHook(title, description)
        if ( (title ~= "" and not overrideDisplayAnnouncementTitle[title]) or (description ~= "" and not overrideDisplayAnnouncementDescription[description]) ) and ChatAnnouncements.SV.DisplayAnnouncements.Debug then
            d("EVENT_DISPLAY_ANNOUNCEMENT")
            d("If you see this message please post a screenshot and context for the event on the LUI Extended ESOUI page.")
            d("title: " .. title)
            d("description: " .. description)
        end

        -- Let unfiltered messages pass through the normal function
        if (title ~= "" and not overrideDisplayAnnouncementTitle[title]) or (description ~= "" and not overrideDisplayAnnouncementDescription[description]) then
            -- Use default behavior if not in the override table
            local messageParams
            if title ~= "" and description ~= "" then
                messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
            elseif title ~= "" then
                messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
            elseif description ~= "" then
                messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
            end

            if messageParams then
                messageParams:SetText(title, description)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
            end
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            return true
        end

        local flagCA
        local flagCSA
        local flagAlert

        -- Resolve whether flags are true
        -- Temporary double conditional here until we resolve all Display Announcement types
        if (title ~= "" and overrideDisplayAnnouncementTitle[title]) or (description ~= "" and overrideDisplayAnnouncementDescription[description]) then
            local reference
            -- If this is an IC announcement then pass it over to the IC Announcement handler to display
            if (title ~= "" and overrideDisplayAnnouncementTitle[title] and overrideDisplayAnnouncementTitle[title].number) or (description ~= "" and overrideDisplayAnnouncementDescription[description] and overrideDisplayAnnouncementDescription[description].number) then
                DisplayAnnouncementIC(overrideDisplayAnnouncementTitle[title].number)
                return
            end
            if title ~= "" and overrideDisplayAnnouncementTitle[title] then reference = overrideDisplayAnnouncementTitle[title].announceType end
            if description ~= "" and overrideDisplayAnnouncementDescription[description] then reference = overrideDisplayAnnouncementDescription[description].announceType end
            if reference == "RESPEC" then
                flagCA = ChatAnnouncements.SV.Notify.NotificationRespecCA and true or false
                flagCSA = ChatAnnouncements.SV.Notify.NotificationRespecCSA and true or false
                flagAlert = ChatAnnouncements.SV.Notify.NotificationRespecAlert and true or false
            elseif reference == "GROUPAREA" then
                flagCA = ChatAnnouncements.SV.Notify.NotificationGroupAreaCA and true or false
                flagCSA = ChatAnnouncements.SV.Notify.NotificationGroupAreaCSA and true or false
                flagAlert = ChatAnnouncements.SV.Notify.NotificationGroupAreaAlert and true or false
            elseif reference == "ARENA" then
                flagCA = ChatAnnouncements.SV.Group.GroupRaidArenaCA and true or false
                flagCSA = ChatAnnouncements.SV.Group.GroupRaidArenaCSA and true or false
                flagAlert = ChatAnnouncements.SV.Group.GroupRaidArenaAlert and true or false
            elseif reference == "ROUND" then
                flagCA = ChatAnnouncements.SV.Group.GroupRaidArenaRoundCA and true or false
                flagCSA = ChatAnnouncements.SV.Group.GroupRaidArenaRoundCSA and true or false
                flagAlert = ChatAnnouncements.SV.Group.GroupRaidArenaRoundAlert and true or false
            elseif reference == "CRAGLORN" then
                flagCA = ChatAnnouncements.SV.Quests.QuestCraglornBuffCA and true or false
                flagCSA = ChatAnnouncements.SV.Quests.QuestCraglornBuffCSA and true or false
                flagAlert = ChatAnnouncements.SV.Quests.QuestCraglornBuffAlert and true or false
            end
        end

        local titleCA
        local titleCSA
        local descriptionCA
        local descriptionCSA

        -- Replace message text when needed
        if title ~= "" and overrideDisplayAnnouncementTitle[title] then
            titleCA = overrideDisplayAnnouncementTitle[title].ca
            titleCSA = overrideDisplayAnnouncementTitle[title].csa
        elseif title ~= "" then
            titleCA = title
            titleCSA = title
        end

        if description ~= "" and overrideDisplayAnnouncementDescription[description] then
            descriptionCA = overrideDisplayAnnouncementDescription[description].ca
            descriptionCSA = overrideDisplayAnnouncementDescription[description].csa
        elseif description ~= "" then
            descriptionCA = title
            descriptionCSA = title
        end

        local messageParams
        local message
        if title ~= "" and description ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        elseif title ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        elseif description ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        end

        if flagCA then
            if title ~= "" and description ~= "" then
                printToChat(titleCA .. descriptionCA)
            elseif title ~= "" then
                printToChat(titleCA)
            elseif description ~= "" then
                printToChat(descriptionCA)
            end
        end

        if flagCSA then
            if messageParams then
                messageParams:SetText(titleCSA, descriptionCSA)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        if flagAlert then
            if title ~= "" and description ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, (titleCA .. descriptionCA) )
            elseif title ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, titleCA)
            elseif description ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, descriptionCA)
            end
        end

        if (flagCA or flagAlert) and not flagCSA then
            PlaySound(SOUNDS.DISPLAY_ANNOUNCEMENT)
        end

        return true
    end

    -- EVENT BROADCAST -- CSA HANDLER
    local function BroadcastHook(message)
        d("EVENT_BROADCAST")

        -- CA
        printToChat(string.format("|cffff00%s|r", message), true)

        -- CSA
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.MESSAGE_BROADCAST)
        messageParams:SetText(string.format("|cffff00%s|r", message))
        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SYSTEM_BROADCAST)
        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)

        -- Alert
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        return true
    end

    -- EVENT_ACHIEVEMENT_AWARDED
    local function AchievementAwardedHook(name, points, id, link)
        -- Display CSA
        if ChatAnnouncements.SV.Achievement.AchievementCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ACHIEVEMENT_AWARDED)
            local icon = select(4, GetAchievementInfo(id))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ACHIEVEMENT_AWARDED)
            messageParams:SetText(ChatAnnouncements.SV.Achievement.AchievementCompleteMsg, zo_strformat(name))
            messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Play sound if CSA is disabled
        if not ChatAnnouncements.SV.Achievement.AchievementCompleteCSA then
            PlaySound(SOUNDS.ACHIEVEMENT_AWARDED)
        end

        local topLevelIndex, categoryIndex, achievementIndex = GetCategoryInfoFromAchievementId(id)
        -- Bail out if this achievement comes from unwanted category
        -- TODO: Make this less shit in the future
        if topLevelIndex == 1 and not ChatAnnouncements.SV.Achievement.AchievementCategory1 then return true end
        if topLevelIndex == 2 and not ChatAnnouncements.SV.Achievement.AchievementCategory2 then return true end
        if topLevelIndex == 3 and not ChatAnnouncements.SV.Achievement.AchievementCategory3 then return true end
        if topLevelIndex == 4 and not ChatAnnouncements.SV.Achievement.AchievementCategory4 then return true end
        if topLevelIndex == 5 and not ChatAnnouncements.SV.Achievement.AchievementCategory5 then return true end
        if topLevelIndex == 6 and not ChatAnnouncements.SV.Achievement.AchievementCategory6 then return true end
        if topLevelIndex == 7 and not ChatAnnouncements.SV.Achievement.AchievementCategory7 then return true end
        if topLevelIndex == 8 and not ChatAnnouncements.SV.Achievement.AchievementCategory8 then return true end
        if topLevelIndex == 9 and not ChatAnnouncements.SV.Achievement.AchievementCategory9 then return true end
        if topLevelIndex == 10 and not ChatAnnouncements.SV.Achievement.AchievementCategory10 then return true end
        if topLevelIndex == 11 and not ChatAnnouncements.SV.Achievement.AchievementCategory11 then return true end
        if topLevelIndex == 12 and not ChatAnnouncements.SV.Achievement.AchievementCategory12 then return true end
        if topLevelIndex == 13 and not ChatAnnouncements.SV.Achievement.AchievementCategory13 then return true end
        if topLevelIndex == 14 and not ChatAnnouncements.SV.Achievement.AchievementCategory14 then return true end
        if topLevelIndex == 15 and not ChatAnnouncements.SV.Achievement.AchievementCategory15 then return true end
        if topLevelIndex == 16 and not ChatAnnouncements.SV.Achievement.AchievementCategory16 then return true end
        if topLevelIndex == 17 and not ChatAnnouncements.SV.Achievement.AchievementCategory17 then return true end
        if topLevelIndex == 18 and not ChatAnnouncements.SV.Achievement.AchievementCategory18 then return true end
        if topLevelIndex == 19 and not ChatAnnouncements.SV.Achievement.AchievementCategory19 then return true end
        if topLevelIndex == 20 and not ChatAnnouncements.SV.Achievement.AchievementCategory20 then return true end
        if topLevelIndex == 21 and not ChatAnnouncements.SV.Achievement.AchievementCategory21 then return true end
        if topLevelIndex == 22 and not ChatAnnouncements.SV.Achievement.AchievementCategory22 then return true end
        if topLevelIndex == 23 and not ChatAnnouncements.SV.Achievement.AchievementCategory23 then return true end
        if topLevelIndex == 24 and not ChatAnnouncements.SV.Achievement.AchievementCategory24 then return true end
        if topLevelIndex == 25 and not ChatAnnouncements.SV.Achievement.AchievementCategory25 then return true end
        if topLevelIndex == 25 and not ChatAnnouncements.SV.Achievement.AchievementCategory26 then return true end

        if ChatAnnouncements.SV.Achievement.AchievementCompleteCA then
            link = zo_strformat(GetAchievementLink(id, linkBrackets[ChatAnnouncements.SV.BracketOptionAchievement]))
            local catName = GetAchievementCategoryInfo(topLevelIndex)
            local subcatName = categoryIndex ~= nil and GetAchievementSubCategoryInfo(topLevelIndex, categoryIndex) or "General"
            local _, _, _, icon = GetAchievementInfo(id)
            icon = ChatAnnouncements.SV.Achievement.AchievementIcon and ("|t16:16:" .. icon .. "|t ") or ""

            local stringpart1 = AchievementColorize1:Colorize(string.format("%s%s%s %s%s", bracket1[ChatAnnouncements.SV.Achievement.AchievementBracketOptions], ChatAnnouncements.SV.Achievement.AchievementCompleteMsg, bracket2[ChatAnnouncements.SV.Achievement.AchievementBracketOptions], icon, link))

            local stringpart2
            if ChatAnnouncements.SV.Achievement.AchievementCompPercentage then
                stringpart2 = ChatAnnouncements.SV.Achievement.AchievementColorProgress and string.format(" %s|c71DE73%s|r%s", AchievementColorize2:Colorize("("), ("100%"), AchievementColorize2:Colorize(")")) or AchievementColorize2:Colorize (" (100%)")
            else
                stringpart2 = ""
            end

            local stringpart3
            if ChatAnnouncements.SV.Achievement.AchievementCategory and ChatAnnouncements.SV.Achievement.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(string.format(" %s%s - %s%s", bracket1[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions], catName, subcatName, bracket2[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions]))
            elseif ChatAnnouncements.SV.Achievement.AchievementCategory and not ChatAnnouncements.SV.Achievement.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(string.format(" %s%s%s", bracket1[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions], catName, bracket2[ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions]))
            else
                stringpart3 = ""
            end

            local finalString = string.format("%s%s%s", stringpart1, stringpart2, stringpart3)
            g_queuedMessages[g_queuedMessagesCounter] = { message = finalString, type = "ACHIEVEMENT" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
        end

        -- Display Alert
        if ChatAnnouncements.SV.Achievement.AchievementCompleteAlert then
            local alertMessage = zo_strformat("<<1>>: <<2>>", ChatAnnouncements.SV.Achievement.AchievementCompleteMsg, name)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
        end

        return true
    end

    local function PledgeOfMaraHook(result, characterName, displayName)
        -- Display CA (Success or Failure)
        if ChatAnnouncements.SV.Social.PledgeOfMaraCA then
            local finalName = ChatAnnouncements.ResolveNameLink(characterName, displayName)
            printToChat(zo_strformat(GetString("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT", result), finalName), true)
        end

        if ChatAnnouncements.SV.Social.PledgeOfMaraAlert or ChatAnnouncements.SV.Social.PledgeOfMaraCSA then
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(characterName, displayName)

            -- Display CSA (Success Only)
            if ChatAnnouncements.SV.Social.PledgeOfMaraCSA then
                if result == PLEDGE_OF_MARA_RESULT_PLEDGED then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_PLEDGE_OF_MARA_RESULT)
                    messageParams:SetText(GetString(SI_RITUAL_OF_MARA_COMPLETION_ANNOUNCE_LARGE), zo_strformat(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT3, finalAlertName))
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
            end

            -- Alert (Success or Failure)
            if ChatAnnouncements.SV.Social.PledgeOfMaraAlert then
                -- If the menu setting to only display Alert on Failure state is toggled, then do not display an Alert on successful Mara Event
                if result == PLEDGE_OF_MARA_RESULT_PLEDGED and not ChatAnnouncements.SV.Social.PledgeOfMaraAlertOnlyFail then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT3, finalAlertName))
                elseif(result ~= PLEDGE_OF_MARA_RESULT_PLEDGED and result ~= PLEDGE_OF_MARA_RESULT_BEGIN_PLEDGE) then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, zo_strformat(GetString("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT", result), finalAlertName))
                end
            end
        end

        -- Play alert sound if Alert is disabled (Note: A sound seems to be played from success regardless of the CSA being on/off here)
        if not ChatAnnouncements.SV.Social.PledgeOfMaraAlert and (result ~= PLEDGE_OF_MARA_RESULT_PLEDGED and result ~= PLEDGE_OF_MARA_RESULT_BEGIN_PLEDGE) then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end

        return true
    end

    -- Unregister the ZOS events for handling Quest Removal/Advanced/Added to replace with our own functions
    eventManager:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_REMOVED)
    eventManager:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADVANCED)
    eventManager:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADDED)
    eventManager:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_REMOVED, OnQuestRemoved)
    eventManager:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADVANCED, OnQuestAdvanced)
    eventManager:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADDED, OnQuestAdded)

    ZO_PreHook(csaHandlers, EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE, LoreBookXPHook)
    ZO_PreHook(csaHandlers, EVENT_LORE_COLLECTION_COMPLETED, LoreCollectionHook)
    ZO_PreHook(csaHandlers, EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE, LoreCollectionXPHook)
    ZO_PreHook(csaHandlers, EVENT_SKILL_POINTS_CHANGED, SkillPointsChangedHook)
    ZO_PreHook(csaHandlers, EVENT_SKILL_LINE_ADDED, SkillLineAddedHook)
    ZO_PreHook(csaHandlers, EVENT_ABILITY_PROGRESSION_RANK_UPDATE, AbilityProgressionRankHook)
    ZO_PreHook(csaHandlers, EVENT_SKILL_RANK_UPDATE, SkillRankUpdateHook)
    ZO_PreHook(csaHandlers, EVENT_SKILL_XP_UPDATE, SkillXPUpdateHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_ADDED, QuestAddedHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_COMPLETE, QuestCompleteHook)
    ZO_PreHook(csaHandlers, EVENT_OBJECTIVE_COMPLETED, ObjectiveCompletedHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_CONDITION_COUNTER_CHANGED, ConditionCounterHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_OPTIONAL_STEP_ADVANCED, OptionalStepHook)
    ZO_PreHook(csaHandlers, EVENT_DISCOVERY_EXPERIENCE, DiscoveryExperienceHook)
    ZO_PreHook(csaHandlers, EVENT_POI_DISCOVERED, PoiDiscoveredHook)
    ZO_PreHook(csaHandlers, EVENT_EXPERIENCE_GAIN, ExperienceGainHook)
    ZO_PreHook(csaHandlers, EVENT_ENLIGHTENED_STATE_GAINED, EnlightenGainHook)
    ZO_PreHook(csaHandlers, EVENT_ENLIGHTENED_STATE_LOST, EnlightenLostHook)
    ZO_PreHook(csaHandlers, EVENT_PLAYER_ACTIVATED, PlayerActivatedHook)
    ZO_PreHook(csaHandlers, EVENT_RIDING_SKILL_IMPROVEMENT, RidingSkillImprovementHook)
    ZO_PreHook(csaHandlers, EVENT_INVENTORY_BAG_CAPACITY_CHANGED, InventoryBagCapacityHook)
    ZO_PreHook(csaHandlers, EVENT_INVENTORY_BANK_CAPACITY_CHANGED, InventoryBankCapacityHook)
    ZO_PreHook(csaCallbackHandlers[1], "callbackFunction", CollectibleUnlockedHook)
    ZO_PreHook(csaHandlers, EVENT_CHAMPION_LEVEL_ACHIEVED, ChampionLevelAchievedHook)
    ZO_PreHook(csaHandlers, EVENT_CHAMPION_POINT_GAINED, ChampionPointGainedHook)
    ZO_PreHook(csaHandlers, EVENT_DUEL_NEAR_BOUNDARY, DuelNearBoundaryHook)
    ZO_PreHook(csaHandlers, EVENT_DUEL_FINISHED, DuelFinishedHook)
    ZO_PreHook(csaHandlers, EVENT_DUEL_COUNTDOWN, DuelCountdownHook)

    eventManager:RegisterForEvent(moduleName, EVENT_DUEL_STARTED, ChatAnnouncements.DuelStarted)

    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_STARTED, RaidStartedHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_COMPLETE, RaidCompleteHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_FAILED, RaidFailedHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_NEW_BEST_SCORE, RaidBestScoreHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_REVIVE_COUNTER_UPDATE, RaidReviveCounterHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_SCORE_UPDATE, RaidScoreUpdateHook)
    ZO_PreHook(csaHandlers, EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE, ActivityFinderCompleteHook)
    ZO_PreHook(csaHandlers, EVENT_DISPLAY_ANNOUNCEMENT, DisplayAnnouncementHook)
    --ZO_PreHook(csaHandlers, EVENT_BROADCAST, BroadcastHook)
    ZO_PreHook(csaHandlers, EVENT_ACHIEVEMENT_AWARDED, AchievementAwardedHook)
    ZO_PreHook(csaHandlers, EVENT_PLEDGE_OF_MARA_RESULT, PledgeOfMaraHook)

    eventManager:RegisterForEvent(moduleName, EVENT_PLEDGE_OF_MARA_OFFER, ChatAnnouncements.MaraOffer)

    -- TODO: Allow these to use their default conditions if Saved Variable option for CA is not turned on
    local function GroupTypeChangedChatHook()
        return true
    end

    local function GroupInviteChatHook()
        return true
    end

    local function GroupMemberLeftChatHook()
        return true
    end

    -- TODO: Conditionals based off EVENT_SOCIAL_ERROR HOOK LATER
    local function SocialErrorHook(error)
        if(not IsSocialErrorIgnoreResponse(error) and ShouldShowSocialErrorInChat(error)) then
            printToChat(zo_strformat(GetString("SI_SOCIALACTIONRESULT", error)), true)
        end
        return true
    end

    local function FriendStatusHook()
        return true
    end

    local function IgnoreAddedHook()
        return true
    end

    local function IgnoreRemovedHook()
        return true
    end

    ZO_PreHook(chatHandlers, EVENT_GROUP_TYPE_CHANGED, GroupTypeChangedChatHook)
    ZO_PreHook(chatHandlers, EVENT_GROUP_INVITE_RESPONSE, GroupInviteChatHook)
    ZO_PreHook(chatHandlers, EVENT_GROUP_MEMBER_LEFT, GroupMemberLeftChatHook)
    ZO_PreHook(chatHandlers, EVENT_SOCIAL_ERROR, SocialErrorHook)
    ZO_PreHook(chatHandlers, EVENT_FRIEND_PLAYER_STATUS_CHANGED, FriendStatusHook)
    ZO_PreHook(chatHandlers, EVENT_IGNORE_ADDED, IgnoreAddedHook)
    ZO_PreHook(chatHandlers, EVENT_IGNORE_REMOVED, IgnoreRemovedHook)

    -- HOOK PLAYER_TO_PLAYER Group Notifications to edit Ignore alert
    local KEYBOARD_INTERACT_ICONS = {
        [SI_PLAYER_TO_PLAYER_WHISPER] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_whisper_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_whisper_over.dds",
            disabledNormal =  "EsoUI/Art/HUD/radialIcon_whisper_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_whisper_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_inviteGroup_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_inviteGroup_over.dds",
            disabledNormal =  "EsoUI/Art/HUD/radialIcon_inviteGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_inviteGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_REMOVE_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_removeFromGroup_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_removeFromGroup_over.dds",
            disabledNormal =  "EsoUI/Art/HUD/radialIcon_removeFromGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_removeFromGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_FRIEND] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_addFriend_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_addFriend_over.dds",
            disabledNormal = "EsoUI/Art/HUD/radialIcon_addFriend_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_addFriend_disabled.dds",
        },
        [SI_CHAT_PLAYER_CONTEXT_REPORT] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_reportPlayer_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_reportPlayer_over.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_DUEL] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_duel_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_duel_over.dds",
            disabledNormal = "EsoUI/Art/HUD/radialIcon_duel_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_duel_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_TRADE] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_trade_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_trade_over.dds",
            disabledNormal = "EsoUI/Art/HUD/radialIcon_trade_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_trade_disabled.dds",
        },
        [SI_RADIAL_MENU_CANCEL_BUTTON] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_cancel_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_cancel_over.dds",
        },
    }

    local GAMEPAD_INTERACT_ICONS = {
        [SI_PLAYER_TO_PLAYER_WHISPER] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_down.dds",
            disabledNormal =  "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_down.dds",
            disabledNormal =  "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_REMOVE_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_down.dds",
            disabledNormal =  "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_FRIEND] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_down.dds",
            disabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_disabled.dds",
        },
        [SI_CHAT_PLAYER_CONTEXT_REPORT] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_reportPlayer_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_reportPlayer_down.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_DUEL] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_down.dds",
            disabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_TRADE] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_down.dds",
            disabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_disabled.dds",
        },
        [SI_RADIAL_MENU_CANCEL_BUTTON] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds",
        },
    }

    local function AlertIgnored(SendString)
        local alertString = IsConsoleUI() and SI_PLAYER_TO_PLAYER_BLOCKED or SendString
        printToChat(GetString(alertString), true)
        if ChatAnnouncements.SV.Group.GroupAlert then
            ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, alertString)
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    end

    PLAYER_TO_PLAYER.ShowPlayerInteractMenu = function(self, isIgnored)
        local currentTargetCharacterName = self.currentTargetCharacterName
        local currentTargetCharacterNameRaw = self.currentTargetCharacterNameRaw
        local currentTargetDisplayName = self.currentTargetDisplayName
        local primaryName = ZO_GetPrimaryPlayerName(currentTargetDisplayName, currentTargetCharacterName)
        local primaryNameInternal = ZO_GetPrimaryPlayerName(currentTargetDisplayName, currentTargetCharacterName, USE_INTERNAL_FORMAT)
        local platformIcons = IsInGamepadPreferredMode() and GAMEPAD_INTERACT_ICONS or KEYBOARD_INTERACT_ICONS
        local ENABLED = true
        local DISABLED = false
        local ENABLED_IF_NOT_IGNORED = not isIgnored

        self:GetRadialMenu():Clear()
        --Gamecard--
        if IsConsoleUI() then
            self:AddShowGamerCard(currentTargetDisplayName, currentTargetCharacterName)
        end

        --Whisper--
        if IsChatSystemAvailableForCurrentPlatform() then
            local nameToUse = IsConsoleUI() and currentTargetDisplayName or primaryNameInternal
            local function WhisperOption() StartChatInput(nil, CHAT_CHANNEL_WHISPER, nameToUse) end
            local function WhisperIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_WHISPER) end
            local whisperFunction = ENABLED_IF_NOT_IGNORED and WhisperOption or WhisperIgnore
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_WHISPER), platformIcons[SI_PLAYER_TO_PLAYER_WHISPER], ENABLED_IF_NOT_IGNORED, whisperFunction)
        end

        --Group--
        local isGroupModificationAvailable = IsGroupModificationAvailable()
        local groupModicationRequiresVoting = DoesGroupModificationRequireVote()
        local isSoloOrLeader = IsUnitSoloOrGroupLeader("player")

        local function AlertGroupDisabled()
            printToChat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE), true)
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end

        local function AlertGroupKickDisabled()
            printToChat(GetString(SI_LUIE_CA_GROUP_LEADERKICK_ERROR))
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_LEADERKICK_ERROR), true)
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end

        if IsPlayerInGroup(currentTargetCharacterNameRaw) then
            local groupKickEnabled = isGroupModificationAvailable and isSoloOrLeader and not groupModicationRequiresVoting or IsInLFGGroup()
            local lfgKick = IsInLFGGroup()
            local groupKickFunction = nil
            if groupKickEnabled then
                if lfgKick then
                    groupKickFunction = function() LUIE.SlashCommands.SlashVoteKick(currentTargetCharacterName) end
                else
                    groupKickFunction = function() GroupKickByName(currentTargetCharacterNameRaw) end
                end
            else
                groupKickFunction = AlertGroupKickDisabled
            end

            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_REMOVE_GROUP), platformIcons[SI_PLAYER_TO_PLAYER_REMOVE_GROUP], groupKickEnabled, groupKickFunction)
        else
            local groupInviteEnabled = ENABLED_IF_NOT_IGNORED and isGroupModificationAvailable and isSoloOrLeader
            local groupInviteFunction = nil
            if groupInviteEnabled then
                groupInviteFunction = function()
                    local NOT_SENT_FROM_CHAT = false
                    local DISPLAY_INVITED_MESSAGE = true
                    TryGroupInviteByName(primaryNameInternal, NOT_SENT_FROM_CHAT, DISPLAY_INVITED_MESSAGE, true)
                end
            else
                if ENABLED_IF_NOT_IGNORED then
                    groupInviteFunction = AlertGroupDisabled
                else
                    local function GroupIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_GROUP) end
                    groupInviteFunction = GroupIgnore
                end
            end

            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_ADD_GROUP), platformIcons[SI_PLAYER_TO_PLAYER_ADD_GROUP], groupInviteEnabled, groupInviteFunction)
        end

        --Friend--
        if IsFriend(currentTargetCharacterNameRaw) then
            local function AlreadyFriendsWarning()
                printToChat(GetString("SI_SOCIALACTIONRESULT", SOCIAL_RESULT_ACCOUNT_ALREADY_FRIENDS), true)
                if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_SOCIALACTIONRESULT", SOCIAL_RESULT_ACCOUNT_ALREADY_FRIENDS))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_ADD_FRIEND), platformIcons[SI_PLAYER_TO_PLAYER_ADD_FRIEND], DISABLED, AlreadyFriendsWarning)
        else
            local function RequestFriendOption()
                if IsConsoleUI() then
                    ZO_ShowConsoleAddFriendDialog(currentTargetCharacterName)
                else
                    RequestFriend(currentTargetDisplayName, nil, true)
                end
                local displayNameLink
                if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                    displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(currentTargetDisplayName, nil, DISPLAY_NAME_LINK_TYPE, currentTargetDisplayName)
                else
                    displayNameLink = ZO_LinkHandler_CreateLink(currentTargetDisplayName, nil, DISPLAY_NAME_LINK_TYPE, currentTargetDisplayName)
                end
                printToChat(zo_strformat(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_LINK, displayNameLink), true)
                if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_LINK, currentTargetDisplayName))
                end
            end
            local function FriendIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_FRIEND) end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_ADD_FRIEND), platformIcons[SI_PLAYER_TO_PLAYER_ADD_FRIEND], ENABLED_IF_NOT_IGNORED, ENABLED_IF_NOT_IGNORED and RequestFriendOption or FriendIgnore)
        end

        --Report--
        local function ReportCallback()
            local nameToReport = IsInGamepadPreferredMode() and currentTargetDisplayName or primaryName
            ZO_HELP_GENERIC_TICKET_SUBMISSION_MANAGER:OpenReportPlayerTicketScene(nameToReport)
        end
        self:AddMenuEntry(GetString(SI_CHAT_PLAYER_CONTEXT_REPORT), platformIcons[SI_CHAT_PLAYER_CONTEXT_REPORT], ENABLED, ReportCallback)

        --Duel--
        local duelState, partnerCharacterName, partnerDisplayName = GetDuelInfo()
        if duelState ~= DUEL_STATE_IDLE then
            local function AlreadyDuelingWarning(duelState, characterName, displayName)
                return function()
                    local userFacingPartnerName = ZO_GetPrimaryPlayerNameWithSecondary(displayName, characterName)
                    local statusString = GetString("SI_DUELSTATE", duelState)
                    statusString = zo_strformat(statusString, userFacingPartnerName)
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, statusString)
                end
            end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_INVITE_DUEL), platformIcons[SI_PLAYER_TO_PLAYER_INVITE_DUEL], DISABLED, AlreadyDuelingWarning(duelState, partnerCharacterName, partnerDisplayName))
        else
            local function DuelInviteOption()
                ChallengeTargetToDuel(currentTargetCharacterName)
            end
            local function DuelIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_DUEL) end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_INVITE_DUEL), platformIcons[SI_PLAYER_TO_PLAYER_INVITE_DUEL], ENABLED_IF_NOT_IGNORED, ENABLED_IF_NOT_IGNORED and DuelInviteOption or DuelIgnore)
        end

        --Trade--
        local function TradeInviteOption() TRADE_WINDOW:InitiateTrade(primaryNameInternal) end
        local function TradeIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_TRADE) end
        local tradeInviteFunction = ENABLED_IF_NOT_IGNORED and TradeInviteOption or TradeIgnore
        self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_INVITE_TRADE), platformIcons[SI_PLAYER_TO_PLAYER_INVITE_TRADE], ENABLED_IF_NOT_IGNORED, tradeInviteFunction)

        --Cancel--
        self:AddMenuEntry(GetString(SI_RADIAL_MENU_CANCEL_BUTTON), platformIcons[SI_RADIAL_MENU_CANCEL_BUTTON], ENABLED)

        self:GetRadialMenu():Show()
        self.showingPlayerInteractMenu = true
        self.isLastRadialMenuGamepad = IsInGamepadPreferredMode()
    end

    --[[
    -- Since the Crown Store Gifting functionality was added, hooking these functions seems to cause an insecure code issue when receiving gifts via the Player to Player notification system.
    -- Not sure how else I can alter these notifications so for the time being support will have to be dropped.

    --local INTERACT_TYPE_TRADE_INVITE = 3
    local INTERACT_TYPE_GROUP_INVITE = 4
    local INTERACT_TYPE_QUEST_SHARE = 5
    local INTERACT_TYPE_FRIEND_REQUEST = 6
    local INTERACT_TYPE_GUILD_INVITE = 7

    local INCOMING_MESSAGE_TEXT = {
        --[INTERACT_TYPE_TRADE_INVITE] = GetString(SI_LUIE_NOTIFICATION_TRADE_INVITE),
        [INTERACT_TYPE_GROUP_INVITE] = GetString(SI_LUIE_NOTIFICATION_GROUP_INVITE),
        [INTERACT_TYPE_QUEST_SHARE] = GetString(SI_LUIE_NOTIFICATION_SHARE_QUEST_INVITE),
        [INTERACT_TYPE_FRIEND_REQUEST] = GetString(SI_LUIE_NOTIFICATION_FRIEND_INVITE),
        [INTERACT_TYPE_GUILD_INVITE] = GetString(SI_LUIE_NOTIFICATION_GUILD_INVITE)
    }

    local function DisplayNotificationMessage(message, data)
        local typeString = INCOMING_MESSAGE_TEXT[data.incomingType]
        if typeString then
            -- Group Invite
            if data.incomingType == INTERACT_TYPE_GROUP_INVITE then
                if ChatAnnouncements.SV.Group.GroupCA then
                    printToChat(zo_strformat(message, typeString), true)
                end
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            -- Guild Invite
            elseif data.incomingType == INTERACT_TYPE_GUILD_INVITE then
                if ChatAnnouncements.SV.Social.GuildCA then
                    printToChat(zo_strformat(message, typeString), true)
                end
                if ChatAnnouncements.SV.Social.GuildAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            -- Friend Invite
            elseif data.incomingType == INTERACT_TYPE_FRIEND_REQUEST then
                if ChatAnnouncements.SV.Social.FriendIgnoreCA then
                    printToChat(zo_strformat(message, typeString), true)
                end
                if ChatAnnouncements.SV.Social.FriendIgnoreAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            -- Quest Shared
            elseif data.incomingType == INTERACT_TYPE_QUEST_SHARE then
                if ChatAnnouncements.SV.Quests.QuestShareCA then
                    printToChat(zo_strformat(message, typeString), true)
                end
                if ChatAnnouncements.SV.Quests.QuestShareAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            else
                ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
            end
        end
    end

    local function NotificationAccepted(data)
        if not data.dontRemoveOnAccept then
            data.pendingResponse = false
        end
        if data.acceptCallback then
            data.acceptCallback()
            if data.uniqueSounds then
                PlaySound(data.uniqueSounds.accept)
            else
                PlaySound(SOUNDS.DIALOG_ACCEPT)
            end
            DisplayNotificationMessage(GetString(SI_NOTIFICATION_ACCEPTED), data)
        end
    end

    local function NotificationDeclined(data)
        if not data.dontRemoveOnDecline then
            data.pendingResponse = false
        end
        if data.declineCallback then
            data.declineCallback()
            if data.uniqueSounds then
                PlaySound(data.uniqueSounds.decline)
            else
                PlaySound(SOUNDS.DIALOG_DECLINE)
            end
            DisplayNotificationMessage(GetString(SI_NOTIFICATION_DECLINED), data)
        end
    end

    PLAYER_TO_PLAYER.Accept = function(self, incomingEntry)
        local index = self:GetIndexFromIncomingQueue(incomingEntry)
        if index then
            if not incomingEntry.dontRemoveOnAccept then
                self:RemoveEntryFromIncomingQueueTable(index)
            end
            NotificationAccepted(incomingEntry)
        else
            self:OnPromptAccepted()
        end
    end

    PLAYER_TO_PLAYER.Decline = function(self, incomingEntry)
        local index = self:GetIndexFromIncomingQueue(incomingEntry)
        if index then
            if not incomingEntry.dontRemoveOnDecline then
                self:RemoveEntryFromIncomingQueueTable(index)
            end
            NotificationDeclined(incomingEntry)
        else
            self:OnPromptDeclined()
        end
    end

    --With proper timing, both of these events can fire in the same frame, making it possible to be responding but having already cleared the incoming queue
    PLAYER_TO_PLAYER.OnPromptAccepted = function(self)
        if self.showingResponsePrompt and #self.incomingQueue > 0 then
            local incomingEntryToRespondTo = self.incomingQueue[1]
            if not incomingEntryToRespondTo.dontRemoveOnAccept then
                self:RemoveEntryFromIncomingQueueTable(1)
            end
            NotificationAccepted(incomingEntryToRespondTo)
        end
    end

    PLAYER_TO_PLAYER.OnPromptDeclined = function(self)
        if self.showingResponsePrompt and #self.incomingQueue > 0 then
            local incomingEntryToRespondTo = self.incomingQueue[1]
            if not incomingEntryToRespondTo.dontRemoveOnDecline then
                self:RemoveEntryFromIncomingQueueTable(1)
            end
            NotificationDeclined(incomingEntryToRespondTo)
        end
    end

    ]]--

    -- Required when hooking ZO_MailSend_Gamepad:IsValid()
    -- Returns whether there is any item attached.
    local function IsAnyItemAttached(bagId, slotIndex)
        for i = 1, MAIL_MAX_ATTACHED_ITEMS do
            local queuedFromBag = GetQueuedItemAttachmentInfo(i)
            if queuedFromBag ~= 0 then -- Slot is filled.
                return true
            end
        end
        return false
    end

    -- Hook Gamepad mail name function
    ZO_MailSend_Gamepad.IsMailValid = function(self)
        local to = self.mailView:GetAddress()
        if (not to) or (to == "") then
            return false
        end

        local nameLink
        if string.match(to, "@") == "@" then
            if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(to, nil, DISPLAY_NAME_LINK_TYPE, to)
            else
                nameLink = ZO_LinkHandler_CreateLink(to, nil, DISPLAY_NAME_LINK_TYPE, to)
            end
        else
            if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(to, nil, CHARACTER_LINK_TYPE, to)
            else
                nameLink = ZO_LinkHandler_CreateLink(to, nil, CHARACTER_LINK_TYPE, to)
            end
        end
        g_mailTarget = ZO_SELECTED_TEXT:Colorize(nameLink)

        local subject = self.mailView:GetSubject()
        local hasSubject = subject and (subject ~= "")
        local body = self.mailView:GetBody()
        local hasBody = body and (body ~= "")
        return hasSubject or hasBody or (GetQueuedMoneyAttachment() > 0) or IsAnyItemAttached()
    end

    -- Hook MAIL_SEND.Send to get name of player we send to.
    MAIL_SEND.Send = function(self)
        windowManager:SetFocusByName("")
        if not self.sendMoneyMode and GetQueuedCOD() == 0 then
            if ChatAnnouncements.SV.Notify.NotificationMailCA then
                printToChat(GetString(SI_LUIE_CA_MAIL_ERROR_NO_COD_VALUE), true)
            end
            if ChatAnnouncements.SV.Notify.NotificationMailAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_CA_MAIL_ERROR_NO_COD_VALUE))
            end
            PlaySound(SOUNDS.NEGATIVE_CLICK)
        else
            SendMail(self.to:GetText(), self.subject:GetText(), self.body:GetText())

            local mailTarget = self.to:GetText()
            local nameLink
            -- Here we look for @ character in the sent mail, if the player send to an account then we want the link to be an account name link, otherwise, it's a character name link.
            if string.match(mailTarget, "@") == "@" then
                if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                    nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(mailTarget, nil, DISPLAY_NAME_LINK_TYPE, mailTarget)
                else
                    nameLink = ZO_LinkHandler_CreateLink(mailTarget, nil, DISPLAY_NAME_LINK_TYPE, mailTarget)
                end
            else
                if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                    nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(mailTarget, nil, CHARACTER_LINK_TYPE, mailTarget)
                else
                    nameLink = ZO_LinkHandler_CreateLink(mailTarget, nil, CHARACTER_LINK_TYPE, mailTarget)
                end
            end

            g_mailTarget = ZO_SELECTED_TEXT:Colorize(nameLink)
        end
    end

    PLAYER_INVENTORY.AddQuestItem = function(self, questItem, searchType)
        local inventory = self.inventories[INVENTORY_QUEST_ITEM]

        questItem.inventory = inventory
        --store all tools and items in a subtable under the questIndex for faster access
        local questIndex = questItem.questIndex
        if not inventory.slots[questIndex] then
            inventory.slots[questIndex] = {}
        end
        table.insert(inventory.slots[questIndex], questItem)

        local index = #inventory.slots[questIndex]

        if(searchType == SEARCH_TYPE_QUEST_ITEM) then
            questItem.searchData = {type = SEARCH_TYPE_QUEST_ITEM, questIndex = questIndex, stepIndex = questItem.stepIndex, conditionIndex = questItem.conditionIndex, index = index }
        else
            questItem.searchData = {type = SEARCH_TYPE_QUEST_TOOL, questIndex = questIndex, toolIndex = questItem.toolIndex, index = index }
        end

        inventory.stringSearch:Insert(questItem.searchData)
        -- Display Item if set to display
        if ChatAnnouncements.SV.Inventory.LootQuestAdd or ChatAnnouncements.SV.Inventory.LootQuestRemove then
            DisplayQuestItem(questItem.questItemId, questItem.stackCount, questItem.iconFile, false)
        end
    end

    PLAYER_INVENTORY.ResetQuest = function(self, questIndex)
        local inventory = self.inventories[INVENTORY_QUEST_ITEM]
        local itemTable = inventory.slots[questIndex]
        if itemTable then
            --remove all quest items from search
            for i = 1, #itemTable do
                inventory.stringSearch:Remove(itemTable.searchData)
                -- Display Item if set to display
                if ChatAnnouncements.SV.Inventory.LootQuestAdd or ChatAnnouncements.SV.Inventory.LootQuestRemove then
                    local itemId = itemTable[i].questItemId
                    local stackCount = itemTable[i].stackCount
                    local icon = itemTable[i].iconFile
                    DisplayQuestItem(itemId, stackCount, icon, true)
                end
            end
        end

        inventory.slots[questIndex] = nil
    end

    -- Called by hooked TryGroupInviteByName function
    local function CompleteGroupInvite(characterOrDisplayName, sentFromChat, displayInvitedMessage, isMenu)
        local isLeader = IsUnitGroupLeader("player")
        local groupSize = GetGroupSize()

        if isLeader and groupSize == SMALL_GROUP_SIZE_THRESHOLD then
            ZO_Dialogs_ShowPlatformDialog("LARGE_GROUP_INVITE_WARNING", characterOrDisplayName, { mainTextParams = { SMALL_GROUP_SIZE_THRESHOLD } })
        else
            GroupInviteByName(characterOrDisplayName)

            ZO_Menu_SetLastCommandWasFromMenu(not sentFromChat)
            if isMenu then
                local link
                if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
                    link = ZO_LinkHandler_CreateLinkWithoutBrackets(characterOrDisplayName, nil, CHARACTER_LINK_TYPE, characterOrDisplayName)
                else
                    link = ZO_LinkHandler_CreateLink(characterOrDisplayName, nil, CHARACTER_LINK_TYPE, characterOrDisplayName)
                end
                printToChat(zo_strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MENU), link), true)
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_Alert(ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MENU), ZO_FormatUserFacingCharacterOrDisplayName(characterOrDisplayName)))
                end
            else
                printToChat(zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_INVITED), ZO_FormatUserFacingCharacterOrDisplayName(characterOrDisplayName)), true)
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_Alert(ALERT, nil, zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_INVITED), ZO_FormatUserFacingCharacterOrDisplayName(characterOrDisplayName)))
                end
            end
        end
    end

    -- HOOK Group Invite function so we can modify CA/Alert here
    TryGroupInviteByName = function(characterOrDisplayName, sentFromChat, displayInvitedMessage, isMenu)
        if IsPlayerInGroup(characterOrDisplayName) then
            printToChat(GetString(SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER), true)
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER)
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            return
        end

        local isLeader = IsUnitGroupLeader("player")
        local groupSize = GetGroupSize()

        if not isLeader and groupSize > 0 then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE))
            return
        end

        if IsConsoleUI() then
            local displayName = characterOrDisplayName

            local function GroupInviteCallback(success)
                if success then
                    CompleteGroupInvite(displayName, sentFromChat, displayInvitedMessage, isMenu)
                end
            end

            ZO_ConsoleAttemptInteractOrError(GroupInviteCallback, displayName, ZO_PLAYER_CONSOLE_INFO_REQUEST_DONT_BLOCK, ZO_CONSOLE_CAN_COMMUNICATE_ERROR_ALERT, ZO_ID_REQUEST_TYPE_DISPLAY_NAME, displayName)
        else
            if IsIgnored(characterOrDisplayName) then
                printToChat(GetString(SI_LUIE_IGNORE_ERROR_GROUP), true)
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, SI_LUIE_IGNORE_ERROR_GROUP)
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end

            CompleteGroupInvite(characterOrDisplayName, sentFromChat, displayInvitedMessage, isMenu)
        end
    end

    -- Hook for EVENT_GUILD_MEMBER_ADDED
    GUILD_ROSTER_MANAGER.OnGuildMemberAdded = function(self, guildId, displayName)
        self:RefreshData()

        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end

        local guildName = GetGuildName(guildId)

        local guilds = GetNumGuilds()
        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            if guildName == name then
                local guildRoster = ZO_GuildRosterManager:New()
                guildRoster:SetGuildId(id)
                local playerData = guildRoster:FindDataByDisplayName(displayName)

                if playerData ~= nil and playerData.inviteeIndex == nil then
                    local guildAlliance = GetGuildAlliance(id)
                    local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
                    local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
                    local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

                    if ChatAnnouncements.SV.Social.GuildCA then
                        printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_ADDED), displayNameLink, guildNameAlliance), true)
                    end
                    if ChatAnnouncements.SV.Social.GuildAlert then
                        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_ADDED), displayName, guildNameAllianceAlert))
                    end
                    PlaySound(SOUNDS.GUILD_ROSTER_ADDED)
                    break
                end
            end
        end
    end

    -- Hook for EVENT_GUILD_MEMBER_REMOVED
    GUILD_ROSTER_MANAGER.OnGuildMemberRemoved = function(self, guildId, rawCharacterName, displayName)
        local displayNameLink
        if ChatAnnouncements.SV.BracketOptionCharacter == 1 then
            displayNameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            displayNameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end

        local guildName = GetGuildName(guildId)

        local guilds = GetNumGuilds()
        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            if guildName == name then
                local guildAlliance = GetGuildAlliance(id)
                local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
                local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
                local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

                if ChatAnnouncements.SV.Social.GuildCA then
                    printToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_LEFT), displayNameLink, guildNameAlliance), true)
                end
                if ChatAnnouncements.SV.Social.GuildAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_LEFT), displayName, guildNameAllianceAlert))
                end
                PlaySound(SOUNDS.GUILD_ROSTER_REMOVED)
                break
            end
        end
        self:RefreshData()
    end

    -- Hook for Guild Invite function used from Guild Menu
    ZO_TryGuildInvite = function(guildId, displayName, sentFromChat)
        -- TODO: Update when more alerts are added to CA
        if not DoesPlayerHaveGuildPermission(guildId, GUILD_PERMISSION_INVITE) then
            ZO_AlertEvent(EVENT_SOCIAL_ERROR, SOCIAL_RESULT_NO_INVITE_PERMISSION)
            return
        end

        -- TODO: Update when more alerts are added to CA
        if GetNumGuildMembers(guildId) == MAX_GUILD_MEMBERS then
            ZO_AlertEvent(EVENT_SOCIAL_ERROR, SOCIAL_RESULT_NO_ROOM)
            return
        end

        local guildName = GetGuildName(guildId)
        local guildAlliance = GetGuildAlliance(guildId)
        local guildColor = ChatAnnouncements.SV.Social.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
        local guildNameAlliance = ChatAnnouncements.SV.Social.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
        local guildNameAllianceAlert = ChatAnnouncements.SV.Social.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

        if IsConsoleUI() then
            local function GuildInviteCallback(success)
                if success then
                    GuildInvite(guildId, displayName)
                    if ChatAnnouncements.SV.Social.GuildCA then
                        printToChat(zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, UndecorateDisplayName(displayName), guildNameAlliance), true)
                    end
                    if ChatAnnouncements.SV.Social.GuildAlert then
                        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, UndecorateDisplayName(displayName), guildNameAllianceAlert))
                    end
                end
            end

            ZO_ConsoleAttemptInteractOrError(GuildInviteCallback, displayName, ZO_PLAYER_CONSOLE_INFO_REQUEST_DONT_BLOCK, ZO_CONSOLE_CAN_COMMUNICATE_ERROR_ALERT, ZO_ID_REQUEST_TYPE_DISPLAY_NAME, displayName)
        else
            -- We can't stop the player from inviting players to guild by Character Name if sent from chat so, might as well not block it. This also makes it consistent with group invites. Can't invite from the radial menu but can use the slash command.
            if IsIgnored(displayName) and not sentFromChat then
                if ChatAnnouncements.SV.Social.GuildCA then
                    printToChat(GetString(SI_LUIE_IGNORE_ERROR_GUILD), true)
                end
                if ChatAnnouncements.SV.Social.GuildAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_IGNORE_ERROR_GUILD))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end

            GuildInvite(guildId, displayName)
            if ChatAnnouncements.SV.Social.GuildCA then
                printToChat(zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, displayName, guildNameAlliance), true)
            end
            if ChatAnnouncements.SV.Social.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, displayName, guildNameAllianceAlert))
            end
        end
    end

    -- Called when changing guilds in the Guild tab
    GUILD_SHARED_INFO.SetGuildId = function(self, guildId)
        self.guildId = guildId
        self:Refresh(guildId)
        -- Set selected guild for use when resolving Rank/Heraldry updates
        g_selectedGuild = guildId
    end

    -- Called when changing guilds in the Guild tab or leaving/joining a guild
    GUILD_SHARED_INFO.Refresh = function(self, guildId)
        if(self.guildId and self.guildId == guildId) then
            local count = GetControl(self.control, "Count")
            local numGuildMembers, numOnline = GetGuildInfo(guildId)

            count:SetText(zo_strformat(SI_GUILD_NUM_MEMBERS_ONLINE_FORMAT, numOnline, numGuildMembers))

            self.canDepositToBank = DoesGuildHavePrivilege(guildId, GUILD_PRIVILEGE_BANK_DEPOSIT)
            if(self.canDepositToBank) then
                self.bankIcon:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
            else
                self.bankIcon:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
            end

            self.canUseTradingHouse = DoesGuildHavePrivilege(guildId, GUILD_PRIVILEGE_TRADING_HOUSE)
            if(self.canUseTradingHouse) then
                self.tradingHouseIcon:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
            else
                self.tradingHouseIcon:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
            end

            self.canUseHeraldry = DoesGuildHavePrivilege(guildId, GUILD_PRIVILEGE_HERALDRY)
            if(self.canUseHeraldry) then
                self.heraldryIcon:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
            else
                self.heraldryIcon:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
            end
        end
        -- Set selected guild for use when resolving Rank/Heraldry updates
        g_selectedGuild = guildId
    end

    -- Used to pull the cost of guild Heraldry change
    ZO_GuildHeraldryManager_Shared.AttemptSaveAndExit = function(self, showBaseScene)
        local blocked = false

        if HasPendingHeraldryChanges() then
            self:SetPendingExit(true)
            if not IsCreatingHeraldryForFirstTime() then
                local pendingCost = GetPendingHeraldryCost()
                -- Pull Heraldry Cost to currency function to use
                g_pendingHeraldryCost = pendingCost
                local heraldryFunds = GetHeraldryGuildBankedMoney()
                if heraldryFunds and pendingCost <= heraldryFunds then
                    self:ConfirmHeraldryApplyChanges()
                    blocked = true
                end
            end
        end

        if not blocked then
            self:ConfirmExit(showBaseScene)
        end
    end
end

function ChatAnnouncements.TradeInviteAccepted(eventCode)
    if ChatAnnouncements.SV.Notify.NotificationTradeCA then
        printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_ACCEPTED), true)
    end
    if ChatAnnouncements.SV.Notify.NotificationTradeAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_TRADE_INVITE_ACCEPTED))
    end

    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if ChatAnnouncements.SV.Inventory.LootTrade then
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ChatAnnouncements.InventoryUpdate)
        g_inventoryStacks = {}
        ChatAnnouncements.IndexInventory() -- Index Inventory
    end
    g_inTrade = true
end

-- Adds items to index if they are added in a trade
function ChatAnnouncements.OnTradeAdded(eventCode, who, tradeIndex, itemSoundCategory)
    local index = tradeIndex
    local name, icon, stack = GetTradeItemInfo(who, tradeIndex)
    local bagId, slotId = GetTradeItemBagAndSlot(who, tradeIndex)
    local itemId = GetItemId(bagId, slotId)
    local itemLink = GetTradeItemLink(who, tradeIndex, linkBrackets[ChatAnnouncements.SV.BracketOptionItem])
    local itemType = GetItemLinkItemType(itemLink)

    if who == 0 then
        g_tradeStacksOut[index] = {icon = icon, stack = stack, itemId = itemId, itemLink = itemLink, itemType = itemType}
    else
        g_tradeStacksIn[index] = {icon = icon, stack = stack, itemId = itemId, itemLink = itemLink, itemType = itemType}
    end
end

-- Removes items from index if they are removed from the trade
function ChatAnnouncements.OnTradeRemoved(eventCode, who, tradeIndex, itemSoundCategory)
    local indexOut = tradeIndex
    if who == 0 then
        g_tradeStacksOut[indexOut] = nil
    else
        g_tradeStacksIn[indexOut] = nil
    end
end

-- Called on player joining a group to determine if message syntax should show group or LFG group.
function ChatAnnouncements.CheckLFGStatusJoin()
    if not g_stopGroupLeaveQueue then
        if not g_lfgDisableGroupEvents then
            if IsInLFGGroup() and not g_joinLFGOverride then
                if ChatAnnouncements.SV.Group.GroupCA then
                    printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF_LFG), true)
                end
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF_LFG))
                end
            elseif not IsInLFGGroup() and not g_joinLFGOverride then
                if ChatAnnouncements.SV.Group.GroupCA then
                    printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF), true)
                end
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
                end
            end
        end
        g_joinLFGOverride = false
    end
end

-- Called when another player joins the group.
function ChatAnnouncements.PrintJoinStatusNotSelf(SendMessage, SendAlert)
    if not g_stopGroupLeaveQueue then
        if ChatAnnouncements.SV.Group.GroupCA then
            printToChat(SendMessage, true)
        end
        if ChatAnnouncements.SV.Group.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, SendAlert)
        end
    end
end

-- Called on player leaving a group to determine if message syntax should show group or LFG group.
function ChatAnnouncements.CheckLFGStatusLeave(WasKicked)
    if not (g_stopGroupLeaveQueue and g_lfgDisableGroupEvents) then
        if not g_leaveLFGOverride then
            if WasKicked then
                if ChatAnnouncements.SV.Group.GroupCA then
                    printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_SELF), true)
                end
                if ChatAnnouncements.SV.Group.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_SELF))
                end
            end
        elseif g_leaveLFGOverride and GetGroupSize() == 0 then
            if ChatAnnouncements.SV.Group.GroupCA then
                printToChat(GetString(SI_LUIE_CA_GROUP_QUIT_LFG), true)
            end
            if ChatAnnouncements.SV.Group.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_QUIT_LFG))
            end
        end
    end
    g_leaveLFGOverride = false
end

-- EVENT_GROUP_INVITE_REMOVED
function ChatAnnouncements.GroupInviteRemoved(eventCode)
    g_groupJoinFudger = true
end

-- EVENT_GROUP_INVITE_RECEIVED
function ChatAnnouncements.OnGroupInviteReceived(eventCode, inviterName, inviterDisplayName)
    g_groupJoinFudger = false

    if ChatAnnouncements.SV.Group.GroupCA then
        local finalName = ChatAnnouncements.ResolveNameLink(inviterName, inviterDisplayName)
        local message = zo_strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), finalName)
        printToChat(message, true)
    end
    if ChatAnnouncements.SV.Group.GroupAlert then
        local finalAlertName = ChatAnnouncements.ResolveNameNoLink(inviterName, inviterDisplayName)
        local alertText = zo_strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), finalAlertName)
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
    end
end

function ChatAnnouncements.IndexGroupLoot()
    local groupSize = GetGroupSize()
    for i=1, groupSize do
        local characterName = GetUnitName('group'..i)
        local displayName = GetUnitDisplayName('group'..i)
        g_groupLootIndex[characterName] = { characterName = characterName, displayName = displayName }
    end
end

-- EVENT_GROUP_MEMBER_JOINED
function ChatAnnouncements.OnGroupMemberJoined(eventCode, memberName)
    -- Update index for Group Loot
    ChatAnnouncements.IndexGroupLoot()

    g_groupJoinFudger = false
    local g_partyStack = { }
    local joinedMemberName = ""
    local joinedMemberAccountName = ""

    -- Iterate through group member indices to get the relevant UnitTags
    for i = 1,40 do
        local memberTag = GetGroupUnitTagByIndex(i)
        if memberTag == nil then
            break -- Once we reach a nil value (aka no party member there, stop the loop)
        end
        g_partyStack[i] = { memberTag = memberTag }
    end

    -- Iterate through UnitTags to get the member who just joined
    for i = 1, #g_partyStack do
        local unitname = GetRawUnitName(g_partyStack[i].memberTag)
        if unitname == memberName then
            joinedMemberName = GetUnitName(g_partyStack[i].memberTag)
            joinedMemberAccountName = GetUnitDisplayName(g_partyStack[i].memberTag)
            break -- Break loop once we get the value we need
        end
    end

    if joinedMemberName ~= "" and joinedMemberName ~= nil then
        if LUIE.PlayerNameRaw ~= memberName then
            -- Can occur if event is before EVENT_PLAYER_ACTIVATED
            local finalName = ChatAnnouncements.ResolveNameLink(joinedMemberName, joinedMemberAccountName)
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(joinedMemberName, joinedMemberAccountName)
            local SendMessage = (zo_strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN), finalName))
            local SendAlert = (zo_strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN), finalAlertName))
            zo_callLater(function() ChatAnnouncements.PrintJoinStatusNotSelf(SendMessage, SendAlert) end, 100)
        elseif LUIE.PlayerNameRaw == memberName then
            zo_callLater(ChatAnnouncements.CheckLFGStatusJoin, 100)
        end
    end

    g_partyStack = { }
end

-- EVENT_GROUP_TYPE_CHANGED
function ChatAnnouncements.OnGroupTypeChanged(eventCode, largeGroup)
    local message
    if largeGroup then
        message = GetString(SI_CHAT_ANNOUNCEMENT_IN_LARGE_GROUP)
    else
        message = GetString(SI_CHAT_ANNOUNCEMENT_IN_SMALL_GROUP)
    end

    if ChatAnnouncements.SV.Group.GroupCA then
        printToChat(message, true)
    end
    if ChatAnnouncements.SV.Group.GroupAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
    end
end

-- EVENT_GROUP_ELECTION_NOTIFICATION_ADDED
function ChatAnnouncements.VoteNotify(eventCode)
    local electionType, timeRemainingSeconds, electionDescriptor, targetUnitTag = GetGroupElectionInfo()
    if electionType == 2 then -- Ready Check
        if ChatAnnouncements.SV.Group.GroupVoteCA then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_MESSAGE), true)
        end
        if ChatAnnouncements.SV.Group.GroupVoteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_GROUP_ELECTION_READY_CHECK_MESSAGE))
        end
    end

    if electionType == 3 then -- Vote Kick
        local kickMemberName = GetUnitName(targetUnitTag)
        local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)

        if ChatAnnouncements.SV.Group.GroupVoteCA then
            local finalName = ChatAnnouncements.ResolveNameLink(kickMemberName, kickMemberAccountName)
            local message = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), finalName)
            printToChat(message, true)
        end
        if ChatAnnouncements.SV.Group.GroupVoteAlert then
            local finalAlertName = ChatAnnouncements.ResolveNameNoLink(kickMemberName, kickMemberAccountName)
            local alertText = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), finalAlertName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
        end
    end
end

-- EVENT_GROUPING_TOOLS_NO_LONGER_LFG
function ChatAnnouncements.LFGLeft(eventCode)
    g_leaveLFGOverride = true
end

-- EVENT_PLEDGE_OF_MARA_OFFER - EVENT HANDLER
function ChatAnnouncements.MaraOffer(eventCode, characterName, isSender, displayName)
    -- Display CA
    if ChatAnnouncements.SV.Social.PledgeOfMaraCA then
        local finalName = ChatAnnouncements.ResolveNameLink(characterName, displayName)
        if isSender then
            printToChat(zo_strformat(GetString(SI_PLEDGE_OF_MARA_SENDER_MESSAGE), finalName), true)
        else
            printToChat(zo_strformat(GetString(SI_PLEDGE_OF_MARA_MESSAGE), finalName), true)
        end
    end

    -- Display Alert
    if ChatAnnouncements.SV.Social.PledgeOfMaraAlert then
        local finalAlertName = ChatAnnouncements.ResolveNameNoLink(characterName, displayName)
        local alertString
        if isSender then
            alertString = zo_strformat(GetString(SI_PLEDGE_OF_MARA_SENDER_MESSAGE), finalAlertName)
        else
            alertString = zo_strformat(GetString(SI_PLEDGE_OF_MARA_MESSAGE), finalAlertName)
        end
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
    end
end

-- EVENT_DUEL_STARTED -- EVENT HANDLER
function ChatAnnouncements.DuelStarted(eventCode)
    -- Display CA
    if ChatAnnouncements.SV.Social.DuelStartCA or ChatAnnouncements.SV.Social.DuelStartAlert then
        local message
        local formattedIcon = zo_iconFormat("EsoUI/Art/HUD/HUD_Countdown_Badge_Dueling.dds", 16, 16)
        if ChatAnnouncements.SV.Social.DuelStartOptions == 1 then
            message = zo_strformat(GetString(SI_LUIE_CA_DUEL_STARTED_WITH_ICON), formattedIcon)
        elseif ChatAnnouncements.SV.Social.DuelStartOptions == 2 then
            message = GetString(SI_LUIE_CA_DUEL_STARTED)
        elseif ChatAnnouncements.SV.Social.DuelStartOptions == 3 then
            message = zo_strformat("<<1>>", formattedIcon)
        end

        if ChatAnnouncements.SV.Social.DuelStartCA then
            printToChat(message, true)
        end

        if ChatAnnouncements.SV.Social.DuelStartAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
    end

    -- Play sound if CSA is not enabled
    if not ChatAnnouncements.SV.Social.DuelStartCSA then
        PlaySound(SOUNDS.DUEL_START)
    end
end

function ChatAnnouncements.SkillXPUpdate(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXP)
    if (skillType == SKILL_TYPE_GUILD) then
        local lineName, _, _, lineId = GetSkillLineInfo(skillType, skillIndex)
        formattedName = zo_strformat(SI_UNIT_NAME, lineName)

        -- Bail out early if a certain type is not set to be displayed
        if lineId == 45 and not ChatAnnouncements.SV.Skills.SkillGuildFighters then
            return
        elseif lineId == 44 and not ChatAnnouncements.SV.Skills.SkillGuildMages then
           return
        elseif lineId == 55 and not ChatAnnouncements.SV.Skills.SkillGuildUndaunted then
           return
        elseif lineId == 117 and not ChatAnnouncements.SV.Skills.SkillGuildThieves then
           return
        elseif lineId == 118 and not ChatAnnouncements.SV.Skills.SkillGuildDarkBrotherhood then
           return
        elseif lineId == 130 and not ChatAnnouncements.SV.Skills.SkillGuildPsijicOrder then
            return
        end

        local change = currentXP - previousXP
        local priority

        if ChatAnnouncements.SV.Skills.SkillGuildAlert then
            local text = zo_strformat(GetString(SI_LUIE_CA_SKILL_GUILD_ALERT), formattedName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end

        -- Bail out or save value if Throttle/Threshold conditions are met
        if lineId == 45 then
            priority = "EXPERIENCE LEVEL"
            -- FG rep is either a quest reward (10) or kills (1 & 5)
            -- Only throttle values 5 or lower (FG Dailies give +10 skill)
            if ChatAnnouncements.SV.Skills.SkillGuildThrottle > 0 and change <= 5 then
                g_guildSkillThrottle = g_guildSkillThrottle + change
                g_guildSkillThrottleLine = formattedName
                eventManager:UnregisterForUpdate(moduleName .. "BufferedRep")
                eventManager:RegisterForUpdate(moduleName .. "BufferedRep", ChatAnnouncements.SV.Skills.SkillGuildThrottle, ChatAnnouncements.PrintBufferedGuildRep )
                return
            end

            -- If throttle wasn't triggered and the value was below threshold then bail out.
            if change <= ChatAnnouncements.SV.Skills.SkillGuildThreshold then
                return
            end
        end

        if lineId == 44 then
            -- Mages Guild rep is either a quest reward (10), book discovered (5), collection discovered (20)
            if change == 10 then
                priority = "EXPERIENCE LEVEL"
            else
                priority = "MESSAGE"
            end
        end

        if lineId == 55 or lineId == 117 or lineId == 118 or lineId == 130 then
            -- Other guilds are usually either a quest reward or achievement reward
            priority = "EXPERIENCE LEVEL"
        end
        ChatAnnouncements.PrintGuildRep(change, formattedName, lineId, priority)
    end
end

function ChatAnnouncements.PrintGuildRep(change, lineName, lineId, priority)
    -- TODO: Move this (not sure where to since putting it in the base function makes it populate before colors are defined)
    local GUILD_SKILL_COLOR_TABLE = {
        [45] = SkillGuildColorizeFG,
        [44] = SkillGuildColorizeMG,
        [55] = SkillGuildColorizeUD,
        [117] = SkillGuildColorizeTG,
        [118] = SkillGuildColorizeDB,
        [130] = SkillGuildColorizePO,
    }

    local icon = zo_iconFormatInheritColor(GUILD_SKILL_ICONS[lineId], 16, 16)
    local formattedIcon = ChatAnnouncements.SV.Skills.SkillGuildIcon and (icon .. " ") or ""

    local guildString = zo_strformat(ChatAnnouncements.SV.Skills.SkillGuildRepName, change)
    local colorize = GUILD_SKILL_COLOR_TABLE[lineId]
    local messageP1 = ("|r|c" .. colorize .. formattedIcon .. change .. " " .. lineName .. " " .. guildString .. "|r|c" .. SkillGuildColorize)
    local formattedMessageP1 = (string.format(ChatAnnouncements.SV.Skills.SkillGuildMsg, messageP1))
    local finalMessage = string.format("|c%s%s|r", SkillGuildColorize, formattedMessageP1)

    -- We set this to skill gain, so as to avoid creating an entire additional chat message category (we want it to show after XP but before any other skill gains or level up so we place it on top of the level up priority).
    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = priority }
    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
    eventManager:RegisterForUpdate(moduleName .. "Printer", 50, ChatAnnouncements.PrintQueuedMessages )
end

function ChatAnnouncements.PrintBufferedGuildRep()
    if (g_guildSkillThrottle > 0 and g_guildSkillThrottle > ChatAnnouncements.SV.Skills.SkillGuildThreshold) then
        local lineId = 45
        local lineName = g_guildSkillThrottleLine
        ChatAnnouncements.PrintGuildRep(g_guildSkillThrottle, lineName, lineId, "EXPERIENCE LEVEL")
    end
    eventManager:UnregisterForUpdate(moduleName .. "BufferedRep")
    g_guildSkillThrottle = 0
    g_guildSkillThrottleLine = ""
end

function ChatAnnouncements.PrintQueuedMessages()
    -- Resolve notification messages first
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "NOTIFICATION" then
            local isSystem
            if g_queuedMessages[i].isSystem then
                isSystem = true
            else
                isSystem = false
            end
            printToChat(g_queuedMessages[i].message, isSystem)
        end
    end

    -- Resolve quest POI added
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "QUEST_POI" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Next display Quest/Objective Completion and Experience
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "QUEST" or g_queuedMessages[i].type == "EXPERIENCE" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Level Up Notifications
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "EXPERIENCE LEVEL" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Skill Gain
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "SKILL GAIN" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Skill Morph
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "SKILL MORPH" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Skill Line
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "SKILL LINE" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Skill
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "SKILL" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Postage
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "CURRENCY POSTAGE" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Quest Items (Remove)
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "QUEST LOOT REMOVE" then
            --if LUIE.PlayerDisplayName == "@ArtOfShred" or LUIE.PlayerDisplayName == "@ArtOfShredLegacy" then d(g_queuedMessages[i].itemId) end -- TODO: Remove debug later
            local itemId = g_queuedMessages[i].itemId
            --if LUIE.PlayerDisplayName == "@ArtOfShred" or LUIE.PlayerDisplayName == "@ArtOfShredLegacy" then d(g_questItemAdded[itemId]) end -- TODO: Remove debug later
            if not g_questItemAdded[itemId] == true then
                printToChat(g_queuedMessages[i].message)
            end
        end
    end

    -- Currency
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "CURRENCY" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Quest Items (ADD)
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "QUEST LOOT ADD" then
            --if LUIE.PlayerDisplayName == "@ArtOfShred" or LUIE.PlayerDisplayName == "@ArtOfShredLegacy" then d(g_queuedMessages[i].itemId) end -- TODO: Remove debug later
            local itemId = g_queuedMessages[i].itemId
            --if LUIE.PlayerDisplayName == "@ArtOfShred" or LUIE.PlayerDisplayName == "@ArtOfShredLegacy" then d(g_questItemRemoved[itemId]) end -- TODO: Remove debug later
            if not g_questItemRemoved[itemId] == true then
                printToChat(g_queuedMessages[i].message)
            end
        end
    end

    -- Loot
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "LOOT" then
            ChatAnnouncements.ResolveItemMessage(g_queuedMessages[i].message, g_queuedMessages[i].formattedRecipient, g_queuedMessages[i].color, g_queuedMessages[i].logPrefix, g_queuedMessages[i].totalString, g_queuedMessages[i].groupLoot )
        end
    end

    -- Collectible
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "COLLECTIBLE" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Resolve achievement update messages second to last
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "ACHIEVEMENT" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Display the rest
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i].type == "MESSAGE" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Clear Messages and Unregister Print Event
    g_queuedMessages = { }
    g_queuedMessagesCounter = 1
    eventManager:UnregisterForUpdate(moduleName .. "Printer")
end

function ChatAnnouncements.CollectibleUsed(eventCode, result, isAttemptingActivation)
    if result ~= COLLECTIBLE_USAGE_BLOCK_REASON_NOT_BLOCKED then return end
    local latency = GetLatency()
    latency = latency + 100
    zo_callLater(ChatAnnouncements.CollectibleResult, latency)
end

function ChatAnnouncements.CollectibleResult()

    -- Check if this variable has a value > 0.
    if LUIE.LastMementoUsed ~= 0 then
        local link = GetCollectibleLink(LUIE.LastMementoUsed, linkBrackets[ChatAnnouncements.SV.BracketOptionCollectibleUse])
        local name = GetCollectibleName(LUIE.LastMementoUsed)
        local icon = GetCollectibleIcon(LUIE.LastMementoUsed)
        local formattedIcon = ChatAnnouncements.SV.Collectibles.CollectibleUseIcon and ("|t16:16:" .. icon .. "|t ") or ""
        local string =
            LUIE.LastMementoUsed == 5886 and GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_CAKE) or
            LUIE.LastMementoUsed == 1167 and GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_PIE) or
            LUIE.LastMementoUsed == 1168 and GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_MEAD) or
            LUIE.LastMementoUsed == 479 and GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_WITCH)

        local message = zo_strformat(string, link, formattedIcon)
        local alert = zo_strformat(string, name, "")

        if message and ChatAnnouncements.SV.Collectibles.CollectibleUseCA or LUIE.LastMementoUsed > 0 then
            message = CollectibleUseColorize:Colorize(message)
            printToChat(message)
        end
        if alert and ChatAnnouncements.SV.Collectibles.CollectibleUseAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alert)
        end

        LUIE.LastMementoUsed = 0
    end

	local newAssistant = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT)
	local newVanity = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
    local newSpecial = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN)
    local newHat = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HAT)
    local newHair = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HAIR)
    local newHeadMark = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HEAD_MARKING)
    local newFacialHair = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_FACIAL_HAIR_HORNS)
    local newMajorAdorn = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_FACIAL_ACCESSORY)
    local newMinorAdorn = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_PIERCING_JEWELRY)
    local newCostume = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME)
    local newBodyMarking = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_BODY_MARKING)
    local newSkin = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_SKIN)
    local newPersonality = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_PERSONALITY)
    local newPolymorph = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH)


	if newAssistant ~= currentAssistant then
		if newAssistant == 0 then
			lastCollectibleUsed = currentAssistant
		else
			lastCollectibleUsed = newAssistant
		end
	end
	if newVanity ~= currentVanity then
		if newVanity == 0 then
			lastCollectibleUsed = currentVanity
		else
			lastCollectibleUsed = newVanity
		end
	end
    if newSpecial ~= currentSpecial then
        if newSpecial == 0 then
            lastCollectibleUsed = currentSpecial
        else
            lastCollectibleUsed = newSpecial
        end
    end
    if newHat ~= currentHat then
        if newHat == 0 then
            lastCollectibleUsed = currentHat
        else
            lastCollectibleUsed = newHat
        end
    end
    if newHair ~= currentHair then
        if newHair == 0 then
            lastCollectibleUsed = currentHair
        else
            lastCollectibleUsed = newHair
        end
    end
    if newHeadMark ~= currentHeadMark then
        if newHeadMark == 0 then
            lastCollectibleUsed = currentHeadMark
        else
            lastCollectibleUsed = newHeadMark
        end
    end
    if newFacialHair ~= currentFacialHair then
        if newFacialHair == 0 then
            lastCollectibleUsed = currentFacialHair
        else
            lastCollectibleUsed = newFacialHair
        end
    end
    if newMajorAdorn ~= currentMajorAdorn then
        if newMajorAdorn == 0 then
            lastCollectibleUsed = currentMajorAdorn
        else
            lastCollectibleUsed = newMajorAdorn
        end
    end
    if newMinorAdorn ~= currentMinorAdorn then
        if newMinorAdorn == 0 then
            lastCollectibleUsed = currentMinorAdorn
        else
            lastCollectibleUsed = newMinorAdorn
        end
    end
    if newCostume ~= currentCostume then
        if newCostume == 0 then
            lastCollectibleUsed = currentCostume
        else
            lastCollectibleUsed = newCostume
        end
    end
    if newBodyMarking ~= currentBodyMarking then
        if newBodyMarking == 0 then
            lastCollectibleUsed = currentBodyMarking
        else
            lastCollectibleUsed = newBodyMarking
        end
    end
    if newSkin ~= currentSkin then
        if newSkin == 0 then
            lastCollectibleUsed = currentSkin
        else
            lastCollectibleUsed = newSkin
        end
    end
    if newPersonality ~= currentPersonality then
        if newPersonality == 0 then
            lastCollectibleUsed = currentPersonality
        else
            lastCollectibleUsed = newPersonality
        end
    end
    if newPolymorph ~= currentPolymorph then
        if newPolymorph == 0 then
            lastCollectibleUsed = currentPolymorph
        else
            lastCollectibleUsed = newPolymorph
        end
    end

	currentAssistant = newAssistant
	currentVanity = newVanity
	currentSpecial = newSpecial
	currentHat = newHat
	currentHair = newHair
	currentHeadMark = newHeadMark
	currentFacialHair = newFacialHair
	currentMajorAdorn = newMajorAdorn
	currentMinorAdorn = newMinorAdorn
	currentCostume = newCostume
	currentBodyMarking = newBodyMarking
	currentSkin = newSkin
	currentPersonality = newPersonality
	currentPolymorph = newPolymorph

    -- If neither menu option is enabled, then bail out here
    if not (ChatAnnouncements.SV.Collectibles.CollectibleUseCA or ChatAnnouncements.SV.Collectibles.CollectibleUseAlert) then
        if not LUIE.SlashCollectibleOverride then
            lastCollectibleUsed = 0
            return
        end
    end

	if lastCollectibleUsed == 0 then
        LUIE.SlashCollectibleOverride = false
        return
    end
	local collectibleType = GetCollectibleCategoryType(lastCollectibleUsed)

    local message
    local alert
    local link = GetCollectibleLink(lastCollectibleUsed, linkBrackets[ChatAnnouncements.SV.BracketOptionCollectibleUse])
    local name = GetCollectibleName(lastCollectibleUsed)
    local nickname = GetCollectibleNickname(lastCollectibleUsed)
    local icon = GetCollectibleIcon(lastCollectibleUsed)
    local formattedIcon = ChatAnnouncements.SV.Collectibles.CollectibleUseIcon and ("|t16:16:" .. icon .. "|t ") or ""

    -- Vanity
    if collectibleType == COLLECTIBLE_CATEGORY_TYPE_VANITY_PET and (ChatAnnouncements.SV.Collectibles.CollectibleUseCategory10 or LUIE.SlashCollectibleOverride) then
        if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0 then
            if ChatAnnouncements.SV.Collectibles.CollectibleUsePetNickname and nickname then
                message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_SUMMON_NN), link, nickname, formattedIcon)
                alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_SUMMON_NN), name, nickname, "")
            else
                message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_SUMMON), link, formattedIcon)
                alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_SUMMON), name, "")
            end
        else
            if ChatAnnouncements.SV.Collectibles.CollectibleUsePetNickname and nickname then
                message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_UNSUMMON_NN), link, nickname, formattedIcon)
                alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_UNSUMMON_NN), name, nickname, "")
            else
                message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_UNSUMMON), link, formattedIcon)
                alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_UNSUMMON), name, "")
            end
        end
    end

    -- Assistants
    if collectibleType == COLLECTIBLE_CATEGORY_TYPE_ASSISTANT and (ChatAnnouncements.SV.Collectibles.CollectibleUseCategory7 or LUIE.SlashCollectibleOverride) then
        if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0 then
            message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_SUMMON), link, formattedIcon)
            alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_SUMMON), name, "")
        else
            message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_UNSUMMON), link, formattedIcon)
            alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_UNSUMMON), name, "")
        end
    end

    -- Special / Appearance
    if collectibleType == COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_HAT
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_HAIR
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_HEAD_MARKING
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_FACIAL_HAIR_HORNS
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_FACIAL_ACCESSORY
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_PIERCING_JEWELRY
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_COSTUME
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_BODY_MARKING
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_SKIN
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_PERSONALITY
    or collectibleType == COLLECTIBLE_CATEGORY_TYPE_POLYMORPH
    then
        local categoryString =
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN) and GetString(SI_COLLECTIBLECATEGORYTYPE23) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_HAT) and GetString(SI_COLLECTIBLECATEGORYTYPE10) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_HAIR) and GetString(SI_COLLECTIBLECATEGORYTYPE13) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_HEAD_MARKING) and GetString(SI_COLLECTIBLECATEGORYTYPE17) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_FACIAL_HAIR_HORNS) and GetString(SI_COLLECTIBLECATEGORYTYPE14) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_FACIAL_ACCESSORY) and GetString(SI_COLLECTIBLECATEGORYTYPE15) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_PIERCING_JEWELRY) and GetString(SI_COLLECTIBLECATEGORYTYPE16) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_COSTUME) and GetString(SI_COLLECTIBLECATEGORYTYPE4) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_BODY_MARKING) and GetString(SI_COLLECTIBLECATEGORYTYPE18) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_SKIN) and GetString(SI_COLLECTIBLECATEGORYTYPE11) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_PERSONALITY) and GetString(SI_COLLECTIBLECATEGORYTYPE9) or
        (collectibleType == COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) and GetString(SI_COLLECTIBLECATEGORYTYPE12)

        if collectibleType == (COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN and (ChatAnnouncements.SV.Collectibles.CollectibleUseCategory12 or LUIE.SlashCollectibleOverride) ) or (collectibleType ~= COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN and (ChatAnnouncements.SV.Collectibles.CollectibleUseCategory3 or LUIE.SlashCollectibleOverride) ) then
            if GetActiveCollectibleByType(GetCollectibleCategoryType(lastCollectibleUsed)) > 0 then
                message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_USE_CATEGORY), categoryString, link, formattedIcon)
                alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_USE_CATEGORY), categoryString, name, "")
            else
                message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_DISABLE_CATEGORY), categoryString, link, formattedIcon)
                alert = zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_DISABLE_CATEGORY), categoryString, name, "")
            end
        end
    end

    if message and ChatAnnouncements.SV.Collectibles.CollectibleUseCA or LUIE.SlashCollectibleOverride then
        message = CollectibleUseColorize:Colorize(message)
        printToChat(message)
    end
    if alert and ChatAnnouncements.SV.Collectibles.CollectibleUseAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alert)
    end

	lastCollectibleUsed = 0
    LUIE.SlashCollectibleOverride = false
end
