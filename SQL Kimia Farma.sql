CREATE OR REPLACE TABLE kimia_farma.tabel_analisa AS (
  Select
  -- Kolom tabel yang wajib ada
  t. transaction_id,
  t. date,
  c. branch_id,
  c. branch_name,
  c. kota,
  c. provinsi,
  c. rating AS rating_cabang,
  t. customer_name,
  p. product_id,
  p. product_name,
  t. price AS actual_price,
  t. discount_percentage,

-- Kolom persenase gross laba
CASE
WHEN t. price <= 5000 THEN 0.10
WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
WHEN t.price > 500000 THEN 0.30
END AS persentase_gross_laba,

(t. price * (1 - t. discount_percentage)) AS nett_sales, -- Kolom nett sales

(t. price * (1 - t. discount_percentage)) * (
  CASE
WHEN t.price <= 50000 THEN 0.10
WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
WHEN t.price > 500000 THEN 0.30
END) AS nett_profit,

t. rating AS rating_transaksi,


  FROM `rakamin-kf-analytics-476513.kimia_farma.kf_final_transaction` AS t LEFT JOIN `rakamin-kf-analytics-476513.kimia_farma.kf_kantor_cabang` AS c ON t.branch_id = c.branch_id
  LEFT JOIN `rakamin-kf-analytics-476513.kimia_farma.kf_product` AS p ON t.product_id = p.product_id

 );