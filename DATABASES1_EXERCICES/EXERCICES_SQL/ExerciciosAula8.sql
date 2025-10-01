use F1;
select * from pais
select * from continente

--produto cartesiano
select * from pais, continente

-- "join"
select * from pais, continente
where continente_id=id

-- mostrar todos os pares de pilotos que têm o mesmo último nome
-- auto-junção/self-join
-- é preciso 2 cópias da tabela piloto na mesma query
select p1.pnome+' '+p1.unome Piloto1, p2.pnome+' '+p2.unome Piloto2 from piloto p1, piloto p2
where p1.unome=p2.unome and p1.id<p2.id

-- para cada ano, mostrar o nome dos pilotos que correram para uma dada equipa
-- também é preciso 2 cópias da tabela piloto porque há 2 relações entre equipa e piloto
select p1.pnome+' '+p1.unome Piloto1, p2.pnome+' '+p2.unome Piloto2 from equipa, piloto p1, piloto p2
where equipa.piloto1_id=p1.id and equipa.piloto2_id=p2.id


-- a clausula JOIN
-- com o "where"
SELECT ano, construtor.nome+'-'+motor.nome, p1.pnome +' '+p1.unome, p2.pnome +' '+ p2.unome FROM construtor, equipa, motor, piloto AS p1, piloto AS p2
WHERE equipa.construtor_id = construtor.id -- condição de junção
AND equipa.motor_id=motor.id -- condição de junção
AND equipa.piloto1_id = p1.id -- condição de junção
AND equipa.piloto2_id = p2.id -- condição de junção
AND equipa.ano > 1980 -- filtro
ORDER BY ano, construtor.nome

-- com o "join"
SELECT ano, construtor.nome+'-'+motor.nome, p1.pnome +' '+p1.unome, p2.pnome +' '+ p2.unome FROM construtor
JOIN equipa on equipa.construtor_id = construtor.id -- condição de junção
JOIN motor on  equipa.motor_id=motor.id -- condição de junção
JOIN piloto p1 on equipa.piloto1_id = p1.id -- condição de junção
JOIN piloto p2 on equipa.piloto2_id = p2.id -- condição de junção
WHERE equipa.ano > 1980 -- filtro
ORDER BY ano, construtor.nome

select * from construtor -- 14 linhas

select * from construtor, pais
where construtor.pais=pais.sigla -- 12 linhas

select * from construtor
join pais on construtor.pais=pais.sigla -- 12 linhas

-- left join: inclui também as linhas sem correspondência na tabela da esquerda
select * from construtor
left join pais on construtor.pais=pais.sigla -- 14 linhas

-- right join: inclui também as linhas sem correspondência na tabela da direita
select * from construtor
right join pais on construtor.pais=pais.sigla -- 34 linhas

-- full join: inclui também as linhas sem correspondência nas tabelas da esquerda e da direita
select * from construtor
full join pais on construtor.pais=pais.sigla -- 36 linhas


-------------------------------------------------------
-- Exercícios Slides Aula 7
-------------------------------------------------------

-- 1. Mostrar todos os países diferentes de onde sejam nacionais pilotos nascidos depois de 1960.
select * from piloto
select * from pais

select distinct pais.nome from piloto
join pais on piloto.pais=pais.sigla
where anoNasc>1960

-- 2. Obter uma lista de todos os motores diferentes usados depois de 1970
select * from motor
select * from equipa

select distinct motor.nome from equipa
join motor on equipa.motor_id=motor.id
where equipa.ano>1970

-- 3. Mostrar todos os construtores fundados num país cujo nome se escreva com pelo menos 6 letras. Indique também o nome do país
select distinct construtor.nome, pais.nome from construtor
join pais on construtor.pais=pais.sigla
where len(pais.nome)>=6

-- 4. Mostrar os nomes de todas as duplas de pilotos de uma mesma nacionalidade que, num dado ano, estavam na mesma equipa, juntamente com o nome da equipa (construtor-motor) e do respectivo país.
select equipa.ano, construtor.nome+'-'+motor.nome Equipa, p1.pnome+' '+p1.unome Piloto1, p1.pais, p2.pnome+' '+p2.unome Piloto2, p2.pais from equipa
join piloto p1 on equipa.piloto1_id=p1.id
join piloto p2 on equipa.piloto2_id=p2.id
join construtor on equipa.construtor_id=construtor.id
join motor on equipa.motor_id=motor.id
where p1.pais=p2.pais

