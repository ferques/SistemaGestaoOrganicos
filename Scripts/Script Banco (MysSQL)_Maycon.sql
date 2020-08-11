-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bdorganicos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdorganicos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdorganicos` DEFAULT CHARACTER SET utf8 ;
USE `bdorganicos` ;

-- -----------------------------------------------------
-- Table `bdorganicos`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`usuario` (
  `id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `login` VARCHAR(45) NULL,
  `senha` TEXT NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`permissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`permissao` (
  `id` INT NOT NULL,
  `nome` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`permissao_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`permissao_usuario` (
  `permissao_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `permitido` TINYINT NOT NULL,
  INDEX `fk_permissao_usuario_permissao_idx` (`permissao_id` ASC) VISIBLE,
  INDEX `fk_permissao_usuario_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  PRIMARY KEY (`usuario_id`, `permissao_id`),
  CONSTRAINT `fk_permissao_usuario_permissao`
    FOREIGN KEY (`permissao_id`)
    REFERENCES `bdorganicos`.`permissao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissao_usuario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `bdorganicos`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`certificadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`certificadora` (
  `id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`estado` (
  `id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `sigla` VARCHAR(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`cidade` (
  `id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_estado1_idx` (`estado_id` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `bdorganicos`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`grupo` (
  `id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `endereco` VARCHAR(100) NULL,
  `numero` INT NULL,
  `bairro` VARCHAR(45) NULL,
  `cidade_id` INT NOT NULL,
  `cnpj` VARCHAR(14) NULL,
  `inscricao_estadual` VARCHAR(20) NULL,
  `distribuidor_produtos` TINYINT NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_grupo_cidade1_idx` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupo_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `bdorganicos`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`produtor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`produtor` (
  `id` INT NOT NULL,
  `certificadora_id` INT NOT NULL,
  `grupo_id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `nome_propriedade` VARCHAR(80) NULL,
  `cpf_cnpj` VARCHAR(14) NULL,
  `endereco` VARCHAR(100) NULL,
  `numero` INT NULL,
  `bairro` VARCHAR(45) NULL,
  `cidade_id` INT NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `latitude` DECIMAL(14,7) NULL,
  `longitude` DECIMAL(14,7) NULL,
  `certificacao_organicos` VARCHAR(1) NULL,
  `venda_consumidorfinal` TINYINT NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produtor_certificadora1_idx` (`certificadora_id` ASC) VISIBLE,
  INDEX `fk_produtor_grupo1_idx` (`grupo_id` ASC) VISIBLE,
  INDEX `fk_produtor_cidade1_idx` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_produtor_certificadora1`
    FOREIGN KEY (`certificadora_id`)
    REFERENCES `bdorganicos`.`certificadora` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtor_grupo1`
    FOREIGN KEY (`grupo_id`)
    REFERENCES `bdorganicos`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtor_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `bdorganicos`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`tipoproduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`tipoproduto` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`produto` (
  `id` INT NOT NULL,
  `tipoproduto_id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `descricao` VARCHAR(150) NULL,
  `preco_unitario` DECIMAL(14,2) NULL,
  `unidade` VARCHAR(3) NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_tipoproduto1_idx` (`tipoproduto_id` ASC) VISIBLE,
  CONSTRAINT `fk_produto_tipoproduto1`
    FOREIGN KEY (`tipoproduto_id`)
    REFERENCES `bdorganicos`.`tipoproduto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`pontosvenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`pontosvenda` (
  `id` INT NOT NULL,
  `nome` VARCHAR(80) NULL,
  `endereco` VARCHAR(100) NULL,
  `numero` INT NULL,
  `bairro` VARCHAR(45) NULL,
  `cidade_id` INT NOT NULL,
  `registro_ativo` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pontosvenda_cidade1_idx` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_pontosvenda_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `bdorganicos`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdorganicos`.`produtor_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdorganicos`.`produtor_produto` (
  `id` INT NOT NULL,
  `produtor_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `pontosvenda_id` INT NOT NULL,
  `dia_semana` INT NULL,
  `horario` TIME NULL,
  `pausado` TINYINT NOT NULL,
  INDEX `fk_produtor_produto_produtor1_idx` (`produtor_id` ASC) VISIBLE,
  INDEX `fk_produtor_produto_produto1_idx` (`produto_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_produtor_produto_pontosvenda1_idx` (`pontosvenda_id` ASC) VISIBLE,
  CONSTRAINT `fk_produtor_produto_produtor1`
    FOREIGN KEY (`produtor_id`)
    REFERENCES `bdorganicos`.`produtor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtor_produto_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `bdorganicos`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtor_produto_pontosvenda1`
    FOREIGN KEY (`pontosvenda_id`)
    REFERENCES `bdorganicos`.`pontosvenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
