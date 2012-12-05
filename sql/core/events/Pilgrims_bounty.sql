UPDATE `game_event` SET `start_time`= '2012-12-08 01:00:00', `end_time`= '2012-12-22 01:00:00' WHERE `eventEntry`=26;

DELETE FROM `achievement_criteria_data` WHERE `type`=11 AND `criteria_id`=3693;
UPDATE `achievement_criteria_data` SET `ScriptName` = 'achievement_bg_control_all_nodes' WHERE `type` =11 AND `criteria_id` =3693;
-- Achievement: Pilgrims Peril
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11134,11135,11136,11137,11138,11139,11140,11141);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES
-- Alliance
(11134, 5, 66303, 0),   -- Orgrimmar
(11134, 6, 14, 0),      -- Orgrimmar
(11134, 16, 404, 0),    -- Orgrimmar
(11135, 5, 66303, 0),   -- Silvermoon City
(11135, 6, 3470, 0),    -- Silvermoon City
(11135, 16, 404, 0),    -- Silvermoon City
(11136, 5, 66303, 0),   -- Thunder Bluff
(11136, 6, 1638, 0),    -- Thunder Bluff
(11136, 16, 404, 0),    -- Thunder Bluff
(11137, 5, 66303, 0),   -- Undercity
(11137, 6, 1497, 0),    -- Undercity
(11137, 16, 404, 0),    -- Undercity
-- Horde
(11138, 5, 66303, 0),   -- Exodar
(11138, 6, 3557, 0),    -- Exodar
(11138, 16, 404, 0),    -- Exodar
(11139, 5, 66303, 0),   -- Darnassus
(11139, 6, 1657, 0),    -- Darnassus
(11139, 16, 404, 0),    -- Darnassus
(11140, 5, 66303, 0),   -- Ironforge
(11140, 6, 809, 0),     -- Ironforge
(11140, 16, 404, 0),    -- Ironforge
(11141, 5, 66303, 0),   -- Stormwind
(11141, 6, 12, 0),      -- Stormwind
(11141, 16, 404, 0);    -- Stormwind

-- Achievement: Now Were Cookin
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11118,11119,11120,11121,11122,11123,11124,11125,11126,11127);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES
-- Alliance
(11118, 16, 404, 0), -- Now Were Cookin / Cranberry Chutney
(11119, 16, 404, 0), -- Now Were Cookin / Candied Sweet Potato
(11120, 16, 404, 0), -- Now Were Cookin / Pumpkin Pie
(11121, 16, 404, 0), -- Now Were Cookin / Slow-Roasted Turkey
(11122, 16, 404, 0), -- Now Were Cookin / Spice Bread Stuffing
-- Horde
(11123, 16, 404, 0), -- Now Were Cookin / Candied Sweet Potato
(11124, 16, 404, 0), -- Now Were Cookin / Cranberry Chutney
(11125, 16, 404, 0), -- Now Were Cookin / Pumpkin Pie
(11126, 16, 404, 0), -- Now Were Cookin / Slow-Roasted Turkey
(11127, 16, 404, 0); -- Now Were Cookin / Spice Bread Stuffing

-- Achievement: Terokkar Turkey Time
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 11142;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES
(11142, 5, 66303, 0), -- Pilgrim Costume
(11142, 16, 404, 0);

-- Achievement: Pilgrim's Paunch
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11078,11079,11080,11081,11082,11083,11084,11085);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES
-- Alliance
(11078, 6, 1657, 0),  -- Darnassus
(11078, 16, 404, 0),  -- Darnassus
(11079, 6, 809, 0),   -- Ironforge
(11079, 16, 404, 0),  -- Ironforge
(11080, 6, 3557, 0),  -- Exodar
(11080, 16, 404, 0),  -- Exodar
(11081, 6, 12, 0),    -- Stormwind
(11081, 16, 404, 0),  -- Stormwind
-- Horde
(11082, 6, 14, 0),    -- Orgrimmar
(11082, 16, 404, 0),  -- Orgrimmar
(11083, 6, 3470, 0),  -- Silvermoon City
(11083, 16, 404, 0),  -- Silvermoon City
(11084, 6, 1638, 0),  -- Thunder Bluff
(11084, 16, 404, 0),  -- Thunder Bluff
(11085, 6, 1497, 0),  -- Undercity
(11085, 16, 404, 0);  -- Undercity

-- Achievement: "FOOD FIGHT!"
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11168,11178,11179,11180,11181);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(11168, 11, 0, 0, 'achievement_food_fight'),
(11168, 16, 404, 0, ''),
(11178, 11, 0, 0, 'achievement_food_fight'),
(11178, 16, 404, 0, ''),
(11179, 11, 0, 0, 'achievement_food_fight'),
(11179, 16, 404, 0, ''),
(11180, 11, 0, 0, 'achievement_food_fight'),
(11180, 16, 404, 0, ''),
(11181, 11, 0, 0, 'achievement_food_fight'),
(11181, 16, 404, 0, '');

-- Achievement: Sharing is Caring
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11086,11088,11089,11090,11167);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES
(11086, 16, 404, 0),
(11088, 16, 404, 0),
(11089, 16, 404, 0),
(11090, 16, 404, 0),
(11167, 16, 404, 0);

