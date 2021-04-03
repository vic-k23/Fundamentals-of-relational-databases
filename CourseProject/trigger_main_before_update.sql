-- -------------------
-- Триггер добавляет запись в таблицу notes о прежней дате госпитализации при её изменении
-- ----------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS main_BEFORE_UPDATE;
DELIMITER //

CREATE TRIGGER `main_BEFORE_UPDATE` BEFORE UPDATE ON `main` FOR EACH ROW BEGIN
	IF OLD.gosp_date <> NEW.gosp_date THEN
		INSERT notes (gid, `type`, content, uid) VALUES (OLD.id, 2, CONCAT('Изменилась дата госпитализации! Прежняя дата: ', date_format(OLD.gosp_date, '%d.%m.%Y'), OLD.gosp_time), NEW.uid);
	END IF;
END//

DELIMITER ;