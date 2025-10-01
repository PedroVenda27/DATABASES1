use f1


-------------------------------------------
--Exercicios
-------------------------------------------

--1 Devolver o total de pontos de cada equipa em cada ano

select construtor.nome+'-'+motor.nome 'Equipa', equipa.ano, sum (pontos) 'Pontos' from equipa
join epoca on epoca.piloto_id in (piloto1_id, piloto2_id) and epoca.ano = equipa.ano
join construtor on construtor_id = construtor.id
join motor on motor_id = motor.id
group by construtor_id, construtor.nome, equipa.ano, motor_id, motor.nome


--2 Apresentar uma lista de construtores ordenada por ordem decrescente do numero de corridas efetuadas em toda a historia

select construtor.nome 'Equipa', sum (partidas) 'Corridas' from equipa
join epoca on epoca.piloto_id in (piloto1_id, piloto2_id) and epoca.ano = equipa.ano
join construtor on construtor_id = construtor.id
join motor on motor_id = motor.id
group by construtor_id, construtor.nome
order by Corridas desc


--3 Para cada marca de motor , apresentar o numero de vitoria que conseguiu em toda a historia

select motor.nome 'Motor', sum (vitorias) 'Vitorias' from equipa
join epoca on epoca.piloto_id in (piloto1_id, piloto2_id) and epoca.ano = equipa.ano
join motor on motor_id = motor.id
group by motor_id, motor.nome
order by Vitorias desc