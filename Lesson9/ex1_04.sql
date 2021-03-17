-- Пусть имеется любая таблица с календарным полем created_at.
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS LOG;
CREATE TABLE LOG(
	id INT unsigned NOT NULL AUTO_INCREMENT,
    created_at DATETIME DEFAULT current_timestamp,
    PRIMARY KEY (id)
    );
    
INSERT LOG (created_at) VALUES ('2020-04-21'), ('2020-05-01'), ('2020-01-10'), ('2020-03-14'), ('2020-04-11'), ('2020-04-15'), ('2020-03-20'), ('2020-04-10'), ('2020-04-19'), ('2020-05-31'), ('2020-06-10'), ('2020-07-10'), ('2020-09-10');

DELETE FROM LOG WHERE id NOT IN (SELECT * FROM (SELECT lg.id FROM LOG AS lg ORDER BY lg.created_at DESC LIMIT 5) AS tbl);

SELECT * FROM LOG ORDER BY created_at;