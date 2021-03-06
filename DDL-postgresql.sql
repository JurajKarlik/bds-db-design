
CREATE SCHEMA IF NOT EXISTS mydb ;
SET SCHEMA 'mydb' ;


CREATE SEQUENCE mydb.membership_seq;

CREATE TABLE IF NOT EXISTS mydb.membership (
  id_membership INT NOT NULL DEFAULT NEXTVAL ('mydb.membership_seq'),
  membership_type VARCHAR(10) NOT NULL,
  date_of_creation DATE NULL,
  date_of_expiration DATE NULL,
  bonus_discount VARCHAR(45)  NOT NULL,
  PRIMARY KEY (id_membership),
  CONSTRAINT id_membership_UNIQUE UNIQUE (id_membership) )
;



CREATE SEQUENCE mydb.user_type_seq;

CREATE TABLE IF NOT EXISTS mydb.user_type (
  id_user_type INT NOT NULL DEFAULT NEXTVAL ('mydb.user_type_seq'),
  user_type VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_user_type),
  CONSTRAINT id_user_type_UNIQUE UNIQUE (id_user_type) )
;



CREATE SEQUENCE mydb.user_seq;

CREATE TABLE IF NOT EXISTS mydb.user (
  id_user INT NOT NULL DEFAULT NEXTVAL ('mydb.user_seq'),
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(6) NOT NULL,
  id_membership INT NOT NULL,
  newsletter_subscription SMALLINT NOT NULL,
  login VARCHAR(30) NULL,
  password VARCHAR(64) NULL,
  id_user_type INT NOT NULL,
  PRIMARY KEY (id_user, id_membership, id_user_type)
  ,
  CONSTRAINT id_user_UNIQUE UNIQUE (id_user) ,
  CONSTRAINT fk_customer_membership1
    FOREIGN KEY (id_membership)
    REFERENCES mydb.membership (id_membership)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_user_type1
    FOREIGN KEY (id_user_type)
    REFERENCES mydb.user_type (id_user_type)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_customer_membership1_idx ON mydb.user (id_membership ASC);
CREATE INDEX fk_user_user_type1_idx ON mydb.user (id_user_type ASC);



CREATE SEQUENCE mydb.contact_seq;

CREATE TABLE IF NOT EXISTS mydb.contact (
  id_contact INT NOT NULL DEFAULT NEXTVAL ('mydb.contact_seq'),
  email VARCHAR(45) NOT NULL,
  phone_number VARCHAR(45) NOT NULL,
  id_user INT NOT NULL,
  PRIMARY KEY (id_contact, id_user)
  ,
  CONSTRAINT id_contact_UNIQUE UNIQUE (id_contact) ,
  CONSTRAINT fk_contact_customer1
    FOREIGN KEY (id_user)
    REFERENCES mydb.user (id_user)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_contact_customer1_idx ON mydb.contact (id_user ASC);



CREATE SEQUENCE mydb.address_seq;

CREATE TABLE IF NOT EXISTS mydb.address (
  id_address INT NOT NULL DEFAULT NEXTVAL ('mydb.address_seq'),
  country VARCHAR(30) NOT NULL,
  city VARCHAR(45) NOT NULL,
  street_name VARCHAR(45) NOT NULL,
  house_number VARCHAR(10) NOT NULL,
  postal_code VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_address),
  CONSTRAINT id_address_UNIQUE UNIQUE (id_address) )
;



CREATE SEQUENCE mydb.category_seq;

CREATE TABLE IF NOT EXISTS mydb.category (
  id_category INT NOT NULL DEFAULT NEXTVAL ('mydb.category_seq'),
  title VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_category),
  CONSTRAINT id_category_UNIQUE UNIQUE (id_category) )
;



CREATE SEQUENCE mydb.product_seq;

CREATE TABLE IF NOT EXISTS mydb.product (
  id_product INT NOT NULL DEFAULT NEXTVAL ('mydb.product_seq'),
  name VARCHAR(45) NOT NULL,
  price DECIMAL(10,0) NOT NULL,
  discount DOUBLE PRECISION NOT NULL,
  in_stock INT NOT NULL,
  gender VARCHAR(15) NOT NULL,
  season VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_product),
  CONSTRAINT id_product_UNIQUE UNIQUE (id_product) )
