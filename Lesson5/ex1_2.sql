UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i') WHERE id <> 0;

ALTER TABLE users MODIFY created_at datetime, MODIFY updated_at datetime;

SELECT * FROM users;
