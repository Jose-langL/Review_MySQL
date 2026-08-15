/*
----------------------------------------
CONSULTA IN
SABER CUALES SON LOS ENTRENADORES CON ID 
----------------------------------------
*/

SELECT entrenadores_Asignados FROM entrenadores
    WHERE id IN ('E001', 'E002');

/*
----------------------------------------
CONSULTA IN
SABER CUALES SON LOS SOCIOS CON ID 
----------------------------------------
*/
SELECT nombre FROM Socios
    WHERE Socio_ID IN ('101', '102');

/*
------------------------------------------------------------------------------------------
CONSULTA INNER JOIN
CONSULTA PARA SABER EL NOMBRE DEL SOCIO, EL PLAN DE ENTRENAMIENTO Y EL ENTRENADOR ASIGNADO
------------------------------------------------------------------------------------------
*/

SELECT 
        S.nombre AS nombre_socio, 
        SPE.planes_entrenamiento AS plan, 
        SPE.Id_entrenador AS entrenador
    FROM Socios S
INNER JOIN Socio_Plan_Entrenamiento SPE ON S.Socio_ID = SPE.Socio_ID;

/*
----------------------------------------
CONSULTA INNER JOIN
CONSULTA PARA SABER EL NOMBRE DEL ENTRENADOR Y SU ESPECIALIDAD
----------------------------------------
*/

SELECT 
    E.entrenadores_Asignados AS nombre,
    SE.especialidad_Entrenador AS Especialidad
    FROM especialidades_entrenadores SE
    INNER JOIN  entrenadores E ON SE.id = E.especialidad_id;


/*
----------------------------------------
CONSULTA OUT
CONSULTA PARA SABER EL TOTAL DE SOCIOS POR SEDE
----------------------------------------
*/

DELIMITER //
CREATE PROCEDURE ContarSociosPorSede(
IN p_sede VARCHAR(10),
OUT total_socios INT
)
BEGIN
    SELECT COUNT(*)
		INTO total_socios
		FROM Socio_Plan_Entrenamiento
		WHERE Sede_id = p_sede;
END //
DELIMITER ;

CALL ContarSociosPorSede('S001', @total);
SELECT @total;

/*
--------------------------------------------------
CONSULTA INOUT
CONSULTA PARA ACUMULAR EL TOTAL DE SOCIOS POR SEDE 
--------------------------------------------------
*/
DELIMITER //
CREATE PROCEDURE AcumularSocios(
IN p_sede VARCHAR(10),
INOUT acumulado INT
)
BEGIN
    DECLARE cantidad INT;
    
    SELECT COUNT(*)
		INTO cantidad
		FROM Socio_Plan_Entrenamiento
		WHERE Sede_id = p_sede;

    SET acumulado = acumulado + cantidad;
END //
DELIMITER ;

SET @contador = 10;
CALL AcumularSocios('S001', @contador);
SELECT @contador;

/*
-----------------------------------------------------------------------------
CONSULTA INSERCCION
CONSULTA PARA INSERTAR UN NUEVO REGISTRO EN LA TABLA Socio_Plan_Entrenamiento
-----------------------------------------------------------------------------
*/
DELIMITER //
CREATE PROCEDURE InsertarAsignacion(
IN p_id INT,
IN p_socio INT,
IN p_plan VARCHAR(10),
IN p_entrenador VARCHAR(10),
IN p_sede VARCHAR(10)
)
BEGIN
    INSERT INTO Socio_Plan_Entrenamiento
		(Id, Socio_ID, planes_entrenamiento, Id_entrenador, Sede_id)
    VALUES
		(p_id, p_socio, p_plan, p_entrenador, p_sede);
END //
DELIMITER ;

CALL InsertarAsignacion(2, 1006, 'P001', 'E001', 'S001');


/*
-------------------------------------------------------
CONSULTA IF THENSE ELSE
CONSULTA PARA VERIFICAR LA ESPECIALIDAD DE UN ENTRENADOR
--------------------------------------------------------
*/

DELIMITER //
CREATE PROCEDURE VerificarEspecialidad(
IN p_entrenador VARCHAR(10),
OUT mensaje VARCHAR(100)
)
BEGIN
    DECLARE esp VARCHAR(100);
    SELECT especialidad_Entrenador
		INTO esp
		FROM especialidades_entrenadores e
    JOIN entrenadores en
        ON e.Id = en.especialidad_id
    WHERE en.Id = p_entrenador;
    IF esp = 'Cardio' THEN
        SET mensaje = 'Entrenador especializado en Cardio';
    ELSE
        SET mensaje = 'Entrenador de otra especialidad';
    END IF;
END //
DELIMITER ;

CALL VerificarEspecialidad('E001', @msg);
SELECT @msg;

/*
--------------------------------------------------------------------
CONSULTA LOOP
CONSULTA PARA CONTAR EL TOTAL DE SOCIOS POR SEDE UTILIZANDO UN BUCLE
-------------------------------------------------------------------
*/

DELIMITER //
CREATE PROCEDURE ContadorLoop(
IN p_sede VARCHAR(10),
OUT total INT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE limite INT;
    
    SELECT COUNT(*)
		INTO limite
		FROM Socio_Plan_Entrenamiento
		WHERE Sede_id = p_sede;
    SET total = 0;
    
    mi_loop: LOOP
        IF i >= limite THEN
            LEAVE mi_loop;
        END IF;
        SET total = total + 1;
        SET i = i + 1;
    END LOOP;
END //
DELIMITER ;

CALL ContadorLoop('S001', @total);
SELECT @total;