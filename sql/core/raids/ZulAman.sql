DELETE FROM `gossip_menu` WHERE `entry`=8932 AND `text_id`=11943;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES (8932,11943);
UPDATE `creature_template` SET `gossip_menu_id` = 8932, `ScriptName` = "npc_harrison_jones_za" WHERE `entry` = 24358;
UPDATE `gameobject_template` SET `ScriptName` = "go_strange_gong" WHERE `entry` = 187359;

INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1568079,'Suit yourself. At least five of you must assist me if we\'re to get inside. Follow me.',0,1,0,0,'harrison SAY_START'),
(-1568080,'According to my calculations, if enough of us bang the gong at once the seal on these doors will break and we can enter.',0,1,0,0,'harrison SAY_AT_GONG'),
(-1568081,'I\'ve researched this site extensively and I won\'t allow any dim-witted treasure hunters to swoop in and steal what belongs to in a museum. I\'ll lead this charge.',0,1,0,0,'harrison SAY_OPEN_ENTRANCE'),
(-1568082,'In fact, it would be best if you just stay here. You\'d only get in my way....',0,1,0,0,'harrison SAY_OPEN_GATE'),
(-1568068,'Da spirits gonna feast today! Begin da ceremonies, sacrifice da prisoners... make room for our new guests!',12053,1,0,0,'zulaman SAY_INST_BEGIN');

DELETE FROM script_waypoint WHERE entry=24358;
INSERT INTO script_waypoint VALUES
(24358, 0, 121.193970, 1645.619385, 42.021, 0, ''),
(24358, 1, 132.051468, 1642.176025, 42.021, 10000, 'SAY_AT_GONG'),
(24358, 2, 120.670631, 1636.346802, 42.415, 0, ''),
(24358, 3, 120.536003, 1611.654663, 43.473, 10000, 'SAY_OPEN_ENTRANCE'),
(24358, 4, 120.536003, 1611.654663, 43.473, 0, '');

UPDATE `gameobject_template` SET `faction` = 0, `flags` = 0, `data0` = 57, `data2` = 0 WHERE  `entry` IN (186648, 187021, 186672, 186667);