-- CIUDAD
INSERT INTO ciudad (Ciudad_id, Ciudad_Sede) VALUES
('C001', 'Madrid');


-- SEDE
INSERT INTO sede (Id, nombre_sede, Ciudad_id) VALUES
('S001', 'Sede Norte', 'C001'),
('S002', 'Sede Sur', 'C001');


-- SOCIOS
INSERT INTO Socios (Socio_ID, nombre, apellido, Telefono) VALUES
(101, 'Ana', 'Perez', '555-1234'),
(102, 'Luis', 'Gomez', '555-5678'),
(103, 'Carla', 'Ruiz', '555-9012');


-- PLANES DE ENTRENAMIENTO
INSERT INTO planes_entrenamiento (Id, n_Entrenamiento) VALUES
('PE01', 'Yoga'),
('PE02', 'Pesas'),
('PE03', 'CrossFit'),
('PE04', 'Boxeo');


-- ESPECIALIDADES DE ENTRENADORES
INSERT INTO especialidades_entrenadores
(Id, especialidad_Entrenador) VALUES
('ES001', 'Yoga'),
('ES002', 'Musculacion'),
('ES003', 'Funcional'),
('ES004', 'Boxeo');


-- ENTRENADORES
INSERT INTO entrenadores
(Id, entrenadores_Asignados, especialidad_id) VALUES
('E001', 'Carlos', 'ES001'),
('E002', 'Marta', 'ES002'),
('E003', 'Ivan', 'ES003'),
('E004', 'Diego', 'ES004');


-- SOCIO - PLAN - ENTRENADOR - SEDE
INSERT INTO Socio_Plan_Entrenamiento
(Id, Socio_ID, planes_entrenamiento, Id_entrenador, Sede_id) VALUES
(1001, 101, 'PE01', 'E001', 'S001'),
(1002, 101, 'PE02', 'E002', 'S001'),
(1003, 102, 'PE03', 'E003', 'S002'),
(1004, 103, 'PE02', 'E002', 'S001'),
(1005, 103, 'PE04', 'E004', 'S001');