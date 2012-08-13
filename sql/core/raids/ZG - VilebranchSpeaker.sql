-- script for Vilebranch Speaker
DELETE FROM creature WHERE id='11391';
UPDATE creature_template SET AIName='', ScriptName='mob_Vilebranch_Speaker' WHERE entry='11391';