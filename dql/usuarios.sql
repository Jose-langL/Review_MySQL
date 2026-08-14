/*
------------------------------------
    USUARIO ADMINISTRADOR
-----------------------------------
*/
CREATE USER 'ADMIN'@'localhost' IDENTIFIED BY 'Admin_233&#';
GRANT ALL PRIVILEGES ON Review_BD.* TO 'ADMIN'@'localhost';
SHOW GRANTS FOR 'ADMIN'@'localhost';

/*
------------------------------------
    USUARIO SOCIO
-----------------------------------
*/
CREATE USER 'Socio'@'localhost' IDENTIFIED BY 'Socio_221$2';
GRANT SELECT ON Review_BD.* TO 'Socio'@'localhost';
SHOW GRANTS FOR 'Socio'@'localhost';

/*
------------------------------------
    USUARIO ENTRENADOR
-----------------------------------
*/
CREATE USER 'Entrenador'@'localhost' IDENTIFIED BY 'Enrenador_233&#';
GRANT SELECT, UPDATE, INSERT ON Review_BD.* TO 'Entrenador'@'localhost';
SHOW GRANTS FOR 'Entrenador'@'localhost';