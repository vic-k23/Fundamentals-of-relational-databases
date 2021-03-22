-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

USE `shop`;
DROP procedure IF EXISTS `add_million_users`;

DELIMITER $$
USE `shop`$$
CREATE PROCEDURE `add_million_users` ()
BEGIN
	START TRANSACTION;
		SET @x = 0;
		REPEAT 
			SET @x = @x + 1;
			INSERT INTO users (`name`, `birthday_at`) VALUES (CONCAT('user', @x), '1981-03-02');
		UNTIL @x > 1000000 END REPEAT;
	COMMIT;
END$$

DELIMITER ;

CALL add_million_users();

SELECT COUNT(id) FROM shop.users;