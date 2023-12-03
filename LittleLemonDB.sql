-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db-capstone-project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-capstone-project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-capstone-project` DEFAULT CHARACTER SET utf8 ;
USE `db-capstone-project` ;

-- -----------------------------------------------------
-- Table `db-capstone-project`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Customers` (
  `CustomerID` INT NOT NULL,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `PhoneNumber` INT NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`MenuItems` (
  `MenuItemID` INT NOT NULL,
  `ItemName` VARCHAR(45) NOT NULL,
  `ItemPrice` INT NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Menu` (
  `MenuID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  `Starter` VARCHAR(100) NOT NULL,
  `Course` VARCHAR(100) NOT NULL,
  `Drinks` VARCHAR(100) NOT NULL,
  `Desserts` VARCHAR(100) NOT NULL,
  `MenuItemID` INT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `menu_menuitem_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menu_menuitem_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `db-capstone-project`.`MenuItems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `OrderQuantity` INT NOT NULL,
  `OrderType` VARCHAR(55) NULL,
  `TotalCost` INT NOT NULL,
  `MenuID` INT NULL,
  `MenuItemID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `orders_menu_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `orders_menuitems_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `orders_menu_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `db-capstone-project`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_menuitems_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `db-capstone-project`.`MenuItems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Staff` (
  `StaffID` INT NOT NULL,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `Role` VARCHAR(100) NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Bookings` (
  `BookingID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NULL,
  `OrderID` INT NULL,
  `StaffID` INT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `bookings_customers_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `bookings_orders_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `bookings_staff_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `bookings_customers_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `db-capstone-project`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bookings_orders_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `db-capstone-project`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bookings_staff_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `db-capstone-project`.`Staff` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`OrderDelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`OrderDelivery` (
  `OrderDeliveryID` INT NOT NULL,
  `OrderDeliveryDate` DATE NULL,
  `OrderDeliveryStatus` VARCHAR(100) NULL,
  `OrderID` INT NULL,
  PRIMARY KEY (`OrderDeliveryID`),
  INDEX `orderdelivery_orders_fk_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `orderdelivery_orders_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `db-capstone-project`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
