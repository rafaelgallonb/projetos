
# 1- Quais poluentes foram considerados na pesquisa?
SELECT DISTINCT(pollutant)
FROM cap09.TB_GLOBAL_QUALIDADE_AR;

# 2- Qual foi a média de poluição ao longo do tempo provocada pelo poluente ground-level ozone (o3)?
SELECT country AS pais,
       CAST(timestamp AS DATE) AS data_coleta,
       ROUND(AVG(value) OVER(PARTITION BY country ORDER BY CAST(timestamp AS DATE)), 2) AS media_valor_poluicao
FROM cap09.TB_GLOBAL_QUALIDADE_AR
WHERE pollutant = 'o3'
ORDER BY country, data_coleta;

# 3- Qual foi a média de poluição causada pelo poluente ground-level ozone (o3) por país medida em µg/m³ (microgramas por metro cúbico)?
SELECT country AS pais, 
       ROUND(AVG(value),2) AS media_poluicao
FROM cap09.TB_GLOBAL_QUALIDADE_AR
WHERE pollutant = 'o3'
AND unit = 'µg/m³'
GROUP BY country
ORDER BY media_poluicao ASC;

# 4- Considerando o resultado anterior, qual país teve maior índice de poluição geral por o3, 
# Itália (IT) ou Espanha (ES)? Por que?
SELECT country AS pais, 
       ROUND(AVG(value),2) AS media_poluicao, 
       STDDEV(value) AS desvio_padrao, 
       MAX(value) AS valor_maximo, 
       MIN(value) AS valor_minimo
FROM cap09.TB_GLOBAL_QUALIDADE_AR
WHERE pollutant = 'o3'
AND unit = 'µg/m³'
AND country IN ('IT', 'ES') 
GROUP BY country
ORDER BY media_poluicao ASC;

# O Coeficiente de Variação (CV) é uma medida estatística da dispersão dos dados em uma série de dados em torno da média. 
# O Coeficiente de Variação representa a razão entre o desvio padrão e a média e é uma estatística útil para comparar o grau 
# de variação de uma série de dados para outra, mesmo que as médias sejam drasticamente diferentes umas das outras.

# Quanto maior o Coeficiente de Variação , maior o nível de dispersão em torno da média, logo, maior variabilidade.

# O Coeficiente de Variação é calculado da seguinte forma: CV = (Desvio Padrão / Média) * 100

SELECT country AS pais, 
       ROUND(AVG(value),2) AS media_poluicao, 
       STDDEV(value) AS desvio_padrao, 
       MAX(value) AS valor_maximo, 
       MIN(value) AS valor_minimo,
       (STDDEV(value) / ROUND(AVG(value),2)) * 100 AS cv
FROM cap09.TB_GLOBAL_QUALIDADE_AR
WHERE pollutant = 'o3'
AND unit = 'µg/m³'
AND country IN ('IT', 'ES') 
GROUP BY country
ORDER BY media_poluicao ASC;

# Conclusão: Embora o CV da Espanha seja muito maior, a média da Itália é muito alta, com os pontos de dados mais próximos da média.
# Os 2 países tem um alto índice de poluição geral por o3
# A Itália apresenta maior índice de poluição geral, pois a média é alta e os pontos de dados estão mais próximos da média.

# 5- Quais localidades e países tiveram média de poluição em 2020 superior a 100 µg/m³ para o poluente fine particulate matter (pm25)?
SELECT COALESCE(location, "Total") AS localidade,
	COALESCE(country, "Total") AS pais, 
       ROUND(AVG(value), 2) AS media_poluicao
FROM cap09.TB_GLOBAL_QUALIDADE_AR
WHERE pollutant = 'pm25'
AND YEAR(timestamp) = 2020
GROUP BY location, country WITH ROLLUP
HAVING media_poluicao > 100
ORDER BY location, country;



