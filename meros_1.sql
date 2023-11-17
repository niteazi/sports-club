DROP DATABASE IF EXISTS sports_club;
CREATE DATABASE if NOT EXISTS sports_club;

--drop TABLES
DROP TABLE IF EXISTS `STATISTIKA`;
DROP TABLE IF EXISTS `TRAUMATISMOS`;
DROP TABLE IF EXISTS `PROPONHSH_PROPONHTHS`;
DROP TABLE IF EXISTS `AGWNES_ATHLITI`;
DROP TABLE IF EXISTS `PROPONHSEIS_ATHLITI`;
DROP TABLE IF EXISTS `PROPONHSH`;
DROP TABLE IF EXISTS `AGWNAS`;
DROP TABLE IF EXISTS `A8LITIS`;
DROP TABLE IF EXISTS `PROPONHTHS`;
DROP TABLE IF EXISTS `A8LIMA`;
DROP TABLE IF EXISTS `SEASON`;
DROP TABLE IF EXISTS `EGKATASTASEIS`;

--CREATE TABLES

CREATE TABLE IF NOT EXISTS `EGKATASTASEIS` (
  `kwdikos_egkatastashs` int(3)  NOT NULL,
  `onoma egkatastashs` varchar(25) NOT NULL,
  `typos_gypedou` varchar(25) NOT NULL,
  `xwrhtikothta`  INT NOT NULL,
  PRIMARY KEY (`kwdikos_egkatastashs`)
);

CREATE TABLE IF NOT EXISTS `SEASON` (
  `epoxh` VARCHAR(20) NOT NULL,
  `etos` int(4) NOT NULL,
  `synolo_agwnwn` int(4) NOT NULL,
  `synolo_nikwn` int(3) NOT NULL,
  `synolo_httwn` int(3) NOT NULL,
  PRIMARY KEY (epoxh, etos)
);

CREATE TABLE IF NOT EXISTS `A8LIMA` (
  `onoma_athlimatos`  varchar(25) NOT NULL,
  `tropos_paixnidiou` ENUM('omadiko', 'atomiko') NOT NULL ,
  `exoplismos`TEXT,
  `kwdikos_egkatastashs` int(3) NOT NULL,
  PRIMARY KEY (`onoma_athlimatos`),
  FOREIGN KEY (kwdikos_egkatastashs) REFERENCES EGKATASTASEIS(kwdikos_egkatastashs)
);

CREATE TABLE if not exists `PROPONHTHS` (
  `kwdikos_proponhth` int(7) NOT NULL,
  `athlima` VARCHAR(25) NOT NULL,
  `onomateponymo` varchar(40) NOT NULL,
  `etiypiresias` int(2) NOT NULL,
  `amivi` float NOT NULL,
  FOREIGN KEY (`athlima`) REFERENCES `A8LIMA`(`onoma_athlimatos`),
  PRIMARY KEY (`kwdikos_proponhth`)
);

CREATE TABLE IF NOT EXISTS `A8LITIS` (
  `aem_athliti` INT(6) NOT NULL,
  `onomateponymo` VARCHAR(40) NOT NULL,
  `fylo` ENUM('Andras', 'Gynaika') NOT NULL,
  `hmerominia_eggrafis` DATE NOT NULL,
  `hmerominia_gennhshs` DATE NOT NULL,
  `kwdikos_proponhth` INT(7) NOT NULL,
  `athlima` VARCHAR(25) NOT NULL,
  FOREIGN KEY (`kwdikos_proponhth`) REFERENCES `PROPONHTHS`(`kwdikos_proponhth`),
  FOREIGN KEY (`athlima`) REFERENCES `A8LIMA`(`onoma_athlimatos`),
  PRIMARY KEY (`aem_athliti`)
);
CREATE TABLE IF NOT EXISTS `AGWNAS` (
  `kwdikos_agwna` INT(4) NOT NULL,
  `epoxh_season` VARCHAR(20) NOT NULL,
  `etos_season` INT(4) NOT NULL,
  `hmeromhnia_dieksagwghs` DATE NOT NULL,
  `wra_dieksagwghs` TIME NOT NULL,
  `apotelesma` VARCHAR(255) NOT NULL,
  `eidos_match` ENUM('filiko', 'antagwnistiko') NOT NULL,
  `topothesia` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`kwdikos_agwna`),
  FOREIGN KEY (`epoxh_season`, `etos_season`) REFERENCES `SEASON` (`epoxh`, `etos`)
);


CREATE TABLE if not exists `PROPONHSH` (
  `kwdikos_proponhshs` int(4) NOT NULL,
  `athlima` VARCHAR(25) NOT NULL,
  `kwdikos_egkatastashs` int(3) NOT NULL,
  `wra_dieksagwghs` TIME NOT NULL,
  `hmera_dieksagwghs` VARCHAR(10) NOT NULL,
  `diarkeia_se_lepta` int(3) NOT NULL,
  FOREIGN KEY (`athlima`) REFERENCES `A8LIMA`(`onoma_athlimatos`),
  FOREIGN KEY (`kwdikos_egkatastashs`) REFERENCES `EGKATASTASEIS`(`kwdikos_egkatastashs`),
  PRIMARY KEY (`kwdikos_proponhshs`)
);

