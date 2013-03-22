-- ==>SOLUCION HUARGO

SET @NPC := 24277;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2724.867,-2996.879,91.80984,0,0,0,100,0),
(@PATH,2,2751.252,-3001.074,89.98224,0,0,0,100,0),
(@PATH,3,2779.356,-3012.149,91.01633,0,0,0,100,0),
(@PATH,4,2790.117,-3024.486,94.64133,0,0,0,100,0),
(@PATH,5,2793.189,-3046.271,97.17670,0,0,0,100,0);
-- not complete

UPDATE `creature_template` SET `faction_A`=0,`faction_H`=0 WHERE `entry`=24277;

DELETE FROM `creature_template_addon` WHERE `entry`=24277;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `bytes1`, `bytes2`, `auras`) VALUES
(24277, @PATH, 0x10000, 0x1, ''); -- aura 43062 missing from dbc

DELETE FROM `creature` WHERE `guid` = @NPC;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`MovementType`) VALUES
(@NPC, 24277,571,1,1,2724.867,-2996.879,91.80984,6.232399,120,0,2);
UPDATE creature_template SET unit_flags=0 WHERE entry=24277;

-- ==>SOLUCION MAMUTS

-- Fix quest Wooly Justice {A/H} ID: 12707
-- Add SAI for Enraged Mammoth
SET @Medallion := 52596;
SET @Mammoth :=   28851;
SET @Trample :=   52603;
SET @TAura :=     52607;
SET @Desciple :=  28861;
SET @Credit :=    28876;
UPDATE `creature_template` SET `AIName`='SmartAI',`spell1`=52601,`spell2`=52603 WHERE `entry`=@Mammoth;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Mammoth AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Mammoth,0,0,0,8,0,100,0,@Medallion,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Enraged Mammoth - On hit by spell from medallion - Change faction to friendly'),
(@Mammoth,0,1,0,1,0,100,0,15000,15000,15000,15000,2,1924,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Enraged Mammoth - On OOC for 10 sec - Change faction to back to normal');
-- Add SAI for Mam'toth desciple
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@Desciple;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Desciple AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Desciple,0,0,0,6,0,100,0,0,0,0,0,33,@Credit,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Mam''toth desciple - On death - Give credit to invoker, if Tampered'),
(@Desciple,0,1,0,25,0,100,0,0,0,0,0,28,@TAura,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Mam''toth desciple - On reset - Remove aura from trample');
-- Add conditions for spell Medallion of Mam'toth
DELETE FROM `conditions` WHERE `SourceEntry`=@Medallion AND `SourceTypeOrReferenceId`=17;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(17,0,@Medallion,0,0,31,1,3,@Mammoth,0,0,0,'', 'Medallion of Mam''toth can hit only Enraged Mammoths');
-- Add conditions for spell Trample
DELETE FROM `conditions` WHERE `SourceEntry`=@Trample AND `SourceTypeOrReferenceId`=13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13,1,@Trample,0,0,31,0,3,@Desciple,0,0,0,'', 'Trample effect 1 can hit only Desciple of Mam''toth'),
(13,2,@Trample,0,0,31,0,3,@Desciple,0,0,0,'', 'Trample effect 2 can hit only Desciple of Mam''toth');
-- Add conditions for smart_event 0 of Mam'toth desciple
DELETE FROM `conditions` WHERE `SourceEntry`=@Desciple AND `SourceTypeOrReferenceId`=22;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22,1,@Desciple,0,0,1,1,@TAura,0,0,0,0,'', 'Mam''toth desciple 1st event is valid only, if has Tampered aura credit');
-- Add conditions for spell Trample Aura
DELETE FROM `conditions` WHERE `SourceEntry`=@TAura AND `SourceTypeOrReferenceId`=13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13,1,@TAura,0,0,31,0,3,@Desciple,0,0,0,'', 'TAura effect can hit only Desciple of Mam''toth');


-- ==>Solución arriba la cola<===

-- Tails Up (13549)

