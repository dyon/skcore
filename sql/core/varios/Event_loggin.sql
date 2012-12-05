INSERT IGNORE INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`, `world_event`) VALUES('210','2012-12-24 23:59:00','2012-12-25 23:59:00','14400','14400','0','Aniversario Silver Kninghts','0');

ALTER TABLE `custom_texts` CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci; 

DELETE FROM `custom_texts` WHERE 'entry'=-2000001;
INSERT IGNORE INTO `custom_texts` (`entry`, `content_default`) VALUES('-2000001',
'
Gracias por confiar en nosotros un años más. Gracias por formar parte de nosotros día a día y crecer juntos.
Muchas sorpresas y novedades nos esperan de ahora en adelante. Esperamos descubrirlas junto a vosotros.
Esperamos que esta mascota os acompañe en vuestras andanzas por Azeroth.
Staff de Silver Knights.
');