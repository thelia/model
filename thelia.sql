SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE  TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `parent` INT NULL ,
  `link` VARCHAR(255) NULL ,
  `visible` TINYINT NOT NULL ,
  `position` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `update_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `category_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category_desc` ;

CREATE  TABLE IF NOT EXISTS `category_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `category_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` LONGTEXT NULL ,
  `chapo` TEXT NULL ,
  `postscriptum` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_ category_desc_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_ category_desc_category_id` ON `category_desc` (`category_id` ASC) ;


-- -----------------------------------------------------
-- Table `tax_rule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tax_rule` ;

CREATE  TABLE IF NOT EXISTS `tax_rule` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(45) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product` ;

CREATE  TABLE IF NOT EXISTS `product` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tax_rule_id` INT NULL ,
  `ref` VARCHAR(255) NOT NULL ,
  `price` FLOAT NOT NULL ,
  `price2` FLOAT NULL ,
  `ecotax` FLOAT NULL ,
  `new` TINYINT NULL DEFAULT 0 ,
  `promo` TINYINT NULL DEFAULT 0 ,
  `stock` INT NULL DEFAULT 0 ,
  `visible` TINYINT NOT NULL DEFAULT 0 ,
  `weight` FLOAT NULL ,
  `position` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_product_tax_rule_id`
    FOREIGN KEY (`tax_rule_id` )
    REFERENCES `tax_rule` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE UNIQUE INDEX `ref_UNIQUE` ON `product` (`ref` ASC) ;

CREATE INDEX `idx_product_tax_rule_id` ON `product` (`tax_rule_id` ASC) ;


-- -----------------------------------------------------
-- Table `product_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_desc` ;

CREATE  TABLE IF NOT EXISTS `product_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `product_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` LONGTEXT NULL ,
  `chapo` TEXT NULL ,
  `postscriptum` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updatet_at` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_product_desc_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_product_desc_product_id` ON `product_desc` (`product_id` ASC) ;


-- -----------------------------------------------------
-- Table `product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_category` ;

CREATE  TABLE IF NOT EXISTS `product_category` (
  `product_id` INT NOT NULL ,
  `category_id` INT NOT NULL ,
  PRIMARY KEY (`product_id`, `category_id`) ,
  CONSTRAINT `fk_product_has_category_product1`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_has_category_category1`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `fk_product_has_category_category1_idx` ON `product_category` (`category_id` ASC) ;

CREATE INDEX `fk_product_has_category_product1_idx` ON `product_category` (`product_id` ASC) ;


-- -----------------------------------------------------
-- Table `area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `area` ;

CREATE  TABLE IF NOT EXISTS `area` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `unit` FLOAT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country` ;

