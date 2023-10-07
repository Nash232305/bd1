-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso-1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema caso-1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso-1` DEFAULT CHARACTER SET utf8 ;
USE `caso-1` ;

-- -----------------------------------------------------
-- Table `caso-1`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Usuario` (
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `dependencia` VARCHAR(45) NULL,
  `rol` VARCHAR(45) NULL,
  `ultimaVisitaDoctor` DATE NULL,
  PRIMARY KEY (`cedula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Compania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Compania` (
  `codigoCompania` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `numeroPatronal` INT NULL,
  `cedulaPresidente` INT NULL,
  `cedulaGerente` INT NOT NULL,
  PRIMARY KEY (`codigoCompania`),
  INDEX `fk_Compania_Usuario_idx` (`cedulaGerente` ASC) VISIBLE,
  CONSTRAINT `fk_Compania_Usuario`
    FOREIGN KEY (`cedulaGerente`)
    REFERENCES `caso-1`.`Usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Proveedor` (
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `tipoProveedor` VARCHAR(45) NULL,
  `nombreContacto` VARCHAR(45) NULL,
  `codigoCompania` INT NOT NULL,
  PRIMARY KEY (`cedula`),
  INDEX `fk_Proveedor_Compania1_idx` (`codigoCompania` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_Compania1`
    FOREIGN KEY (`codigoCompania`)
    REFERENCES `caso-1`.`Compania` (`codigoCompania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Cliente` (
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`cedula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Segmento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Segmento` (
  `codigo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `codigoCompania` INT NOT NULL,
  `gerenteID` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_table1_Compania1_idx` (`codigoCompania` ASC) VISIBLE,
  INDEX `fk_Segmento_Usuario1_idx` (`gerenteID` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Compania1`
    FOREIGN KEY (`codigoCompania`)
    REFERENCES `caso-1`.`Compania` (`codigoCompania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Segmento_Usuario1`
    FOREIGN KEY (`gerenteID`)
    REFERENCES `caso-1`.`Usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Inventario` (
  `codigo` INT NOT NULL,
  `stock` INT NULL,
  `ultimaCompra` DATE NULL,
  `ultimoInventario` DATE NULL,
  `Segmento_codigo` INT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Inventario_Segmento1_idx` (`Segmento_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Inventario_Segmento1`
    FOREIGN KEY (`Segmento_codigo`)
    REFERENCES `caso-1`.`Segmento` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Orden` (
  `numero` INT NOT NULL,
  `fecha` DATE NULL,
  `idComprador` INT NULL,
  `montoTotal` FLOAT NULL,
  `idAprobador` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Orden_Usuario1_idx` (`idAprobador` ASC) VISIBLE,
  CONSTRAINT `fk_Orden_Usuario1`
    FOREIGN KEY (`idAprobador`)
    REFERENCES `caso-1`.`Usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`LineaProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`LineaProducto` (
  `idlineaProducto` INT NOT NULL,
  `cantidadOrdenada` INT NULL,
  `precioXarticulo` FLOAT NULL,
  `totalLinea` FLOAT NULL,
  `Orden_numero` INT NOT NULL,
  PRIMARY KEY (`idlineaProducto`),
  INDEX `fk_LineaProducto_Orden1_idx` (`Orden_numero` ASC) VISIBLE,
  CONSTRAINT `fk_LineaProducto_Orden1`
    FOREIGN KEY (`Orden_numero`)
    REFERENCES `caso-1`.`Orden` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`Articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`Articulo` (
  `codigo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `tipo` VARCHAR(45) NULL,
  `precioUnitario` FLOAT NULL,
  `Inventario_codigo` INT NOT NULL,
  `LineaProducto_idlineaProducto` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Articulo_Inventario1_idx` (`Inventario_codigo` ASC) VISIBLE,
  INDEX `fk_Articulo_LineaProducto1_idx` (`LineaProducto_idlineaProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Articulo_Inventario1`
    FOREIGN KEY (`Inventario_codigo`)
    REFERENCES `caso-1`.`Inventario` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_LineaProducto1`
    FOREIGN KEY (`LineaProducto_idlineaProducto`)
    REFERENCES `caso-1`.`LineaProducto` (`idlineaProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`PrecioVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`PrecioVenta` (
  `idPrecioVenta` INT NOT NULL,
  `precioVenta` FLOAT NULL,
  `Articulo_codigo` INT NOT NULL,
  PRIMARY KEY (`idPrecioVenta`),
  INDEX `fk_PrecioVenta_Articulo1_idx` (`Articulo_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_PrecioVenta_Articulo1`
    FOREIGN KEY (`Articulo_codigo`)
    REFERENCES `caso-1`.`Articulo` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso-1`.`ClienteXSegmento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-1`.`ClienteXSegmento` (
  `Cliente_cedula` INT NOT NULL,
  `Segmento_codigo` INT NOT NULL,
  PRIMARY KEY (`Cliente_cedula`, `Segmento_codigo`),
  INDEX `fk_Cliente_has_Segmento_Segmento1_idx` (`Segmento_codigo` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Segmento_Cliente1_idx` (`Cliente_cedula` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Segmento_Cliente1`
    FOREIGN KEY (`Cliente_cedula`)
    REFERENCES `caso-1`.`Cliente` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Segmento_Segmento1`
    FOREIGN KEY (`Segmento_codigo`)
    REFERENCES `caso-1`.`Segmento` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- INSERT statements for Usuario table
INSERT INTO `caso-1`.`Usuario` (`cedula`, `nombre`, `dependencia`, `rol`, `ultimaVisitaDoctor`) VALUES
(1, 'John Doe', 'Department A', 'Manager', '2023-01-01'),
(2, 'Jane Smith', 'Department B', 'Employee', '2023-02-15'),
(3, 'Alice Johnson', 'Department C', 'Employee', '2023-03-10'),
(4, 'Bob Wilson', 'Department D', 'Manager', '2023-04-20'),
(5, 'Eve Brown', 'Department E', 'Employee', '2023-05-25'),
(6, 'Charlie Davis', 'Department F', 'Employee', '2023-06-30'),
(7, 'Grace Lee', 'Department G', 'Manager', '2023-07-10'),
(8, 'Daniel Miller', 'Department H', 'Employee', '2023-08-15'),
(9, 'Olivia Martinez', 'Department I', 'Employee', '2023-09-20'),
(10, 'Mike Johnson', 'Department J', 'Employee', '2023-10-05');

-- INSERT statements for Compania table
INSERT INTO `caso-1`.`Compania` (`codigoCompania`, `nombre`, `direccion`, `numeroPatronal`, `cedulaPresidente`, `cedulaGerente`) VALUES
(1, 'Company A', 'Address A', 12345, 1, 1),
(2, 'Company B', 'Address B', 67890, 2, 2),
(3, 'Company C', 'Address C', 13579, 3, 3),
(4, 'Company D', 'Address D', 24680, 4, 4),
(5, 'Company E', 'Address E', 98765, 5, 5),
(6, 'Company F', 'Address F', 54321, 6, 6),
(7, 'Company G', 'Address G', 10101, 7, 7),
(8, 'Company H', 'Address H', 11223, 8, 8),
(9, 'Company I', 'Address I', 13131, 9, 9),
(10, 'Company J', 'Address J', 14141, 10, 10);

-- INSERT statements for Proveedor table
INSERT INTO `caso-1`.`Proveedor` (`cedula`, `nombre`, `direccion`, `telefono`, `tipoProveedor`, `nombreContacto`, `codigoCompania`) VALUES
(1, 'Supplier A', 'Address A', '1234567890', 'Type A', 'Contact A', 1),
(2, 'Supplier B', 'Address B', '0987654321', 'Type B', 'Contact B', 2),
(3, 'Supplier C', 'Address C', '1122334455', 'Type C', 'Contact C', 3),
(4, 'Supplier D', 'Address D', '5544332211', 'Type D', 'Contact D', 4),
(5, 'Supplier E', 'Address E', '9876543210', 'Type E', 'Contact E', 5),
(6, 'Supplier F', 'Address F', '1237894560', 'Type F', 'Contact F', 6),
(7, 'Supplier G', 'Address G', '4561237890', 'Type G', 'Contact G', 7),
(8, 'Supplier H', 'Address H', '7890123456', 'Type H', 'Contact H', 8),
(9, 'Supplier I', 'Address I', '5678901234', 'Type I', 'Contact I', 9),
(10, 'Supplier J', 'Address J', '3456789012', 'Type J', 'Contact J', 10);

-- INSERT statements for Cliente table
INSERT INTO `caso-1`.`Cliente` (`cedula`, `nombre`, `direccion`, `telefono`) VALUES
(1, 'Customer A', 'Address A', '1234567890'),
(2, 'Customer B', 'Address B', '0987654321'),
(3, 'Customer C', 'Address C', '1122334455'),
(4, 'Customer D', 'Address D', '5544332211'),
(5, 'Customer E', 'Address E', '9876543210'),
(6, 'Customer F', 'Address F', '1237894560'),
(7, 'Customer G', 'Address G', '4561237890'),
(8, 'Customer H', 'Address H', '7890123456'),
(9, 'Customer I', 'Address I', '5678901234'),
(10, 'Customer J', 'Address J', '3456789012');

-- INSERT statements for Segmento table
INSERT INTO `caso-1`.`Segmento` (`codigo`, `descripcion`, `codigoCompania`, `gerenteID`) VALUES
(1, 'Segment A', 1, 1),
(2, 'Segment B', 2, 2),
(3, 'Segment C', 3, 3),
(4, 'Segment D', 4, 4),
(5, 'Segment E', 5, 5),
(6, 'Segment F', 6, 6),
(7, 'Segment G', 7, 7),
(8, 'Segment H', 8, 8),
(9, 'Segment I', 9, 9),
(10, 'Segment J', 10, 10);

-- INSERT statements for Inventario table
INSERT INTO `caso-1`.`Inventario` (`codigo`, `stock`, `ultimaCompra`, `ultimoInventario`, `Segmento_codigo`) VALUES
(1, 100, '2023-01-01', '2023-01-01', 1),
(2, 200, '2023-02-01', '2023-02-01', 2),
(3, 300, '2023-03-01', '2023-03-01', 3),
(4, 400, '2023-04-01', '2023-04-01', 4),
(5, 500, '2023-05-01', '2023-05-01', 5),
(6, 600, '2023-06-01', '2023-06-01', 6),
(7, 700, '2023-07-01', '2023-07-01', 7),
(8, 800, '2023-08-01', '2023-08-01', 8),
(9, 900, '2023-09-01', '2023-09-01', 9),
(10, 1000, '2023-10-01', '2023-10-01', 10);

-- INSERT statements for Orden table
INSERT INTO `caso-1`.`Orden` (`numero`, `fecha`, `idComprador`, `montoTotal`, `idAprobador`) VALUES
(1, '2023-01-01', 1, 100.00, 1),
(2, '2023-02-01', 2, 200.00, 2),
(3, '2023-03-01', 3, 300.00, 3),
(4, '2023-04-01', 4, 400.00, 4),
(5, '2023-05-01', 5, 500.00, 5),
(6, '2023-06-01', 6, 600.00, 6),
(7, '2023-07-01', 7, 700.00, 7),
(8, '2023-08-01', 8, 800.00, 8),
(9, '2023-09-01', 9, 900.00, 9),
(10, '2023-10-01', 10, 1000.00, 10);

-- INSERT statements for LineaProducto table
INSERT INTO `caso-1`.`LineaProducto` (`idlineaProducto`, `cantidadOrdenada`, `precioXarticulo`, `totalLinea`, `Orden_numero`) VALUES
(1, 10, 10.00, 100.00, 1),
(2, 20, 20.00, 400.00, 2),
(3, 30, 30.00, 900.00, 3),
(4, 40, 40.00, 1600.00, 4),
(5, 50, 50.00, 2500.00, 5),
(6, 60, 60.00, 3600.00, 6),
(7, 70, 70.00, 4900.00, 7),
(8, 80, 80.00, 6400.00, 8),
(9, 90, 90.00, 8100.00, 9),
(10, 100, 100.00, 10000.00, 10);

-- INSERT statements for Articulo table
INSERT INTO `caso-1`.`Articulo` (`codigo`, `descripcion`, `tipo`, `precioUnitario`, `Inventario_codigo`, `LineaProducto_idlineaProducto`) VALUES
(1, 'Product A', 'Type A', 10.00, 1, 1),
(2, 'Product B', 'Type B', 20.00, 2, 2),
(3, 'Product C', 'Type C', 30.00, 3, 3),
(4, 'Product D', 'Type D', 40.00, 4, 4),
(5, 'Product E', 'Type E', 50.00, 5, 5),
(6, 'Product F', 'Type F', 60.00, 6, 6),
(7, 'Product G', 'Type G', 70.00, 7, 7),
(8, 'Product H', 'Type H', 80.00, 8, 8),
(9, 'Product I', 'Type I', 90.00, 9, 9),
(10, 'Product J', 'Type J', 100.00, 10, 10);

-- INSERT statements for PrecioVenta table
INSERT INTO `caso-1`.`PrecioVenta` (`idPrecioVenta`, `precioVenta`, `Articulo_codigo`) VALUES
(1, 15.00, 1),
(2, 25.00, 2),
(3, 35.00, 3),
(4, 45.00, 4),
(5, 55.00, 5),
(6, 65.00, 6),
(7, 75.00, 7),
(8, 85.00, 8),
(9, 95.00, 9),
(10, 105.00, 10);

-- INSERT statements for ClienteXSegmento table
INSERT INTO `caso-1`.`ClienteXSegmento` (`Cliente_cedula`, `Segmento_codigo`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


select * from Articulo;