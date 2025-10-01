--use F1;
--select * from pais
--select * from continente

----produto cartesiano
--select * from pais, continente

---- "join"
--select * from pais, continente
--where continente_id=id

---- mostrar todos os pares de pilotos que têm o mesmo último nome
---- auto-junção/self-join
---- é preciso 2 cópias da tabela piloto na mesma query
--select p1.pnome+' '+p1.unome Piloto1, p2.pnome+' '+p2.unome Piloto2 from piloto p1, piloto p2
--where p1.unome=p2.unome and p1.id<p2.id

---- para cada ano, mostrar o nome dos pilotos que correram para uma dada equipa
---- também é preciso 2 cópias da tabela piloto porque há 2 relações entre equipa e piloto
--select p1.pnome+' '+p1.unome Piloto1, p2.pnome+' '+p2.unome Piloto2 from equipa, piloto p1, piloto p2
--where equipa.piloto1_id=p1.id and equipa.piloto2_id=p2.id


---- a clausula JOIN
---- com o "where"
--SELECT ano, construtor.nome+'-'+motor.nome, p1.pnome +' '+p1.unome, p2.pnome +' '+ p2.unome FROM construtor, equipa, motor, piloto AS p1, piloto AS p2
--WHERE equipa.construtor_id = construtor.id -- condição de junção
--AND equipa.motor_id=motor.id -- condição de junção
--AND equipa.piloto1_id = p1.id -- condição de junção
--AND equipa.piloto2_id = p2.id -- condição de junção
--AND equipa.ano > 1980 -- filtro
--ORDER BY ano, construtor.nome

---- com o "join"
--SELECT ano, construtor.nome+'-'+motor.nome, p1.pnome +' '+p1.unome, p2.pnome +' '+ p2.unome FROM construtor
--JOIN equipa on equipa.construtor_id = construtor.id -- condição de junção
--JOIN motor on  equipa.motor_id=motor.id -- condição de junção
--JOIN piloto p1 on equipa.piloto1_id = p1.id -- condição de junção
--JOIN piloto p2 on equipa.piloto2_id = p2.id -- condição de junção
--WHERE equipa.ano > 1980 -- filtro
--ORDER BY ano, construtor.nome

--select * from construtor -- 14 linhas

--select * from construtor, pais
--where construtor.pais=pais.sigla -- 12 linhas

--select * from construtor
--join pais on construtor.pais=pais.sigla -- 12 linhas

---- left join: inclui também as linhas sem correspondência na tabela da esquerda
--select * from construtor
--left join pais on construtor.pais=pais.sigla -- 14 linhas

---- right join: inclui também as linhas sem correspondência na tabela da direita
--select * from construtor
--right join pais on construtor.pais=pais.sigla -- 34 linhas

---- full join: inclui também as linhas sem correspondência nas tabelas da esquerda e da direita
--select * from construtor
--full join pais on construtor.pais=pais.sigla -- 36 linhas


--Mostrar todos os países diferentes de onde sejam nacionais pilotos
--nascidos depois de 1960.
select * from piloto
select * from pais

select distinct pais.nome from piloto
join pais on piloto.pais=pais.sigla
where anoNasc > 1960

--? Obter uma lista de todos os motores diferentes usados depois de
--1970

select * from motor
select * from equipa

select distinct motor.nome from equipa
join motor on equipa.motor_id = motor.id
where ano > 1967

--? Mostrar todos os construtores fundados num país cujo nome se
--escreva com pelo menos 6 letras. Indique também o nome do país
select distinct construtor.nome , pais.nome from construtor
join pais on construtor.pais =pais.sigla
where len(pais.nome) >= 6

--? Mostrar os nomes de todas as duplas de pilotos de uma mesma
--nacionalidade que, num dado ano, estavam na mesma equipa,
--juntamente com o nome da equipa (construtor-motor) e do
--respectivo país.

select equipa.ano , construtor.nome + '-' + motor.nome Equipa , p1.pnome + ' ' + p1.unome Piloto1 ,p1.pais ,p2.pnome + ' ' + p2.unome Piloto2 ,p2.pais from equipa
join piloto p1 on equipa.piloto1_id = p1.id
join piloto p2  on equipa.piloto2_id = p2.id
join construtor  on equipa.construtor_id = construtor.id
join motor on equipa.motor_id = motor.id
where p1.pais = p2.pais

--? Mostrar todos os pares de pilotos que tenham nascido no mesmo
--ano.

SELECT p1.pnome + ' ' + p1.unome, p1.anoNasc, p2.pnome + ' ' +p2.unome , p2.anoNasc
from piloto p1, piloto p2

where p1.anoNasc = p2.anoNasc
AND p1.id < p2.id


SELECT p1.pnome + ' ' + p1.unome, p1.anoNasc, p2.pnome + ' ' +p2.unome , p2.anoNasc
from piloto p1
join piloto p2 on p1.id<p2.id
where p1.anoNasc = p2.anoNasc


--? Mostrar todos os pilotos alemães que já correram em carros com
--motor BMW, indicando o nome do construtor e em que ano o
--fizeram.