;



CREATE SEQUENCE mydb.delivery_seq;

CREATE TABLE IF NOT EXISTS mydb.delivery (
  id_delivery INT NOT NULL DEFAULT NEXTVAL ('mydb.delivery_seq'),
  type VARCHAR(45) NOT NULL,
  date DATE NULL,
  id_address INT NOT NULL,
  id_contact INT NOT NULL,
  id_user INT NOT NULL,
  PRIMARY KEY (id_delivery, id_address, id_contact, id_user)
  ,
  CONSTRAINT id_delivery_UNIQUE UNIQUE (id_delivery) ,
  CONSTRAINT fk_delivery_address1
    FOREIGN KEY (id_address)
    REFERENCES mydb.address (id_address)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_delivery_contact1
    FOREIGN KEY (id_contact , id_user)
    REFERENCES mydb.contact (id_contact , id_user)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_delivery_address1_idx ON mydb.delivery (id_address ASC);
CREATE INDEX fk_delivery_contact1_idx ON mydb.delivery (id_contact ASC, id_user ASC);



CREATE SEQUENCE mydb.payment_seq;

CREATE TABLE IF NOT EXISTS mydb.payment (
  id_payment INT NOT NULL DEFAULT NEXTVAL ('mydb.payment_seq'),
  type VARCHAR(20) NOT NULL,
  completed SMALLINT NULL,
  payment_time DATE NULL,
  PRIMARY KEY (id_payment),
  CONSTRAINT id_payment_UNIQUE UNIQUE (id_payment) )
;



CREATE SEQUENCE mydb.order_seq;

CREATE TABLE IF NOT EXISTS mydb.order (
  id_order INT NOT NULL DEFAULT NEXTVAL ('mydb.order_seq'),
  status VARCHAR(45) NOT NULL,
  total DECIMAL(10,0) NOT NULL,
  shipping DECIMAL(10,0) NOT NULL,
  discount DECIMAL(10,0) NULL,
  id_user INT NOT NULL,
  id_delivery INT NOT NULL,
  id_payment INT NOT NULL,
  PRIMARY KEY (id_order, id_user, id_delivery, id_payment)
  ,
  CONSTRAINT id_order_UNIQUE UNIQUE (id_order) ,
  CONSTRAINT fk_order_customer1
    FOREIGN KEY (id_user)
    REFERENCES mydb.user (id_user)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_order_delivery1
    FOREIGN KEY (id_delivery)
    REFERENCES mydb.delivery (id_delivery)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_order_payment1
    FOREIGN KEY (id_payment)
    REFERENCES mydb.payment (id_payment)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_order_customer1_idx ON mydb.order (id_user ASC);
CREATE INDEX fk_order_delivery1_idx ON mydb.order (id_delivery ASC);
CREATE INDEX fk_order_payment1_idx ON mydb.order (id_payment ASC);



CREATE TABLE IF NOT EXISTS mydb.user_has_address (
  id_user INT NOT NULL,
  id_address INT NOT NULL,
  PRIMARY KEY (id_user, id_address)
  ,
  CONSTRAINT fk_customer_has_address_customer1
    FOREIGN KEY (id_user)
    REFERENCES mydb.user (id_user)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_customer_has_address_address1
    FOREIGN KEY (id_address)
    REFERENCES mydb.address (id_address)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_customer_has_address_address1_idx ON mydb.user_has_address (id_address ASC);
CREATE INDEX fk_customer_has_address_customer1_idx ON mydb.user_has_address (id_user ASC);



CREATE TABLE IF NOT EXISTS mydb.order_has_product (
  id_order INT NOT NULL,
  id_product INT NOT NULL,
  size VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_order, id_product)
  ,
  CONSTRAINT fk_order_has_product_order1
    FOREIGN KEY (id_order)
    REFERENCES mydb.order (id_order)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_order_has_product_product1
    FOREIGN KEY (id_product)
    REFERENCES mydb.product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_order_has_product_product1_idx ON mydb.order_has_product (id_product ASC);
CREATE INDEX fk_order_has_product_order1_idx ON mydb.order_has_product (id_order ASC);



CREATE TABLE IF NOT EXISTS mydb.product_has_category (
  id_product INT NOT NULL,
  id_category INT NOT NULL,
  PRIMARY KEY (id_product, id_category)
  ,
  CONSTRAINT fk_product_has_category_product1
    FOREIGN KEY (id_product)
    REFERENCES mydb.product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_category_category1
    FOREIGN KEY (id_category)
    REFERENCES mydb.category (id_category)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_product_has_category_category1_idx ON mydb.product_has_category (id_category ASC);
CREATE INDEX fk_product_has_category_product1_idx ON mydb.product_has_category (id_product ASC);



SET SCHEMA 'mydb';
INSERT INTO mydb.membership (id_membership, membership_type, date_of_creation, date_of_expiration, bonus_discount) VALUES (DEFAULT, 'Standard', NULL, NULL, '0');
INSERT INTO mydb.membership (id_membership, membership_type, date_of_creation, date_of_expiration, bonus_discount) VALUES (DEFAULT, 'Premium', NULL, NULL, '15');
INSERT INTO mydb.membership (id_membership, membership_type, date_of_creation, date_of_expiration, bonus_discount) VALUES (DEFAULT, 'Employee', NULL, NULL, '5');


SET SCHEMA 'mydb';
INSERT INTO mydb.user_type (id_user_type, user_type) VALUES (DEFAULT, 'customer');
INSERT INTO mydb.user_type (id_user_type, user_type) VALUES (DEFAULT, 'employee ');
INSERT INTO mydb.user_type (id_user_type, user_type) VALUES (DEFAULT, 'manager');
INSERT INTO mydb.user_type (id_user_type, user_type) VALUES (DEFAULT, 'admin');
INSERT INTO mydb.user_type (id_user_type, user_type) VALUES (DEFAULT, 'inspector');


SET SCHEMA 'mydb';
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Milan', 'Vesel??', '4.5.1987', 'M', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Martin', 'Sladk??', '7.14.2000', 'M', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Jozef', 'Bund??l', '2.15.1958', 'M', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Honza ', 'Ko??????lek', '7.13.2004', 'M', 2, 1, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Jan ', 'Krut??', '10.31.2000', 'M', 3, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Val??rie ', 'Vysok??', '5.12.1982', 'F', 2, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Vikt??rie ', 'Mal??', '8.8.1976', 'F', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Grzegorz', 'Brzeczysczykiewicz', '8.15.1987', 'M', 3, 0, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Anton ', 'Zelen??', '12.3.2000', 'M', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Mari??n', 'Horsk??', '7.2.1975', 'M', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Miroslav', 'Zeman', '8.19.1990', 'M', 2, 0, NULL, NULL, 3);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Vladim??r ', 'Spurn??', '4.27.1982', 'M', 2, 0, NULL, NULL, 3);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Marcel ', 'Pfeifer', '5.21.1998', 'M', 1, 0, NULL, NULL, 4);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Nat??lia ', 'Klimkov??', '11.18.2004', 'F', 2, 1, NULL, NULL, 5);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Sabina ', 'Sedl????kov??', '09.12.1965', 'F', 3, 1, NULL, NULL, 4);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Wanda ', 'Zahuran????kov??', '10.22.1972', 'F', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Michaela ', 'Kurti??ov??', '5.16.1978', 'F', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ivana ', 'Trebatick??', '5.17.1998', 'F', 2, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'J??lia ', 'Vrbovsk??', '12.31.1999', 'F', 2, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Marie ', 'Mach??lov??', '9.23.1979', 'F', 2, 1, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Brunhilde ', 'Guntericht', '1.19.1980', 'F', 3, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Jean ', 'De-Wilde', '7.19.1997', 'M', 3, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'David ', 'Kochan', '4.16.2000', 'M', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ji???? ', 'Stejskal', '10.30.2006', 'M', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Vojt??ch ', 'Fi??ar', '4.29.1962', 'M', 1, 0, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Pavol ', 'Mike??', '11.15.1979', 'M', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Peter', 'Popluh??r', '6.16.1998', 'M', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Matej ', 'Sabo', '5.31.2001', 'M', 2, 0, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Milo??', 'Metejsk??', '7.1.1987', 'M', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Lubo??', 'Kosteln??', '9.14.1992', 'M', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Mark??ta ', 'Frank', '05.03.1993', 'F', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Jasm??na', 'Alagi??', '01.08.2003', 'F', 2, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ildik??', 'F??herv??ry', '8.28.2003', 'F', 3, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'L??szlo', 'Keczkem??ti', '1.6.1983', 'M', 2, 1, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Andrzej', 'Sapkowski', '9.7.1986', 'M', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ond??ej', 'Nepela', '11.15.1990', 'M', 2, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ivan', 'Popovi??', '1.4.1992', 'M', 1, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Pierre', 'LeGermain', '1.23.2003', 'M', 3, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ladislav', 'Kochan', '4.4.1983', 'M', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Vladislav', 'Kab??t', '1.18.1991', 'M', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ane??ka ', 'Michal????kov??', '1.12.1992', 'F', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ester', 'Drdulov??', '4.18.1997', 'F', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Pavl??na', 'Pavli??ov??', '8.7.1991', 'F', 3, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Karin', 'Palkechov??', '9.28.1994', 'F', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Oksana', 'Putinovskaya', '7.18.1995', 'F', 2, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Svetlana ', 'Dubovskij', '6.30.1998', 'F', 1, 0, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Filip ', 'Skor??', '10.12.2003', 'M', 2, 1, NULL, NULL, 1);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Anna ', 'Sabov??', '11.26.1984', 'F', 1, 0, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Lucia ', '??ur??nov??', '7.20.1990', 'F', 3, 1, NULL, NULL, 2);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Ign??c', 'Pie????ansk??', '2.18.1993', 'M', 2, 0, NULL, NULL, 3);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Oli??via', 'Nov??', '5.4.1999', 'F', 1, 0, NULL, NULL, 3);
INSERT INTO mydb.user (id_user, first_name, last_name, date_of_birth, gender, id_membership, newsletter_subscription, login, password, id_user_type) VALUES (DEFAULT, 'Luk????', 'Lackovi??', '11.21.2003', 'M', 2, 0, NULL, NULL, 3);