--N:M pinakas athliti kai proponhseis
CREATE TABLE if not exists `PROPONHSEIS_ATHLITI` (
  `aem_athliti` int(6) NOT NULL,
  `kwdikos_proponhshs` int(4) NOT NULL,
  PRIMARY KEY (`aem_athliti`, `kwdikos_proponhshs`),
  FOREIGN KEY (`aem_athliti`) REFERENCES `A8LITIS`(`aem_athliti`),
  FOREIGN KEY (`kwdikos_proponhshs`) REFERENCES `PROPONHSH`(`kwdikos_proponhshs`)
);

--N:M pinakas athliti kai agwnas
CREATE TABLE if not exists `AGWNES_ATHLITI` (
  `aem_athliti` int(6) NOT NULL,
  `kwdikos_agwna` int(4) NOT NULL,
  PRIMARY KEY (`aem_athliti`, `kwdikos_agwna`),
  FOREIGN KEY (`aem_athliti`) REFERENCES `A8LITIS`(`aem_athliti`),
  FOREIGN KEY (`kwdikos_agwna`) REFERENCES `AGWNAS`(`kwdikos_agwna`)
);

--N:M pinakas proponhsh kai proponhths
CREATE TABLE if not exists `PROPONHSH_PROPONHTHS` (
  `proponhsh_kwdikos` int(4) NOT NULL,
  `proponhtes_kwdikos` int(7) NOT NULL,
  PRIMARY KEY (`proponhsh_kwdikos`, `proponhtes_kwdikos`),
  FOREIGN KEY (`proponhsh_kwdikos`) REFERENCES `PROPONHSH`(`kwdikos_proponhshs`),
  FOREIGN KEY (`proponhtes_kwdikos`) REFERENCES `PROPONHTHS`(`kwdikos_proponhth`)
);

--weak entity table
 
  CREATE TABLE IF NOT EXISTS `TRAUMATISMOS` (
  `trauma_id` INT AUTO_INCREMENT,
  `aem_athliti` INT(6) NOT NULL,
  `hmeromhnia` DATE NOT NULL,
  `typos_traumatismou` VARCHAR(30) NOT NULL,
  `anafora_symvantos` TEXT,
  `sovarotita` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`aem_athliti`, `trauma_id`),
  FOREIGN KEY (`aem_athliti`) REFERENCES `A8LITIS`(`aem_athliti`) ON DELETE CASCADE
);

--g n mporei n mpei sta statistika to apotelesma tou agwna
CREATE INDEX idx_agwnas_apotelesma ON AGWNAS(apotelesma);

--1:1 me agwna

CREATE TABLE IF NOT EXISTS `STATISTIKA` (
  `kwdikos_agwna` INT(4) NOT NULL,
  `apotelesma` VARCHAR(255) NOT NULL,
  `diarkeia_se_lepta` INT(3) NOT NULL,
  `arithmos_theatwn` INT(5) NOT NULL,
  `kairikes_synthikes` VARCHAR(30),
  PRIMARY KEY (`kwdikos_agwna`),
  FOREIGN KEY (`kwdikos_agwna`) REFERENCES `AGWNAS`(`kwdikos_agwna`),
  FOREIGN KEY (`apotelesma`) REFERENCES `AGWNAS`(`apotelesma`),
  UNIQUE (`kwdikos_agwna`)
);

--INSERT VALUES

INSERT INTO EGKATASTASEIS
VALUES 
(123,'ghpedo podosfairou', 'kleisto', 200),
(128,'ghpedo basket', 'kleisto', 200),
(173,'ghpedo tennis', 'anoixto', 100);


INSERT INTO SEASON
VALUES 
('Anoiksi',2022, 20, 15,5),
('Ftinoporo',2022, 15, 10,5),
('Anoiksi',2021, 10, 5,5);


INSERT INTO A8LIMA
VALUES 
('Podosfairo', 'omadiko', 'mpala', 123),
('Basket', 'omadiko', 'mpala', 128),
('Tennis', 'atomiko', 'raketes', 173);

INSERT INTO PROPONHTHS
VALUES
(1234567, 'Podosfairo', 'Giorgos Gkolios', 2, 1000),
(1234568, 'Basket', 'Giannis Kapis', 3, 1100),
(1234569, 'Tennis', 'Xrhstos Dimitriadhs', 1, 900);

INSERT INTO A8LITIS
VALUES 
(123456, 'Dimitris Skourths', 'Andras', '2020-09-01', '2000-01-01', 1234567, 'Podosfairo'),
(123457, 'Orfeas Dedes', 'Andras', '2021-09-05', '2001-05-12', 1234568, 'Basket'),
(123458, 'Iosif Tsannis', 'Andras', '2019-10-10', '2000-03-15', 1234569, 'Tennis');