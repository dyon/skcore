-- Antipersonnel cannons Strand of the Ancients
UPDATE `creature_template` SET `mechanic_immune_mask` = 75507760, `RegenHealth` = 0 WHERE `entry` IN (27894,32795);

-- Battleground Demolishers strand of the ancients
UPDATE `creature_template` SET `mechanic_immune_mask` = 377831290, `RegenHealth` = 0 WHERE `entry` IN (28781,32796);