/* Quest: Reinar en los cielos (Montañas FiloEspada)
http://es.wowhead.com/quest=11078 */;

DELETE FROM Smart_scripts WHERE entryorguid IN (185932,185936,185937,185938);
INSERT INTO `Smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES('185932','1','0','0','62','0','100','0','8685','0','0','0','12','23282','1','360000','0','0','0','8','0','0','0','2421.88','6986.83','368.447','1.11764','Obsidia\'s Egg - On Gossip Select - Summon Obsidia'),
VALUES('185932','1','1','0','62','0','100','0','8685','0','0','0','57','32569','35','0','0','0','0','7','0','0','0','0','0','0','0','Obsidia\'s Egg - On Gossip Select - Delete Item Used'),
VALUES('185936','1','0','0','62','0','100','0','8689','0','0','0','12','23061','1','360000','0','0','0','8','0','0','0','2078.1','7388.1','372.651','3.99922','Rivendark\'s Egg - On Gossip Select - Summon Rivendark'),
VALUES('185936','1','1','0','62','0','100','0','8689','0','0','0','57','32569','35','0','0','0','0','7','0','0','0','0','0','0','0','Rivendark\'s Egg - On Gossip Select - Delete Item Used'),
VALUES('185937','1','0','0','62','0','100','0','8690','0','0','0','12','23261','1','360000','0','0','0','8','0','0','0','3873.86','5225.33','270.782','0.182405','Furywing\'s Egg - On Gossip Select - Summon Furywing'),
VALUES('185937','1','1','0','62','0','100','0','8690','0','0','0','57','32569','35','0','0','0','0','7','0','0','0','0','0','0','0','Furywing\'s Egg - On Gossip Select - Delete Item Used'),
VALUES('185938','1','0','0','62','0','100','0','8691','0','0','0','12','23281','1','360000','0','0','0','8','0','0','0','4150.23','5432.7','274.451','2.30896','Insidion\'s Egg - On Gossip Select - Summon Insidion'),
VALUES('185938','1','1','0','62','0','100','0','8691','0','0','0','57','32569','35','0','0','0','0','7','0','0','0','0','0','0','0','Insidion\'s Egg - On Gossip Select - Delete Item Used');


UPDATE GameObject_Template
SET AIName='SmartGameObjectAI', ScriptName=''
WHERE ENTRY IN (185932,185936,185937,185938);
