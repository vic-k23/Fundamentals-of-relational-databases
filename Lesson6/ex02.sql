-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT 
	message.from_user_id as friend_id, 
    count(message.from_user_id) as cnt
from message 
where 
	message.to_user_id=80 
    and message.from_user_id in (SELECT IF(from_user_id = 80, to_user_id, from_user_id) AS friend_id
    FROM friend_request
    WHERE
      (from_user_id = 80 OR to_user_id = 80)
      AND `status` = 1) 
group by friend_id
order by cnt desc
limit 1;