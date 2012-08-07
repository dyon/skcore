DELETE FROM spell_area WHERE spell IN (73822, 73828);
/*INSERT INTO spell_area (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES
(73822, 4812, 0, 0, 0, 0, 690, 2, 1),
(73828, 4812, 0, 0, 0, 0, 1101, 2, 1);*/

/*-- Difficulty: 5 / 10 / 15 / 20 / 25 / 30
-- Strength of Wrynn (Alliance)
-- 73762, 73824, 73825, 73826, 73827, 73828
SET @alliance := 73824;

-- Hellscream's Warsong (Horde)
-- 73816, 73818, 73819, 73820, 73821, 73822
SET @horde := 73818;

-- Area: Icecrown Citadel
SET @area := 4812;
DELETE FROM `spell_area` WHERE area = @area AND spell IN (73762, 73824, 73825, 73826, 73827, 73828);
DELETE FROM `spell_area` WHERE area = @area AND spell IN (73816, 73818, 73819, 73820, 73821, 73822);
INSERT INTO spell_area (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES
(@alliance, @area, 0, 0, 0, 0, 1101, 2, 1),
(@horde, @area, 0, 0, 0, 0, 690, 2, 1);*/