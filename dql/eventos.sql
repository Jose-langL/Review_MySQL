CREATE TABLE IF NOT EXISTS reporte_socios_entrenador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_entrenador VARCHAR(10),
    nombre_entrenador VARCHAR(100),
    total_socios INT NOT NULL
);

DELIMITER //
CREATE EVENT IF NOT EXISTS evt_reporte_diario_socios_entrenador
ON SCHEDULE EVERY 1 DAY
STARTS (CURRENT_DATE + INTERVAL 1 DAY) 
DO
BEGIN
    INSERT INTO reporte_socios_entrenador (fecha, id_entrenador, nombre_entrenador, total_socios)
    SELECT 
        CURDATE() AS fecha,
        e.id AS id_entrenador,
        e.entrenadores_Asignados AS nombre_entrenador,
        COUNT(spe.Socio_ID) AS total_socios
    FROM entrenadores e
    LEFT JOIN Socio_Plan_Entrenamiento spe ON e.id = spe.id_entrenador
    GROUP BY e.id, e.entrenadores_Asignados;
END //
DELIMITER ;

/*
----------------------------------------------------------------
            TRIGEER PARA VERIFICAR DISPONIBILIDAD DE ENTRENADOR
----------------------------------------------------------------
*/_
DELIMITER //
CREATE TRIGGER trg_verificar_disponibilidad_entrenador
BEFORE INSERT ON Socio_Plan_Entrenamiento
FOR EACH ROW
BEGIN
    DECLARE socios_actuales INT;
    DECLARE limite_maximo INT DEFAULT 10;

    SELECT COUNT(*) 
    INTO socios_actuales
    FROM Socio_Plan_Entrenamiento
    WHERE id_entrenador = NEW.id_entrenador;

    IF socios_actuales >= limite_maximo THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El entrenador seleccionado ya alcanzó el cupo máximo de socios asignados.';
    END IF;
END //
DELIMITER ;