SET SCHEMA 'mydb';
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'cderoove@live.com', '(761) 479-0470', 1);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'world@outlook.com', '(642) 516-6125', 2);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'ehood@optonline.net', '(926) 218-3457', 3);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'scitext@yahoo.ca', '(938) 743-4956', 4);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'fukuchi@hotmail.com', '(807) 369-2394', 5);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'skoch@mac.com', '(815) 883-8883', 6);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'bachmann@gmail.com', '(429) 311-8835', 7);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'gommix@verizon.net', '(310) 897-0174', 8);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'dowdy@verizon.net', '(389) 584-0468', 9);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'mfburgo@yahoo.ca', '(509) 907-6877', 10);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'alias@msn.com', '(362) 903-1078', 11);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'gknauss@mac.com', '(862) 947-7269', 12);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'tattooman@optonline.net', '(337) 221-1400', 13);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'boftx@gmail.com', '(925) 653-8676', 14);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'gboss@mac.com', '(541) 381-3140', 15);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'syrinx@outlook.com', '(202) 293-6233', 16);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'improv@outlook.com', '(670) 556-0930', 17);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'johndo@mac.com', '(398) 790-4501', 18);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'mwandel@me.com', '(952) 275-9495', 19);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'barlow@live.com', '(851) 434-5131', 20);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'konit@gmail.com', '(678) 565-8096', 21);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'tellis@optonline.net', '(836) 444-4187', 22);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'fwiles@msn.com', '(222) 535-6142', 23);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'syncnine@mac.com', '(589) 660-3745', 24);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'cderoove@msn.com', '(981) 691-1455', 25);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'bflong@att.net', '(486) 920-3726', 26);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'doche@me.com', '(757) 704-9265', 27);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'jelmer@aol.com', '(820) 989-3473', 28);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'danneng@yahoo.ca', '(489) 360-2322', 29);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'kildjean@att.net', '(511) 764-4873', 30);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'pdbaby@me.com', '(429) 661-4141', 31);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'chaikin@mac.com', '(934) 392-5441', 32);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'wbarker@optonline.net', '(364) 230-9144', 33);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'arnold@hotmail.com', '(452) 766-3476', 34);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'rddesign@sbcglobal.net', '(806) 534-1565', 35);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'falcao@mac.com', '(448) 852-1723', 36);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'wagnerch@live.com', '(392) 458-9173', 37);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'gmcgath@aol.com', '(667) 237-0479', 38);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'mrsam@icloud.com', '(531) 258-1670', 39);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'arandal@yahoo.com', '(875) 964-8949', 40);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'grolschie@yahoo.ca', '(524) 555-9119', 41);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'bebing@gmail.com', '(373) 227-3192', 42);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'fhirsch@msn.com', '(844) 603-8162', 43);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'penna@gmail.com', '(289) 625-3913', 44);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'lpalmer@me.com', '(463) 475-0548', 45);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'tjensen@optonline.net', '(905) 461-6857', 46);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'msusa@me.com', '(660) 260-0167', 47);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'jbuchana@yahoo.ca', '(969) 336-0957', 48);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'crusader@aol.com', '(214) 277-9346', 49);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'gozer@outlook.com', '(655) 565-8169', 50);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'presoff@mac.com', '(963) 984-5372', 51);
INSERT INTO mydb.contact (id_contact, email, phone_number, id_user) VALUES (DEFAULT, 'hachi@sbcglobal.net', '(474) 514-7488', 52);


