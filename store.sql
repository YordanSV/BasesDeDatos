
DROP TABLE combo_product;
DROP TABLE product;
DROP TABLE orden_combo;
DROP TABLE combo;
DROP TABLE orden;
DROP TABLE user;

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


CREATE TABLE product(
    id INT NOT NULL,
    nombre VARCHAR(32)NOT NULL,
    precio INT NOT NULL,
    PRIMARY KEY(id)
);
INSERT INTO product(id,nombre, precio) VALUES
     (1,'Hamburguesa', 1500),
     (2,'Papas',1800),
     (3,'Taco',2400),
     (4,'Chalupa',1200),
     (5,'Papanachos',2600),
     (6,'Helado',1000),
     (7,'Nuggets', 1600),
     (8,'Refresco', 890);



CREATE TABLE combo(
    id INT NOT NULL,
    nombre VARCHAR(32) NOT NULL,
    tamano VARCHAR(32) DEFAULT 'normal',     /*normal, mediano, grande*/
    PRIMARY KEY(id)
);
 
 INSERT INTO combo(id,nombre) VALUES
      (1,'Hamburguesa con papas y refresco'),
      (2,'Papanacho con refresco'),
      (3,'Taco'),
      (4,'Chalupa con papas'),
      (5,'Papanachos'),
      (6,'Helado con papas'),
      (7,'Nuggets con refresco');

 
 
CREATE TABLE combo_product(
    id_combo INT NOT NULL,
    id_product INT NOT NULL,
    FOREIGN KEY(id_product) REFERENCES product(id),
    FOREIGN KEY(id_combo) REFERENCES combo(id)
);

INSERT INTO combo_product(id_combo, id_product) VALUES
     (1,1),
     (1,2),
     (1,8),
     (2,5),
     (2,8),
     (3,3),
     (4,4),
     (4,2),
     (5,5),
     (6,6),
     (6,2),
     (7,7),
     (7,8);


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


CREATE TABLE orden_combo(
    id INT NOT NULL AUTO_INCREMENT,
    id_combo INT NOT NULL,
    id_orden INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_combo) REFERENCES combo(id),
    FOREIGN KEY(id_orden) REFERENCES orden(id)
);

INSERT INTO orden_combo (id_orden, id_combo) VALUES
     (1,5),
     (1,7),
     (1,5),
     (2,7),
     (2,2),
     (3,1),
     (3,4),
     (3,5),
     (4,4),
     (4,6),
     (5,4),
     (5,4),
     (5,4),
     (6,1);

/* numero de orden de cada usuario
     Ana 1,3
     Michael 2
     Sofia 5,6
     Alonso 4
*/
/*
SELECT u.nombre, o.id, oc.id_combo, COUNT(oc.id_combo) FROM user u
LEFT JOIN orden o ON u.id = o.id_user
LEFT JOIN orden_combo oc ON oc.id_orden = o.id
GROUP BY o.id, oc.id_combo;
*/
/*UPDATE combo SET tamano = 'grande' WHERE id = 3;*/

SELECT c.nombre,c.tamano, IF(c.tamano = 'mediano',SUM(p.precio)+1000,IF(c.tamano = 'grande',SUM(p.precio)+2000,SUM(p.precio))) as Precio FROM combo c
LEFT JOIN combo_product cp ON c.id = cp.id_combo
LEFT JOIN product p ON p.id = cp.id_product
GROUP BY c.nombre;
