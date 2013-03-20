/*
 * Copyright © 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright © 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
Name: SK_Custom_Commandscript
%Complete: 100
Comment: Comandos extra
Category: commandscripts
EndScriptData */

/* Corrección de script para wotlk 3.3.5 Skwow.net realizada por SaiNth 20/03/2013 */


#include "ScriptMgr.h"
#include "Chat.h"

class sk_custom_commandscript : public CommandScript
{
    public:
        sk_custom_commandscript() : CommandScript("sk_custom_commandscript") { }

        ChatCommand* GetCommands() const
        {
            static ChatCommand AnunciarBanCommandTable[] =
            {
                { "playeraccount",  SEC_ADMINISTRATOR,  false,  &HandleAnnounceBanAccountByCharacterCommand,      "", NULL },
                { NULL,             0,                  false,  NULL,                                             "", NULL }
            };

            static ChatCommand commandTable[] =
            {
                { "aban",           SEC_ADMINISTRATOR,  false,  NULL,                            "", AnunciarBanCommandTable },
                { NULL,             0,                  false,  NULL,                            "", NULL }
            };
            
            return commandTable;
        }

        static bool HandleAnnounceBanAccountByCharacterCommand(ChatHandler* handler, const char* args)
        {
            if (!*args)
                return false;

            char* nameStr = strtok((char*)args, " ");

            if (!nameStr)
            {
                return false;
            }

            std::string name = nameStr;
            char* durationStr = strtok(NULL," ");

            if (!durationStr || !atoi(durationStr))
            {
                return false;
            }

            char* reasonStr = strtok(NULL,"");

            if (!reasonStr)
            {
                return false;
            }

            if (!normalizePlayerName(name))
            {
                handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }

            switch (sWorld->BanAccount(BAN_CHARACTER, name, durationStr, reasonStr, handler->GetSession() ? handler->GetSession()->GetPlayerName().c_str() : ""))
            {
                case BAN_SUCCESS:
                {

                    if (atoi(durationStr) > 0)
                        handler->PSendSysMessage(LANG_BAN_YOUBANNED, name.c_str(), secsToTimeString(TimeStringToSecs(durationStr), true).c_str(), reasonStr);
                    else
                        handler->PSendSysMessage(LANG_BAN_YOUPERMBANNED, name.c_str(), reasonStr);

                    std::string mensaje = "|cffff0000[BAN]: |cffff3300" + std::string(name.c_str()) + "|cffff0000 ha sido baneado/a "+ (atoi(durationStr) > 0 ? ("durante |cffff3300" + std::string(GetTimeFormat(TimeStringToSecs(durationStr), false).c_str())) : "|cffff3300permanentemente") + "|cffff0000por |cffff3300"+ (std::string(handler->GetSession()->GetPlayerName()))+". |cffff0000Razon: |cffff3300"+std::string(reasonStr) + ".|r";
                    char buff[2048];
                    
                    sprintf(buff, mensaje.c_str());
                    sWorld->SendServerMessage(SERVER_MSG_STRING, buff);
                    
                    break;
                }
                case BAN_NOTFOUND:
                {
                    handler->PSendSysMessage(LANG_BAN_NOTFOUND, "character", name.c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }
                default:
                    break;
            }

            return true;
        }

        static std::string GetTimeFormat(uint64 timeInSecs, bool hoursOnly)
        {
            uint64 secs    = timeInSecs % MINUTE;
            uint64 minutes = timeInSecs % HOUR / MINUTE;
            uint64 hours   = timeInSecs % DAY  / HOUR;
            uint64 days    = timeInSecs / DAY;

            std::ostringstream ss;

            if (days)
            {
                ss << days << " Dí­a(s) ";
            }
            if (hours || hoursOnly)
            {
                ss << hours << " Hora(s) ";
            }
            if (!hoursOnly)
            {
                if (minutes)
                {
                    ss << minutes << " Minuto(s) ";
                }
                if (secs || (!days && !hours && !minutes))
                {
                    ss << secs << " Segundo(s)";
                }
            }

            return ss.str();
        }
};

void AddSC_sk_custom_commandscript()
{
    new sk_custom_commandscript();
}