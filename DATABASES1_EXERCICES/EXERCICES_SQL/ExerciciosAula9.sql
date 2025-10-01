use f1

select * from piloto
select * from epoca


--13. Mostrar para cada piloto e por cada ano a média de pontos por corrida


select * from piloto
select * from epoca

select piloto.pnome+' '+piloto.unome 'Piloto',ano, pontos/partidas 'media' from piloto
join epoca on piloto.id=epoca.piloto_id
order by piloto_id, ano

--14. Mostrar os anos,os pilotos e a equipa em que o segundo piloto teve mais vitorias que o primeiro (da mesma equipa)

select equipa.ano, construtor.nome+'-'+motor.nome Equipa, p1.pnome+' '+p1.unome
Piloto1, ep1.vitorias, p2.pnome+' ' +p2.unome Piloto2, ep2.vitorias from equipa

join piloto p1 on equipa.piloto1_id = p1.id
join piloto p2 on equipa.piloto2_id = p2.id
join construtor on equipa.construtor_id = construtor.id
join motor on equipa.motor_id = motor.id
join epoca ep1 on (p1.id = ep1.piloto_id and ep1.ano = equipa.ano)
join epoca ep2 on (p2.id = ep2.piloto_id and ep2.ano = equipa.ano)
where ep2.vitorias > ep1.vitorias

--15. Mostrar por cada ano uma lista de pilotos, indicando a sua nacionalidade e nome completo da equipa, ordenada pelo numero de pontos que cada um conseguiu.

select piloto.pnome+' '+piloto.unome Piloto , piloto.pais , construtor.nome+' '+motor.nome Equipa from equipa

join construtor on equipa.construtor_id = construtor.id
join motor on equipa.motor_id = motor.id
join piloto on piloto.id in (equipa.piloto1_id , equipa.piloto2_id)
join epoca on (epoca.piloto_id=piloto.id and epoca.ano=equipa.ano)
order by  equipa.ano, epoca.pontos desc

--16. Mostrar o nome no formato "<inicial>. <ultimo nome>" de todos os pilotos nao europeus
select substring (piloto.pnome,1,1)+' '+piloto.unome Piloto , pais.nome , continente.nome from piloto
join pais on piloto.pais=pais.sigla
join continente on pais.continente_id=continente.id
where continente.nome! ='Europa'