SET SCHEMA 'mydb';
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia ', 'Bratislava', 'Kapicova', '1547/32', '81107');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia', 'Vrbov??', 'Mieru', '724/7a', '92203');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia ', 'Pie????any', 'Nikola_Teslu', '8985/541', '92101');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Germany', 'Munich', 'Masaicher_Strasse', '6', '80539');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha', 'Na_Smetance', '412', '11900');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Brno ', 'Purky??ova', '93', '60200');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Brno', '??itn?? ', '12', '60300');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'T??eb????', 'Sokolovsk??', '518', '67401');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Liberec', 'Vorone??sk??', '1119', '46005');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Brno ', 'Sk??celova', '1457/58', '61200');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Brno ', 'Vychodilova', '7', '61400');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha ', '??ikm??', '2321/22', '11908');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha ', '??ikm??', '2319/18', '11800');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', '??st??_nad_Labem', 'Na_V??rovce', '392/15', '40002');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Poland', 'Krakow', 'Mazowiecka', '102', '30-000');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Poland', 'Katowice ', 'Wilcza', '2A', '40-005');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia', '??ilina', 'Bernol??kova', '784/52', '01009');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'France ', 'Lyon', 'Rue_Andr??_Bonin', '654/78', '69004');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'France ', 'Paris', 'Na_Lysine ', '272/17', '75004');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha', 'Na_Podkovce', '23', '10000');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia ', 'Chtelnica', 'Chtelnica', '945', '92205');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia ', 'Vrbov??', 'Gen.M.R.??tef??nika', '208/3', '92203');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Austria ', 'Salzburg', 'General-Arnold_Strasse', '13', '5071');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia', 'Vrbov??', 'Mieru', '715/23', '92203');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Hungary ', 'Budapest', 'G??t_Utca', '7845/58', '1014');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Slovakia ', 'Trnava', 'Bratislavsk??', '954/12', '91701');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha', 'B??dli??n??', '928', '10000');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha ', 'V??pencov??', '309', '10400');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Brno', 'Kotl????sk??', '817', '60200');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Ostrava  ', 'U_hr??bk??', '41', '70030');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'T??eb???? ', 'Slunn??', '1109', '67401');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Liberec', 'Durychova', '963/9', '46010');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Plze??', 'Sedmikr??skov??', '17/4', '32200');
INSERT INTO mydb.address (id_address, country, city, street_name, house_number, postal_code) VALUES (DEFAULT, 'Czech_Republic', 'Praha ', 'Cukrovarn??cka', '456/14', '10300');


