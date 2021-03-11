-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT 
	user_id, 
    CONCAT(firstname, ' ', lastname) AS fio, 
    birthday, 
    gender,
    (
		(SELECT COUNT(*) FROM message WHERE message.from_user_id=p.user_id)+
        (SELECT COUNT(*) FROM vk.like WHERE vk.like.user_id = p.user_id)+
        (SELECT COUNT(*) FROM vk.post WHERE vk.post.user_id=p.user_id)
    ) AS activity
FROM vk.profile AS p
ORDER BY activity
LIMIT 10;