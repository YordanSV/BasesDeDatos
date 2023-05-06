DROP TABLE orden_product;
DROP TABLE product;
DROP TABLE orden;
DROP TABLE user;

/*--------------------------user-----------------------------*/

CREATE TABLE user(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(32)NOT NULL,
    edad INT NOT NULL,
    PRIMARY KEY(id)
);
INSERT INTO  user (nombre, edad) VALUES
     ('Ana', 25),
     ('Michael', 37),
     ('Sofia', 28),
     ('Alonso',34);

/*------------------------orden-------------------------------*/

CREATE TABLE orden(
    id INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_user) REFERENCES user(id)
);

INSERT INTO orden(id_user, fecha) VALUES
     (1,'2023-11-04'),  /*1*/
     (2,'2023-05-23'),  /*2*/
     (1,'2023-06-26'),  /*3*/
     (4,'2023-02-18'),  /*4*/
     (3,'2023-02-15'),  /*5*/
     (3,'2023-04-17');  /*6*/

/*----------------------product-------------------------------*/

CREATE TABLE product(
    id INT NOT NULL,
    nombre VARCHAR(32) NOT NULL,
    precio INT NOT NULL,
    PRIMARY KEY(id)
);
INSERT INTO product(id,nombre, precio) VALUES
     (1,'Hamburguesa con papas y refresco', 3500),
     (2,'Papanacho con refresco', 2700),
     (3,'Chalupa con papas',3000),
     (4,'Papanachos',2500),
     (5,'Helado con papas', 2400),
     (6,'Nuggets con refresco',2000),
     (7,'Hamburguesa', 1500),
     (8,'Papas',1800),
     (9,'Taco',2400),
     (10,'Chalupa',1200),
     (11,'Papanachos',2600),
     (12,'Helado',1000),
     (13,'Nuggets', 1600),
     (14,'Refresco', 890);

CREATE TABLE orden_product(
     id_product INT NOT NULL,
     id_orden INT NOT NULL,
     cantidad INT DEFAULT 1,
     FOREIGN KEY(id_orden) REFERENCES orden(id),
     FOREIGN KEY(id_product) REFERENCES product(id)
);
INSERT INTO orden_product(id_orden, id_product) VALUES
     (1,1),
     (1,8),
     (1,8),
     (2,13),
     (2,8),
     (2,13),
     (2,4),
     (3,3),
     (4,4),
     (4,12),
     (5,5),
     (6,6),
     (6,2);

SELECT id_orden as num_orden, id_product as num_poducto, sum(cantidad) FROM orden_product
GROUP BY id_orden, id_product;

/* numero de orden de cada usuario
     Ana 1,3
     Michael 2
     Sofia 5,6
     Alonso 4
*/
