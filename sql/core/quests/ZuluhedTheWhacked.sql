-- Fix quest 10866 Zuluhed the Whacked
UPDATE `quest_template` SET `RequiredNpcOrGo1` = -185156, `RequiredSpellCast1` = 0 WHERE `Id` = 10866;