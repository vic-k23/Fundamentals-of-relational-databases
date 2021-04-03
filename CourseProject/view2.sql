-- -----------------------------
-- План госпитализации на сегодня
-- ---------------------------------
DROP VIEW IF EXISTS hospitalization_plan_for_today;
CREATE VIEW hospitalization_plan_for_today AS
SELECT date_format(gosp_date, '%d.%m.%Y') AS gosp_date
	, gosp_time
    , concat(fname, ' ', sname, ' ', patronymic) AS fio
    , r.`name` AS region
    , op.`name` as operation
    , d.cod as diagnoze
    , vmp.cod as cod_vmp
    , (select content from notes where gid = m.id order by edit_time DESC limit 1) as note
from main as m
	left join patient as p on m.pid = p.id
    left join regions as r on p.region_id = r.id
    left join operacii as op on m.op_id = op.id
    left join diagnoz as d on m.diag_id = d.id
    LEFT JOIN codyvmp as vmp ON m.vmp_id = vmp.id
WHERE datediff(now(), gosp_date) = 0
	and state_id not in (2, 3)
ORDER BY operation, gosp_time, region_id, fio;