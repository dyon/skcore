#include "ScriptMgr.h"
#include "Player.h"

//Helper for Events
bool HasItemInMail(Player *player, uint32 item)
{
    QueryResult result;
    uint32 item_id = item;
    result = CharacterDatabase.PQuery("SELECT `mail_items`.`item_guid` FROM `mail_items` INNER JOIN `item_instance` ON item_instance.guid = mail_items.item_guid WHERE item_instance.itemEntry = '%i' AND `mail_items`.`receiver` = '%i' LIMIT 1", item_id, player->GetGUID());
    if(result)
        return true;
    else
        return false;

    //for (PlayerMails::iterator itr = pPlayer->GetMailBegin(); itr != pPlayer->GetMailEnd(); ++itr)
    //{
    //    error_log("Has Mail");
    //    uint8 item_count = (*itr)->items.size();
    //    for (uint8 i = 0; i < item_count; ++i)
    //    {
    //        Item *item = pPlayer->GetMItem((*itr)->items[i].item_guid);
    //        error_log("Has Item in Mail %d", item->GetEntry());
    //        if(item->GetEntry() == ItemEntry)
    //            return true;
    //    }
    //}
    //return false;
}

enum EventAnicersarioSK
{
    EVENT_ANIVERSARIO_SK        = 210,
};

//OnLogin not implemented yet
class SurprisePlayerScript : public PlayerScript
{
public:
    SurprisePlayerScript() : PlayerScript("SurprisePlayerScript") { }

    void OnLogin(Player* player)
    {
        if(IsEventActive(EVENT_ANIVERSARIO_SK))
        {
            if (!player->HasItemCount(20371, 1, true) && !HasItemInMail(player, 20371) && !player->HasSpell(24696))
            {
                std::string subject = """\xc2\xa1""Sexto aniversario de Silver Knights!";
                MailSender sender(MAIL_CREATURE, 16474);
                MailDraft draft(subject, sObjectMgr->GetTrinityString(-2000001, LOCALE_esES));


                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                if(Item* item = Item::CreateItem(20371, 1, player))
                {
                    // save new item before send
                    item->SaveToDB(trans);                               // save for prevent lost at next mail load, if send fail then item will deleted

                    // item
                    draft.AddItem(item);
                }

                draft.SendMailTo(trans, player, MailSender(sender));
                CharacterDatabase.CommitTransaction(trans);
            }
        }
    }
};
 
void AddSC_event_login()
{
    new SurprisePlayerScript();
}