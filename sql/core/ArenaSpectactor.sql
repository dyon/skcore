DELETE FROM `trinity_string` WHERE `entry` BETWEEN 11610 AND 11616;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(11610, 'Player %s forbided you to watch his arena match.'),
(11611, 'Player %s is not a member of arena match.'),
(11612, 'You should not be a member of arena or battleground match.'),
(11613, 'You already have a spectator state.'),
(11614, 'Arena spectators system disabled.'),
(11615, 'You cannot use chat while you are a spectator.'),
(11616, 'You should not have pet while you are a spectator.');

DELETE FROM `command` WHERE `name` = 'spectate player';
INSERT INTO `command` VALUES ('spectate player', 0, 'Syntax: .spectate player $player\r\n\r\nMakes you a spectator of arena match with $player');