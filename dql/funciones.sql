-- funcion 1 
DELIMITER //
CREATE FUNCTION fn_obtener_nombre_socio(p_socio_id INT)
RETURNS VARCHAR(200)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_nombre_completo VARCHAR(200);

    SELECT CONCAT(nombre, ' ', apellido)
		INTO v_nombre_completo
		FROM Socios
		WHERE Socio_ID = p_socio_id;

    RETURN IFNULL(v_nombre_completo, 'Socio no encontrado');
END //
DELIMITER ;

SELECT fn_obtener_nombre_socio(101) AS NombreSocio;

-- funcion 2 
DELIMITER //
CREATE FUNCTION fn_calcular_comision_entrenador(p_id_entrenador VARCHAR(10))
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_socios INT;
    DECLARE comision DECIMAL(10,2);

    SELECT COUNT(*) 
		INTO total_socios
		FROM Socio_Plan_Entrenamiento
		WHERE id_entrenador = p_id_entrenador;

    SET comision = total_socios * 15.00;

    RETURN comision;
END //
DELIMITER ;

SELECT fn_calcular_comision_entrenador('E001') AS comision_total;

-- funcion 3
DELIMITER //
CREATE FUNCTION fn_evaluar_carga_entrenador(p_id_entrenador VARCHAR(10))
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_socios INT;
    
    SELECT COUNT(*) INTO total_socios
		FROM Socio_Plan_Entrenamiento
		WHERE id_entrenador = p_id_entrenador;

    IF total_socios = 0 THEN
        RETURN 'Disponible';
    ELSEIF total_socios <= 5 THEN
        RETURN 'Carga Normal';
    ELSE
        RETURN 'Carga Llena';
    END IF;
END //
DELIMITER ;

SELECT fn_evaluar_carga_entrenador('E001') AS estado;

-- funcion 4 
DELIMITER //
CREATE FUNCTION fn_calcular_monto_meses(
p_cuota_base DECIMAL(10,2), p_meses INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE total DECIMAL(10,2) DEFAULT 0.00;

    WHILE contador < p_meses DO
        SET total = total + p_cuota_base;
        SET contador = contador + 1;
    END WHILE;

    RETURN total;
END //
DELIMITER ;

SELECT fn_calcular_monto_meses(50.00, 3) AS total_a_pagar;

-- funcion 5 
DELIMITER //
CREATE FUNCTION fn_obtener_telefono_socio(p_socio_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE numero_telefono VARCHAR(20);

    SELECT Telefono INTO numero_telefono
     FROM Socios
     WHERE Socio_ID = p_socio_id;

    RETURN numero_telefono;
END //
DELIMITER ;

SELECT fn_obtener_telefono_socio(1) AS telefono;

-- funcion 6 
DELIMITER //
CREATE FUNCTION fn_generar_codigo_descuento(p_socio_id INT)
RETURNS VARCHAR(50)
NOT DETERMINISTIC
NO SQL
BEGIN
    DECLARE numero_aleatorio INT;
    DECLARE codigo VARCHAR(50);

    SET numero_aleatorio = FLOOR(1 + RAND() * 100);
    SET codigo = CONCAT('DESC-', p_socio_id, '-', numero_aleatorio);

    RETURN codigo;
END //
DELIMITER ;

SELECT fn_generar_codigo_descuento(1) AS cupon;

-- funcion 7 
DELIMITER //
CREATE FUNCTION fn_obtener_ciudad_sede(p_sede_id VARCHAR(10))
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE nombre_ciudad VARCHAR(100) DEFAULT 'Sede no encontrada';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET nombre_ciudad = 'Sede no existe';

    SELECT c.Ciudad_Sede INTO nombre_ciudad
		FROM sede s
		INNER JOIN ciudad c ON s.Ciudad_id = c.Ciudad_id
		WHERE s.Id = p_sede_id;

    RETURN nombre_ciudad;
END //
DELIMITER ;

SELECT fn_obtener_ciudad_sede('S999') AS ciudad;