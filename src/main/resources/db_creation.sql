create database marketplace_product;
\c marketplace_product;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SET timezone TO 'UTC';
CREATE USER market_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON database marketplace_product TO market_user;