USE F1;

-- Básico
SELECT * FROM motor;

SELECT * FROM piloto;

SELECT pais FROM piloto;

SELECT * FROM construtor;

SELECT CONCAT(nome,'-',pais) FROM construtor;

SELECT DISTINCT pais FROM piloto;

SELECT * FROM piloto;

SELECT DISTINCT pnome, unome FROM piloto;

SELECT pnome, unome FROM piloto LIMIT 5;

SELECT pnome AS Nome, unome AS Apelido FROM piloto;

SELECT pnome AS Nome, unome AS `Último Nome` FROM piloto;

SELECT * FROM construtor WHERE UPPER(pais) = 'UK';

-- Pilotos franceses ou italianos com +60 anos
SELECT CONCAT(pnome,' ',unome) AS Piloto,
       pais,
       YEAR(CURDATE()) - anoNasc AS Idade
FROM piloto
WHERE (pais IN ('FRA','ITA'))
  AND (YEAR(CURDATE()) - anoNasc) > 60;

-- LIKE patterns
-- nomes que começam por J
SELECT pnome FROM piloto
WHERE pnome LIKE 'J%';

-- nomes que acabam em n
SELECT pnome FROM piloto
WHERE pnome LIKE '%n';

-- nomes que têm um n
SELECT pnome FROM piloto
WHERE pnome LIKE '%n%';

-- 'o' na 2.ª posição e depois um 'n' em qualquer posição
SELECT pnome FROM piloto
WHERE pnome LIKE '_o%n%';

-- 'a' na 3.ª posição e depois um 'n' em qualquer posição
SELECT pnome FROM piloto
WHERE pnome LIKE '__a%n%';

-- order by
SELECT * FROM piloto ORDER BY anoNasc, unome;

SELECT * FROM piloto ORDER BY unome, anoNasc;

-- Nome abreviado: 3 primeiras letras + '.' + apelido em maiúsculas
SELECT CONCAT(SUBSTRING(pnome,1,3),'.',UPPER(unome)) AS `Nome Abreviado`
FROM piloto;

-- Exemplo CASE
SELECT CONCAT(pnome,' ',unome) AS NomeCompleto,
       CASE
         WHEN pais = 'BRA' THEN 'Brasileiro'
         WHEN pais = 'ARG' THEN 'Argentino'
         ELSE 'Outro'
       END AS nacionalidade,
       CASE
         WHEN anoNasc < 1950 THEN 'Veterano'
         WHEN anoNasc >= 1950 AND anoNasc < 1980
              THEN CAST(YEAR(CURDATE()) - anoNasc AS CHAR)
         ELSE '...'
       END AS idade
FROM piloto;

------------------------------------

-- Ingleses nascidos na 1.ª metade do séc. XX
SELECT unome, YEAR(CURDATE()) - anoNasc AS Idade
FROM piloto
WHERE anoNasc < 1950
  AND UPPER(pais) = 'UK';

-- Nacionalidades (sem repetições) de todas as mulheres que já correram na F1
SELECT DISTINCT pais
FROM piloto
WHERE UPPER(sexo) = 'F';

-- Para cada construtor inglês, nome e décadas desde fundação (arredondado por defeito)
SELECT nome,
       FLOOR((YEAR(CURDATE()) - anoFund) / 10) AS toDecades
FROM construtor
WHERE UPPER(pais) = 'UK';

-- Apelidos diferentes, ordenados pelo número de letras (crescente)
SELECT DISTINCT unome
FROM piloto
ORDER BY CHAR_LENGTH(unome) ASC, unome ASC;

-- [EM FALTA 1] Mostrar o nome e a idade de todos os construtores que não sejam ingleses
SELECT nome,
       YEAR(CURDATE()) - anoFund AS Idade
FROM construtor
WHERE UPPER(pais) <> 'UK';

-- [EM FALTA 2] Mostrar o nome de todas as pilotas (qualquer país) OU
-- todos os pilotos não italianos, formatado "<ultimo nome>, <primeiro nome>",
-- ordenado alfabeticamente pelo último nome
SELECT CONCAT(unome, ', ', pnome) AS NomeFormatado
FROM piloto
WHERE UPPER(sexo) = 'F'
   OR (UPPER(sexo) <> 'F' AND UPPER(pais) <> 'ITA')
ORDER BY unome ASC, pnome ASC;
