CREATE DATABASE Review_BD;
USE Review_BD;
CREATE TABLE ciudad (
    Ciudad_id VARCHAR(10) PRIMARY KEY AUTO_INCREMENT,
    Ciudad_Sede VARCHAR(100) NOT NULL
);

CREATE TABLE sede (
    Id VARCHAR(10) PRIMARY KEY AUTO_INCREMENT,
    nombre_sede VARCHAR(100) NOT NULL,
    Ciudad_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (Ciudad_id) REFERENCES ciudad(Ciudad_id)
);

CREATE TABLE Socios (
    Socio_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20)
);

CREATE TABLE planes_entrenamiento (
    Id VARCHAR(10) PRIMARY KEY AUTO_INCREMENT,
    n_Entrenamiento VARCHAR(100) NOT NULL
);

CREATE TABLE especialidades_entrenadores (
    Id VARCHAR(10) PRIMARY KEY AUTO_INCREMENT,
    especialidad_Entrenador VARCHAR(100) NOT NULL
);

CREATE TABLE entrenadores (
    Id VARCHAR(10) PRIMARY KEY AUTO_INCREMENT,
    entrenadores_Asignados VARCHAR(100) NOT NULL,
    especialidad_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (especialidad_id)
        REFERENCES especialidades_entrenadores(Id)
);

CREATE TABLE Socio_Plan_Entrenamiento (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Socio_ID INT NOT NULL,
    planes_entrenamiento VARCHAR(10) NOT NULL,
    Id_entrenador VARCHAR(10) NOT NULL,
    Sede_id VARCHAR(10) NOT NULL,

    FOREIGN KEY (Socio_ID)
        REFERENCES Socios(Socio_ID),

    FOREIGN KEY (planes_entrenamiento)
        REFERENCES planes_entrenamiento(Id),

    FOREIGN KEY (Id_entrenador)
        REFERENCES entrenadores(Id),

    FOREIGN KEY (Sede_id)
        REFERENCES sede(Id)
);