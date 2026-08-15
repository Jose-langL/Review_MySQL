CREATE TABLE socios_por_sede (
    id INT NOT NULL,
    Socio_ID INT NOT NULL,
    Sede_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (id, Sede_id)
)
PARTITION BY LIST COLUMNS(Sede_id) (
    PARTITION p_norte VALUES IN ('S001', 'S002'),
    PARTITION p_sur VALUES IN ('S003', 'S004'),
    PARTITION p_centro VALUES IN ('S005')
);CREATE TABLE socios_por_sede (
    id INT NOT NULL,
    Socio_ID INT NOT NULL,
    Sede_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (id, Sede_id)
)
PARTITION BY LIST COLUMNS(Sede_id) (
    PARTITION p_norte VALUES IN ('S001', 'S002'),
    PARTITION p_sur VALUES IN ('S003', 'S004'),
    PARTITION p_centro VALUES IN ('S005')
);