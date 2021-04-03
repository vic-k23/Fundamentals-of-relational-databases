DELIMITER //
DROP FUNCTION IF EXISTS create_random_phone_number//

CREATE FUNCTION create_random_phone_number()
RETURNS CHAR(12) NO SQL
BEGIN
	DECLARE i INT;
    DECLARE num CHAR(12);
    SET i = 10;
    SET num = '+7';
    REPEAT
		SET num = CONCAT(num, ROUND(RAND()*9));
		SET i = i - 1;
	UNTIL i <= 0 END REPEAT;
    RETURN num;
END//


DROP PROCEDURE IF EXISTS fill_phone_numbers//

CREATE PROCEDURE fill_phone_numbers()
BEGIN
	DECLARE rows_num INT;
	SELECT COUNT(id) + 321 INTO rows_num FROM patient;
    REPEAT
		INSERT INTO phone_numbers (pid, phone) VALUES ((SELECT id FROM patient ORDER BY rand() LIMIT 1), create_random_phone_number()) ON DUPLICATE KEY UPDATE  phone = create_random_phone_number();
        SET rows_num = rows_num - 1;
    UNTIL rows_num <= 0 END REPEAT;
END//
DELIMITER ;

CALL fill_phone_numbers();