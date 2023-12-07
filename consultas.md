# **Filtro Bases de Datos** 

1. Cantidad de Paradas por Ruta

   ```sql
   SELECT codigo_ruta, nombre_ruta, COUNT(parada_codigo) AS cantidad_paradas
   FROM programacion 
   JOIN rutas ON codigo_ruta = codigo_ruta
   GROUP BY codigo_ruta, nombre_ruta;
   +-------------+----------------+------------------+
   | codigo_ruta | nombre_ruta    | cantidad_paradas |
   +-------------+----------------+------------------+
   |          13 | Centro Florida |               39 |
   |          12 | Lagos          |               39 |
   |          11 | Autopista      |               39 |
   |          10 | Niza           |               39 |
   |           9 | Punta Estrella |               39 |
   |           8 | Ciudadela      |               39 |
   |           7 | Cabecera       |               39 |
   |           6 | Prado          |               39 |
   |           5 | Terminal       |               39 |
   |           4 | Diamantes      |               39 |
   |           3 | Cacique        |               39 |
   |           2 | Café Madrid    |               39 |
   |           1 | Universidades  |               39 |
   +-------------+----------------+------------------+
   ```

2. Nombre de las paradas de la ruta universidades

     ```sql
     SELECT DISTINCT estaciones.nombre_estacion
     FROM rutas
     JOIN programacion ON rutas.codigo_ruta = programacion.ruta_codigo
     JOIN estaciones ON programacion.parada_codigo = estaciones.codigo_parada
     WHERE rutas.nombre_ruta = 'Universidades';
     +--------------------+
     | nombre_estacion    |
     +--------------------+
     | Colseguros         |
     | Clínica Chicamocha |
     | Plaza Guarín       |
     | Mega Mall          |
     | UIS                |
     | UDI                |
     | Santo Tomás        |
     +--------------------+
     ```

3. Nombres de las Rutas No Programadas

     ```sql
     SELECT rutas.nombre_ruta
     FROM rutas
     LEFT JOIN programacion ON rutas.codigo_ruta = programacion.ruta_codigo
     WHERE programacion.ruta_codigo IS NULL OR programacion.ruta_codigo IS NOT NULL AND programacion.conductor_codigo IS NULL;
     +----------------+
     | nombre_ruta    |
     +----------------+
     | Cacique        |
     | Cacique        |
     | Cacique        |
     | Cacique        |
     | Cacique        |
     | Prado          |
     | Cabecera       |
     | Ciudadela      |
     | Ciudadela      |
     | Ciudadela      |
     | Punta Estrella |
     | Centro Florida |
     +----------------+
     ```

4. Rutas Programadas sin Conductor Asignado

     ```sql
     SELECT rutas.*
     FROM rutas
     LEFT JOIN programacion ON rutas.codigo_ruta = programacion.ruta_codigo
     WHERE programacion.conductor_codigo IS NULL;
     
     +-------------+----------------+-------------+-------------+
     | codigo_ruta | nombre_ruta    | tiempo_ruta | zona_codigo |
     +-------------+----------------+-------------+-------------+
     |           3 | Cacique        | 01:45:00    |        NULL |
     |           3 | Cacique        | 01:45:00    |        NULL |
     |           3 | Cacique        | 01:45:00    |        NULL |
     |           3 | Cacique        | 01:45:00    |        NULL |
     |           3 | Cacique        | 01:45:00    |        NULL |
     |           6 | Prado          | 01:30:00    |        NULL |
     |           7 | Cabecera       | 01:30:00    |        NULL |
     |           8 | Ciudadela      | 02:00:00    |        NULL |
     |           8 | Ciudadela      | 02:00:00    |        NULL |
     |           8 | Ciudadela      | 02:00:00    |        NULL |
     |           9 | Punta Estrella | 02:30:00    |        NULL |
     |          13 | Centro Florida | 02:30:00    |        NULL |
     +-------------+----------------+-------------+-------------+
     ```

5. Conductores No Asignados a la Programación

     ```sql
     SELECT conductores.*
     FROM conductores
     LEFT JOIN programacion ON conductores.codigo_conductor = programacion.conductor_codigo
     WHERE programacion.conductor_codigo IS NULL;
     +------------------+-----------------------------+-------------+
     | codigo_conductor | nombre_conductor            | zona_codigo |
     +------------------+-----------------------------+-------------+
     |                1 | Andrés Manuel López Obrador |        NULL |
     |                2 | Nicolás Maduro Moros        |        NULL |
     |                4 | Luiz Inácio Lula da Silva   |        NULL |
     |                8 | Gustavo Petro Urrego        |        NULL |
     |                9 | Luis Arce                   |        NULL |
     +------------------+-----------------------------+-------------+
     ```

6. Buses No asignados a la Programación

     ```sql
     SELECT buses.*
     FROM buses
     LEFT JOIN conductores_buses ON buses.codigo_bus = conductores_buses.bus_codigo
     WHERE conductores_buses.bus_codigo IS NULL;
     +------------+--------+
     | codigo_bus | placa  |
     +------------+--------+
     |          2 | XDL965 |
     |          8 | XXL757 |
     +------------+--------+
     ```
     