SET SCHEMA 'mydb';
INSERT INTO mydb.category (id_category, title) VALUES (DEFAULT, 'Shoes');
INSERT INTO mydb.category (id_category, title) VALUES (DEFAULT, 'T-shirts');
INSERT INTO mydb.category (id_category, title) VALUES (DEFAULT, 'Hoodies');
INSERT INTO mydb.category (id_category, title) VALUES (DEFAULT, 'Tracksuits');
INSERT INTO mydb.category (id_category, title) VALUES (DEFAULT, 'Trousers');
INSERT INTO mydb.category (id_category, title) VALUES (DEFAULT, 'Accessories ');


SET SCHEMA 'mydb';
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adilette', 60, 0, 30, 'Unisex', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Ultraboost_4.0_DNA', 160, 0, 10, 'Men', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'NMD_R1_V2', 145, 10, 15, 'Unisex', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'TERREX_FROZETRACK_MID_WINTER_HIKING', 130, 0, 10, 'Men', 'Winter');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'TERREX_Conrax_Climaheat_Boa', 130, 12, 5, 'Women', 'Winter');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'COLD.RDY_Training', 40, 5, 45, 'Unisex', 'Fall');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Essentials_Fleece_Camo-Print', 60, 0, 12, 'Men', 'Spring');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adicolor_Essentials_Trefoil_Crewneck', 50, 0, 25, 'Unisex', 'Winter');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adicolor_Classics_3-Stripes_Crew', 40, 5, 3, 'Women', 'Spring');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Primeblue_Designed_2_Move', 20, 0, 0, 'Women', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Top_Hyperglam_Crop_Zip', 15, 5, 10, 'Women', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adicolor_Classics_3-Stripes', 25, 5, 10, 'Unisex', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Own_the_Run', 15, 0, 0, 'Women', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Primegreen_Essentials_3-Stripes', 65, 0, 15, 'Men', 'Summer');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adicolor_Classics_3-stripes', 60, 0, 10, 'Men', 'Fall');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adicolor_Classics_Primeblue_SST', 60, 10, 15, 'Unisex', 'Spring');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'SPORT_SP0016', 160, 0, 5, 'Unisex', 'All_seasons');
INSERT INTO mydb.product (id_product, name, price, discount, in_stock, gender, season) VALUES (DEFAULT, 'Adicolor_backpack', 30, 0, 60, 'Unisex', 'All_seasons');


