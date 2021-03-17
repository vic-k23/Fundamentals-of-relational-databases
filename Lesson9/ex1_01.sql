-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
UPDATE sample.users SET
	`name` = (SELECT `name` FROM shop.users WHERE `id`=1),
    `birthday_at` = (SELECT `birthday_at` FROM shop.users WHERE `id`=1),
    `created_at` = (SELECT `created_at` FROM shop.users WHERE `id`=1)
WHERE `id`=1;
DELETE FROM shop.users WHERE `id`=1;
COMMIT;