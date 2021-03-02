UPDATE users SET created_at = NOW(), updated_at = NOW() WHERE id <> 0;
SELECT * FROM shop.users;