-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55

DROP FUNCTION IF EXISTS FIBONACCI;

DELIMITER //
CREATE FUNCTION FIBONACCI (n INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE a, b, i, temp INT;
    SET a = 0, b = 1, i = 0, temp = 0;
    WHILE i < n DO
		SET temp = a + b;
        SET a = b;
        SET b = temp;
		SET i = i + 1;
	END WHILE;
    RETURN a;
END//
DELIMITER ;

SELECT FIBONACCI(10);