SET @NPC = 80005;

DELETE FROM `creature_template` WHERE `entry` = @NPC;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `faction_A`, `faction_H`, `npcflag`, `unit_class`, `type`, `ScriptName`) VALUES
(@NPC, '10913', 'Samohung', 'Arena spectator', '35', '35', '1', '1', '7', 'npc_arena_watcher');

DELETE FROM `creature_text` WHERE `entry` = @NPC;
INSERT INTO `creature_text` (`entry`, `groupid`, `text`, `type`, `comment`) VALUES
(@NPC, '0', 'Sorry matches at the moment there is no', '15', 'ArenaWatcher'),
(@NPC, '1', 'The match has been completed', '15', 'ArenaWatcher'),
(@NPC, '2', 'Target is offline', '15', 'ArenaWatcher'),
(@NPC, '3', 'Target not in arena', '15', 'ArenaWatcher'),
(@NPC, '4', 'Target is GameMaster', '15', 'ArenaWatcher');


DELETE FROM `trinity_string` WHERE `entry` BETWEEN 11200 AND 11203;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
('11200', 'Watch the match 2x2 (now games: %u)'),
('11201', 'Watch the match 3x3 (now games: %u)'),
('11202', 'Watch the match 5x5 (now games: %u)'),
('11203', 'Follow player');