SET SCHEMA 'mydb';
INSERT INTO mydb.delivery (id_delivery, type, date, id_address, id_contact, id_user) VALUES (DEFAULT, 'UPS', NULL, 1, 3, 3);
INSERT INTO mydb.delivery (id_delivery, type, date, id_address, id_contact, id_user) VALUES (DEFAULT, '??esk??_Po??ta', NULL, 23, 30, 30);
INSERT INTO mydb.delivery (id_delivery, type, date, id_address, id_contact, id_user) VALUES (DEFAULT, 'Fedex', NULL, 10, 15, 15);
INSERT INTO mydb.delivery (id_delivery, type, date, id_address, id_contact, id_user) VALUES (DEFAULT, 'GLS', NULL, 17, 23, 23);
INSERT INTO mydb.delivery (id_delivery, type, date, id_address, id_contact, id_user) VALUES (DEFAULT, 'Unindetified_white_van', NULL, 18, 25, 25);
INSERT INTO mydb.delivery (id_delivery, type, date, id_address, id_contact, id_user) VALUES (DEFAULT, 'Slovensk??_po??ta', NULL, 12, 49, 49);


SET SCHEMA 'mydb';
INSERT INTO mydb.payment (id_payment, type, completed, payment_time) VALUES (DEFAULT, 'on_delivery_by_cash', 0, NULL);
INSERT INTO mydb.payment (id_payment, type, completed, payment_time) VALUES (DEFAULT, 'Online_transactioon', NULL, NULL);
INSERT INTO mydb.payment (id_payment, type, completed, payment_time) VALUES (DEFAULT, 'on_delivery_by_card', NULL, NULL);
INSERT INTO mydb.payment (id_payment, type, completed, payment_time) VALUES (DEFAULT, 'Tatra_pay', NULL, NULL);
INSERT INTO mydb.payment (id_payment, type, completed, payment_time) VALUES (DEFAULT, 'Paypal', NULL, NULL);


