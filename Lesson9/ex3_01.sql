-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //

DROP FUNCTION IF EXISTS hello //
CREATE FUNCTION hello()
RETURNS VARCHAR(50) NOT DETERMINISTIC READS SQL DATA
BEGIN
  RETURN
	CASE
		WHEN TIME(NOW()) BETWEEN TIME('06:00') AND TIME('12:00') THEN "Доброе утро"
        WHEN TIME(NOW()) BETWEEN TIME('12:00') AND TIME('18:00') THEN "Добрый день"
        WHEN TIME(NOW()) BETWEEN TIME('18:00') AND TIME('00:00') THEN "Добрый вечер"
        WHEN TIME(NOW()) BETWEEN TIME('00:00') AND TIME('06:00') THEN "Доброй ночи"
	END;
END//

DELIMITER ;

SELECT TIME(NOW()), hello();