/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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

/*
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('500030','38186','100','1','1','3','3'); 

DELETE FROM `creature` WHERE `id`=500030;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('500030','571','1','128','0','0','4463.77','3790.81','348.12','6.12777','28800','0','0','6066450','0','0','0','0','0'); 

DELETE FROM `creature_template` WHERE `id`=500030;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('500030','0','0','0','0','0','19677','0','0','0','Rok el Sensible','Hijo Bastardo de Gruul','','0','82','82','2','16','16','0','1','0.992063','1','1','488','642','0','782','7.5','2000','0','1','33280','2048','8','0','0','0','0','0','363','521','121','6','72','500030','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','450','1','1','0','0','0','0','0','0','0','0','1','0','8388624','0','','12340');

DELETE FROM `script_texts` WHERE `npc_entry`=500030;
DELETE FROM `creature_text` WHERE `entry`=500030;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(500030, 0, 0, 'Rok hacer honor a su pueblo ¡Rok partirte en mil pedazos!', 14, 0, 100, 0, 0, 0, 'Rok SAY_COMBAT'),
(500030, 1, 0, '¿A ti gustar fuego? ¡Rok quemar todo!', 14, 0, 100, 0, 0, 0, 'Rok SAY_SCORCH'),
(500030, 2, 0, '¡Rok hacer daño! ¿A ti doler? Pobrecito...', 14, 0, 100, 0, 0, 0, 'Rok SAY_SLAY'),
(500030, 3, 0, '¡Rok enfadado, Padre dar espalda!', 14, 0, 100, 0, 0, 0, 'Rok SAY_BERSERK'),
(500030, 4, 0, 'Otro con-ti-nu-ara ta-rea de Rok...', 14, 0, 100, 0, 0, 0, 'Rok SAY_DEATH'),
(500030, 5, 0, 'Rok tener hambre !Hacer barbacoa!', 41, 0, 100, 0, 0, 0, 'Rok EMOTE_JETS');
*/

enum Talks
{
    SAY_COMBAT                   = 0, //Rok hacer honor a su pueblo ¡Rok partirte en mil pedazos!
    SAY_SCORCH                   = 1, //¿A ti gustar fuego? ¡Rok quemar todo!
    SAY_SLAY                     = 2, //¡Rok hacer daño! ¿A ti doler? Pobrecito...
    SAY_BERSERK                  = 3, //¡Rok enfadado, Padre dar espalda!
    SAY_DEATH                    = 4, //Otro con-ti-nu-ara ta-rea de Rok...
    EMOTE_JETS                   = 5  //Rok tener hambre !Hacer barbacoa!
};

enum Spells
{
    // Rok el Sensible
    SPELL_SCORCH                 = 63474,
    SPELL_GROUND                 = 62548,
    SPELL_FLAME_JETS             = 63472,
    SPELL_BERSERK                = 47008
};

enum Creatures
{
    NPC_GROUND_SCORCH            = 33221
};

enum Events
{
    EVENT_JET                    = 1,
    EVENT_SCORCH                 = 2,
    EVENT_BERSERK                = 3
};

class w_boss_rok_el_sensible : public CreatureScript
{
    public:
        w_boss_rok_el_sensible() : CreatureScript("w_boss_rok_el_sensible") { }

        struct w_boss_rok_el_sensibleAI : public ScriptedAI
        {
            w_boss_rok_el_sensibleAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;
			
            void Reset()
            {
                events.Reset();

                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
            }
            
            void EnterCombat(Unit* who)
            {
                DoZoneInCombat();

                events.Reset();
                Talk(SAY_COMBAT);
                events.ScheduleEvent(EVENT_JET, 15*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_SCORCH, 10*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_BERSERK, 4*MINUTE*IN_MILLISECONDS);
            }
            
            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
            }
            
            void KilledUnit(Unit* /*victim*/)
            {
                Talk(SAY_SLAY);
            }
      
            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
				
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_JET:
                            Talk(EMOTE_JETS);
                            DoCast(me, SPELL_FLAME_JETS);
                            events.DelayEvents(2*IN_MILLISECONDS);   // Cast time
                            events.ScheduleEvent(EVENT_JET, urand(18*IN_MILLISECONDS, 22*IN_MILLISECONDS));
                            return;
                        case EVENT_SCORCH:
                            Talk(SAY_SCORCH);
                            if (Unit* target = me->getVictim())
                            DoCast(SPELL_SCORCH);
                            events.ScheduleEvent(EVENT_SCORCH, 12*IN_MILLISECONDS);
                            return;
                        case EVENT_BERSERK:
                            DoCast(me, SPELL_BERSERK, true);
                            Talk(SAY_BERSERK);
                            return;
                        default:
                            return;
                    }
                }

                DoMeleeAttackIfReady();

                EnterEvadeIfOutOfCombatArea(diff);
            }
        };
        
        CreatureAI* GetAI(Creature* creature) const
        {
            return new w_boss_rok_el_sensibleAI(creature);
        }
};

void AddSC_rok_el_sensible()
{
    new w_boss_rok_el_sensible();
}
