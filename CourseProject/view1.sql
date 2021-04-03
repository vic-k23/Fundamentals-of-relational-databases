-- -----------------------------------------------
-- Представление Отчёт по видам оплаты за год по месяцам
-- -----------------------------------------------
DROP VIEW IF EXISTS VMP_report;
CREATE VIEW VMP_report AS
SELECT g.cod AS `group_cod`
	, vmp.cod AS `vmp_cod`
    , vmp.`description`
    , COUNT(IF(MONTH(gosp_date) = 1, m.id, NULL)) AS jan
    , COUNT(IF(MONTH(gosp_date) = 2, m.id, NULL)) AS feb
    , COUNT(IF(MONTH(gosp_date) = 3, m.id, NULL)) AS mar
    , COUNT(IF(MONTH(gosp_date) = 4, m.id, NULL)) AS apr
    , COUNT(IF(MONTH(gosp_date) = 5, m.id, NULL)) AS may
    , COUNT(IF(MONTH(gosp_date) = 6, m.id, NULL)) AS jun
    , COUNT(IF(MONTH(gosp_date) = 7, m.id, NULL)) AS jul
    , COUNT(IF(MONTH(gosp_date) = 8, m.id, NULL)) AS aug
    , COUNT(IF(MONTH(gosp_date) = 9, m.id, NULL)) AS sep
    , COUNT(IF(MONTH(gosp_date) = 10, m.id, NULL)) AS oct
    , COUNT(IF(MONTH(gosp_date) = 11, m.id, NULL)) AS nov
    , COUNT(IF(MONTH(gosp_date) = 12, m.id, NULL)) AS `dec`
FROM main AS m
	LEFT JOIN codyvmp AS vmp ON m.vmp_id = vmp.id
    LEFT JOIN vmp_groups AS g ON vmp.group_id = g.id
WHERE YEAR(gosp_date) = 2020
	AND state_id = 4
GROUP BY g.cod, vmp.cod, vmp.`description`
HAVING (g.cod IS NOT NULL AND vmp.cod IS NOT NULL AND vmp.`description` IS NOT NULL);