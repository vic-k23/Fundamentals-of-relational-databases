-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

SELECT (SELECT `name` FROM cities WHERE `label`=`from`) AS `from`, (SELECT `name` FROM cities WHERE `label`=`to`) AS `to` FROM lesson7.flights;