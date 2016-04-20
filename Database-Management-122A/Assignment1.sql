
CREATE DATABASE IF NOT EXISTS `UCA` DEFAULT CHARACTER SET latin1;
USE `UCA`;
SET FOREIGN_KEY_CHECKS=0;

-- ENTITY SETS
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `dishOrder`;
DROP TABLE IF EXISTS `credit_card`;
DROP TABLE IF EXISTS `lounge`;
DROP TABLE IF EXISTS `dish`;

SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE customer(
cid INTEGER,
SSN INTEGER,
gender VARCHAR(7),
email VARCHAR(40),
addr_street VARCHAR(40),
addr_city VARCHAR(40),
addr_state VARCHAR(15),
addr_zipcode CHAR(5),
PRIMARY KEY (cid)
);
CREATE TABLE credit_card(
cid INTEGER,
expr_date CHAR(7),
card_num CHAR(16),
PRIMARY KEY (cid),
FOREIGN KEY (cid) references customer(cid) ON DELETE CASCADE
);
CREATE TABLE dishOrder(
did INTEGER,
cid INTEGER NOT NULL,
total_amount DEC(4,2),
order_datetime DATETIME,
FOREIGN KEY (cid) references customer(cid) ON DELETE NO ACTION,
PRIMARY KEY (did)
);
CREATE TABLE lounge(
lid INTEGER,
lounge_location VARCHAR(15)

);
