/*
 * Copyright (C) 2006 - 2012 Skwow <http://www.skwow.net/>
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
 
#include "ScriptPCH.h"
 
#define GOSSIP_HELLO_1  "Saludos"
#define GOSSIP_HELLO_2  "Y... ""\xc2\xbf""Qu""\xC3\xA9"" hago ahora?"
#define GOSSIP_HELLO_3  """\xc2\xbf""De qu""\xC3\xA9"" se trata?"
#define GOSSIP_HELLO_4  """\xc2\xbf""Algo m""\xC3\xA1""s que deba saber? ""\xc2\xbf""Podr""\xC3\xAD""as darme alg""\xC3\xBA""n consejo?"
#define GOSSIP_HELLO_5  """\xc2\xa1""Adi""\xC3\xB3""s y Gracias!"
 
enum Info
{
    ITEM_LIBRO              = 16321,
};
 
class npc_inicio : public CreatureScript
{
public:
    npc_inicio() : CreatureScript("npc_inicio") { }
 
bool OnGossipHello(Player* player, Creature* creature)
{
	player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_1, GOSSIP_SENDER_MAIN,   1000);
 
	player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
	return true;
}
 
void SendDefaultMenu_npc_inicio(Player* player, Creature* creature, uint32 uiAction)
{
	player->PlayerTalkClass->ClearMenus();
	switch(uiAction)
	{
		case 1000:
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_2, GOSSIP_SENDER_MAIN, 2000);
			creature->MonsterWhisper("""\xc2\xa1""Bienvenido al Reino Ragnaros!", player->GetGUID());
			player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,creature->GetGUID());
			break;
		case 2000:
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_3, GOSSIP_SENDER_MAIN, 3000);
			creature->MonsterWhisper("Es la hora de comenzar tu aventura. Pero antes, te vamos a hacer un regalo.", player->GetGUID());
			player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,creature->GetGUID());
			break;
		case 3000:
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_4, GOSSIP_SENDER_MAIN, 4000);
			creature->MonsterWhisper("Un libro en el que vas a poder consultar algunos temas por si tienes dudas.", player->GetGUID());
			player->AddItem(ITEM_LIBRO,1);
			player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,creature->GetGUID());
			break;
		case 4000:
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_5, GOSSIP_SENDER_MAIN, 5000);
			creature->MonsterWhisper("P""\xC3\xA1""salo en grande y disfruta lo m""\xC3\xA1""ximo posible de esta comunidad.", player->GetGUID());
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,creature->GetGUID());
			break;
		case 5000:
			player->CLOSE_GOSSIP_MENU();
			creature->MonsterWhisper("""\xc2\xa1""""\xC3\x81""nimo y mucha Suerte!", player->GetGUID());
			break;
	}
}
 
bool OnGossipSelect(Player* player, Creature* creature, uint32 uiSender, uint32 uiAction)
{
	if (uiSender == GOSSIP_SENDER_MAIN)
		SendDefaultMenu_npc_inicio(player, creature, uiAction);
	return true;
}
};
 
void AddSC_npc_inicio()
{
    new npc_inicio();
}
