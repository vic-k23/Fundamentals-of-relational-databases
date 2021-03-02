SELECT `name`,
	birthday_at,
	CASE
		WHEN MONTH(birthday_at) = 5 THEN 'may' 
        WHEN MONTH(birthday_at) = 8 THEN 'august'
	END AS birthday_month
FROM shop.users
WHERE MONTH(birthday_at) IN (5, 8)
ORDER BY birthday_at;