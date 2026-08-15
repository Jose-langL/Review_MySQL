/*
------------------------------------
Contar socios con un bucle WHILE
-----------------------------------
*/

DELIMITER //
CREATE PROCEDURE ContarSociosWhile()
BEGIN
    DECLARE contador INT DEFAULT 1;
    DECLARE total_socios INT;
    
    SELECT COUNT(*) INTO total_socios
		FROM Socios;
		WHILE contador <= total_socios DO
        
	SET contador = contador + 1;
    END WHILE;
		SELECT 
			total_socios AS Total_Socios,
			contador - 1 AS Socios_Contados;
END //
DELIMITER ;

CALL ContarSociosWhile();

/*
------------------------------------
Contar socios con un bucle REPEAT
-----------------------------------
*/

DELIMITER //
CREATE PROCEDURE RecorrerSedesRepeat()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total_sedes INT;

    SELECT COUNT(*) INTO total_sedes
		FROM Sedes;
        
    REPEAT
        SET i = i + 1;
		UNTIL i > total_sedes
    END REPEAT;

    SELECT 
        'El total de sedes son' AS Mensaje,
        total_sedes AS Total_Sedes,
        i AS Valor_Final;
END //
DELIMITER ;

Call RecorrerSedesRepeat(); 

/*
------------------------------------
CASE con manejo de erroes 
-----------------------------------
*/
DELIMITER //
CREATE FUNCTION fn_obtener_estado_sede(p_sede_id VARCHAR(10))
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_ciudad_id VARCHAR(10);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND RETURN 'Error: Sede no existe';

    SELECT Ciudad_id INTO v_ciudad_id
		FROM sede
		WHERE Id = p_sede_id;
        
    CASE v_ciudad_id
        WHEN 'C001' THEN RETURN 'Sede Principal';
        WHEN 'C002' THEN RETURN 'Sede Norte';
        WHEN 'C003' THEN RETURN 'Sede Sur';
        ELSE RETURN 'Sede Secundaria';
    END CASE;
END //
DELIMITER ;

-- Si la sede existe:
SELECT fn_obtener_estado_sede('S001') AS estado;

-- Si la sede no existe
SELECT fn_obtener_estado_sede('S999') AS estado;