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