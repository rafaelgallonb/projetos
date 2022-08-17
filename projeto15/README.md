# Projeto 15: Análise de Dados Série Temporal - Capital Bikeshare

https://s3.amazonaws.com/capitalbikeshare-data/index.html

Dataset de 2012 Q1 (Part1) e Q2 (Part2)

1 – Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro?

2 – Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel)?

3 – Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel) ao longo do tempo?

4 – Qual hora do dia (independente do mês) a bike de número W01182 teve o maior número de aluguéis considerando a data de início? 

5 – Qual o número de aluguéis da bike de número W01182 ao longo do tempo considerando a data de início?

6 – Retornar:
- Estação fim, data fim de cada aluguel de bike e duração de cada aluguel em segundos
- Número de aluguéis de bike (independente da estação) ao longo do tempo
- Somente os registros quando a data fim foi no mês de Abril

7 – Retornar:
- Estação fim, data fim e duração em segundos do aluguel
- A data fim deve ser retornada no formato: 01/January/2012 00:00:00
- Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo do tempo
- Retornar os dados para os aluguéis entre 7 e 11 da manhã


8 – Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para outro, considerando data de início do aluguel e estação de início?
- A data de início deve ser retornada no formato Sat/Jan/12 00:00:00. Retornar os dados para os aluguéis entre 01 e 03 da manhã.


9 – Retornar:
- Estação fim, data fim e duração em segundos do aluguel
- A data fim deve ser retornada no formato 01/January/2012 00:00:00
- Queremos os registros divididos em 4 grupos ao longo do tempo por partição
- Retornar os dados para os aluguéis entre 8 e 10 da manhã
- Qual critério usado pela função NTILE para dividir os grupos?


10 – Quais estações tiveram mais de 35 horas de duração total do aluguel de bike ao longo do tempo considerando a data fim e estação fim?
- Retornar os dados entre os dias ‘2012-04-01’ e ‘2012-04-02’

