-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso-2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema caso-2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso-2` DEFAULT CHARACTER SET utf8mb3 ;
USE `caso-2` ;

-- -----------------------------------------------------
-- Table `caso-2`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-2`.`persona` (
  `cedula` INT NOT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso-2`.`cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-2`.`cuenta` (
  `numero` INT NOT NULL,
  `monto` FLOAT NULL DEFAULT NULL,
  `fechaVencimiento` DATE NULL DEFAULT NULL,
  `Persona_cedula` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Cuenta_Persona1_idx` (`Persona_cedula` ASC) VISIBLE,
  CONSTRAINT `fk_Cuenta_Persona1`
    FOREIGN KEY (`Persona_cedula`)
    REFERENCES `caso-2`.`persona` (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso-2`.`formapago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-2`.`formapago` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso-2`.`abono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-2`.`abono` (
  `fecha` DATE NULL DEFAULT NULL,
  `monto` FLOAT NULL DEFAULT NULL,
  `cuota` INT NOT NULL,
  `FormaPago_codigo` INT NOT NULL,
  INDEX `fk_Abono_Cuenta1_idx` (`cuota` ASC) VISIBLE,
  INDEX `fk_Abono_FormaPago1_idx` (`FormaPago_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Abono_Cuenta1`
    FOREIGN KEY (`cuota`)
    REFERENCES `caso-2`.`cuenta` (`numero`),
  CONSTRAINT `fk_Abono_FormaPago1`
    FOREIGN KEY (`FormaPago_codigo`)
    REFERENCES `caso-2`.`formapago` (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso-2`.`personafisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-2`.`personafisica` (
  `fechaNacimiento` DATE NULL DEFAULT NULL,
  `Persona_cedula` INT NOT NULL,
  INDEX `fk_PersonaFisica_Persona_idx` (`Persona_cedula` ASC) VISIBLE,
  CONSTRAINT `fk_PersonaFisica_Persona`
    FOREIGN KEY (`Persona_cedula`)
    REFERENCES `caso-2`.`persona` (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso-2`.`personajuridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso-2`.`personajuridica` (
  `nombreComercial` VARCHAR(45) NULL DEFAULT NULL,
  `Persona_cedula` INT NOT NULL,
  INDEX `fk_PersonaJuridica_Persona1_idx` (`Persona_cedula` ASC) VISIBLE,
  CONSTRAINT `fk_PersonaJuridica_Persona1`
    FOREIGN KEY (`Persona_cedula`)
    REFERENCES `caso-2`.`persona` (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `caso-2`.`persona` (`cedula`, `tipo`, `nombre`) VALUES
(1, 'Tipo1', 'Nombre1'),
(2, 'Tipo2', 'Nombre2'),
(3, 'Tipo3', 'Nombre3'),
(4, 'Tipo4', 'Nombre4'),
(5, 'Tipo5', 'Nombre5'),
(6, 'Tipo6', 'Nombre6'),
(7, 'Tipo7', 'Nombre7'),
(8, 'Tipo8', 'Nombre8'),
(9, 'Tipo9', 'Nombre9'),
(10, 'Tipo10', 'Nombre10');

INSERT INTO `caso-2`.`personafisica` (`fechaNacimiento`, `Persona_cedula`) VALUES
('1990-05-15', 1),
('1985-08-20', 2),
('1992-12-05', 3),
('1988-04-30', 4),
('1995-09-10', 5),
('1987-02-25', 6),
('1998-07-08', 7),
('1989-11-12', 8),
('1994-03-18', 9),
('1991-06-22', 10);

INSERT INTO `caso-2`.`personajuridica` (`nombreComercial`, `Persona_cedula`) VALUES
('Comercial1', 1),
('Comercial2', 2),
('Comercial3', 3),
('Comercial4', 4),
('Comercial5', 5),
('Comercial6', 6),
('Comercial7', 7),
('Comercial8', 8),
('Comercial9', 9),
('Comercial10', 10);

INSERT INTO `caso-2`.`cuenta` (`numero`, `monto`, `fechaVencimiento`, `Persona_cedula`) VALUES
(101, 1000.0, '2023-10-15', 1),
(102, 1500.0, '2023-11-20', 2),
(103, 800.0, '2023-12-10', 3),
(104, 2000.0, '2024-01-05', 4),
(105, 1200.0, '2024-02-15', 5),
(106, 900.0, '2024-03-25', 6),
(107, 1800.0, '2024-04-10', 7),
(108, 1300.0, '2024-05-20', 8),
(109, 600.0, '2024-06-30', 9),
(110, 2100.0, '2024-07-15', 10);

INSERT INTO `caso-2`.`formapago` (`codigo`, `nombre`) VALUES
(201, 'FormaPago1'),
(202, 'FormaPago2'),
(203, 'FormaPago3'),
(204, 'FormaPago4'),
(205, 'FormaPago5'),
(206, 'FormaPago6'),
(207, 'FormaPago7'),
(208, 'FormaPago8'),
(209, 'FormaPago9'),
(210, 'FormaPago10');

INSERT INTO `caso-2`.`abono` (`fecha`, `monto`, `cuota`, `FormaPago_codigo`) VALUES
('2023-10-20', 200.0, 101, 201),
('2023-11-25', 300.0, 102, 202),
('2023-12-15', 150.0, 103, 203),
('2024-01-10', 400.0, 104, 204),
('2024-02-20', 250.0, 105, 205),
('2024-03-30', 180.0, 106, 206),
('2024-04-15', 350.0, 107, 207),
('2024-05-25', 280.0, 108, 208),
('2024-06-05', 120.0, 109, 209),
('2024-07-20', 420.0, 110, 210);