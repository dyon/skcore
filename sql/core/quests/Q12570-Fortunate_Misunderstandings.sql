UPDATE `creature_template` SET `ainame`='SmartAI',`scriptname`='' WHERE `entry`=28217;

DELETE FROM `creature` WHERE `guid` IN(100983,101028,101029,101031);
DELETE FROM `script_texts` WHERE `npc_entry`=28217;
DELETE FROM `creature_text` WHERE `entry`=28217;
INSERT INTO `creature_text` VALUES
('28217','0','0','Let me know when you ready to go, okay?','12','0','0','0','0','0',''),
('28217','1','0','You save me! We thank you. We going to go back to village now. You come too... you can stay with us! Puppy-men kind of mean anyway. ','12','0','0','0','0','0',''),
('28217','2','0','Home time!','12','0','0','0','0','0','');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=9677 AND `id`=1;
INSERT INTO `gossip_menu_option` VALUES
('9677','1','0','I am ready to travel to your village now.','1','1','0','0','0','0','');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9677 AND `SourceEntry`=1;
INSERT INTO `conditions` VALUES
('15','9677','1','0','0','9','0','12570','0','0','0','0','','Only show gossip if quest 12570 is active');

DELETE FROM `script_waypoint` WHERE `entry`=28217;
DELETE FROM `waypoints` WHERE `entry`=28217;
INSERT INTO `waypoints` VALUES
('28217','1','5399.96','4509.07','-131.053',NULL),
('28217','2','5396.95','4514.84','-131.791',NULL),
('28217','3','5395.16','4524.06','-132.335',NULL),
('28217','4','5400.15','4526.84','-136.058',NULL),
('28217','5','5403.53','4527.2','-138.907',NULL),
('28217','6','5406.51','4527.47','-141.983',NULL),
('28217','7','5409.16','4526.37','-143.902',NULL),
('28217','8','5412.04','4523.05','-143.998',NULL),
('28217','9','5415.23','4521.19','-143.961',NULL),
('28217','10','5417.74','4519.74','-144.292',NULL),
('28217','11','5421.77','4519.79','-145.36',NULL),
('28217','12','5426.75','4520.53','-147.931',NULL),
('28217','13','5429.06','4521.82','-148.919',NULL),
('28217','14','5436.52','4534.63','-149.618',NULL),
('28217','15','5441.52','4542.23','-149.367',NULL),
('28217','16','5449.06','4553.47','-149.187',NULL),
('28217','17','5453.5','4565.61','-147.526',NULL),
('28217','18','5455.04','4578.6','-147.147',NULL),
('28217','19','5462.32','4591.69','-147.738',NULL),
('28217','20','5470.04','4603.04','-146.044',NULL),
('28217','21','5475.93','4608.86','-143.152',NULL),
('28217','22','5484.48','4613.78','-139.19',NULL),
('28217','23','5489.03','4616.56','-137.796',NULL),
('28217','24','5497.92','4629.89','-135.556',NULL),
('28217','25','5514.48','4638.82','-136.19',NULL),
('28217','26','5570','4654.5','-134.947',NULL),
('28217','27','5578.32','4653.29','-136.896',NULL),
('28217','28','5596.56','4642.26','-136.593',NULL),
('28217','29','5634.02','4600.35','-137.291',NULL);

DELETE FROM `smart_scripts` WHERE `entryorguid`=28217 AND `source_type`=0 AND `id`>1;
INSERT INTO `smart_scripts` VALUES
('28217','0','2','0','19','0','100','0','12570','0','0','0','1','0','0','0','0','0','0','1','0','0','0','0','0','0','0','On quest accept - say line 1'),
('28217','0','3','4','62','0','100','0','9677','1','0','0','53','1','28217','0','0','0','2','1','0','0','0','0','0','0','0','On gossip option select - Start WP'),
('28217','0','4','5','61','0','100','0','0','0','0','0','72','0','0','0','0','0','0','7','0','0','0','0','0','0','0','Link with event 3 - Close gossip'),
('28217','0','5','6','61','0','100','0','0','0','0','0','1','1','0','0','0','0','0','1','0','0','0','0','0','0','0','Link with event 4 - say line 2'),
('28217','0','6','0','61','0','100','0','0','0','0','0','83','1','0','0','0','0','0','1','0','0','0','0','0','0','0','Link with event 5 - Remove npc_flag 1'),
('28217','0','7','8','40','0','100','0','29','28217','0','0','1','2','0','0','0','0','0','1','0','0','0','0','0','0','0','On WP 28 reached - say line 3'),
('28217','0','8','9','61','0','100','0','0','0','0','0','41','7000','0','0','0','0','0','1','0','0','0','0','0','0','0','Link with event 7 - despawn'),
('28217','0','9','0','61','0','100','0','0','0','0','0','15','12570','0','0','0','0','0','18','25','0','0','0','0','0','0','Link with event 8 - give quest credit');