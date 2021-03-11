-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT * FROM shop.users WHERE id IN (SELECT user_id FROM shop.orders WHERE user_id IS NOT NULL);