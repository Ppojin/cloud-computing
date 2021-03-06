-- MySQL Script generated by MySQL Workbench
-- Thu Dec 26 10:32:01 2019
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `ssn` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `age` SMALLINT(3) NULL,
  `rank` VARCHAR(45) NULL,
  `speciality` VARCHAR(45) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dept` (
  `dno` INT NOT NULL AUTO_INCREMENT,
  `dname` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  `run_professor_ssn` INT NOT NULL,
  PRIMARY KEY (`dno`),
  INDEX `fk_Dept_Professor1_idx` (`run_professor_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Dept_Professor1`
    FOREIGN KEY (`run_professor_ssn`)
    REFERENCES `mydb`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Graduate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Graduate` (
  `ssn` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `age` VARCHAR(45) NULL,
  `deg_prog` VARCHAR(45) NOT NULL,
  `dept_dno` INT NOT NULL,
  `graduate_ssn` INT NOT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_Graduate_Dept1_idx` (`dept_dno` ASC) VISIBLE,
  INDEX `fk_Graduate_Graduate1_idx` (`graduate_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Graduate_Dept1`
    FOREIGN KEY (`dept_dno`)
    REFERENCES `mydb`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Graduate_Graduate1`
    FOREIGN KEY (`graduate_ssn`)
    REFERENCES `mydb`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Project` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `sponssor` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `budget` DECIMAL(10,2) NOT NULL,
  `manage_ssn` INT NOT NULL,
  PRIMARY KEY (`pid`),
  INDEX `fk_Project_Professor1_idx` (`manage_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Professor1`
    FOREIGN KEY (`manage_ssn`)
    REFERENCES `mydb`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Work_dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Work_dept` (
  `professor_ssn` INT NOT NULL,
  `dept_dno` INT NOT NULL,
  `pct_time` INT NOT NULL,
  INDEX `fk_Work_dept_Professor1_idx` (`professor_ssn` ASC) VISIBLE,
  INDEX `fk_Work_dept_Dept1_idx` (`dept_dno` ASC) VISIBLE,
  PRIMARY KEY (`professor_ssn`, `dept_dno`),
  CONSTRAINT `fk_Work_dept_Professor1`
    FOREIGN KEY (`professor_ssn`)
    REFERENCES `mydb`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Work_dept_Dept1`
    FOREIGN KEY (`dept_dno`)
    REFERENCES `mydb`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Work_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Work_in` (
  `professor_ssn` INT NOT NULL,
  `pid` INT NOT NULL,
  PRIMARY KEY (`professor_ssn`, `pid`),
  INDEX `fk_Work_in_Project1_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_Work_in_Professor1`
    FOREIGN KEY (`professor_ssn`)
    REFERENCES `mydb`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Work_in_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `mydb`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Work_prog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Work_prog` (
  `pid` INT NOT NULL,
  `graduate_ssn` INT NOT NULL,
  PRIMARY KEY (`pid`, `graduate_ssn`),
  INDEX `fk_Work_prog4_Graduate1_idx` (`graduate_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Work_prog4_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `mydb`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Work_prog4_Graduate1`
    FOREIGN KEY (`graduate_ssn`)
    REFERENCES `mydb`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
