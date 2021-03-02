-- CREATE TABLE tbl (
-- 	idtbl INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     PRIMARY KEY (idtbl))

-- INSERT INTO `shop`.`tbl`
-- ()
-- VALUES (), (), (), (), ();


SELECT round(exp(SUM(log(idtbl)))) AS `product` FROM shop.tbl;