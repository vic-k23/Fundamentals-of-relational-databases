-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(cnt) FROM (SELECT vk.like.user_id, count(*) as cnt FROM vk.like where vk.like.user_id in (SELECT * FROM (SELECT user_id FROM vk.profile order by vk.profile.birthday desc limit 10) as ten) group by user_id) as t;