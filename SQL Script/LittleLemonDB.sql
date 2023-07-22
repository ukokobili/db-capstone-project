-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
  `customerID` INT NOT NULL,
  `firstName` VARCHAR(255) NOT NULL,
  `surnameName` VARCHAR(255) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `emailAddress` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staff` (
  `staffID` INT NOT NULL,
  `firstName` VARCHAR(255) NOT NULL,
  `lastName` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `salary` FLOAT NOT NULL,
  `phoneNumber` INT NOT NULL,
  PRIMARY KEY (`staffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `bookingID` INT NOT NULL,
  `bookingDate` DATETIME NOT NULL,
  `numberOfGuest` INT NOT NULL,
  `tableNumber` INT NOT NULL,
  `customerID` INT NOT NULL,
  `staffID` INT NOT NULL,
  PRIMARY KEY (`bookingID`),
  INDEX `customerID_idx` (`customerID` ASC) VISIBLE,
  INDEX `staffID_idx` (`staffID` ASC) VISIBLE,
  CONSTRAINT `customerID`
    FOREIGN KEY (`customerID`)
    REFERENCES `LittleLemonDB`.`customers` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`staffID`)
    REFERENCES `LittleLemonDB`.`staff` (`staffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `orderID` INT NOT NULL,
  `orderDate` DATETIME NOT NULL,
  `totalCost` FLOAT NOT NULL,
  `bookingID` INT NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `bookingID_idx` (`bookingID` ASC) VISIBLE,
  CONSTRAINT `bookingID`
    FOREIGN KEY (`bookingID`)
    REFERENCES `LittleLemonDB`.`bookings` (`bookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_delivery_status` (
  `orderDeliveryID` INT NOT NULL,
  `deliveryDate` DATETIME NOT NULL,
  `status` BINARY NOT NULL,
  `orderID` INT NOT NULL,
  PRIMARY KEY (`orderDeliveryID`),
  INDEX `orderID_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `orderID`
    FOREIGN KEY (`orderID`)
    REFERENCES `LittleLemonDB`.`orders` (`orderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu` (
  `menuID` INT NOT NULL,
  `cuisine` VARCHAR(255) NOT NULL,
  `starters` VARCHAR(255) NOT NULL,
  `courses` VARCHAR(255) NOT NULL,
  `drinks` VARCHAR(255) NOT NULL,
  `desserts` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`menuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_details` (
  `orderDetailsID` INT NOT NULL,
  `menuID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `cost` FLOAT NOT NULL,
  PRIMARY KEY (`orderDetailsID`),
  INDEX `menuID_idx` (`menuID` ASC) VISIBLE,
  CONSTRAINT `menuID`
    FOREIGN KEY (`menuID`)
    REFERENCES `LittleLemonDB`.`menu` (`menuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderDetailsID`
    FOREIGN KEY (`orderDetailsID`)
    REFERENCES `LittleLemonDB`.`orders` (`orderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
