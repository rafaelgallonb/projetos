# Solução Exercício 3

# Cria o schema
CREATE SCHEMA `exec3` DEFAULT CHARACTER SET utf8 ;

# Usa o schema
Use exec3;

# Verifica character set
SELECT @@character_set_database, @@collation_database;

SHOW VARIABLES LIKE 'collation%';

SELECT 
   table_schema,
   table_name,
   table_collation   
FROM information_schema.tables
WHERE table_schema = 'exec3';

# Cria tabelas
CREATE TABLE `exec3`.`TB_ATLETAS` (
  `name` VARCHAR(200) NULL,
  `noc` VARCHAR(200) NULL,
  `discipline` VARCHAR(200) NULL);

CREATE TABLE `exec3`.`TB_COACHES` (
  `name` VARCHAR(200) NULL,
  `noc` VARCHAR(200) NULL,
  `discipline` VARCHAR(200) NULL,
  `event` VARCHAR(200) NULL);

CREATE TABLE `exec3`.`TB_MEDALS` (
  `rank` INT NULL,
  `noc` VARCHAR(200) NULL,
  `gold` INT NULL,
  `silver` INT NULL,
  `bronze` INT NULL,
  `total` INT NULL,
  `rank_total` INT NULL);

CREATE TABLE `exec3`.`TB_ENTRIESGENDER` (
  `discipline` VARCHAR(200) NULL,
  `female` INT NULL,
  `male` INT NULL,
  `total` INT NULL);

CREATE TABLE `exec3`.`TB_TEAMS` (
  `name` VARCHAR(200) NULL,
  `discipline` VARCHAR(200) NULL,
  `noc` VARCHAR(200) NULL,
  `event` VARCHAR(200) NULL);

# Altera o character set (se necessário)
ALTER TABLE `exec3`.`TB_ATLETAS` CHARACTER SET latin2 COLLATE latin2_general_ci;
ALTER DATABASE exec3 CHARACTER SET latin2 COLLATE latin2_general_ci;

# Conecte no MySQL via linha de comando
/usr/local/mysql/bin/mysql -u root -p

# Execute:
SET GLOBAL local_infile = true;
exit;

# Conecte novamente
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Carrega os dados
LOAD DATA LOCAL INFILE 'SQL-Para-Data-Science/Cap05/Exercicio3/Athletes.csv' INTO TABLE `exec3`.`TB_ATLETAS` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'SQL-Para-Data-Science/Cap05/Exercicio3/Coaches.csv' INTO TABLE `exec3`.`TB_COACHES` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'SQL-Para-Data-Science/Cap05/Exercicio3/Medals.csv' INTO TABLE `exec3`.`TB_MEDALS` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'SQL-Para-Data-Science/Cap05/Exercicio3/EntriesGender.csv' INTO TABLE `exec3`.`TB_ENTRIESGENDER` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'SQL-Para-Data-Science/Cap05/Exercicio3/Teams.csv' INTO TABLE `exec3`.`TB_TEAMS` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Solução SQL

# Item 1
SELECT name FROM exec3.TB_COACHES WHERE discipline = 'Handball';
SELECT name FROM exec3.TB_ATLETAS WHERE discipline = 'Handball';

# Item 2
SELECT name, gold
FROM exec3.TB_COACHES A, exec3.TB_MEDALS B
WHERE A.noc = B.noc
AND A.noc = 'Australia'
AND gold > 0
ORDER BY gold DESC;

-> Não pode ser respondido

# Item 3
-> Não pode ser respondido

# Item 4
SELECT A.noc, gold, silver 
FROM exec3.TB_ATLETAS A, exec3.TB_MEDALS B
WHERE A.noc = B.noc
AND a.noc = 'Norway'

-> Não pode ser respondido

# Item 5
-> Não pode ser respondido



