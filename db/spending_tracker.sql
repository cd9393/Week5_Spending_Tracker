DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE tags(
  id SERIAL8 PRIMARY KEY,
  category VARCHAR(255),
  budget INT4
);

CREATE TABLE merchants(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL8 PRIMARY KEY,
  amount DECIMAL(10,2),
  transaction_date date,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE
)
