-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT count(if(user_id in (SELECT user_id FROM vk.profile where gender='m'), 1, null)) as male, count(if(user_id in (SELECT user_id FROM vk.profile where gender='f'), 1, null)) as female FROM vk.like ;