CREATE  TABLE IF NOT EXISTS `country` (
  `id` INT NOT NULL ,
  `area_id` INT NULL ,
  `isocode` VARCHAR(4) NOT NULL ,
  `isoalpha2` VARCHAR(2) NULL ,
  `isoalpha3` VARCHAR(4) NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_country_area_id`
    FOREIGN KEY (`area_id` )
    REFERENCES `area` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_country_area_id` ON `country` (`area_id` ASC) ;


-- -----------------------------------------------------
-- Table `country_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country_desc` ;

CREATE  TABLE IF NOT EXISTS `country_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `country_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_country_desc_country_id`
    FOREIGN KEY (`country_id` )
    REFERENCES `country` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_country_desc_country_id` ON `country_desc` (`country_id` ASC) ;


-- -----------------------------------------------------
-- Table `tax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tax` ;

CREATE  TABLE IF NOT EXISTS `tax` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `rate` FLOAT NOT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `tax_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tax_desc` ;

CREATE  TABLE IF NOT EXISTS `tax_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tax_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_tax_desc_tax_id`
    FOREIGN KEY (`tax_id` )
    REFERENCES `tax` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_tax_desc_tax_id` ON `tax_desc` (`tax_id` ASC) ;


-- -----------------------------------------------------
-- Table `tax_rule_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tax_rule_desc` ;

CREATE  TABLE IF NOT EXISTS `tax_rule_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tax_rule_id` INT NULL ,
  `lang` VARCHAR(10) NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_tax_rule_desc_tax_rule_id`
    FOREIGN KEY (`tax_rule_id` )
    REFERENCES `tax_rule` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_tax_rule_desc_tax_rule_id` ON `tax_rule_desc` (`tax_rule_id` ASC) ;


-- -----------------------------------------------------
-- Table `tax_rule_country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tax_rule_country` ;

CREATE  TABLE IF NOT EXISTS `tax_rule_country` (
  `id` INT NOT NULL ,
  `tax_rule_id` INT NULL ,
  `country_id` INT NULL ,
  `tax_id` INT NULL ,
  `none` TINYINT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_tax_rule_country_tax_id`
    FOREIGN KEY (`tax_id` )
    REFERENCES `tax` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_tax_rule_country_tax_rule_id`
    FOREIGN KEY (`tax_rule_id` )
    REFERENCES `tax_rule` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_tax_rule_country_country_id`
    FOREIGN KEY (`country_id` )
    REFERENCES `country` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_tax_rule_country_tax_id` ON `tax_rule_country` (`tax_id` ASC) ;

CREATE INDEX `idx_tax_rule_country_tax_rule_id` ON `tax_rule_country` (`tax_rule_id` ASC) ;

CREATE INDEX `idx_tax_rule_country_country_id` ON `tax_rule_country` (`country_id` ASC) ;


-- -----------------------------------------------------
-- Table `feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature` ;

CREATE  TABLE IF NOT EXISTS `feature` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `visible` INT NULL DEFAULT 0 ,
  `position` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `feature_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature_desc` ;

CREATE  TABLE IF NOT EXISTS `feature_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `feature_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` VARCHAR(45) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_feature_desc_feature_id`
    FOREIGN KEY (`feature_id` )
    REFERENCES `feature` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_feature_desc_feature_id` ON `feature_desc` (`feature_id` ASC) ;


-- -----------------------------------------------------
-- Table `feature_av`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature_av` ;

CREATE  TABLE IF NOT EXISTS `feature_av` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `feature_id` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_feature_av_feature_id`
    FOREIGN KEY (`feature_id` )
    REFERENCES `feature` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_feature_av_feature_id` ON `feature_av` (`feature_id` ASC) ;


-- -----------------------------------------------------
-- Table `feature_av_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature_av_desc` ;

CREATE  TABLE IF NOT EXISTS `feature_av_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `feature_av_id` INT NOT NULL ,
  `lang` VARCHAR(10) NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NOT NULL ,
  `chapo` TEXT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_feature_av_desc_feature_av_id`
    FOREIGN KEY (`feature_av_id` )
    REFERENCES `feature_av` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_feature_av_desc_feature_av_id` ON `feature_av_desc` (`feature_av_id` ASC) ;


-- -----------------------------------------------------
-- Table `feature_prod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature_prod` ;

CREATE  TABLE IF NOT EXISTS `feature_prod` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `product_id` INT NOT NULL ,
  `feature_id` INT NOT NULL ,
  `feature_av_id` INT NULL ,
  `default` VARCHAR(255) NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_feature_prod_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_feature_prod_feature_id`
    FOREIGN KEY (`feature_id` )
    REFERENCES `feature` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_feature_prod_feature_av_id`
    FOREIGN KEY (`feature_av_id` )
    REFERENCES `feature_av` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'e';

CREATE INDEX `idx_feature_prod_product_id` ON `feature_prod` (`product_id` ASC) ;

CREATE INDEX `idx_feature_prod_feature_id` ON `feature_prod` (`feature_id` ASC) ;

CREATE INDEX `idx_feature_prod_feature_av_id` ON `feature_prod` (`feature_av_id` ASC) ;


-- -----------------------------------------------------
-- Table `feature_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature_category` ;

CREATE  TABLE IF NOT EXISTS `feature_category` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `feature_id` INT NOT NULL ,
  `category_id` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_feature_category_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_feature_category_feature_id`
    FOREIGN KEY (`feature_id` )
    REFERENCES `feature` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_feature_category_category_id` ON `feature_category` (`category_id` ASC) ;

CREATE INDEX `idx_feature_category_feature_id` ON `feature_category` (`feature_id` ASC) ;


-- -----------------------------------------------------
-- Table `attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute` ;

CREATE  TABLE IF NOT EXISTS `attribute` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `attribute_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute_desc` ;

CREATE  TABLE IF NOT EXISTS `attribute_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `lang` VARCHAR(10) NOT NULL ,
  `attribute_id` INT NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_ attribute_desc_attribute_id`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `attribute` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_ attribute_desc_attribute_id` ON `attribute_desc` (`attribute_id` ASC) ;


-- -----------------------------------------------------
-- Table `attribute_av`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute_av` ;

CREATE  TABLE IF NOT EXISTS `attribute_av` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `attribute_id` INT NOT NULL ,
  `position` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_attribute_av_attribute_id`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `attribute` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_attribute_av_attribute_id` ON `attribute_av` (`attribute_id` ASC) ;


-- -----------------------------------------------------
-- Table `attribute_av_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute_av_desc` ;

CREATE  TABLE IF NOT EXISTS `attribute_av_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `attribute_av_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_attribute_av_desc_attribute_av_id`
    FOREIGN KEY (`attribute_av_id` )
    REFERENCES `attribute_av` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_attribute_av_desc_attribute_av_id` ON `attribute_av_desc` (`attribute_av_id` ASC) ;


-- -----------------------------------------------------
-- Table `combination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `combination` ;

CREATE  TABLE IF NOT EXISTS `combination` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `ref` VARCHAR(255) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `attribute_combination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute_combination` ;

CREATE  TABLE IF NOT EXISTS `attribute_combination` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `attribute_id` INT NOT NULL ,
  `combination_id` INT NOT NULL ,
  `attribute_av_id` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_At` DATETIME NOT NULL ,
  PRIMARY KEY (`id`, `attribute_id`, `combination_id`, `attribute_av_id`) ,
  CONSTRAINT `fk_ attribute_combination_attribute_id`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `attribute` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ attribute_combination_attribute_av_id`
    FOREIGN KEY (`attribute_av_id` )
    REFERENCES `attribute_av` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ attribute_combination_combination_id`
    FOREIGN KEY (`combination_id` )
    REFERENCES `combination` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_ attribute_combination_attribute_id` ON `attribute_combination` (`attribute_id` ASC) ;

CREATE INDEX `idx_ attribute_combination_attribute_av_id` ON `attribute_combination` (`attribute_av_id` ASC) ;

CREATE INDEX `idx_ attribute_combination_combination_id` ON `attribute_combination` (`combination_id` ASC) ;


-- -----------------------------------------------------
-- Table `stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stock` ;

CREATE  TABLE IF NOT EXISTS `stock` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `combination_id` INT NULL ,
  `product_id` INT NOT NULL ,
  `increase` FLOAT NULL ,
  `value` FLOAT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_stock_combination_id`
    FOREIGN KEY (`combination_id` )
    REFERENCES `combination` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_stock_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_stock_combination_id` ON `stock` (`combination_id` ASC) ;

CREATE INDEX `idx_stock_product_id` ON `stock` (`product_id` ASC) ;


-- -----------------------------------------------------
-- Table `attribute_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute_category` ;

CREATE  TABLE IF NOT EXISTS `attribute_category` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `category_id` INT NOT NULL ,
  `attribute_id` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_attribute_category_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_attribute_category_attribute_id`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `attribute` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_attribute_category_category_id` ON `attribute_category` (`category_id` ASC) ;

CREATE INDEX `idx_attribute_category_attribute_id` ON `attribute_category` (`attribute_id` ASC) ;


-- -----------------------------------------------------
-- Table `config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config` ;

CREATE  TABLE IF NOT EXISTS `config` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `value` VARCHAR(255) NOT NULL ,
  `protected` TINYINT NOT NULL DEFAULT 1 ,
  `hidden` TINYINT NOT NULL DEFAULT 1 ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Contain smtp config';


-- -----------------------------------------------------
-- Table `customer_title`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_title` ;

CREATE  TABLE IF NOT EXISTS `customer_title` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `default` INT NOT NULL DEFAULT 0 ,
  `position` VARCHAR(45) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE  TABLE IF NOT EXISTS `customer` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `ref` VARCHAR(50) NOT NULL ,
  `customer_title_id` INT NULL ,
  `company` VARCHAR(255) NULL ,
  `firstname` VARCHAR(255) NOT NULL ,
  `lastname` VARCHAR(255) NOT NULL ,
  `address1` VARCHAR(255) NOT NULL ,
  `address2` VARCHAR(255) NULL COMMENT '				' ,
  `address3` VARCHAR(255) NULL ,
  `zipcode` VARCHAR(10) NULL ,
  `city` VARCHAR(255) NOT NULL ,
  `country_id` INT NOT NULL ,
  `phone` VARCHAR(20) NULL ,
  `cellphone` VARCHAR(20) NULL ,
  `email` VARCHAR(50) NULL ,
  `password` VARCHAR(255) NULL ,
  `algo` VARCHAR(128) NULL ,
  `salt` VARCHAR(128) NULL ,
  `reseller` TINYINT NULL ,
  `lang` VARCHAR(10) NULL ,
  `sponsor` VARCHAR(50) NULL ,
  `discount` FLOAT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_ customer_customer_title_id`
    FOREIGN KEY (`customer_title_id` )
    REFERENCES `customer_title` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE UNIQUE INDEX `ref_UNIQUE` ON `customer` (`ref` ASC) ;

CREATE INDEX `idx_ customer_customer_title_id` ON `customer` (`customer_title_id` ASC) ;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE  TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(255) NULL ,
  `customer_id` INT NOT NULL ,
  `customer_title_id` INT NULL ,
  `company` VARCHAR(255) NULL ,
  `firstname` VARCHAR(255) NOT NULL ,
  `lastname` VARCHAR(255) NOT NULL ,
  `address1` VARCHAR(255) NOT NULL ,
  `address2` VARCHAR(255) NOT NULL ,
  `address3` VARCHAR(255) NOT NULL ,
  `zipcode` VARCHAR(10) NOT NULL ,
  `city` VARCHAR(255) NOT NULL ,
  `country_id` INT NOT NULL ,
  `phone` VARCHAR(20) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_address_customer_id`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_address_customer_title_id`
    FOREIGN KEY (`customer_title_id` )
    REFERENCES `customer_title` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_address_customer_id` ON `address` (`customer_id` ASC) ;

CREATE INDEX `idx_address_customer_title_id` ON `address` (`customer_title_id` ASC) ;


-- -----------------------------------------------------
-- Table `customer_title_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_title_desc` ;

CREATE  TABLE IF NOT EXISTS `customer_title_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `customer_title_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `short` VARCHAR(10) NULL ,
  `long` VARCHAR(45) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_customer_title_desc_customer_title_id`
    FOREIGN KEY (`customer_title_id` )
    REFERENCES `customer_title` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_customer_title_desc_customer_title_id` ON `customer_title_desc` (`customer_title_id` ASC) ;


-- -----------------------------------------------------
-- Table `lang`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lang` ;

CREATE  TABLE IF NOT EXISTS `lang` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(100) NULL ,
  `code` VARCHAR(10) NULL ,
  `url` VARCHAR(255) NULL ,
  `default` TINYINT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `folder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `folder` ;

CREATE  TABLE IF NOT EXISTS `folder` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `parent` INT NOT NULL ,
  `link` VARCHAR(255) NULL ,
  `visible` TINYINT NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `folder_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `folder_desc` ;

CREATE  TABLE IF NOT EXISTS `folder_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `folder_id` INT NOT NULL ,
  `lang` VARCHAR(10) NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `postscriptum` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_ folder_desc_folder_id`
    FOREIGN KEY (`folder_id` )
    REFERENCES `folder` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_ folder_desc_folder_id` ON `folder_desc` (`folder_id` ASC) ;


-- -----------------------------------------------------
-- Table `content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content` ;

CREATE  TABLE IF NOT EXISTS `content` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `visible` TINYINT NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `content_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_desc` ;

CREATE  TABLE IF NOT EXISTS `content_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `content_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `postscriptum` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_content_desc_content_id`
    FOREIGN KEY (`content_id` )
    REFERENCES `content` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_content_desc_content_id` ON `content_desc` (`content_id` ASC) ;


-- -----------------------------------------------------
-- Table `content_assoc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_assoc` ;

CREATE  TABLE IF NOT EXISTS `content_assoc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `category_id` INT NULL ,
  `product_id` INT NULL ,
  `content_id` INT NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_content_assoc_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_content_assoc_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_content_assoc_content_id`
    FOREIGN KEY (`content_id` )
    REFERENCES `content` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_content_assoc_category_id` ON `content_assoc` (`category_id` ASC) ;

CREATE INDEX `idx_content_assoc_product_id` ON `content_assoc` (`product_id` ASC) ;

CREATE INDEX `idx_content_assoc_content_id` ON `content_assoc` (`content_id` ASC) ;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE  TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `product_id` INT NULL ,
  `category_id` INT NULL ,
  `folder_id` INT NULL ,
  `content_id` INT NULL ,
  `file` VARCHAR(255) NOT NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_image_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_image_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_image_content_id`
    FOREIGN KEY (`content_id` )
    REFERENCES `content` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_image_folder_id`
    FOREIGN KEY (`folder_id` )
    REFERENCES `folder` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_image_product_id` ON `image` (`product_id` ASC) ;

CREATE INDEX `idx_image_category_id` ON `image` (`category_id` ASC) ;

CREATE INDEX `idx_image_content_id` ON `image` (`content_id` ASC) ;

CREATE INDEX `idx_image_folder_id` ON `image` (`folder_id` ASC) ;


-- -----------------------------------------------------
-- Table `image_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image_desc` ;

CREATE  TABLE IF NOT EXISTS `image_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `image_id` INT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_image_desc_image_id`
    FOREIGN KEY (`image_id` )
    REFERENCES `image` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_image_desc_image_id` ON `image_desc` (`image_id` ASC) ;


-- -----------------------------------------------------
-- Table `document`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `document` ;

CREATE  TABLE IF NOT EXISTS `document` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `product_id` INT NULL ,
  `category_id` INT NULL ,
  `folder_id` INT NULL ,
  `content_id` INT NULL ,
  `file` VARCHAR(255) NOT NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_document_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_document_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_document_content_id`
    FOREIGN KEY (`content_id` )
    REFERENCES `content` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_document_folder_id`
    FOREIGN KEY (`folder_id` )
    REFERENCES `folder` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_document_product_id` ON `document` (`product_id` ASC) ;

CREATE INDEX `idx_document_category_id` ON `document` (`category_id` ASC) ;

CREATE INDEX `idx_document_content_id` ON `document` (`content_id` ASC) ;

CREATE INDEX `idx_document_folder_id` ON `document` (`folder_id` ASC) ;


-- -----------------------------------------------------
-- Table `document_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `document_desc` ;

CREATE  TABLE IF NOT EXISTS `document_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `document_id` INT NOT NULL ,
  `lang` VARCHAR(10) NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_ document_desc_document_id`
    FOREIGN KEY (`document_id` )
    REFERENCES `document` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_ document_desc_document_id` ON `document_desc` (`document_id` ASC) ;


-- -----------------------------------------------------
-- Table `currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currency` ;

CREATE  TABLE IF NOT EXISTS `currency` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `code` VARCHAR(45) NULL ,
  `symbol` VARCHAR(45) NULL ,
  `rate` FLOAT NULL ,
  `default` TINYINT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `order_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_address` ;

CREATE  TABLE IF NOT EXISTS `order_address` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `customer_title_id` INT NULL ,
  `company` VARCHAR(255) NULL ,
  `firstname` VARCHAR(255) NOT NULL ,
  `lastname` VARCHAR(255) NOT NULL ,
  `address1` VARCHAR(255) NOT NULL ,
  `address2` VARCHAR(255) NULL ,
  `address3` VARCHAR(255) NULL ,
  `zipcode` VARCHAR(10) NOT NULL ,
  `city` VARCHAR(255) NOT NULL ,
  `phone` VARCHAR(20) NULL ,
  `country_id` INT NOT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `order_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_status` ;

CREATE  TABLE IF NOT EXISTS `order_status` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(45) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order` ;

CREATE  TABLE IF NOT EXISTS `order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `ref` VARCHAR(45) NULL ,
  `customer_id` INT NOT NULL ,
  `address_invoice` INT NULL ,
  `address_delivery` INT NULL ,
  `invoice_date` DATE NULL ,
  `currency_id` INT NULL ,
  `currency_rate` FLOAT NOT NULL ,
  `transaction` VARCHAR(100) NULL ,
  `delivery_num` VARCHAR(100) NULL ,
  `invoice` VARCHAR(100) NULL ,
  `postage` FLOAT NULL ,
  `payment` VARCHAR(45) NOT NULL ,
  `carrier` VARCHAR(45) NOT NULL ,
  `status_id` INT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_order_currency_id`
    FOREIGN KEY (`currency_id` )
    REFERENCES `currency` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_customer_id`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_address_invoice`
    FOREIGN KEY (`address_invoice` )
    REFERENCES `order_address` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_address_delivery`
    FOREIGN KEY (`address_delivery` )
    REFERENCES `order_address` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_status_id`
    FOREIGN KEY (`status_id` )
    REFERENCES `order_status` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_order_currency_id` ON `order` (`currency_id` ASC) ;

CREATE INDEX `idx_order_customer_id` ON `order` (`customer_id` ASC) ;

CREATE INDEX `idx_order_address_invoice` ON `order` (`address_invoice` ASC) ;

CREATE INDEX `idx_order_address_delivery` ON `order` (`address_delivery` ASC) ;

CREATE INDEX `idx_order_status_id` ON `order` (`status_id` ASC) ;


-- -----------------------------------------------------
-- Table `order_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_product` ;

CREATE  TABLE IF NOT EXISTS `order_product` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NOT NULL ,
  `product_ref` VARCHAR(255) NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `quantity` FLOAT NOT NULL ,
  `price` FLOAT NOT NULL ,
  `tax` FLOAT NULL ,
  `parent` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_order_product_order_id`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_order_product_order_id` ON `order_product` (`order_id` ASC) ;


-- -----------------------------------------------------
-- Table `order_status_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_status_desc` ;

CREATE  TABLE IF NOT EXISTS `order_status_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `status_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_order_status_desc_status_id`
    FOREIGN KEY (`status_id` )
    REFERENCES `order_status` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_order_status_desc_status_id` ON `order_status_desc` (`status_id` ASC) ;


-- -----------------------------------------------------
-- Table `order_feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_feature` ;

CREATE  TABLE IF NOT EXISTS `order_feature` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_product_id` INT NOT NULL ,
  `feature_desc` VARCHAR(255) NULL ,
  `feature_av_desc` VARCHAR(255) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_order_feature_order_product_id`
    FOREIGN KEY (`order_product_id` )
    REFERENCES `order_product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_order_feature_order_product_id` ON `order_feature` (`order_product_id` ASC) ;


-- -----------------------------------------------------
-- Table `module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `module` ;

CREATE  TABLE IF NOT EXISTS `module` (
  `id` INT NOT NULL ,
  `code` VARCHAR(55) NOT NULL ,
  ` type` TINYINT NOT NULL ,
  `activate` TINYINT NULL ,
  `position` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE UNIQUE INDEX `code_UNIQUE` ON `module` (`code` ASC) ;


-- -----------------------------------------------------
-- Table `module_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `module_desc` ;

CREATE  TABLE IF NOT EXISTS `module_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `module_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `currency_id` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_module_desc_module_id`
    FOREIGN KEY (`module_id` )
    REFERENCES `module` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_module_desc_module_id` ON `module_desc` (`module_id` ASC) ;


-- -----------------------------------------------------
-- Table `accessory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accessory` ;

CREATE  TABLE IF NOT EXISTS `accessory` (
  `id` INT NOT NULL ,
  `product_id` INT NOT NULL ,
  `accessory` INT NOT NULL ,
  `position` INT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_accessory_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_accessory_accessory`
    FOREIGN KEY (`accessory` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_address_product_id` ON `accessory` (`product_id` ASC) ;

CREATE INDEX `idx_address_accessory` ON `accessory` (`accessory` ASC) ;


-- -----------------------------------------------------
-- Table `delivzone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivzone` ;

CREATE  TABLE IF NOT EXISTS `delivzone` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `area_id` INT NULL ,
  `delivery` VARCHAR(45) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_delivzone_area_id`
    FOREIGN KEY (`area_id` )
    REFERENCES `area` (`id` )
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE INDEX `idx_delivzone_area_id` ON `delivzone` (`area_id` ASC) ;


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

CREATE  TABLE IF NOT EXISTS `group` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(30) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE UNIQUE INDEX `code_UNIQUE` ON `group` (`code` ASC) ;


-- -----------------------------------------------------
-- Table `group_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_desc` ;

CREATE  TABLE IF NOT EXISTS `group_desc` (
  `id` INT NOT NULL ,
  `group_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_group_desc_group_id`
    FOREIGN KEY (`group_id` )
    REFERENCES `group` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_group_desc_group_id` ON `group_desc` (`group_id` ASC) ;


-- -----------------------------------------------------
-- Table `resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `resource` ;

CREATE  TABLE IF NOT EXISTS `resource` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(30) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE UNIQUE INDEX `code_UNIQUE` ON `resource` (`code` ASC) ;


-- -----------------------------------------------------
-- Table `resource_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `resource_desc` ;

CREATE  TABLE IF NOT EXISTS `resource_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `resource_id` INT NOT NULL ,
  `lang` VARCHAR(10) NULL ,
  `title` VARCHAR(255) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_resource_desc_resource_id`
    FOREIGN KEY (`resource_id` )
    REFERENCES `resource` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_resource_desc_resource_id` ON `resource_desc` (`resource_id` ASC) ;


-- -----------------------------------------------------
-- Table `admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admin` ;

CREATE  TABLE IF NOT EXISTS `admin` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(100) NOT NULL ,
  `lastname` VARCHAR(100) NOT NULL ,
  `login` VARCHAR(100) NOT NULL ,
  `password` VARCHAR(128) NOT NULL ,
  `algo` VARCHAR(128) NULL ,
  `salt` VARCHAR(128) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `admin_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admin_group` ;

CREATE  TABLE IF NOT EXISTS `admin_group` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group_id` INT NULL ,
  `admin_id` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_admin_group_group_id`
    FOREIGN KEY (`group_id` )
    REFERENCES `group` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_admin_group_admin_id`
    FOREIGN KEY (`admin_id` )
    REFERENCES `admin` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_admin_group_group_id` ON `admin_group` (`group_id` ASC) ;

CREATE INDEX `idx_admin_group_admin_id` ON `admin_group` (`admin_id` ASC) ;


-- -----------------------------------------------------
-- Table `group_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_resource` ;

CREATE  TABLE IF NOT EXISTS `group_resource` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group_id` INT NOT NULL ,
  `resource_id` INT NOT NULL ,
  `read` TINYINT NULL DEFAULT 0 ,
  `write` TINYINT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_group_resource_group_id`
    FOREIGN KEY (`group_id` )
    REFERENCES `group` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_group_resource_resource_id`
    FOREIGN KEY (`resource_id` )
    REFERENCES `resource` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `id_idx` ON `group_resource` (`group_id` ASC) ;

CREATE INDEX `idx_group_resource_resource_id` ON `group_resource` (`resource_id` ASC) ;


-- -----------------------------------------------------
-- Table `group_module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_module` ;

CREATE  TABLE IF NOT EXISTS `group_module` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group_id` INT NOT NULL ,
  `module_id` INT NULL ,
  `access` TINYINT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_group_module_group_id`
    FOREIGN KEY (`group_id` )
    REFERENCES `group` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_group_module_module_id`
    FOREIGN KEY (`module_id` )
    REFERENCES `module` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `id_idx` ON `group_module` (`group_id` ASC) ;

CREATE INDEX `id_idx1` ON `group_module` (`module_id` ASC) ;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE  TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(45) NOT NULL ,
  `protected` TINYINT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `message_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message_desc` ;

CREATE  TABLE IF NOT EXISTS `message_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `message_id` INT NOT NULL ,
  `lang` VARCHAR(10) NULL ,
  `title` VARCHAR(45) NULL ,
  `description` TEXT NULL ,
  `description_html` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_message_desc_message_id`
    FOREIGN KEY (`message_id` )
    REFERENCES `message` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_message_desc_message_id` ON `message_desc` (`message_id` ASC) ;


-- -----------------------------------------------------
-- Table `rewriting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rewriting` ;

CREATE  TABLE IF NOT EXISTS `rewriting` (
  `id` INT NOT NULL ,
  `url` VARCHAR(255) NOT NULL ,
  `product_id` INT NULL ,
  `category_id` INT NULL ,
  `folder_id` INT NULL ,
  `content_id` INT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_rewriting_product_id`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_rewriting_category_id`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_rewriting_folder_id`
    FOREIGN KEY (`folder_id` )
    REFERENCES `folder` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_rewriting_content_id`
    FOREIGN KEY (`content_id` )
    REFERENCES `content` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_rewriting_product_id` ON `rewriting` (`product_id` ASC) ;

CREATE INDEX `idx_rewriting_category_id` ON `rewriting` (`category_id` ASC) ;

CREATE INDEX `idx_rewriting_folder_id` ON `rewriting` (`folder_id` ASC) ;

CREATE INDEX `idx_rewriting_content_id` ON `rewriting` (`content_id` ASC) ;


-- -----------------------------------------------------
-- Table `coupon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `coupon` ;

CREATE  TABLE IF NOT EXISTS `coupon` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(45) NOT NULL ,
  `action` VARCHAR(255) NOT NULL ,
  `value` FLOAT NOT NULL ,
  `used` TINYINT NULL ,
  `available_since` DATETIME NULL ,
  `date_limit` DATETIME NULL ,
  `activate` TINYINT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE UNIQUE INDEX `code_UNIQUE` ON `coupon` (`code` ASC) ;


-- -----------------------------------------------------
-- Table `coupon_rule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `coupon_rule` ;

CREATE  TABLE IF NOT EXISTS `coupon_rule` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `coupon_id` INT NOT NULL ,
  `controller` VARCHAR(255) NULL ,
  `operation` VARCHAR(255) NULL ,
  `value` FLOAT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_coupon_rule_coupon_id`
    FOREIGN KEY (`coupon_id` )
    REFERENCES `coupon` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_coupon_rule_coupon_id` ON `coupon_rule` (`coupon_id` ASC) ;


-- -----------------------------------------------------
-- Table `coupon_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `coupon_order` ;

CREATE  TABLE IF NOT EXISTS `coupon_order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NOT NULL ,
  `code` VARCHAR(45) NOT NULL ,
  `value` FLOAT NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_coupon_order_order_id`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_coupon_order_order_id` ON `coupon_order` (`order_id` ASC) ;


-- -----------------------------------------------------
-- Table `config_desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_desc` ;

CREATE  TABLE IF NOT EXISTS `config_desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `config_id` INT NOT NULL ,
  `lang` VARCHAR(10) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `chapo` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_ config_desc_config_id`
    FOREIGN KEY (`config_id` )
    REFERENCES `config` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE INDEX `idx_ config_desc_config_id` ON `config_desc` (`config_id` ASC) ;


-- -----------------------------------------------------
-- Table `admin_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admin_log` ;

CREATE  TABLE IF NOT EXISTS `admin_log` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `admin_login` VARCHAR(255) NULL ,
  `admin_firstname` VARCHAR(255) NULL ,
  `admin_lastname` VARCHAR(255) NULL ,
  `action` VARCHAR(255) NULL ,
  `request` TEXT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_folder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_folder` ;

CREATE  TABLE IF NOT EXISTS `content_folder` (
  `content_id` INT NOT NULL ,
  `folder_id` INT NOT NULL ,
  PRIMARY KEY (`content_id`, `folder_id`) ,
  CONSTRAINT `fk_content_folder_content_id`
    FOREIGN KEY (`content_id` )
    REFERENCES `content` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_content_folder_folder_id`
    FOREIGN KEY (`folder_id` )
    REFERENCES `folder` (`id` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `fk__idx` ON `content_folder` (`content_id` ASC) ;

CREATE INDEX `fk_content_folder_folder_id_idx` ON `content_folder` (`folder_id` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
