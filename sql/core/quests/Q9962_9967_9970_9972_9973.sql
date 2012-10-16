-- Fix Quest 9962,9967,9970,9972,9973
UPDATE `smart_scripts` SET `target_type`=16 WHERE `entryorguid`=18398 AND `id`=1; -- Brokentoe
UPDATE `smart_scripts` SET `target_type`=16 WHERE `entryorguid`=18399 AND `id`=4; -- Murkblood Twin
UPDATE `smart_scripts` SET `target_type`=16 WHERE `entryorguid`=18400 AND `id`=5; -- Rokdar the Sundered Lord
UPDATE `smart_scripts` SET `target_type`=16 WHERE `entryorguid`=18401 AND `id`=3; -- Skra'gath
UPDATE `smart_scripts` SET `id`=5,`link`=6,`target_type`=16 WHERE `entryorguid`=18402 AND `action_type`=15; -- Warmaul Champion
UPDATE `smart_scripts` SET `id`=6 WHERE `entryorguid`=18402 AND `action_type`=45; -- Warmaul Champion

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(18069, 0, 14, 0, 6, 0, 100, 0, 0, 0, 0, 0, 15, 9977, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Death - Give Quest Credit');