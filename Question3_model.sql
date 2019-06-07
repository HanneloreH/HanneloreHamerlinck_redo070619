-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gene` (
  `Gene_id` INT NOT NULL,
  `Gene_name` VARCHAR(45) NULL,
  `Gene_description` TEXT(50000) NULL,
  PRIMARY KEY (`Gene_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Syndrome` (
  `Syndrome_name` VARCHAR(45) NULL,
  `Syndrome_description` TEXT(50000) NULL,
  `Syndrome_id` INT NOT NULL,
  PRIMARY KEY (`Syndrome_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diagnosis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diagnosis` (
  `idDiagnosis` INT NOT NULL,
  `Patient_id` INT NULL,
  `Date of diagnosis` DATE NULL,
  `Age at diagnosis` INT NULL,
  PRIMARY KEY (`idDiagnosis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `Syndrome_id` INT NOT NULL,
  `Gender` ENUM("M", "F") NULL,
  `Birhtdate` DATE NULL,
  `Diagnosis_id` INT NOT NULL,
  PRIMARY KEY (`idPatient`),
  INDEX `fk_Patient-Syndrome_idx` (`Syndrome_id` ASC) VISIBLE,
  INDEX `fk_patient_diagnosis_idx` (`Diagnosis_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient-Syndrome`
    FOREIGN KEY (`Syndrome_id`)
    REFERENCES `mydb`.`Syndrome` (`Syndrome_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_diagnosis`
    FOREIGN KEY (`Diagnosis_id`)
    REFERENCES `mydb`.`Diagnosis` (`idDiagnosis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mutation` (
  `id` INT NOT NULL,
  `Gene_id` INT NOT NULL,
  `Start` INT NULL,
  `end` INT NULL,
  `Chromosome` INT NULL,
  `Patient_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  INDEX `fk_mutation_gen_idx` (`Gene_id` ASC) VISIBLE,
  CONSTRAINT `fk_mutation_patient`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mutation_gen`
    FOREIGN KEY (`Gene_id`)
    REFERENCES `mydb`.`Gene` (`Gene_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
