-- Setting session variables for script execution
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Creating schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8;
USE `LittleLemonDB`;

-- Creating CustomerDetails table
CREATE TABLE IF NOT EXISTS `CustomerDetails` (
  `CustomerID` INT NOT NULL,
  `Contacts` VARCHAR(255) NOT NULL,
  `Names` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE = InnoDB;

-- Creating Bookings table with the addition of CustomerID
CREATE TABLE IF NOT EXISTS `Bookings` (
  `BookingID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  CONSTRAINT `Booking_Customer_fk` FOREIGN KEY (`CustomerID`) REFERENCES `CustomerDetails` (`CustomerID`)
) ENGINE = InnoDB;

-- Creating Order_Delivery_Status table
CREATE TABLE IF NOT EXISTS `Order_Delivery_Status` (
  `StatusID` INT NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryStatus` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StatusID`)
) ENGINE = InnoDB;

-- Creating Orders table
CREATE TABLE IF NOT EXISTS `Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` INT NOT NULL,
  `StatusID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `Customer_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `Order_fk_idx` (`StatusID` ASC) VISIBLE,
  CONSTRAINT `Customer_fk` FOREIGN KEY (`CustomerID`) REFERENCES `CustomerDetails` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Order_fk` FOREIGN KEY (`StatusID`) REFERENCES `Order_Delivery_Status` (`StatusID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Creating Staff_Information table
CREATE TABLE IF NOT EXISTS `Staff_Information` (
  `StaffID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(255) NOT NULL,
  `Salary` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StaffID`)
) ENGINE = InnoDB;

-- Creating Menu table
CREATE TABLE IF NOT EXISTS `Menu` (
  `MenuID` INT NOT NULL,
  `Starters` VARCHAR(255) NOT NULL,
  `Cuisines` VARCHAR(255) NOT NULL,
  `Courses` VARCHAR(255) NOT NULL,
  `Drinks` VARCHAR(255) NOT NULL,
  `Desserts` VARCHAR(255) NOT NULL,
  `OrderID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `Menu_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `Bookings_fk_idx` (`BookingID` ASC) VISIBLE,
  INDEX `Staff_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `Menu_fk` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Bookings_fk` FOREIGN KEY (`BookingID`) REFERENCES `Bookings` (`BookingID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Staff_fk` FOREIGN KEY (`StaffID`) REFERENCES `Staff_Information` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Restoring session variables to their original state
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