-- Pilgrims Bounty: Chair
DELETE FROM `creature_template_addon` WHERE `entry` IN (34823,34812,34824,34822,34819);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(34823, 0, 0, 0, 1, 0, '61793 61798'), -- The Cranberry Chair / (Cranberry Server | Can Eat - Cranberries)
(34812, 0, 0, 0, 1, 0, '61796 61801'), -- The Turkey Chair / (Turkey Server | Can Eat - Turkey)
(34824, 0, 0, 0, 1, 0, '61797 61802'), -- The Sweet Potato Chair / (Sweet Potatoes Server | Can Eat - Sweet Potatoes)
(34822, 0, 0, 0, 1, 0, '61794 61799'), -- The Pie Chair / (Pie Server | Can Eat - Pie)
(34819, 0, 0, 0, 1, 0, '61795 61800'); -- The Stuffing Chair / (Stuffing Server | Can Eat - Stuffing)

-- Achievement: The Turkinator
UPDATE `creature_template` SET `ScriptName` = 'npc_wild_turkey' WHERE `entry` =32820; -- Wild Turkey

-- Pilgrims Bounty: Chair
UPDATE `creature_template` SET `spell1`=66261, `spell2`=61784, `spell3`=61785, `spell4`=61788, `spell5`=61786, `spell6`=61787 WHERE `entry`=34823; -- The Cranberry Chair
UPDATE `creature_template` SET `spell1`=66250, `spell2`=61784, `spell3`=61785, `spell4`=61788, `spell5`=61786, `spell6`=61787 WHERE `entry`=34812; -- The Turkey Chair
UPDATE `creature_template` SET `spell1`=66259, `spell2`=61784, `spell3`=61785, `spell4`=61788, `spell5`=61786, `spell6`=61787 WHERE `entry`=34819; -- The Stuffing Chair
UPDATE `creature_template` SET `spell1`=66260, `spell2`=61784, `spell3`=61785, `spell4`=61788, `spell5`=61786, `spell6`=61787 WHERE `entry`=34822; -- The Pie Chair
UPDATE `creature_template` SET `spell1`=66262, `spell2`=61784, `spell3`=61785, `spell4`=61788, `spell5`=61786, `spell6`=61787 WHERE `entry`=34824; -- The Sweet Potato Chair

-- Item: Turkey Caller
UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35, `ScriptName` = 'npc_lonely_turkey' WHERE `entry` =32956; -- Lonely Turkey

-- Achievement: The Turkinator
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_turkey_tracker';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62014, 'spell_gen_turkey_tracker'); -- Turkey Tracker

-- Feast On Spells
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_feast_on';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(61784, 'spell_gen_feast_on'), -- Feast On Turkey
(61785, 'spell_gen_feast_on'), -- Feast On Cranberries
(61786, 'spell_gen_feast_on'), -- Feast On Sweet Potatoes
(61787, 'spell_gen_feast_on'), -- Feast On Pie
(61788, 'spell_gen_feast_on'); -- Feast On Stuffing

DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_gen_well_fed_pilgrims_bounty_ap',
'spell_gen_well_fed_pilgrims_bounty_zm',
'spell_gen_well_fed_pilgrims_bounty_hit',
'spell_gen_well_fed_pilgrims_bounty_haste',
'spell_gen_well_fed_pilgrims_bounty_spirit');

INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(61807, 'spell_gen_well_fed_pilgrims_bounty_ap'),     -- A Serving of Turkey
(61804, 'spell_gen_well_fed_pilgrims_bounty_zm'),     -- A Serving of Cranberries
(61806, 'spell_gen_well_fed_pilgrims_bounty_hit'),    -- A Serving of Stuffing
(61808, 'spell_gen_well_fed_pilgrims_bounty_haste'),  -- A Serving of Sweet Potatoes
(61805, 'spell_gen_well_fed_pilgrims_bounty_spirit'); -- A Serving of Pie

DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_gen_on_plate_pilgrims_bounty_turkey',
'spell_gen_on_plate_pilgrims_bounty_cranberries',
'spell_gen_on_plate_pilgrims_bounty_stuffing',
'spell_gen_on_plate_pilgrims_bounty_sweet_potatoes',
'spell_gen_on_plate_pilgrims_bounty_pie');

INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(66250, 'spell_gen_on_plate_pilgrims_bounty_turkey'),            -- Pass The Turkey
(66261, 'spell_gen_on_plate_pilgrims_bounty_cranberries'),       -- Pass The Cranberries
(66259, 'spell_gen_on_plate_pilgrims_bounty_stuffing'),          -- Pass The Stuffing
(66262, 'spell_gen_on_plate_pilgrims_bounty_sweet_potatoes'),    -- Pass The Sweet Potatoes
(66260, 'spell_gen_on_plate_pilgrims_bounty_pie');               -- Pass The Pie

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_bountiful_feast';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66477, 'spell_gen_bountiful_feast'); -- Bountiful Feast

DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_gen_slow_roasted_turkey',
'spell_gen_cranberry_chutney',
'spell_gen_spice_bread_stuffing',
'spell_gen_pumpkin_pie',
'spell_gen_candied_sweet_potato');

INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(65422, 'spell_gen_slow_roasted_turkey'),   -- Slow-Roasted Turkey
(65420, 'spell_gen_cranberry_chutney'),     -- Cranberry Chutney
(65419, 'spell_gen_spice_bread_stuffing'),  -- Spice Bread Stuffing
(65421, 'spell_gen_pumpkin_pie'),           -- Pumpkin Pie
(65418, 'spell_gen_candied_sweet_potato');  -- Candied Sweet Potato

-- Temp Hack Fixes
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (32823,32830,32840);
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (32823,32830,32840);

UPDATE `creature_template` SET `modelid2` = '0', `speed_walk` = '0', `speed_run` = '0' WHERE `entry` IN (34823,34812,34824,34822,34819);