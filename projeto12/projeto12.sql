# Criação de tabela para importação dos dados

CREATE TABLE `cap03`.`TB_DADOS` (
  `classe` VARCHAR(100) NULL,
  `idade` VARCHAR(45) NULL,
  `menopausa` VARCHAR(45) NULL,
  `tamanho_tumor` VARCHAR(45) NULL,
  `inv_nodes` VARCHAR(45) NULL,
  `node_caps` VARCHAR(3) NULL,
  `deg_malig` INT NULL,
  `seio` VARCHAR(5) NULL,
  `quadrante` VARCHAR(10) NULL,
  `irradiando` VARCHAR(3) NULL);

SELECT COUNT(*) FROM cap03.TB_DADOS;


# Binarização da variável classe (0/1)
SELECT DISTINCT classe FROM cap03.TB_DADOS;

SELECT 
  CASE 
    WHEN classe = 'no-recurrence-events' THEN 0 
        WHEN classe = 'recurrence-events' THEN 1
  END as classe
FROM cap03.TB_DADOS;


# Binarização da variável irradiando (0/1)
SELECT DISTINCT irradiando FROM cap03.TB_DADOS;

SELECT 
  CASE 
    WHEN irradiando = 'no' THEN 0 
        WHEN irradiando = 'yes' THEN 1
  END as irradiando
FROM cap03.TB_DADOS;


# Binarização da variável node_caps (0/1)
SELECT DISTINCT node_caps FROM cap03.TB_DADOS;

SELECT 
  CASE 
    WHEN node_caps = 'no' THEN 0 
        WHEN node_caps = 'yes' THEN 1
  END as node_caps
FROM cap03.TB_DADOS;


# Para ajustar a variável node_caps iremos agora codificar a variável e não mais binarizar
SELECT 
  CASE 
    WHEN node_caps = 'no' THEN 0 
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
  END as node_caps
FROM cap03.TB_DADOS;


# Categorização da variável seio (E/D)
SELECT DISTINCT seio FROM cap03.TB_DADOS;

SELECT 
  CASE 
    WHEN seio = 'left' THEN 'E' 
        WHEN seio = 'right' THEN 'D'
  END as seio
FROM cap03.TB_DADOS;


# Categorização da variável tamanho_tumor (6 Categorias)
SELECT DISTINCT tamanho_tumor FROM cap03.TB_DADOS;

SELECT 
  CASE 
    WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
  END as tamanho_tumor
FROM cap03.TB_DADOS;


# Label Encoding da variável quadrante (1,2,3,4,5)
SELECT DISTINCT quadrante FROM cap03.TB_DADOS;

SELECT 
  CASE 
    WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
  END as quadrante
FROM cap03.TB_DADOS;


# Query com todas as transformações
SELECT 
  CASE 
    WHEN classe = 'no-recurrence-events' THEN 0 
        WHEN classe = 'recurrence-events' THEN 1
  END as classe,
  idade,
  menopausa,
  CASE 
    WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
  END as tamanho_tumor,
  inv_nodes,
  CASE 
    WHEN node_caps = 'no' THEN 0 
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
  END as node_caps,
  deg_malig,
  CASE 
    WHEN seio = 'left' THEN 'E' 
        WHEN seio = 'right' THEN 'D'
  END as seio,
  CASE 
    WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
  END as quadrante,
  CASE 
    WHEN irradiando = 'no' THEN 0 
        WHEN irradiando = 'yes' THEN 1
  END as irradiando
FROM cap03.TB_DADOS;


# Cria uma nova tabela
CREATE TABLE cap03.TB_DADOS2
AS
SELECT 
  CASE 
    WHEN classe = 'no-recurrence-events' THEN 0 
        WHEN classe = 'recurrence-events' THEN 1
  END as classe,
  idade,
  menopausa,
  CASE 
    WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
  END as tamanho_tumor,
  inv_nodes,
  CASE 
    WHEN node_caps = 'no' THEN 0 
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
  END as node_caps,
  deg_malig,
  CASE 
    WHEN seio = 'left' THEN 'E' 
        WHEN seio = 'right' THEN 'D'
  END as seio,
  CASE 
    WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
  END as quadrante,
  CASE 
    WHEN irradiando = 'no' THEN 0 
        WHEN irradiando = 'yes' THEN 1
  END as irradiando
FROM cap03.TB_DADOS;


SELECT COUNT(*) FROM cap03.TB_DADOS2;


# 1 - Aplicação de Label Encoding à variável menopausa

SELECT DISTINCT menopausa FROM cap03.TB_DADOS2;

CREATE TABLE cap03.TB_DADOS3
AS
SELECT
classe,
idade,
CASE
  WHEN menopausa = 'premeno' THEN 1
  WHEN menopausa = 'ge40' THEN 2
  WHEN menopausa = 'lt40' THEN 3
END as menopausa,
tamanho_tumor,
inv_nodes,
node_caps,
deg_malig,
seio,
quadrante,
irradiando
FROM cap03.TB_DADOS2;


# 2 - Criar uma nova coluna chamada posicao_tumor concatenando as colunas inv_nodes e quadrante

SELECT * FROM cap03.TB_DADOS3;

CREATE TABLE cap03.TB_DADOS4
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
CONCAT(inv_nodes, '-' , quadrante) AS posição_tumor,
node_caps,
deg_malig,
seio,
irradiando
FROM cap03.TB_DADOS3;


# 3 - Aplicação de One-Hot-Encoding à coluna deg_malig

SELECT * FROM cap03.TB_DADOS4;
SELECT DISTINCT deg_malig FROM cap03.TB_DADOS4;

CREATE TABLE cap03.TB_DADOS5
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
posição_tumor,
node_caps, 
CASE WHEN deg_malig = 1 THEN 1 ELSE 0 END AS deg_malig_cat1,
CASE WHEN deg_malig = 2 THEN 1 ELSE 0 END AS deg_malig_cat2,
CASE WHEN deg_malig = 3 THEN 1 ELSE 0 END AS deg_malig_cat3,
seio,
irradiando
FROM cap03.TB_DADOS4;