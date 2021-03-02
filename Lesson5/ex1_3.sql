-- INSERT INTO `shop`.`storehouses_products`
-- (`storehouse_id`, `product_id`, `value`)
-- VALUES
-- (1, 1, 3),
-- (2, 3, 30),
-- (2, 6, 0),
-- (3, 4, 50),
-- (4, 5, 0);

SELECT * FROM shop.storehouses_products order by IF(value > 0, value, 99999999999);