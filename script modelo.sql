CREATE TABLE `estaciones`(
    `codigo_parada` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_estacion` VARCHAR(50)
);
CREATE TABLE `conductores_buses`(
    `conductor_codigo` INT ,
    `bus_codigo` INT 
);
CREATE TABLE `dias_semana`(
    `codigo_dia` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_dia` VARCHAR(50) 
);
CREATE TABLE `rutas`(
    `codigo_ruta` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_ruta` VARCHAR(50),
    `tiempo_ruta` TIME,
    `zona_codigo` INT 
);
CREATE TABLE `buses`(
    `codigo_bus` INT AUTO_INCREMENT PRIMARY KEY,
    `placa` VARCHAR(50)
);
ALTER TABLE
    `buses` ADD PRIMARY KEY(`codigo_bus`);
CREATE TABLE `programacion`(
    `ruta_codigo` INT,
    `parada_codigo` INT,
    `conductor_codigo` INT,
    `dia_codigo` INT 
);
CREATE TABLE `zonas`(
    `codigo_zona` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_zona` VARCHAR(50)
);
CREATE TABLE `conductores`(
    `codigo_conductor` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_conductor` VARCHAR(50),
    `zona_codigo` INT 
);
ALTER TABLE
    `rutas` ADD CONSTRAINT `rutas_zona_codigo_foreign` FOREIGN KEY(`zona_codigo`) REFERENCES `zonas`(`codigo_zona`);
ALTER TABLE
    `conductores_buses` ADD CONSTRAINT `conductores_buses_conductor_codigo_foreign` FOREIGN KEY(`conductor_codigo`) REFERENCES `conductores`(`codigo_conductor`);
ALTER TABLE
    `programacion` ADD CONSTRAINT `programacion_dia_codigo_foreign` FOREIGN KEY(`dia_codigo`) REFERENCES `dias_semana`(`codigo_dia`);
ALTER TABLE
    `conductores_buses` ADD CONSTRAINT `conductores_buses_bus_codigo_foreign` FOREIGN KEY(`bus_codigo`) REFERENCES `buses`(`codigo_bus`);
ALTER TABLE
    `programacion` ADD CONSTRAINT `programacion_conductor_codigo_foreign` FOREIGN KEY(`conductor_codigo`) REFERENCES `conductores`(`codigo_conductor`);
ALTER TABLE
    `conductores` ADD CONSTRAINT `conductores_zona_codigo_foreign` FOREIGN KEY(`zona_codigo`) REFERENCES `zonas`(`codigo_zona`);
ALTER TABLE
    `programacion` ADD CONSTRAINT `programacion_parada_codigo_foreign` FOREIGN KEY(`parada_codigo`) REFERENCES `estaciones`(`codigo_parada`);
ALTER TABLE
    `programacion` ADD CONSTRAINT `programacion_ruta_codigo_foreign` FOREIGN KEY(`ruta_codigo`) REFERENCES `rutas`(`codigo_ruta`);



INSERT INTO zonas VALUES 
(1, 'Norte'),
(2, 'Sur'),
(3, 'Oriente'),
(4, 'Occidente'),
(5, 'Floridablanca'),
(6, 'Girón'),
(7, 'Piedecuesta');

INSERT INTO rutas VALUES
(1, 'Universidades', '2:00:00', 1),
(2, 'Café Madrid', '2:15:00', 1),
(3, 'Cacique', '1:45:00', NULL ),
(4, 'Diamantes', '1:50:00', 4),
(5, 'Terminal', '2:00:00', 4),
(6, 'Prado', '1:30:00', NULL),
(7, 'Cabecera', '1:30:00', NULL),
(8, 'Ciudadela', '2:00:00', NULL),
(9, 'Punta Estrella', '2:30:00', NULL),
(10, 'Niza', '2:45:00', 5),
(11, 'Autopista', '2:15:00', 5),
(12, 'Lagos', '2:15:00', 5),
(13, 'Centro Florida', '2:30:00', NULL);

INSERT INTO estaciones VALUES
(1, 'Colseguros'),
(2, 'Clínica Chicamocha'),
(3, 'Plaza Guarín'),
(4, 'Mega Mall'),
(5, 'UIS'),
(6, 'UDI'),
(7, 'Santo Tomás'),
(8, 'Boulevard Santander'),
(9, 'Búcaros'),
(10, 'Rosita'),
(11, 'Puerta del Sol'),
(12, 'Cacique'),
(13, 'Plaza Satélite'),
(14, 'La Sirena'),
(15, 'Provenza'),
(16, 'Fontana'),
(17, 'Gibraltar'),
(18, 'Terminal'),
(19, 'Mutis'),
(20, 'Plaza Real');

INSERT INTO conductores VALUES
(1, 'Andrés Manuel López Obrador', NULL),
(2, 'Nicolás Maduro Moros', NULL),
(3, 'Alberto Fernández', 4),
(4, 'Luiz Inácio Lula da Silva', NULL),
(5, 'Gabriel Boric', 1),
(6, 'Miguel Díaz-Canel', 5),
(7, 'Daniel Ortega', 5),
(8, 'Gustavo Petro Urrego', NULL),
(9, 'Luis Arce', NULL),
(10, 'Xiomara Castro', 5);

INSERT INTO buses VALUES
(1, 'XVH345'),
(2, 'XDL965'),
(3, 'XFG847'),
(4, 'XRJ452'),
(5, 'XDF459'),
(6, 'XET554'),
(7, 'XKL688'),
(8, 'XXL757');

INSERT INTO conductores_buses VALUES
(1, NULL),
(2, NULL),
(3, 5),
(3, 6),
(3, 1),
(3, 3),
(4, NULL),
(5, 1),
(5, 3),
(5, 5),
(6, 7),
(6, 6),
(7, 7),
(8, NULL),
(9, NULL),
(10, 3),
(10, 5),
(10, 4),
(10, 7);

INSERT INTO dias_semana (nombre_dia) VALUES
('Lunes'),
('Martes'),
('Miercoles'),
('Jueves'),
('Viernes'),
('Sabado'),
('Domingo');

INSERT INTO programacion VALUES
(1,	1, 5, 1),
(1,	1, 5, 2),
(1,	2, 5, 3),
(1,	3, 5, 3),
(1,	4, 5, 3),
(1,	5, 5, 3),
(1,	6, 5, 3),
(1,	7, 5, 3),
(1,	2, 5, 4),
(1,	3, 5, 4),
(1,	4, 5, 4),
(1,	5, 5, 4),
(1,	6, 5, 4),
(1,	7, 5, 4),
(2, NULL, 5, 5),
(2, NULL, 5, 6),
(2, NULL, 5, 7),
(3,	8, NULL, NULL),
(3,	9, NULL, NULL),
(3,	10, NULL, NULL),
(3,	11, NULL, NULL),
(3,	12, NULL, NULL),
(4,	13, 3, 1),
(4,	14, 3, 1),
(4,	15, 3, 1),
(4,	13, 3, 2),
(4,	14, 3, 2),
(4,	15, 3, 2),
(4,	13, 3, 3),
(4,	14, 3, 3),
(4,	15, 3, 3),
(5,	16, 3, 4),
(5,	17, 3, 4),
(5,	16, 3, 5),
(5,	17, 3, 5),
(5,	16, 3, 6),
(5,	17, 3, 6),
(5,	16, 3, 7),
(5,	17, 3, 7),
(6, NULL, NULL, NULL),
(7, NULL, NULL, NULL),
(8, 18, NULL, NULL),
(8, 19, NULL, NULL),
(8, 20, NULL, NULL),
(9, NULL, NULL, NULL),
(10, NULL, 10, 1),
(10, NULL, 10, 2),
(10, NULL, 10, 3),
(10, NULL, 10, 4),
(10, NULL, 10, 5),
(11, NULL, 10, 6),
(11, NULL, 10, 7),
(11, NULL, 7, 1),
(11, NULL, 7, 2),
(12, NULL, 6, 3),
(12, NULL, 6, 4),
(12, NULL, 6, 5),
(12, NULL, 6, 6),
(12, NULL, 6, 7),
(13, NULL, NULL, NULL);
