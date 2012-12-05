#ifndef DEF_TRANSMOGRIFICATION_H
#define DEF_TRANSMOGRIFICATION_H

#include "Config.h"

enum TransmogTrinityStrings
{
    LANG_REM_TRANSMOGRIFICATIONS_ITEMS  = 12000,
    LANG_ERR_NO_TRANSMOGRIFICATIONS     = 12001,
    LANG_REM_TRANSMOGRIFICATION_ITEM    = 12002,
    LANG_ERR_NO_TRANSMOGRIFICATION      = 12003,
    LANG_ITEM_TRANSMOGRIFIED            = 12004,
    LANG_ERR_NO_ITEM_SUITABLE           = 12005,
    LANG_ERR_NO_ITEM_EXISTS             = 12006,
    LANG_ERR_EQUIP_SLOT_EMPTY           = 12007,

    LANG_SLOT_NAME_HEAD                 = 12008,
    LANG_SLOT_NAME_SHOULDERS            = 12009,
    LANG_SLOT_NAME_BODY                 = 12010,
    LANG_SLOT_NAME_CHEST                = 12011,
    LANG_SLOT_NAME_WAIST                = 12012,
    LANG_SLOT_NAME_LEGS                 = 12013,
    LANG_SLOT_NAME_FEET                 = 12014,
    LANG_SLOT_NAME_WRISTS               = 12015,
    LANG_SLOT_NAME_HANDS                = 12016,
    LANG_SLOT_NAME_BACK                 = 12017,
    LANG_SLOT_NAME_MAINHAND             = 12018,
    LANG_SLOT_NAME_OFFHAND              = 12019,
    LANG_SLOT_NAME_RANGED               = 12020,
    LANG_SLOT_NAME_TABARD               = 12021,

    LANG_OPTION_BACK                    = 12022,
    LANG_OPTION_REMOVE_ALL              = 12023,
    LANG_POPUP_REMOVE_ALL               = 12024,
    LANG_OPTION_UPDATE_MENU             = 12025,
    LANG_OPTION_REMOVE_ONE              = 12026,
    LANG_POPUP_REMOVE_ONE               = 12027,
    LANG_POPUP_TRANSMOGRIFY             = 12028,

    LANG_ERR_NO_TOKEN                   = 12029
};

enum TransmogrificationResult // custom
{
    ERR_FAKE_NEW_BAD_QUALITY,
    ERR_FAKE_OLD_BAD_QUALITY,
    ERR_FAKE_SAME_DISPLAY,
    ERR_FAKE_SAME_DISPLAY_FAKE,
    ERR_FAKE_CANT_USE,
    ERR_FAKE_NOT_SAME_CLASS,
    ERR_FAKE_BAD_CLASS,
    ERR_FAKE_BAD_SUBLCASS,
    ERR_FAKE_BAD_INVENTORYTYPE,
    ERR_FAKE_OK
};

class Transmogrification
{
public:
    Transmogrification() { };
    ~Transmogrification() { };

    uint32 GetRequireGold() { return RequireGold; }
    float GetGoldModifier() { return GoldModifier; }
    uint32 GetGoldCost() { return GoldCost; }

    bool GetRequireToken() { return RequireToken; }
    uint32 GetTokenEntry() { return TokenEntry; }
    uint32 GetTokenAmount() { return TokenAmount; }

    static uint32 GetFakeEntry(Item* item);
    static void DeleteFakeFromDB(uint32 lowGUID);
    static bool DeleteFakeEntry(Item* item);
    static void SetFakeEntry(Item* item, uint32 entry);
    static uint32 SuitableForTransmogrification(Player* player, Item* oldItem, Item* newItem);

    bool AllowedQuality(uint32 quality) // Only thing used elsewhere (Player.cpp)
    {
        switch(quality)
        {
        case ITEM_QUALITY_POOR: return AllowPoor;
        case ITEM_QUALITY_NORMAL: return AllowCommon;
        case ITEM_QUALITY_UNCOMMON: return AllowUncommon;
        case ITEM_QUALITY_RARE: return AllowRare;
        case ITEM_QUALITY_EPIC: return AllowEpic;
        case ITEM_QUALITY_LEGENDARY: return AllowLegendary;
        case ITEM_QUALITY_ARTIFACT: return AllowArtifact;
        case ITEM_QUALITY_HEIRLOOM: return AllowHeirloom;
        default: return false;
        }
    }

    void LoadConfig()
    {
        RequireGold = (uint32)ConfigMgr::GetIntDefault("Transmogrification.RequireGold", 1);
        GoldModifier = ConfigMgr::GetFloatDefault("Transmogrification.GoldModifier", 1.0f);
        GoldCost = (uint32)ConfigMgr::GetIntDefault("Transmogrification.GoldCost", 100000);

        RequireToken = ConfigMgr::GetBoolDefault("Transmogrification.RequireToken", false);
        TokenEntry = (uint32)ConfigMgr::GetIntDefault("Transmogrification.TokenEntry", 49426);
        TokenAmount = (uint32)ConfigMgr::GetIntDefault("Transmogrification.TokenAmount", 1);

        AllowPoor = ConfigMgr::GetBoolDefault("Transmogrification.AllowPoor", false);
        AllowCommon = ConfigMgr::GetBoolDefault("Transmogrification.AllowCommon", false);
        AllowUncommon = ConfigMgr::GetBoolDefault("Transmogrification.AllowUncommon", true);
        AllowRare = ConfigMgr::GetBoolDefault("Transmogrification.AllowRare", true);
        AllowEpic = ConfigMgr::GetBoolDefault("Transmogrification.AllowEpic", true);
        AllowLegendary = ConfigMgr::GetBoolDefault("Transmogrification.AllowLegendary", false);
        AllowArtifact = ConfigMgr::GetBoolDefault("Transmogrification.AllowArtifact", false);
        AllowHeirloom = ConfigMgr::GetBoolDefault("Transmogrification.AllowHeirloom", true);

        if(!sObjectMgr->GetItemTemplate(TokenEntry))
        {
            sLog->outError(LOG_FILTER_SERVER_LOADING, "Transmogrification.TokenEntry (%u) does not exist. Using default.", TokenEntry);
            TokenEntry = 49426;
        }
    }

private:

    uint32 RequireGold;
    float GoldModifier;
    uint32 GoldCost;

    bool RequireToken;
    uint32 TokenEntry;
    uint32 TokenAmount;

    bool AllowPoor;
    bool AllowCommon;
    bool AllowUncommon;
    bool AllowRare;
    bool AllowEpic;
    bool AllowLegendary;
    bool AllowArtifact;
    bool AllowHeirloom;
};
#define sTransmogrification ACE_Singleton<Transmogrification, ACE_Null_Mutex>::instance()

#endif