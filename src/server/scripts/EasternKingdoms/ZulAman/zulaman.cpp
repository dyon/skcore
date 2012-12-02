/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Zulaman
SD%Complete: 90
SDComment: Forest Frog will turn into different NPC's. Workaround to prevent new entry from running this script
SDCategory: Zul'Aman
EndScriptData */

/* ContentData
npc_forest_frog
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "zulaman.h"
#include "Player.h"
#include "SpellInfo.h"

/*######
## npc_forest_frog
######*/

#define SPELL_REMOVE_AMANI_CURSE    43732
#define SPELL_PUSH_MOJO             43923
#define ENTRY_FOREST_FROG           24396

class npc_forest_frog : public CreatureScript
{
    public:

        npc_forest_frog()
            : CreatureScript("npc_forest_frog")
        {
        }

        struct npc_forest_frogAI : public ScriptedAI
        {
            npc_forest_frogAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            InstanceScript* instance;

            void Reset() {}

            void EnterCombat(Unit* /*who*/) {}

            void DoSpawnRandom()
            {
                if (instance)
                {
                    uint32 cEntry = 0;
                    switch (rand()%10)
                    {
                        case 0: cEntry = 24397; break;          //Mannuth
                        case 1: cEntry = 24403; break;          //Deez
                        case 2: cEntry = 24404; break;          //Galathryn
                        case 3: cEntry = 24405; break;          //Adarrah
                        case 4: cEntry = 24406; break;          //Fudgerick
                        case 5: cEntry = 24407; break;          //Darwen
                        case 6: cEntry = 24445; break;          //Mitzi
                        case 7: cEntry = 24448; break;          //Christian
                        case 8: cEntry = 24453; break;          //Brennan
                        case 9: cEntry = 24455; break;          //Hollee
                    }

                    if (!instance->GetData(TYPE_RAND_VENDOR_1))
                        if (rand()%10 == 1) cEntry = 24408;      //Gunter
                    if (!instance->GetData(TYPE_RAND_VENDOR_2))
                        if (rand()%10 == 1) cEntry = 24409;      //Kyren

                    if (cEntry) me->UpdateEntry(cEntry);

                    if (cEntry == 24408) instance->SetData(TYPE_RAND_VENDOR_1, DONE);
                    if (cEntry == 24409) instance->SetData(TYPE_RAND_VENDOR_2, DONE);
                }
            }

            void SpellHit(Unit* caster, const SpellInfo* spell)
            {
                if (spell->Id == SPELL_REMOVE_AMANI_CURSE && caster->GetTypeId() == TYPEID_PLAYER && me->GetEntry() == ENTRY_FOREST_FROG)
                {
                    //increase or decrease chance of mojo?
                    if (rand()%99 == 50) DoCast(caster, SPELL_PUSH_MOJO, true);
                    else DoSpawnRandom();
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_forest_frogAI(creature);
        }
};

/*######
## npc_zulaman_hostage
######*/

#define GOSSIP_HOSTAGE1        "I am glad to help you."

static uint32 HostageEntry[] = {23790, 23999, 24024, 24001};
static uint32 ChestEntry[] = {186648, 187021, 186672, 186667};

class npc_zulaman_hostage : public CreatureScript
{
    public:
        npc_zulaman_hostage() : CreatureScript("npc_zulaman_hostage") { }

        struct npc_zulaman_hostageAI : public ScriptedAI
        {
            npc_zulaman_hostageAI(Creature* creature) : ScriptedAI(creature)
            {
                IsLoot = false;
            }

            bool IsLoot;
            uint64 PlayerGUID;

            void Reset() {}

            void EnterCombat(Unit* /*who*/) {}

            void JustDied(Unit* /*killer*/)
            {
                Player* player = Unit::GetPlayer(*me, PlayerGUID);
                if (player)
                    player->SendLoot(me->GetGUID(), LOOT_CORPSE);
            }

            void UpdateAI(const uint32 /*diff*/)
            {
                if (IsLoot)
                    DoCast(me, 7, false);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_zulaman_hostageAI(creature);
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HOSTAGE1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
                player->CLOSE_GOSSIP_MENU();

            if (!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                return true;

            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            InstanceScript* instance = creature->GetInstanceScript();
            if (instance)
            {
                //uint8 progress = instance->GetData(DATA_CHESTLOOTED);
                instance->SetData(DATA_CHESTLOOTED, 0);
                float x, y, z;
                creature->GetPosition(x, y, z);
                uint32 entry = creature->GetEntry();
                for (uint8 i = 0; i < 4; ++i)
                {
                    if (HostageEntry[i] == entry)
                    {
                        creature->SummonGameObject(ChestEntry[i], x-2, y, z, 0, 0, 0, 0, 0, 0);
                        break;
                    }
                }
            }
            return true;
        }
};
/*######
## npc_harrison_jones_za
######*/

enum
{
SAY_START = -1568079,
SAY_AT_GONG = -1568080,
SAY_OPENING_ENTRANCE = -1568081,
SAY_OPEN_GATE = -1568082,
SAY_INST_BEGIN = -1568068,

SPELL_BANGING_THE_GONG = 45222,

SOUND_GONG = 12204,
SOUND_CELEBRATE = 12135
};

#define GOSSIP_ITEM_BEGIN "Thanks for the concern, but we intend to explore Zul'Aman."

class npc_harrison_jones_za : public CreatureScript
{
public:
    npc_harrison_jones_za() : CreatureScript("npc_harrison_jones_za") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            if (npc_harrison_jones_zaAI* pHarrisonAI = dynamic_cast<npc_harrison_jones_zaAI*>(creature->AI()))
                pHarrisonAI->StartEvent(player);
            player->CLOSE_GOSSIP_MENU();
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript();

