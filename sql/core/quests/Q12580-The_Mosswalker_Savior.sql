SET @ENTRY := 28113;
SET @SCRIPT1 := 2811301;
SET @SCRIPT2 := 2811302;
SET @SOURCETYPE := 0;
SET @SOURCETYPE2 := 9;
SET @GOSSIP := 9728;
SET @QUEST := 12580;
-- correct unit_flag
UPDATE `creature_template` SET `unit_flags`=33024 WHERE `entry`=@ENTRY;
-- creature-Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@ENTRY, 0, 0, 'Please take... my shinies. All done...', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Dead1'),
(@ENTRY, 0, 1, 'We not do anything... to them... I no understand.', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Dead2'),
(@ENTRY, 0, 2, 'Use my shinies... make weather good again... make undead things go away.', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Dead3'),
(@ENTRY, 0, 3, 'We gave shinies to shrine... we not greedy... why this happen?', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Dead4'),
(@ENTRY, 0, 4, 'I do something bad? I sorry...', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Dead5'),
(@ENTRY, 1, 0, 'We saved. You nice, dryskin.', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Saved1'),
(@ENTRY, 1, 1, 'Maybe you make weather better too?', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Saved2'),
(@ENTRY, 1, 2, 'You save us! Yay for you!', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Saved3'),
(@ENTRY, 1, 3, 'Thank you! You good!', 12, 0, 100, 0, 0, 0, 'Mosswalker Victim - Saved4');
-- Gossip-Condition
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `SourceTypeOrReferenceId`=15 ;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry` , `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3` , `ErrorTextId`, `ScriptName`, `Comment`)
VALUES (15, @GOSSIP, 0 , 0, 9, @QUEST, 0 , 0, 0 , 0, 'Only show gossip 9728 when quest 12580 is added');
-- SAI
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SCRIPT1 AND `source_type`=@SOURCETYPE2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SCRIPT2 AND `source_type`=@SOURCETYPE2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Random Timed_Action
(@ENTRY,@SOURCETYPE,0,1,62,0,100,0,9728,0,0,0,87,@SCRIPT1,@SCRIPT2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Gossip Select - Random Script Start"),
(@ENTRY,@SOURCETYPE,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Close Gossip"),
-- Death
(@SCRIPT1,@SOURCETYPE2,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Script 1 - Say"),
(@SCRIPT1,@SOURCETYPE2,1,0,0,0,100,0,2000,2000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script 1 - Die"),
-- Live
(@SCRIPT2,@SOURCETYPE2,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Script 2 - Say"),
(@SCRIPT2,@SOURCETYPE2,1,0,0,0,100,0,0,0,0,0,11,52157,0,0,0,0,0,7,0,0,0,0,0,0,0,"Script 1 - Credit"),
(@SCRIPT2,@SOURCETYPE2,2,0,0,0,100,0,5000,5000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script 1 - Despawn");