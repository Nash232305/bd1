-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tarea_6
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tarea_6
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tarea_6` DEFAULT CHARACTER SET utf8mb3 ;
USE `tarea_6` ;

-- -----------------------------------------------------
-- Table `tarea_6`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`direccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provincia` VARCHAR(45) NULL DEFAULT NULL,
  `canton` VARCHAR(45) NULL DEFAULT NULL,
  `distrito` VARCHAR(45) NULL DEFAULT NULL,
  `senas` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tarea_6`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`cliente` (
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion_id` INT NOT NULL,
  PRIMARY KEY (`cedula`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC) VISIBLE,
  INDEX `fk_Cliente_direccion1_idx` (`direccion_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_direccion1`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `tarea_6`.`direccion` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tarea_6`.`correo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`correo` (
  `idCorreo` INT NOT NULL AUTO_INCREMENT,
  `correo` VARCHAR(45) NULL DEFAULT NULL,
  `Cliente_cedula` INT NOT NULL,
  PRIMARY KEY (`idCorreo`),
  INDEX `fk_Correo_Cliente1_idx` (`Cliente_cedula` ASC) VISIBLE,
  CONSTRAINT `fk_Correo_Cliente1`
    FOREIGN KEY (`Cliente_cedula`)
    REFERENCES `tarea_6`.`cliente` (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tarea_6`.`libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`libro` (
  `idLibro` INT NOT NULL,
  `autor` VARCHAR(45) NULL DEFAULT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `precio` FLOAT NULL DEFAULT NULL,
  `genero` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tarea_6`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `total` FLOAT NOT NULL,
  `Cliente_cedula` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_cedula` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_cedula`)
    REFERENCES `tarea_6`.`cliente` (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tarea_6`.`listadolibro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`listadolibro` (
  `idlistadoLibro` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL DEFAULT NULL,
  `idLibro` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idlistadoLibro`),
  INDEX `fk_listadoLibro_Libro1_idx` (`idLibro` ASC) VISIBLE,
  INDEX `fk_listadoLibro_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_listadoLibro_Libro1`
    FOREIGN KEY (`idLibro`)
    REFERENCES `tarea_6`.`libro` (`idLibro`),
  CONSTRAINT `fk_listadoLibro_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `tarea_6`.`pedido` (`idPedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tarea_6`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarea_6`.`stock` (
  `idStock` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL DEFAULT NULL,
  `idLibro` INT NOT NULL,
  PRIMARY KEY (`idStock`),
  INDEX `fk_Stock_Libro_idx` (`idLibro` ASC) VISIBLE,
  UNIQUE INDEX `idStock_UNIQUE` (`idStock` ASC) VISIBLE,
  CONSTRAINT `fk_Stock_Libro`
    FOREIGN KEY (`idLibro`)
    REFERENCES `tarea_6`.`libro` (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- --------------------------------------------------------------------------------------------------
/*procedimiento almacenado para agregar libros

Crear un procedimiento almacenado que permita agregar nuevos libros a la base de datos
de libros.
*/
DELIMITER //
DROP PROCEDURE IF EXISTS AgregarLibro;
CREATE PROCEDURE AgregarLibro(
  IN p_id INT,
  IN p_autor VARCHAR(45),
  IN p_titulo VARCHAR(45),
  IN p_precio FLOAT,
  IN p_genero VARCHAR(45),
  IN p_cantidad INT
)
BEGIN
  INSERT INTO libro (idLibro, autor, titulo, precio, genero)
  VALUES (p_id, p_autor, p_titulo, p_precio, p_genero);
  
  INSERT INTO stock (cantidad, idLibro)
  VALUES (p_cantidad, p_id);
END //

DELIMITER ;
-- --------------------------------------------------------------------------------------------------
/*Procedimiento almacenado para realizar pedidos

Crea un procedimiento almacenado que permita a un cliente realizar un pedido. Esto debe
disminuir el stock disponible de libros en la tabla de libros.
*/
DELIMITER //
DROP PROCEDURE IF EXISTS RealizarPedido;
CREATE PROCEDURE RealizarPedido(
  IN p_cedulaCliente INT,
  IN p_idLibro INT,
  IN p_cantidad INT,
  IN p_fechaPedido DATE
)
BEGIN
  -- Verificar si hay suficiente stock del libro
  DECLARE stockDisponible INT;
  SELECT cantidad INTO stockDisponible FROM stock WHERE idLibro = p_idLibro;
  IF p_cantidad <= stockDisponible THEN
    -- Registrar el pedido
    INSERT INTO pedido (Cliente_cedula, fecha, total) VALUES (p_cedulaCliente, p_fechaPedido, 0);
    SET @idPedido = LAST_INSERT_ID();

    INSERT INTO listadolibro (cantidad, idLibro, Pedido_idPedido) VALUES (p_cantidad, p_idLibro, @idPedido);
    -- Llamar a la función para calcular el total y actualizar el campo "total" en la tabla de pedido
    select calcularTotalPedido(@idPedido);
  ELSE
    -- Si no hay suficiente stock, lanzar una excepción
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No hay suficiente stock para realizar este pedido';
  END IF;
END //
DELIMITER ;
-- --------------------------------------------------------------------------------------------------
/*
Funcion para calcular total de pedido

Crear una función que acepte un identificador de pedido y calcule el total del pedido
sumando los precios de los libros solicitados en ese pedido.
*/
DELIMITER //
DROP FUNCTION IF EXISTS calcularTotalPedido;
CREATE FUNCTION calcularTotalPedido(idPedido INT) RETURNS FLOAT DETERMINISTIC
BEGIN
    DECLARE totalPrecio FLOAT;
    
    SELECT SUM(libro.precio * listadolibro.cantidad)
    INTO totalPrecio
    FROM libro
    INNER JOIN listadolibro ON libro.idLibro = listadolibro.idLibro
    WHERE listadolibro.Pedido_idPedido = idPedido;
    UPDATE pedido SET total = totalPrecio WHERE pedido.idPedido = idPedido;
    RETURN totalPrecio;
END //
DELIMITER ;
-- --------------------------------------------------------------------------------------------------
/*
trigger para actualizar stock

Crea un disparador que se activa cuando se registra un nuevo pedido. Este disparador debe
actualizar el stock disponible de libros en la tabla de libros para reflejar la cantidad vendida
en el pedido.
*/
DELIMITER //
CREATE TRIGGER ActualizarStock
AFTER INSERT ON listadolibro FOR EACH ROW
BEGIN
  UPDATE stock
  SET cantidad = cantidad - NEW.cantidad
  WHERE idLibro = NEW.idLibro;
END //
DELIMITER ;
-- --------------------------------------------------------------------------------------------------
-- PRUEBA DE FUNCIONAMIENTO
CALL AgregarLibro(120, 'Miguel de Cervantes', 'Don Quijote', 8000, 'Novela', 14);

SELECT l.*, s.cantidad FROM libro l
LEFT JOIN stock s ON l.idLibro = s.idLibro;

INSERT INTO Direccion values(1, 'Limon', 'Limon', 'Limon 2000', 'Limon 2000');
INSERT INTO Cliente values(2021051418, 'Hengerlyn Nash', 1);

SET @fechaActual = CURDATE(); 
CALL RealizarPedido(2021051418, 120, 14, @fechaActual);
select * from pedido;