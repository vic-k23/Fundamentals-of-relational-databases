DROP TABLE IF EXISTS `shop`.`LOG`;

CREATE TABLE `shop`.`LOG` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `table_name` VARCHAR(45) NOT NULL,
  `table_pk` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS `shop`.`catalogs_AFTER_INSERT`;
DROP TRIGGER IF EXISTS `shop`.`products_AFTER_INSERT`;
DROP TRIGGER IF EXISTS `shop`.`users_AFTER_INSERT`;

DELIMITER $$
USE `shop`$$
-- catalogs
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`catalogs_AFTER_INSERT` AFTER INSERT ON `catalogs` FOR EACH ROW
BEGIN
	INSERT INTO `shop`.`LOG` (`table_name`, `table_pk`, `name`) VALUES ('catalogs', NEW.`id`, NEW.`name`);
END$$
-- products
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`products_AFTER_INSERT` AFTER INSERT ON `products` FOR EACH ROW
BEGIN
	INSERT INTO `shop`.`LOG` (`table_name`, `table_pk`, `name`) VALUES ('products', NEW.`id`, NEW.`name`);
END$$
-- users
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW
BEGIN
	INSERT INTO `shop`.`LOG` (`table_name`, `table_pk`, `name`) VALUES ('users', NEW.`id`, NEW.`name`);
END$$
DELIMITER ;

