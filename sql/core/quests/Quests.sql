-- Quest: Un asunto grimoso

SET @ENTRY := 22911;
/*Actualizando Creature_Template para ejecutar Smart Scripts*/
UPDATE creature_template 
SET AIName='SmartAI', ScriptName=''
WHERE entry= @ENTRY;

/*Insertando datos en Smar Scripts*/
DELETE FROM smart_scripts WHERE entryorguid= @ENTRY;
INSERT INTO `smart_scripts` VALUES(@ENTRY,'0','0','0','6','0','100','0','0','0','0','0','11','39862','3','0','0','0','0','1','0','0','0','0','0','0','0','Vim\'gol el Vil - On Death - Summon Grimorio de Vim\'gol el Vil');

/*Actualizando el GameObject*/
UPDATE gameobject_template 
SET flags=4
WHERE entry=185562;

/*Insertando las Condiciones en la que aparece el Grimorio, solamente si el pj tiene la quest*/
DELETE FROM Conditions WHERE sourceentry=22911 AND SourceTypeOrReferenceId=22;
INSERT INTO Conditions VALUES 
(22,1,@ENTRY,0,0,9,0,10998,0,0,0,0,'','Execute Summon Object Only If Player has Quest taken');

-- Quest: El foco de la playa
SELECT * FROM item_template WHERE entry=36751;

UPDATE item_template
SET spellid_2=50546
WHERE entry=36751;

DELETE FROM spell_scripts WHERE id=50546;
INSERT INTO spell_scripts VALUES
(50546,0,3,8,26773,0,0,0,0,0,0);

-- Fin del Fix

-- Quest: En lo alto del bosque
UPDATE item_template
SET spellid_2=50547
WHERE entry=36779;

DELETE FROM spell_scripts WHERE id=50547;
INSERT INTO spell_scripts VALUES
(50547,0,3,8,26831,0,0,0,0,0,0);

-- Fin del Fix
 
-- Quest: El final de la línea
UPDATE item_template
SET spellid_2=50548
WHERE entry=36815;

SELECT * FROM spell_scripts WHERE id=50548
DELETE FROM spell_scripts WHERE id=50548;

INSERT INTO spell_scripts VALUES
(50548,0,3,8,26887,0,0,0,0,0,0);

UPDATE creature_Template 
SET AIName='', ScriptName=''
WHERE entry=26889;

DELETE FROM areatrigger_scripts WHERE entry=4956;
INSERT INTO areatrigger_scripts
VALUES (4956,'SmartTrigger');

DELETE FROM smart_scripts WHERE EntryorGuid=4956;
INSERT INTO smart_scripts
VALUES (4956,2,0,0,46,0,100,0,4956,0,0,0,33,26889,0,0,0,0,0,7,0,0,0,0,0,0,0,'Areatrigger The END of the Line - On Trigger - Quest Credit')

-- Fin del Fix