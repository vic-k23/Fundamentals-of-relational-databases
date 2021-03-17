--  Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбцам id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts(
	`id` INT NOT NULL AUTO_INCREMENT, 
    `name` CHAR(10) comment "Имя пользователя", 
    `password` CHAR(255) comment "Хэш пароля пользователя",
    PRIMARY KEY (`id`));
    
DROP VIEW IF EXISTS username;
CREATE VIEW username AS SELECT `id`, `name` FROM accounts;

DROP USER IF EXISTS 'user_read'@'localhost';
CREATE USER 'user_read'@'localhost' IDENTIFIED BY 'passw';
GRANT SELECT ON username TO 'user_read'@'localhost';