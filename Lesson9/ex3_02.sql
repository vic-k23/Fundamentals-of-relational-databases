-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.


DELIMITER //

DROP TRIGGER IF EXISTS `shop`.`products_BEFORE_INSERT`//

CREATE TRIGGER `shop`.`products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW
BEGIN
	IF NEW.`name` IS NULL AND NEW.`description` IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Поля name и description не могут одновременно быть пустыми!";
	END IF;
END//

DELIMITER ;

INSERT INTO `shop`.`products`
(`name`, `description`, `price`, `catalog_id`)
VALUES
(NULL, 'description of something', 0.0, 1);

INSERT INTO `shop`.`products`
(`name`, `description`, `price`, `catalog_id`)
VALUES
('Noname', NULL, 1000.0, 3);

INSERT INTO `shop`.`products`
(`name`, `description`, `price`, `catalog_id`)
VALUES
(NULL, NULL, 0.0, 1);

SELECT * FROM `shop`.`products`;