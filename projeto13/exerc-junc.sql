# Junção de Tabelas
# Retornar id do pedido e nome do cliente


# Inner Join
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES as C 
ON P.id_cliente = C.id_cliente;


# Retornar id do pedido e nome do cliente
# Inner Join
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P, cap04.TB_CLIENTES AS C
WHERE P.id_cliente = C.id_cliente;


# Retornar id do pedido, nome do cliente e nome do vendedor


# Inner Join com 3 tabelas
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM ((cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
INNER JOIN cap04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor);


# Retornar id do pedido, nome do cliente e nome do vendedor


# Inner Join com 3 tabelas
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM cap04.TB_PEDIDOS AS P, cap04.TB_CLIENTES AS C, cap04.TB_VENDEDOR AS V
WHERE P.id_cliente = C.id_cliente
  AND P.id_vendedor = V.id_vendedor;


# INNER JOIN e Outras Cláusulas SQL


# Inner Join - Padrão ANSI
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES as C 
ON P.id_cliente = C.id_cliente;


# JOIN sem INNER ainda é INNER
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Inner Join quando o nome da coluna é o mesmo em ambas as tabelas
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES as C 
USING (id_cliente);


# Inner Join com WHERE e ORDER BY
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES as C 
USING (id_cliente)
WHERE C.nome_cliente LIKE 'Bob%'
ORDER BY P.id_pedido DESC;


# Retornar todos os clientes, com ou sem pedido associado (usando Left Join)


# Left Join - indica que queremos todos os dados da tabela da esquerda mesmo sem correspondente na tabela da direita
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
LEFT JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Usamos LEFT JOIN como abreviação para LEFT OUTER JOIN
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
LEFT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Se inverter a ordem das tabelas o resultado é diferente
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_PEDIDOS AS P
LEFT JOIN cap04.TB_CLIENTES AS C 
ON C.id_cliente = P.id_cliente;


# Retornar todos os clientes, com ou sem pedido associado (usando Right Join)


# Right Join - indica que queremos todos os dados da tabela da direita mesmo sem correspondente na tabela da esquerda
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_PEDIDOS AS P
RIGHT JOIN cap04.TB_CLIENTES AS C 
ON C.id_cliente = P.id_cliente;


# Retornar a data do pedido, o nome do cliente, todos os vendedores, com ou sem pedido associado, e ordenar o resultado pelo nome do cliente.


# Solução
SELECT P.data_pedido, C.nome_cliente, V.nome_vendedor
FROM ((cap04.TB_PEDIDOS AS P
JOIN cap04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
RIGHT JOIN cap04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor)
ORDER BY C.nome_cliente;


# Solução com mais detalhes
SELECT 
     CASE 
      WHEN P.data_pedido IS NULL THEN "Sem Pedido"
            ELSE P.data_pedido
    END AS data_pedido,
        CASE 
      WHEN C.nome_cliente IS NULL THEN "Sem Pedido"
            ELSE C.nome_cliente
    END AS nome_cliente,
        V.nome_vendedor
FROM ((cap04.TB_PEDIDOS AS P
JOIN cap04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
RIGHT JOIN cap04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor)
ORDER BY C.nome_cliente;


# Vamos inserir um registro na tabela de pedidos que será "órfão" e queremos retornar todos os dados de ambas as tabelas mesmo sem correspondência
INSERT INTO `cap04`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`)
VALUES (1004, 10, 6, now(), 23);


# Left Join
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
LEFT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Right Join
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
RIGHT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Full Outer Join (alguns SGBDs não implementam essa junção)
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
FULL OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Resolvemos o problema com o UNION e UNION ALL

# UNION
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
LEFT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente
UNION
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
RIGHT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# UNION ALL
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
LEFT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente
UNION ALL
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
RIGHT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Inserir mais um registro na tabela de clientes
INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (6, "Madona", "Rua 45", "Campos", "RJ");


# Retornar clientes que sejam da mesma cidade


# Self Join
SELECT A.nome_cliente, A.cidade_cliente
FROM cap04.TB_CLIENTES A, cap04.TB_CLIENTES B
WHERE A.id_cliente <> B.id_cliente
AND A.cidade_cliente = B.cidade_cliente;


# Retornar todos os dados de todas as tabelas


# CROSS JOIN
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
CROSS JOIN cap04.TB_PEDIDOS AS P;


# CROSS JOIN
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P, cap04.TB_CLIENTES AS C;


# CROSS JOIN com WHERE tem o mesmo comportamento do INNER JOIN
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
CROSS JOIN cap04.TB_PEDIDOS AS P
WHERE C.id_cliente = P.id_cliente;
