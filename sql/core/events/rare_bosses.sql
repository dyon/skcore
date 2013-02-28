ALTER TABLE `creature_loot_template` CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci; 

UPDATE `item_template` SET `Flags`=2048 WHERE `entry`=38186;

-- Rok el Sensible
DELETE FROM `creature_loot_template` WHERE `entry`=500030;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values
('500030','38186','100','1','1','1','1');

DELETE FROM `creature` WHERE `id`=500030;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values
('500030','571','0','128','0','0','4463.77','3790.81','348.12','6.12777','28800','0','0','6066450','0','0','0','0','0'); 

DELETE FROM `creature_template` WHERE `entry`=500030;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values
('500030','0','0','0','0','0','19677','0','0','0','Rok el Sensible','Hijo Bastardo de Gruul','','0','83','83','2','16','16','0','1','0.992063','2','2','589','698','0','869','35','2000','2000','1','33280','2048','8','0','0','0','0','0','375','521','121','1','72','500030','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1250000','1250000','','1','3','1','450','1','1','0','38186','0','0','0','0','0','0','1','617299839','0','w_boss_rok_el_sensible','12340');

DELETE FROM `creature_text` WHERE `entry`=500030;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(500030, 0, 0, 'Rok hacer honor a su pueblo ¡Rok partirte en mil pedazos!', 14, 0, 100, 0, 0, 0, 'Rok SAY_COMBAT'),
(500030, 1, 0, '¿A ti gustar fuego? ¡Rok quemar todo!', 14, 0, 100, 0, 0, 0, 'Rok SAY_SCORCH'),
(500030, 2, 0, '¡Rok hacer daño! ¿A ti doler? Pobrecito...', 14, 0, 100, 0, 0, 0, 'Rok SAY_SLAY'),
(500030, 3, 0, '¡Rok enfadado, Padre dar espalda!', 14, 0, 100, 0, 0, 0, 'Rok SAY_BERSERK'),
(500030, 4, 0, 'Otro con-ti-nu-ara ta-rea de Rok...', 14, 0, 100, 0, 0, 0, 'Rok SAY_DEATH'),
(500030, 5, 0, 'Rok tener hambre !Hacer barbacoa!', 41, 0, 100, 0, 0, 0, 'Rok EMOTE_JETS');

-- Romeo
DELETE FROM `creature_loot_template` WHERE `entry`=500031;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values
('500031','38186','100','1','1','1','1'); 

DELETE FROM `creature_template` WHERE `entry`=500031;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values
('500031','0','0','0','0','0','7975','0','0','0','Romeo el Soñador','','','0','83','83','2','16','16','0','1','0.992063','1','2','589','698','0','869','35','2000','2000','1','33280','2048','8','0','0','0','0','0','445','654','169','1','72','500030','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1250000','1250000','','1','7','1','450','1','1','0','38186','0','0','0','0','0','0','1','617299839','0','w_boss_romeo','12340');


DELETE FROM `creature` WHERE `id`=500031;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values
('500031','1','0','128','0','0','-10035.14','-4032.76','18.2033','3.427390','28800','0','0','4800000','0','0','0','0','0');

DELETE FROM `creature_text` WHERE `entry`=500031;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(500031, 0, 0, '¡Atrevidos! ¿Cómo os atrevéis a entrometeros en nuestros asuntos?', 14, 0, 100, 0, 0, 0, 'Romeo -  SAY_COMBAT'),
(500031, 1, 0, '¡Quemare vuestra alma por insolentes!', 14, 0, 100, 0, 0, 0, 'Romeo - SAY_FLAME_BREATH'),
(500031, 2, 0, '¿Has sufrido? Seguro que sí.', 14, 0, 100, 0, 0, 0, 'Romeo - SAY_SLAY'),
(500031, 3, 0, '¡Esto termina aqui!', 14, 0, 100, 0, 0, 0, 'Romeo - SAY_BERSERK'),
(500031, 4, 0, 'Ha llegado mi hora Julieta...', 14, 0, 100, 0, 0, 0, 'Romeo -  SAY_DEATH'),
(500031, 5, 0, '¡Sentid lo que es vivir con odio!', 41, 0, 100, 0, 0, 0, 'Romeo - EMOTE_BELLOWING_ROAR');

-- Julieta
DELETE FROM `creature_loot_template` WHERE `entry`=500032;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values
('500032','38186','100','1','1','1','1'); 

DELETE FROM `creature_template` WHERE `entry`=500032;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values
('500032','0','0','0','0','0','7553','0','0','0','Julieta la Esperanza','','','0','83','83','2','16','16','0','1','0.992063','1','2','589','698','0','869','35','2000','2000','1','33280','2048','8','0','0','0','0','0','445','654','169','1','72','500030','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1250000','1250000','','1','7','1','450','1','1','0','38186','0','0','0','0','0','0','1','617299839','0','w_boss_julieta_la_esperanza','12340');

DELETE FROM `creature` WHERE `id`=500032;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values
('500032','1','0','128','0','0','-10034.26','-4042.74','16.1436','3.084954','28800','0','0','4800000','0','0','0','0','0');

DELETE FROM `creature_text` WHERE `entry`=500032;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(500032, 0, 0, 'Vamos a degustar carne fresca', 14, 0, 100, 0, 0, 0, 'Julieta - SAY_COMBAT'),
(500032, 1, 0, '¡Quemare vuestro cuerpo por insolentes!', 14, 0, 100, 0, 0, 0, 'Julieta - SAY_FLAME_BREATH'),
(500032, 2, 0, 'Me encanta verte en el suelo...', 14, 0, 100, 0, 0, 0, 'Julieta - SAY_SLAY'),
(500032, 3, 0, '¡Esto termina aqui!', 14, 0, 100, 0, 0, 0, 'Julieta - SAY_BERSERK'),
(500032, 4, 0, 'Ha llegado mi hora Romeo.', 14, 0, 100, 0, 0, 0, 'Julieta -  SAY_DEATH'),
(500032, 5, 0, '¡Sentid lo que es vivir sin amor!', 41, 0, 100, 0, 0, 0, 'Julieta - EMOTE_BELLOWING_ROAR');