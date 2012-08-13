-- SELECT CONCAT('UPDATE creature_template SET mechanic_immune_mask = ', mechanic_immune_mask, ' WHERE entry IN (', entry, ', ', difficulty_entry_1, ', ', difficulty_entry_2, ', ', difficulty_entry_3, '); -- ', NAME) FROM creature_template WHERE entry IN (34780, 34497, 34496, 34564, 34797, 34799, 35144, 34796);

-- Trial of the Crusader
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (35144, 35511, 35512, 35513); -- Acidmaw
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34799, 35514, 35515, 35516); -- Dreadscale
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34797, 35447, 35448, 35449); -- Icehowl
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34796, 35438, 35439, 35440); -- Gormok the Impaler
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34496, 35347, 35348, 35349); -- Eydis Darkbane
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34497, 35350, 35351, 35352); -- Fjola Lightbane
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34564, 34566, 35615, 35616); -- Anub'arak
-- UPDATE creature_template SET mechanic_immune_mask = 0 WHERE -- entry = 34660;  Anub'arak spike
UPDATE creature_template SET mechanic_immune_mask = 617299803 WHERE entry IN (34780, 35216, 35268, 35269); -- Lord Jaraxxus