-- Frost Leopard SAI
SET @ENTRY := 29327;
SET @QUEST := 13549;
SET @GOSSIP := 54000;
SET @SPELL_RAKE := 54668;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 42386; -- Sleeping Sleep
UPDATE `creature_template` SET `AIName`='SmartAI',`npcflag`=0,`gossip_menu_id`=@GOSSIP,`faction_A`=1990,`faction_H`=1990,`unit_flags`=0 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frost Leopard - In Combat - Cast Rake"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Reset - Set Faction Back"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_BLOWGUN,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Spellhit - Run Script"),
--
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Set Faction Friendly"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Cast Sleep"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Set npc_flag Gossip"),
--
(@ENTRY,0,3,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100+1,@ENTRY*100+2,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Gossip Select - Run Random Script"),
--
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - Script 1 - Say Line 0"),
(@ENTRY*100+1,9,1,0,0,0,100,0,1000,1000,0,0,36,33007,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Update Template Male"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Remove Sleep"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Remove OOC Flag"),
--
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - Script 2 - Say Line 1"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,36,33010,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Update Template Female"),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Remove Sleep"),
(@ENTRY*100+2,9,3,0,0,0,100,0,0,0,0,0,33,33005,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Quest Credit"),
(@ENTRY*100+2,9,4,0,0,0,100,0,0,0,0,0,29,0,0,28527,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Follow Player"); -- Apparently crediting doesn't work through this action

-- Insert gossip and static text
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=14266;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,14266);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@GOSSIP,0,0,"Lift the frost leopard's tail to check if it's a male or a female.",1,1,0);

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Frost Leopard"),
(@ENTRY,1,0,"It's a female!",42,0,100,0,0,0,"Female Frost Leopard");

-- Male Frost Leopard SAI
SET @ENTRY := 33007;
SET @SPELL_RAKE := 54668;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Frost Leopard - In Combat - Cast Rake");

-- Female Frost Leopard
SET @ENTRY := 33010;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;


-- Icepaw Bear SAI
SET @ENTRY := 29319;
SET @QUEST := 13549;
SET @GOSSIP := 55000;
SET @SPELL_CLAWS_OF_ICE := 54632;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 42386; -- Sleeping Sleep
UPDATE `creature_template` SET `AIName`='SmartAI',`npcflag`=0,`gossip_menu_id`=@GOSSIP,`faction_A`=1990,`faction_H`=1990,`unit_flags`=32768 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Icepaw Bear - In Combat - Cast Claws of Ice"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Reset - Set Faction Back"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_BLOWGUN,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Spellhit - Run Script"),
--
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Set Faction Friendly"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Cast Sleep"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Set npc_flag Gossip"),
--
(@ENTRY,0,3,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100+1,@ENTRY*100+2,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Gossip Select - Run Random Script"),
--
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Icepaw Bear - Script 1 - Say Line 0"),
(@ENTRY*100+1,9,1,0,0,0,100,0,1000,1000,0,0,36,33008,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Update Template Male"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Remove Sleep"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Remove OOC Flag"),
--
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - Script 2 - Say Line 1"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,36,33011,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Update Template Female"),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Remove Sleep"),
(@ENTRY*100+2,9,3,0,0,0,100,0,0,0,0,0,33,33006,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Quest Credit"),
(@ENTRY*100+2,9,4,0,0,0,100,0,0,0,0,0,29,0,0,28527,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Follow Player"); -- Apparently crediting doesn't work through this action

-- Insert gossip and static text
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=14267;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,14267);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@GOSSIP,0,0,"Lift the icepaw bear's tail to check if it's a male or a female.",1,1,0);

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Icepaw Bear"),
(@ENTRY,1,0,"It's a female!",42,0,100,0,0,0,"Female Icepaw Bear");

-- Male Icepaw Bear SAI
SET @ENTRY := 33008;
SET @SPELL_CLAWS_OF_ICE := 54632;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Icepaw Bear - In Combat - Cast Claws of Ice");

-- Female Frost Leopard
SET @ENTRY := 33011;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;


-- Only show first gossip if player is on quest Tails Up
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `ConditionValue1`=@QUEST;
DELETE FROM `conditions` WHERE `SourceEntry` IN (@SPELL_BLOWGUN) AND `ConditionValue1` IN (29327,29319);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,@QUEST,0,0,0,'',"Only show gossip if player is on quest Tails Up"),
(17,0,@SPELL_BLOWGUN,0,19,29327,0,0,0,'',"Spell To'kini's Blowgun can only be cast at Frost Leopard"),
(17,0,@SPELL_BLOWGUN,1,19,29319,0,0,0,'',"Spell To'kini's Blowgun can only be cast at Icepaw Bear");


-- ==>ZIGURATS REDES<====

-- Add support for {Q} A Tangled Skein ID: 12555
-- rewritten from sniff: thx Pitcrawler
SET @Sprayer :=       28274;
SET @Thrower :=       51165; -- Throws a web
SET @Summon :=        51314; -- Summons Broken Sprayer GO
SET @Explosion :=     53236; -- Explosion on fall
SET @Credit :=        28289; -- Kill Credit
SET @Trigger :=       29457; -- Trigger to permit explosion only when Sprayer reach him
SET @SpellTrigger :=  51173; -- A Tangled Skein: Encasing Webs - Effect that procs from @Thrower
SET @EncasingWebs :=  51168; -- The visual that A Tangled Skein: Encasing Webs - Effect should apply
SET @SummonTrigger := 54496;
SET @Script :=      2827400;
-- Add SAI support for Plague Sprayer
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@Sprayer; -- they shouldn't be attackable, but unit_flag 2 cause evade
UPDATE `creature_template` SET `AIName`='SmartAI',`InhabitType`=1 WHERE `entry`=@Trigger; -- need this to make trigger (while guardian) stay at ground
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@Sprayer,@Trigger) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Script AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Trigger,0,0,0,54,0,100,0,0,0,0,0,75,@EncasingWebs,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Plagued Sprayer - On just summoned - Cast Encasing Webs'),
(@Sprayer,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Plagued Sprayer - On spawn/reset - Set react state passive'),
(@Sprayer,0,1,0,8,0,100,1,@Thrower,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Plagued Sprayer - On spell hit by player with thrower - Store invoker as target'),
(@Sprayer,0,2,3,8,0,100,1,@SpellTrigger,0,0,0,11,@SummonTrigger,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Plagued Sprayer - On spell hit by item spell - Cast summon trigger'),
(@Sprayer,0,3,0,61,0,100,1,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Plagued Sprayer - Linked with previous event - Set run on'),
(@Sprayer,0,4,0,23,0,100,1,@EncasingWebs,1,0,0,69,1,0,0,0,0,0,19,@Trigger,20,0,0,0,0,0, 'Plagued Sprayer - On creature has aura Encasing Webs - Move to closest trigger in 20 yards'),
(@Sprayer,0,5,0,34,0,100,1,8,1,0,0,80,@Script,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Plagued Sprayer - On point 1 reached - Start action list'),
-- Script
(@Script,9,0,0,0,0,100,0,0,0,0,0,11,@Explosion,0,0,0,0,0,1,0,0,0,0,0,0,0,'Plagued Sprayer - Action 0 - Cast huge explosion on self'),
(@Script,9,1,0,0,0,100,0,300,300,0,0,33,@Credit,0,0,0,0,0,12,1,0,0,0,0,0,0,'Plagued Sprayer - Action 1 - Give credit to stored invoker'),
(@Script,9,2,0,0,0,100,0,0,0,0,0,11,@Summon,0,0,0,0,0,1,0,0,0,0,0,0,0,'Plagued Sprayer - Action 2 - Cast summon broken GO sprayer on self'), -- need small delay for the explosion to be displayed
(@Script,9,3,0,0,0,100,0,0,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Plagued Sprayer - Action 3 - Die'),
(@Script,9,4,0,0,0,100,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Plagued Sprayer - Action 4 - Set unseen');
-- Conditions
DELETE FROM `conditions` WHERE `SourceEntry`=@Thrower AND `SourceTypeOrReferenceId`=17;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(17,0,@Thrower,0,0,31,1,3,@Sprayer,0,0,0,'', 'Thrower can target only Plague Sprayer');
-- Delete wrong, nonexistant Trigger spawn
DELETE FROM `creature` WHERE `id`=@Trigger;
-- Update creature data for plague sprayers they should have movement type 0
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `id`=@Sprayer;

-- ===>BATALLA MOBS

UPDATE creature_template SET unit_flags=512 WHERE entry=27749 OR entry=27751;
UPDATE creature_template SET unit_flags=512 WHERE entry=27564 OR entry=27567;
UPDATE creature_template SET unit_flags=512 WHERE entry=27534;
