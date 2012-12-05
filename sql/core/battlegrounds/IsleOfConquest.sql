-- Fix Isle of Conquest - Teleports
UPDATE `spell_linked_spell` SET `spell_effect` = 66551 WHERE `spell_trigger` IN (66549, 66548);
UPDATE `spell_linked_spell` SET `spell_trigger` = 66551 WHERE `spell_effect` IN (-66548, -66549);