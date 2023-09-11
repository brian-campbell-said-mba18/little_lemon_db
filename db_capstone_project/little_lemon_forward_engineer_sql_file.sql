-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8 ;
USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`staff` (
  `staff_id` INT NOT NULL,
  `staff_name` VARCHAR(45) NOT NULL,
  `staff_role` VARCHAR(45) NOT NULL,
  `staff_salary` DECIMAL(11,2) NOT NULL,
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC) VISIBLE,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`order_delivery_status` (
  `order_delivery_status_id` INT NOT NULL,
  `order_delivery_status_date` DATE NOT NULL,
  `order_delivery_status_status` VARCHAR(45) NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`order_delivery_status_id`),
  UNIQUE INDEX `idorder_delivery_status_id_UNIQUE` (`order_delivery_status_id` ASC) VISIBLE,
  INDEX `fk_order_delivery_status_staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_delivery_status_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `little_lemon_db`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`orders` (
  `order_id` VARCHAR(45) NOT NULL,
  `order_date` DATE NOT NULL,
  `order_revenue` DECIMAL(11,2) NOT NULL,
  `order_cost` DECIMAL(11,2) NOT NULL,
  `order_profit` DECIMAL(11,2) NOT NULL,
  `order_quantity` DECIMAL(11,2) NOT NULL,
  `order_delivery_status_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_orders_order_delivery_status1_idx` (`order_delivery_status_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_order_delivery_status1`
    FOREIGN KEY (`order_delivery_status_id`)
    REFERENCES `little_lemon_db`.`order_delivery_status` (`order_delivery_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`customers` (
  `cutomer_id` VARCHAR(45) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_country` VARCHAR(45) NOT NULL,
  `customer_city` VARCHAR(45) NOT NULL,
  `customer_phone_number` INT NOT NULL,
  PRIMARY KEY (`cutomer_id`),
  UNIQUE INDEX `idcustomers_UNIQUE` (`cutomer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`bookings` (
  `booking_id` INT NOT NULL,
  `booking_date` DATE NOT NULL,
  `booking_table_number` INT NOT NULL,
  `customer_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE INDEX `booking_id_UNIQUE` (`booking_id` ASC) VISIBLE,
  INDEX `fk_bookings_customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `little_lemon_db`.`customers` (`cutomer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`menu` (
  `menu_id` INT NOT NULL,
  `menu_cuisine_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`menu_items` (
  `menu_item_id` INT NOT NULL,
  `menu_item_course_name` VARCHAR(45) NOT NULL,
  `menu_item_starter_name` VARCHAR(45) NOT NULL,
  `menu_item_desert_name` VARCHAR(45) NOT NULL,
  `menu_item_drink_name` VARCHAR(45) NOT NULL,
  `menu_item_side_name` VARCHAR(45) NOT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`menu_item_id`),
  UNIQUE INDEX `menu_item_id_UNIQUE` (`menu_item_id` ASC) VISIBLE,
  INDEX `fk_menu_items_menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_items_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `little_lemon_db`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`order_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`order_transactions` (
  `order_transaction_id` INT NOT NULL,
  `order_transaction_revenue` DECIMAL(11,2) NOT NULL,
  `order_transaction_cost` DECIMAL(11,2) NOT NULL,
  `order_transaction_profit` DECIMAL(11,2) NOT NULL,
  `order_transaction_percent_discount` DECIMAL(4,2) NOT NULL,
  `order_transaction_quantity` INT NOT NULL,
  `customer_id` VARCHAR(45) NOT NULL,
  `order_id` VARCHAR(45) NOT NULL,
  `menu_id` INT NOT NULL,
  `menu_item_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  PRIMARY KEY (`order_transaction_id`),
  UNIQUE INDEX `order_transaction_id_UNIQUE` (`order_transaction_id` ASC) VISIBLE,
  INDEX `fk_order_transactions_orders_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_transactions_bookings1_idx` (`booking_id` ASC) VISIBLE,
  INDEX `fk_order_transactions_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_order_transactions_menu1_idx` (`menu_id` ASC) VISIBLE,
  INDEX `fk_order_transactions_menu_items1_idx` (`menu_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_transactions_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `little_lemon_db`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_transactions_bookings1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `little_lemon_db`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_transactions_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `little_lemon_db`.`customers` (`cutomer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_transactions_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `little_lemon_db`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_transactions_menu_items1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `little_lemon_db`.`menu_items` (`menu_item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
