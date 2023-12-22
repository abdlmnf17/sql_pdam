-- 1. Pelanggan yang tidak membuat pesanan
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- 2. Total banyak pembelian yang dilakukan oleh setiap pelanggan
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_pembelian
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 3. Pelanggan yang pernah melakukan pesanan dengan setidaknya dua salesman
SELECT c.customer_id, c.customer_name
FROM customers c
INNER JOIN (
    SELECT o.customer_id
    FROM orders o
    INNER JOIN (
        SELECT customer_id, COUNT(DISTINCT salesman_id) AS num_salesmen
        FROM orders
        GROUP BY customer_id
        HAVING num_salesmen >= 2
    ) sub ON o.customer_id = sub.customer_id
) sub2 ON c.customer_id = sub2.customer_id;

-- 4. Nama pelanggan beserta total banyak pesanan yang dilakukan, urutkan berdasarkan banyak pesanannya
SELECT c.customer_name, COUNT(o.order_id) AS total_pesanan
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_pesanan DESC;

-- 5. Salesman dengan komisi tertinggi beserta komisinya
SELECT salesman_name, comission
FROM salesman
ORDER BY comission DESC
LIMIT 1;
