-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT `products`.`name`, `description`, `price`, `catalogs`.`name` FROM products LEFT JOIN catalogs ON products.catalog_id = catalogs.id;