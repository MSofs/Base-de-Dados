-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LivrariaOnline
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LivrariaOnline` ;

-- -----------------------------------------------------
-- Schema LivrariaOnline
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LivrariaOnline` DEFAULT CHARACTER SET utf8 ;
USE `LivrariaOnline` ;

-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Editora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Editora` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Editora` (
  `IDEditora` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Website` VARCHAR(60) NULL,
  `Email` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC) VISIBLE,
  PRIMARY KEY (`IDEditora`),
  UNIQUE INDEX `IDEditora_UNIQUE` (`IDEditora` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Autor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Autor` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Autor` (
  `IDAutor` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Idade` INT NULL,
  `DataNascimento` DATE NULL,
  PRIMARY KEY (`IDAutor`),
  UNIQUE INDEX `IDAutor_UNIQUE` (`IDAutor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Livro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Livro` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Livro` (
  `CodLivro` INT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  `Preco` DECIMAL(5,2) NOT NULL,
  `Ano` INT NULL,
  `Genero` VARCHAR(45) NULL,
  `Lingua` VARCHAR(45) NOT NULL,
  `Edicao` INT NULL,
  `Quantidade` INT NOT NULL,
  `ISBN` VARCHAR(15) NOT NULL,
  `IDEditora` INT NOT NULL,
  `IDAutor` INT NOT NULL,
  PRIMARY KEY (`CodLivro`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE,
  INDEX `fk_Livro_Editora1_idx` (`IDEditora` ASC) VISIBLE,
  INDEX `fk_Livro_Autor1_idx` (`IDAutor` ASC) VISIBLE,
  UNIQUE INDEX `CodLivro_UNIQUE` (`CodLivro` ASC) VISIBLE,
  CONSTRAINT `fk_Livro_Editora1`
    FOREIGN KEY (`IDEditora`)
    REFERENCES `LivrariaOnline`.`Editora` (`IDEditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_Autor1`
    FOREIGN KEY (`IDAutor`)
    REFERENCES `LivrariaOnline`.`Autor` (`IDAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Cliente` (
  `NrCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `NIF` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `QuantidadeComprada` INT NOT NULL,
  `ValorGasto` DECIMAL(5,2) NOT NULL,
  `RecomendadePor` INT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Concelho` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NrCliente`),
  UNIQUE INDEX `NrCliente_UNIQUE` (`NrCliente` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  INDEX `fk_Cliente_Cliente1_idx` (`RecomendadePor` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Cliente1`
    FOREIGN KEY (`RecomendadePor`)
    REFERENCES `LivrariaOnline`.`Cliente` (`NrCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Premium`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Premium` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Premium` (
  `NrCliente` INT NOT NULL,
  `Desconto` DECIMAL(4,2) NOT NULL,
  INDEX `fk_Premium_Cliente1_idx` (`NrCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Premium_Cliente1`
    FOREIGN KEY (`NrCliente`)
    REFERENCES `LivrariaOnline`.`Cliente` (`NrCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Telefone` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Telefone` (
  `IDEditora` INT NOT NULL,
  `Telefone` INT NOT NULL,
  PRIMARY KEY (`Telefone`),
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE,
  INDEX `fk_Contacto_Editora1_idx` (`IDEditora` ASC) VISIBLE,
  CONSTRAINT `fk_Contacto_Editora1`
    FOREIGN KEY (`IDEditora`)
    REFERENCES `LivrariaOnline`.`Editora` (`IDEditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Encomenda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Encomenda` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Encomenda` (
  `NrEncomenda` INT NOT NULL AUTO_INCREMENT,
  `ValorTotal` DECIMAL(5,2) NOT NULL,
  `TamanhoEncomenda` INT NOT NULL,
  `Data` DATETIME NOT NULL,
  `NrCliente` INT NOT NULL,
  PRIMARY KEY (`NrEncomenda`),
  UNIQUE INDEX `NrEncomenda_UNIQUE` (`NrEncomenda` ASC) VISIBLE,
  INDEX `fk_Encomenda_Cliente1_idx` (`NrCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Encomenda_Cliente1`
    FOREIGN KEY (`NrCliente`)
    REFERENCES `LivrariaOnline`.`Cliente` (`NrCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaOnline`.`Compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`Compra` ;

CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`Compra` (
  `CodLivro` INT NOT NULL,
  `Preco` DECIMAL(5,2) NOT NULL,
  `Quantidade` INT NOT NULL,
  `PrecoPQ` DECIMAL(5,2) NOT NULL,
  `NrEncomenda` INT NOT NULL,
  INDEX `fk_Compra_Encomenda1_idx` (`NrEncomenda` ASC) VISIBLE,
  INDEX `fk_Compra_Livro1_idx` (`CodLivro` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Encomenda1`
    FOREIGN KEY (`NrEncomenda`)
    REFERENCES `LivrariaOnline`.`Encomenda` (`NrEncomenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Livro1`
    FOREIGN KEY (`CodLivro`)
    REFERENCES `LivrariaOnline`.`Livro` (`CodLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `LivrariaOnline` ;

-- -----------------------------------------------------
-- Placeholder table for view `LivrariaOnline`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaOnline`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `LivrariaOnline`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LivrariaOnline`.`view1`;
DROP VIEW IF EXISTS `LivrariaOnline`.`view1` ;
USE `LivrariaOnline`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