7. Zonas NO Programadas

     ```sql
     SELECT codigo_zona, nombre_zona
     FROM zonas 
     LEFT JOIN rutas ON codigo_zona = zona_codigo
     WHERE zona_codigo IS NULL;
     +-------------+-------------+
     | codigo_zona | nombre_zona |
     +-------------+-------------+
     |           2 | Sur         |
     |           3 | Oriente     |
     |           6 | Girón       |
     |           7 | Piedecuesta |
     +-------------+-------------+
     ```
     
8. Programación asignada a cada conductor (Conductor, Ruta y Día)

     ```sql
     SELECT DISTINCT conductores.nombre_conductor, rutas.nombre_ruta, dias_semana.nombre_dia
     FROM programacion
     JOIN conductores ON programacion.conductor_codigo = conductores.codigo_conductor
     JOIN rutas ON programacion.ruta_codigo = rutas.codigo_ruta
     JOIN dias_semana ON programacion.dia_codigo = dias_semana.codigo_dia;
     +-------------------+---------------+------------+
     | nombre_conductor  | nombre_ruta   | nombre_dia |
     +-------------------+---------------+------------+
     | Gabriel Boric     | Universidades | Lunes      |
     | Alberto Fernández | Diamantes     | Lunes      |
     | Xiomara Castro    | Niza          | Lunes      |
     | Daniel Ortega     | Autopista     | Lunes      |
     | Gabriel Boric     | Universidades | Martes     |
     | Alberto Fernández | Diamantes     | Martes     |
     | Xiomara Castro    | Niza          | Martes     |
     | Daniel Ortega     | Autopista     | Martes     |
     | Gabriel Boric     | Universidades | Miercoles  |
     | Alberto Fernández | Diamantes     | Miercoles  |
     | Xiomara Castro    | Niza          | Miercoles  |
     | Miguel Díaz-Canel | Lagos         | Miercoles  |
     | Gabriel Boric     | Universidades | Jueves     |
     | Alberto Fernández | Terminal      | Jueves     |
     | Xiomara Castro    | Niza          | Jueves     |
     | Miguel Díaz-Canel | Lagos         | Jueves     |
     | Gabriel Boric     | Café Madrid   | Viernes    |
     | Alberto Fernández | Terminal      | Viernes    |
     | Xiomara Castro    | Niza          | Viernes    |
     | Miguel Díaz-Canel | Lagos         | Viernes    |
     | Gabriel Boric     | Café Madrid   | Sabado     |
     | Alberto Fernández | Terminal      | Sabado     |
     | Xiomara Castro    | Autopista     | Sabado     |
     | Miguel Díaz-Canel | Lagos         | Sabado     |
     | Gabriel Boric     | Café Madrid   | Domingo    |
     | Alberto Fernández | Terminal      | Domingo    |
     | Xiomara Castro    | Autopista     | Domingo    |
     | Miguel Díaz-Canel | Lagos         | Domingo    |
     +-------------------+---------------+------------+
     ```

9. Programación asignada a conductores que hacen rutas de más de dos horas

     ```sql
     SELECT *
     FROM programacion
     WHERE ruta_codigo IN (SELECT codigo_ruta FROM rutas WHERE tiempo_ruta > '02:00:00');
     +-------------+---------------+------------------+------------+
     | ruta_codigo | parada_codigo | conductor_codigo | dia_codigo |
     +-------------+---------------+------------------+------------+
     |           2 |          NULL |                5 |          5 |
     |           2 |          NULL |                5 |          6 |
     |           2 |          NULL |                5 |          7 |
     |           9 |          NULL |             NULL |       NULL |
     |          10 |          NULL |               10 |          1 |
     |          10 |          NULL |               10 |          2 |
     |          10 |          NULL |               10 |          3 |
     |          10 |          NULL |               10 |          4 |
     |          10 |          NULL |               10 |          5 |
     |          11 |          NULL |               10 |          6 |
     |          11 |          NULL |               10 |          7 |
     |          11 |          NULL |                7 |          1 |
     |          11 |          NULL |                7 |          2 |
     |          12 |          NULL |                6 |          3 |
     |          12 |          NULL |                6 |          4 |
     |          12 |          NULL |                6 |          5 |
     |          12 |          NULL |                6 |          6 |
     |          12 |          NULL |                6 |          7 |
     |          13 |          NULL |             NULL |       NULL |
     +-------------+---------------+------------------+------------+
     ```

10. Nombres de Zonas y cantidad de rutas que tienen programadas (Contar)

    ```sql
    SELECT zonas.nombre_zona, COUNT(rutas.codigo_ruta) as cantidad_rutas
    FROM zonas
    JOIN rutas ON zonas.codigo_zona = rutas.zona_codigo
    GROUP BY zonas.codigo_zona;
    +---------------+----------------+
    | nombre_zona   | cantidad_rutas |
    +---------------+----------------+
    | Norte         |              2 |
    | Occidente     |              2 |
    | Floridablanca |              3 |
    +---------------+----------------+
    ```
