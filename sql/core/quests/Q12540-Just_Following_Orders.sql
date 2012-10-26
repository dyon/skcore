-- [Q] Just Following Orders

-- Add Gossips (sniffs & github)
DELETE FROM `gossip_menu` WHERE `entry`=9677 AND `text_id`=13124;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9677,13124);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=9677;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9677,0,0, '<Reach down and pull the Injured Rainspeaker Oracle to its feet.>',1,1,0,0,0,0, '');

-- SAI
SET @ENTRY := 28217;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='', `gossip_menu_id`=9677 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(@ENTRY, 0, 0, 1, 62, 0, 100, 0, 9677, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Gossip Select - Close Gossip'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 28325, 6, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Gossip Select - Spawn npc 28325');

-- Add quest completer
DELETE FROM `creature_involvedrelation` WHERE `id`=28217 AND `quest`=12540;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(28217, 12540);

-- Conditions
DELETE FROM `conditions` WHERE `SourceGroup`=9677 AND `SourceTypeOrReferenceId`=15;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9677, 0, 0, 9, 12540, 0, 0, 0, '', 'Only show gossip if quest 12540 is active');