# Carga de dados via linha de comando

CREATE TABLE cap06.TB_BIKES (
  `duracao_segundos` int DEFAULT NULL,
  `data_inicio` text,
  `data_fim` text,
  `numero_estacao_inicio` int DEFAULT NULL,
  `estacao_inicio` text,
  `numero_estacao_fim` int DEFAULT NULL,
  `estacao_fim` text,
  `numero_bike` text,
  `tipo_membro` text);

# Conecte no MySQL via linha de comando
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap07/Exercicio5/dados/2012-capitalbikeshare-tripdata/2012Q1-capitalbikeshare-tripdata.csv' INTO TABLE `exec5`.`TB_BIKES` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;




# Duração total do aluguel das bikes (em horas)
SELECT SUM(duracao_segundos/60/60) AS duracao_total_horas
FROM cap06.TB_BIKES;

# Duração total do aluguel das bikes (em horas), ao longo do tempo (soma acumulada)
SELECT duracao_segundos,
       SUM(duracao_segundos/60/60) OVER (ORDER BY data_inicio) AS duracao_total_horas
FROM cap06.TB_BIKES; 

# Duração total do aluguel das bikes (em horas), ao longo do tempo, por estação de início do aluguel da bike,
# quando a data de início foi inferior a '2012-01-08'
SELECT estacao_inicio,
       duracao_segundos,
       SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS tempo_total_horas
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Mesma query anterior sem ORDER BY no Partition
SELECT estacao_inicio,
       duracao_segundos,
       SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio) AS estacao_inicio_total
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';



# Estatísticas

# Qual a média de tempo (em horas) de aluguel de bike da estação de início 31017?
SELECT estacao_inicio,
       AVG(duracao_segundos/60/60) AS media_tempo_aluguel
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31017
GROUP BY estacao_inicio;

# Qual a média de tempo (em horas) de aluguel da estação de início 31017, ao longo do tempo (média móvel)?
SELECT estacao_inicio,
       AVG(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS media_tempo_aluguel
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31017;

# Retornar:
# Estação de início, data de início e duração de cada aluguel de bike em segundos
# Duração total de aluguel das bikes ao longo do tempo por estação de início
# Duração média do aluguel de bikes ao longo do tempo por estação de início
# Número de aluguéis de bikes por estação ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'

# Esta query calcula estatísticas, mas não ao longo do tempo!
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       SUM(duracao_segundos/60/60) AS duracao_total_aluguel,
       AVG(duracao_segundos/60/60) AS media_tempo_aluguel,
       COUNT(duracao_segundos/60/60) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
GROUP BY estacao_inicio, data_inicio, duracao_segundos;

# Esta query calcula estatísticas, ao longo do tempo!
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS duracao_total_aluguel,
       AVG(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS media_tempo_aluguel,
       COUNT(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Retornar:
# Estação de início, data de início de cada aluguel de bike e duração de cada aluguel em segundos
# Número de aluguéis de bikes (independente da estação) ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'

# Solução 1
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       COUNT(duracao_segundos/60/60) OVER (ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Solução 2
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# E se quisermos o mesmo resultado anterior, mas a contagem por estação?
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
# para a estação de id 31000
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
# para a estação de id 31000, com a coluna de data_inicio convertida para o formato date
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
# para a estação de id 31000, com a coluna de data_inicio convertida para o formato date
# Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo do tempo
# DENSE_RANK() concede todas as linhas idênticas a mesma classificação (ranking) e salta para o próximo item no ranking
SELECT estacao_inicio,
       CAST(data_inicio as date),
       duracao_segundos,
       DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS ranking_aluguel
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
# para a estação de id 31000, com a coluna de data_inicio convertida para o formato date
# Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo do tempo
# RANK() concede todas as linhas idênticas a mesma classificação (ranking) e salta para o próximo item no ranking
SELECT estacao_inicio,
       CAST(data_inicio as date),
       duracao_segundos,
       RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS ranking_aluguel
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# Comparando as funções
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis,
       DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS ranking_aluguel_dense_rank,
       RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS ranking_aluguel_rank
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# NTILE
# A função NTILE() é uma função de janela (window) que distribui linhas de uma partição ordenada em um número predefinido 
# de grupos aproximadamente iguais. A função atribui a cada grupo um número a partir de 1. 
SELECT estacao_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_alugueis,
       NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_dois,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_quatro,
       NTILE(5) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_cinco
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# NTILE
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis,
       NTILE(1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo,
       NTILE(16) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# LAG e LEAD
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS registro_lag,
       LEAD(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS registro_lead
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para outro?
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# LAG com Subquery
SELECT *
  FROM (
    SELECT estacao_inicio,
           CAST(data_inicio as date) AS data_inicio,
           duracao_segundos,
           duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
      FROM cap06.TB_BIKES
     WHERE data_inicio < '2012-01-08'
     AND numero_estacao_inicio = 31000) resultado
 WHERE resultado.diferenca IS NOT NULL;



# Window Alias

# NTILE
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo_dois,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo_quatro,
       NTILE(5) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo_cinco
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Criamos um alias para a janela e particionamos novamente a janela
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_dois,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_quatro,
       NTILE(5) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_cinco
  FROM cap06.TB_BIKES
 WHERE data_inicio < '2012-01-08'
WINDOW ntile_window AS (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date))
 ORDER BY estacao_inicio;



# https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

# Extraindo itens específicos da data
SELECT data_inicio,
       DATE(data_inicio),
       TIMESTAMP(data_inicio),
       YEAR(data_inicio),
       MONTH(data_inicio),
       DAY(data_inicio)
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31000;

# Extraindo o mês da data
SELECT EXTRACT(MONTH FROM data_inicio) AS mes, duracao_segundos
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31000;

# Adicionando 10 dias à data de início
SELECT data_inicio, DATE_ADD(data_inicio, INTERVAL 10 DAY) AS data_inicio, duracao_segundos
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31000;

# Retornando dados de 10 dias anteriores à data de início do aluguel da bike
SELECT data_inicio, duracao_segundos
FROM cap06.TB_BIKES
WHERE DATE_SUB("2012-03-31", INTERVAL 10 DAY) <= data_inicio
AND numero_estacao_inicio = 31000;

# Diferença entre data_inicio e data_fim
SELECT data_inicio, data_fim, DATEDIFF(data_inicio, data_fim)
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31000;

# Diferença entre data_inicio e data_fim
SELECT DATE_FORMAT(data_inicio, "%H") AS hora_inicio, 
       DATE_FORMAT(data_fim, "%H") AS hora_fim, 
       DATEDIFF(data_inicio, data_fim)
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31000;

# Diferença entre data_inicio e data_fim
SELECT DATE_FORMAT(data_inicio, "%H") AS hora_inicio, 
       DATE_FORMAT(data_fim, "%H") AS hora_fim, 
       (DATE_FORMAT(data_fim, "%H") - DATE_FORMAT(data_inicio, "%H")) AS diff
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31000;