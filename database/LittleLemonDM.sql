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
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(100) NULL,
  `ContactNumber` VARCHAR(100) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `MenuID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NULL,
  `Starter` VARCHAR(100) NULL,
  `Course` VARCHAR(100) NULL,
  `Drink` VARCHAR(100) NULL,
  `Dessert` VARCHAR(100) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `StaffID` INT NOT NULL,
  `StaffName` VARCHAR(100) NULL,
  `Role` VARCHAR(100) NULL,
  `Salary` DECIMAL(10,2) NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderDeliveryStatus` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATE NULL,
  `Status` VARCHAR(100) NULL,
  PRIMARY KEY (`DeliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NULL,
  `Quantity` INT NULL,
  `TotalCost` DECIMAL(10,2) NULL,
  `Customers_CustomerID` INT NOT NULL,
  `Menu_MenuID` INT NOT NULL,
  `Staff_StaffID` INT NOT NULL,
  `OrderDeliveryStatus_DeliveryID` INT NOT NULL,
  PRIMARY KEY (`OrderID`, `Customers_CustomerID`, `Menu_MenuID`, `Staff_StaffID`),
  INDEX `fk_Orders_Customers1_idx` (`Customers_CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Menu1_idx` (`Menu_MenuID` ASC) VISIBLE,
  INDEX `fk_Orders_Staff1_idx` (`Staff_StaffID` ASC) VISIBLE,
  INDEX `fk_Orders_OrderDeliveryStatus1_idx` (`OrderDeliveryStatus_DeliveryID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `mydb`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Menu1`
    FOREIGN KEY (`Menu_MenuID`)
    REFERENCES `mydb`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Staff1`
    FOREIGN KEY (`Staff_StaffID`)
    REFERENCES `mydb`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_OrderDeliveryStatus1`
    FOREIGN KEY (`OrderDeliveryStatus_DeliveryID`)
    REFERENCES `mydb`.`OrderDeliveryStatus` (`DeliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `BookingID` INT NOT NULL,
  `BookingDate` DATE NULL,
  `TableNumber` INT NULL,
  `Customers_CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`, `Customers_CustomerID`),
  INDEX `fk_Bookings_Customers_idx` (`Customers_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `mydb`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
