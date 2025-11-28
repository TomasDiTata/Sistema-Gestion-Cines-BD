DROP database IF EXISTS CineHoyts;
CREATE database CineHoyts;
USE CineHoyts;

CREATE TABLE complejos(
	id_complejo INT,
	nombre VARCHAR(30) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    altura INT 
    check (altura > 0),
    ciudad VARCHAR(30) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
    apertura TIME NOT NULL,
    cierre TIME NOT NULL
);

ALTER TABLE complejos 
MODIFY id_complejo INT AUTO_INCREMENT PRIMARY KEY;

CREATE TABLE tipo_sala(
	id_tipo_sala INT,
    descripcion VARCHAR(15)
);

ALTER TABLE tipo_sala
MODIFY id_tipo_sala INT AUTO_INCREMENT PRIMARY KEY;

CREATE TABLE salas(
	id_sala INT,
    columnas INT NOT NULL,
    filas INT NOT NULL,
    capacidad int,
    id_complejo int NOT NULL,
    id_tipo_sala int NOT NULL,
    check (filas > 0),
    check (columnas > 0)
);

ALTER TABLE salas
MODIFY id_sala INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE salas ADD foreign key (id_complejo)
REFERENCES complejos (id_complejo);

ALTER TABLE salas ADD foreign key (id_tipo_sala)
REFERENCES tipo_sala (id_tipo_sala);

DELIMITER $$

CREATE TRIGGER calcular_capacidad_sala
BEFORE INSERT ON salas
FOR EACH ROW
BEGIN
    SET NEW.capacidad = NEW.filas * NEW.columnas;
END$$

CREATE TRIGGER actualizar_capacidad_sala
BEFORE UPDATE ON salas
FOR EACH ROW
BEGIN
    SET NEW.capacidad = NEW.filas * NEW.columnas;
END$$

DELIMITER ;



CREATE TABLE peliculas(
	id_pelicula INT,
    nombre VARCHAR(30) NOT NULL,
    productora VARCHAR(20) NOT NULL,
    genero VARCHAR(40) NOT NULL,
    duracion TIME NOT NULL,
    clasificacion enum('Apta para todo publico', 'Recomienda supervision de padres', 'No apta para menores de 13 años', 'Apta para mayores de 18 años') NOT NULL
);

ALTER TABLE peliculas
MODIFY id_pelicula INT AUTO_INCREMENT PRIMARY KEY;

CREATE TABLE clientes(
	id_cliente INT, 
    dni INT NOT NULL UNIQUE,
    nombre VARCHAR(15) NOT NULL,
    apellido1 VARCHAR(15) NOT NULL,
	apellido2 VARCHAR(15) DEFAULT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    genero enum('Masculino', 'Femenino') NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

ALTER TABLE clientes 
MODIFY id_cliente INT AUTO_INCREMENT PRIMARY KEY;

CREATE TABLE funciones(
	id_funcion INT,
    fecha_hora DATETIME NOT NULL,
    idioma enum('Español', 'Ingles', 'Portugues') NOT NULL,
    formato VARCHAR(30),
    id_pelicula INT,
    id_sala INT
);

ALTER TABLE funciones 
MODIFY id_funcion INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE funciones ADD foreign key (id_pelicula)
REFERENCES peliculas (id_pelicula);

ALTER TABLE funciones ADD foreign key (id_sala)
REFERENCES salas (id_sala);

CREATE TABLE transacciones(
	id_transaccion INT,
    fila INT NOT NULL,
    columna_asiento CHAR(1)
    CHECK (ASCII(columna_asiento) BETWEEN 65 AND 90),
    estado enum('Ocupado', 'Libre'),
    id_funcion INT
);

ALTER TABLE transacciones 
MODIFY id_transaccion INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE transacciones ADD foreign key (id_funcion)
REFERENCES funciones (id_funcion);

CREATE TABLE entradas(
	id_entrada INT,
    fecha_compra DATETIME NOT NULL,
    precio DECIMAL(6,2) NOT NULL
    check (precio > 0),
    forma_pago VARCHAR(20) NOT NULL,
    id_cliente INT,
    id_transaccion INT
);

ALTER TABLE entradas
MODIFY id_entrada INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE entradas ADD foreign key (id_cliente)
REFERENCES clientes (id_cliente);

ALTER TABLE entradas ADD foreign key (id_transaccion)
REFERENCES transacciones (id_transaccion);