        if(!instance)
            return false;

        if(instance->GetData(DATA_EVENT_RUN) != NOT_STARTED)
            return false;

        if(creature->isQuestGiver())
           player->PrepareQuestMenu( creature->GetGUID());

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BEGIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
    
    struct npc_harrison_jones_zaAI : public npc_escortAI
    {
        npc_harrison_jones_zaAI(Creature* creature) : npc_escortAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
            Reset();
        }
    
        InstanceScript* m_pInstance;
        uint32 ResetTimer;
    
        void DamageTaken(Unit* done_by, uint32 &damage)
        {
            // if hitted by Amani'shi Guardian, killed immediately
            if(done_by->GetTypeId() == TYPEID_UNIT && damage)
            {
                damage = me->GetMaxHealth();
                done_by->GetMotionMaster()->MoveChase(GetPlayerForEscort());
            }
        }
    
        void WaypointReached(uint32 uiPointId)
        {
            if (!m_pInstance)
                return;
    
            switch(uiPointId)
            {
                case 1:
                    DoScriptText(SAY_AT_GONG, me);
    
                    if (GameObject* pEntranceDoor = m_pInstance->instance->GetGameObject(m_pInstance->GetData64(DATA_GO_GONG)))
                        pEntranceDoor->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
    
                    //Start bang gong for 10min
                    me->CastSpell(me, SPELL_BANGING_THE_GONG, false);
                    break;
                case 2:
                    DoScriptText(SAY_OPENING_ENTRANCE, me);
                    break;
                case 3:
                    DoScriptText(SAY_OPEN_GATE, me);
                    // Todo: fix the escort pause and have players click the gong
                    me->RemoveAurasDueToSpell(SPELL_BANGING_THE_GONG);
                    DoPlaySoundToSet(me, SOUND_CELEBRATE);
                    m_pInstance->SetData(DATA_EVENT_RUN,IN_PROGRESS);
                    break;
                case 4:
                    std::list<Creature*> trolls;
                    GetCreatureListWithEntryInGrid(trolls, me, 23889, 25.0f);
                    for(std::list<Creature *>::iterator i = trolls.begin(); i != trolls.end(); i++)
                    {
                        (*i)->AI()->DoZoneInCombat();
                        (*i)->AddThreat(me, 1000);
                    }
                    GetCreatureListWithEntryInGrid(trolls, me, 23597, 25.0f);
                    for(std::list<Creature *>::iterator i = trolls.begin(); i != trolls.end(); i++)
                    {
                        (*i)->AI()->DoZoneInCombat();
                        (*i)->AddThreat(me, 1000);
                    }
    //                ((Creature*)Guardian)->GetMotionMaster()->MoveChase(me);
                    SetEscortPaused(true);
                    if (Creature* HEXLORD = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_HEXLORDGUID)))
                        DoScriptText(SAY_INST_BEGIN, HEXLORD);
                    break;
                    //TODO: Spawn group of Amani'shi Savage and make them run to entrance
                    //TODO: Add, and modify reseting of the event, reseting quote is missing
            }
        }
    
        void Reset()
        {
            ResetTimer = 600000;    // 10min for players to make an event
            me->RemoveAllAuras();
            me->setActive(true);    // very important due to grid issues
        }
    
        void StartEvent(Player* player)
        {
            DoScriptText(SAY_START, me);
            Start(true, false, player->GetGUID(), 0, false, true);
        }
    
        void SetHoldState(bool bOnHold)
        {
            SetEscortPaused(bOnHold);
    
            me->InterruptNonMeleeSpells(false);
            //Stop banging gong if still
            if (me->HasAura(SPELL_BANGING_THE_GONG, 0))
            {
                me->RemoveAurasDueToSpell(SPELL_BANGING_THE_GONG);
                DoPlaySoundToSet(me, SOUND_CELEBRATE);
            }
        }
    
        void UpdateAI(const uint32 diff)
        {
            if(HasEscortState(STATE_ESCORT_PAUSED))
            {/*
                if(ResetTimer < diff)
                {
                    me->Kill(me, false);
                    me->Respawn();
                    ResetTimer = 600000;
                }
                else
                    ResetTimer -= diff;*/
            }
            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_harrison_jones_zaAI(creature);
    }
};

class go_strange_gong : public GameObjectScript
{
    public:
        go_strange_gong() : GameObjectScript("go_strange_gong") { }

        bool OnGossipSelect(Player* player, GameObject* go)
        {
            InstanceScript* instance = player->GetInstanceScript();

            if (!instance)
                return false;

            if (instance->GetData(DATA_EVENT_RUN) == SPECIAL)
            {
                if (Creature* harrison = ObjectAccessor::GetCreature(*player, instance->GetData64(DATA_HARRISON)))
                    CAST_AI(npc_harrison_jones_za::npc_harrison_jones_zaAI, harrison->AI())->SetHoldState(false);
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                return false;
            }

            instance->SetData(DATA_EVENT_RUN, SPECIAL);
            return true;
        }
};

void AddSC_zulaman()
{
    new npc_forest_frog();
    new npc_zulaman_hostage();
    new npc_harrison_jones_za();
    new go_strange_gong();
}