-- 5. Mostrar todos os pares de pilotos que tenham nascido no mesmo ano.
select p1.pnome+' '+p1.unome Piloto1, p2.pnome+' '+p2.unome Piloto2
from piloto p1, piloto p2
where p1.anoNasc=p2.anoNasc and p1.id<p2.id

select p1.pnome+' '+p1.unome Piloto1, p1.anoNasc, p2.pnome+' '+p2.unome Piloto2, p2.anoNasc
from piloto p1
join piloto p2 on p1.id<p2.id
where p1.anoNasc=p2.anoNasc

-- 6. Mostrar todos os pilotos alemães que já correram em carros com motor BMW, indicando o nome do construtor e em que ano o fizeram.
select equipa.ano, construtor.nome+'-'+motor.nome Equipa, piloto.pnome+' '+piloto.unome Piloto, piloto.pais from equipa
join construtor on equipa.construtor_id=construtor.id
join motor on equipa.motor_id=motor.id
join piloto on (piloto.id=equipa.piloto1_id or piloto.id=equipa.piloto2_id)
where piloto.pais='GER' and motor.nome='BMW'

select equipa.ano, construtor.nome+'-'+motor.nome Equipa, piloto.pnome+' '+piloto.unome Piloto, piloto.pais from equipa
join construtor on equipa.construtor_id=construtor.id
join motor on equipa.motor_id=motor.id
join piloto on piloto.id in(equipa.piloto1_id, equipa.piloto2_id)
where piloto.pais='GER' and motor.nome='BMW'

-- 7. Mostrar todos os pilotos que correram para marcas da sua nacionalidade, sem repetições.
select distinct piloto.pnome+' '+piloto.unome Piloto, piloto.pais from equipa
join construtor on equipa.construtor_id=construtor.id
join motor on equipa.motor_id=motor.id
join piloto on piloto.id in(equipa.piloto1_id, equipa.piloto2_id)
where piloto.pais=construtor.pais

-- 8. Mostrar os pilotos, e respectiva nacionalidade, que correram em equipas fundadas, na altura, havia mais de 20 anos. Indicar o nome da equipa, o ano de fundação e o ano em que correram.
-- TPC: parecida com a 7

-- 9. Mostrar o nome das equipas que num dado ano tiveram dois pilotos de nacionalidades diferentes da sua.
-- TPC: parecida com 4

-- 10. Mostrar o nome e a nacionalidade de pilotos que tenham corrido em carros não ingleses até 2000, ordenando por idade dos pilotos, do mais velho para o mais novo.
select distinct piloto.pnome+' '+piloto.unome Piloto, piloto.pais, piloto.anoNasc from equipa
join construtor on equipa.construtor_id=construtor.id
join motor on equipa.motor_id=motor.id
join piloto on piloto.id in(equipa.piloto1_id, equipa.piloto2_id)
where construtor.pais!='UK' and equipa.ano<=2000
order by piloto.anoNasc


-- 11. Mostrar as equipas que tenham tido num dado ano (e indicar o ano) dois pilotos com pelo menos 30anos. Indicar o último nome dos pilotos e a respectiva idade.
-- TPC: parecida com 4

-- 12. Mostrar para cada ano o total de pontos de cada equipa, ordenando as equipas por ano (ascendente) e por pontuação (descendente)
select * from equipa
select * from epoca

select equipa.ano, construtor.nome+'-'+motor.nome Equipa, e1.pontos+e2.pontos EPontos from equipa
join epoca e1 on (equipa.piloto1_id=e1.piloto_id and equipa.ano=e1.ano)
join epoca e2 on (equipa.piloto2_id=e2.piloto_id and equipa.ano=e2.ano)
join construtor on equipa.construtor_id=construtor.id
join motor on equipa.motor_id=motor.id
order by equipa.ano, EPontos desc

-- Mostrar para cada piloto e por cada ano a média de pontos por corrida começada.

-- Mostrar os anos, os pilotos e a equipa em que o segundo piloto teve mais vitórias que o primeiro (da mesma equipa)

-- Mostrar por cada ano uma lista de pilotos, indicando a sua nacionalidade e nome completo da equipa, ordenada pelo número de pontos que cada um conseguiu.

-- Mostrar o nome no formato “<inicial>. <último nome>” de todos os pilotos não europeus
