SELECT s.nombre, s.apellido
FROM Socios s
JOIN Socio_Plan_Entrenamiento sp
    ON s.Socio_ID = sp.Socio_ID
JOIN sede se
    ON sp.Sede_id = se.Id
JOIN ciudad c
    ON se.Ciudad_id = c.Ciudad_id;