SET SCHEMA 'mydb';
INSERT INTO mydb.order (id_order, status, total, shipping, discount, id_user, id_delivery, id_payment) VALUES (DEFAULT, 'On_its_way', 120, 2, 10, 3, 1, 1);
INSERT INTO mydb.order (id_order, status, total, shipping, discount, id_user, id_delivery, id_payment) VALUES (DEFAULT, 'At_the_branch', 145, 15, 0, 15, 3, 2);
INSERT INTO mydb.order (id_order, status, total, shipping, discount, id_user, id_delivery, id_payment) VALUES (DEFAULT, 'Delivered', 90, 3, 0, 23, 4, 4);
INSERT INTO mydb.order (id_order, status, total, shipping, discount, id_user, id_delivery, id_payment) VALUES (DEFAULT, 'Packaging', 290, 0, 0, 49, 6, 5);
INSERT INTO mydb.order (id_order, status, total, shipping, discount, id_user, id_delivery, id_payment) VALUES (DEFAULT, 'On_its_way', 205, 0, 10, 30, 2, 3);
INSERT INTO mydb.order (id_order, status, total, shipping, discount, id_user, id_delivery, id_payment) VALUES (DEFAULT, 'Delivered', 60, 3, 0, 25, 5, 3);


SET SCHEMA 'mydb';
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (1, 1);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (2, 1);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (3, 1);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (6, 2);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (7, 2);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (8, 2);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (4, 3);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (5, 4);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (6, 5);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (7, 6);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (8, 7);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (9, 8);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (10, 8);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (11, 8);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (12, 9);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (13, 8);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (14, 10);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (15, 10);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (16, 1);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (17, 11);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (18, 12);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (19, 13);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (20, 14);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (21, 15);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (22, 16);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (23, 17);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (24, 17);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (25, 18);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (26, 19);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (27, 20);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (28, 21);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (29, 22);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (30, 23);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (30, 24);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (31, 25);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (32, 26);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (33, 27);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (34, 28);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (35, 29);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (36, 29);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (37, 29);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (38, 29);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (39, 29);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (40, 30);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (41, 30);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (42, 30);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (43, 31);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (45, 32);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (46, 33);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (47, 34);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (48, 12);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (49, 12);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (50, 5);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (51, 16);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (52, 1);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (52, 9);
INSERT INTO mydb.user_has_address (id_user, id_address) VALUES (52, 8);


SET SCHEMA 'mydb';
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (1, 1, '45');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (1, 6, 'XL');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (1, 10, 'L');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (2, 3, '38');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (3, 18, 'L');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (3, 15, 'M');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (4, 2, '42');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (4, 4, '39');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (5, 3, '43');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (5, 16, 'L');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (5, 8, 'L');
INSERT INTO mydb.order_has_product (id_order, id_product, size) VALUES (6, 3, '46');


SET SCHEMA 'mydb';
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (1, 1);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (2, 1);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (3, 1);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (4, 1);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (5, 1);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (6, 3);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (7, 3);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (8, 3);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (9, 3);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (10, 2);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (11, 2);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (12, 2);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (13, 2);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (14, 4);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (15, 5);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (16, 5);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (17, 6);
INSERT INTO mydb.product_has_category (id_product, id_category) VALUES (18, 6);



