-- скрипты характерных выборок
use gosp;

--
-- Список пациентов, дата госпитализации которых запланирована в текущем месяце
--
SELECT 
	doc_date
    , talon_num
    , gosp_date
    , gosp_time
    , d.cod AS diagnoze
    , op.`name` AS operation
    , dep.`name` AS department
    , CONCAT(fname, ' ', sname, ' ', patronymic) AS fio
    , r.`name` AS region
    , s.state
FROM main as m
	LEFT JOIN patient AS p ON m.pid = p.id
    LEFT JOIN regions AS r ON p.region_id = r.id
    LEFT JOIN diagnoz AS d ON m.diag_id = d.id
    LEFT JOIN operacii AS op ON m.op_id = op.id
    LEFT JOIN otdelenie AS dep ON m.dep_id = dep.id
    LEFT JOIN statusy AS s ON m.state_id = s.id
WHERE MONTH(gosp_date) = MONTH(NOW())
	AND talon_num IS NOT NULL -- выберем только пациентов, на которых оформлен талон квоты
ORDER BY gosp_date, gosp_time, fio
LIMIT 5000;

--
-- Подсчёт выполненных операций в 2020 году с группировкой по операциям и разбивкой по месяцам
--
 SELECT
	op.`name` AS operation
    , COUNT(IF(MONTH(gosp_date) = 1, m.op_id, NULL)) AS jan
    , COUNT(IF(MONTH(gosp_date) = 2, m.op_id, NULL)) AS feb
    , COUNT(IF(MONTH(gosp_date) = 3, m.op_id, NULL)) AS mar
    , COUNT(IF(MONTH(gosp_date) = 4, m.op_id, NULL)) AS apr
    , COUNT(IF(MONTH(gosp_date) = 5, m.op_id, NULL)) AS may
    , COUNT(IF(MONTH(gosp_date) = 6, m.op_id, NULL)) AS jun
    , COUNT(IF(MONTH(gosp_date) = 7, m.op_id, NULL)) AS jul
    , COUNT(IF(MONTH(gosp_date) = 8, m.op_id, NULL)) AS aug
    , COUNT(IF(MONTH(gosp_date) = 9, m.op_id, NULL)) AS sep
    , COUNT(IF(MONTH(gosp_date) = 10, m.op_id, NULL)) AS oct
    , COUNT(IF(MONTH(gosp_date) = 11, m.op_id, NULL)) AS nov
    , COUNT(IF(MONTH(gosp_date) = 12, m.op_id, NULL)) AS `dec`
    , COUNT(m.id) AS operations_count
FROM main AS m
	LEFT JOIN operacii AS op ON m.op_id = op.id
WHERE YEAR(gosp_date) = 2020
	AND m.state_id = 4
GROUP BY op.`name`
WITH ROLLUP;


--
-- Список пациентов, чья госпитализация запланирована через 14 дней. Обычно используется для обзвона, с целью подтвердить приезд.
--
SELECT
	DATE_FORMAT(gosp_date, '%d.%m.%Y') as gosp_date
    , gosp_time
    , CONCAT(fname, ' ', sname, ' ', patronymic) AS fio
    , r.`name` AS region
    , phone
    , note
    , d.cod AS diagnoze
    , op.`name` AS operation
FROM main as m
	LEFT JOIN patient AS p ON m.pid = p.id
    LEFT JOIN phone_numbers AS ph ON p.id = ph.pid
    LEFT JOIN regions AS r ON p.region_id = r.id
    LEFT JOIN diagnoz AS d ON m.diag_id = d.id
    LEFT JOIN operacii AS op ON m.op_id = op.id
WHERE DATEDIFF(NOW(), gosp_date) = 14
ORDER BY gosp_date, gosp_time, fio
LIMIT 5000;