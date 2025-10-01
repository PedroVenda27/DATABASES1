USE Trabalho;

-- Ex1

SELECT 
    P.nome AS Nome,
    YEAR(GETDATE()) - YEAR(P.dataNascimento) AS Idade,
    YEAR(GETDATE()) - MIN(L.ano) AS Anos_Escrevendo,
    SUM(E.num) AS Livros_Vendidos
FROM 
    Autor A
    JOIN Pessoa P ON A.pessoa_id = P.id
    JOIN Livro L ON A.id = L.autor_id
    JOIN Edicao E ON L.id = E.livro_id
GROUP BY 
    P.nome, 
    P.dataNascimento;

-- Ex2

SELECT 
    L.titulo AS Titulo,
    SUM(E.valorVendas) AS Total_Vendas_Mundiais,
    COUNT(E.id) AS Numero_Total_Edicoes,
    SUM(E.valorVendas) AS Receitas_Totais,
    SUM(E.custoProducao) + ISNULL(SUM(LPP.custoDireitoPublicacao), 0) + ISNULL(SUM(T.custo), 0) AS Custos_Totais,
    (SUM(E.valorVendas) - (SUM(E.custoProducao) + ISNULL(SUM(LPP.custoDireitoPublicacao), 0) + ISNULL(SUM(T.custo), 0))) AS Saldo_Final
FROM 
    Livro L
    JOIN Edicao E ON L.id = E.livro_id
    LEFT JOIN ListaPodePublicar LPP ON L.id = LPP.livro_id
    LEFT JOIN Traducao T ON E.traducao_id = T.id
GROUP BY 
    L.titulo;


-- Ex3

SELECT L.titulo AS Titulo_Original, T.titulo AS Titulo_Publicado, P.nome AS Pais
FROM Livro L
JOIN Edicao E ON L.id = E.livro_id
JOIN Traducao T ON E.id = T.id
JOIN EdicaoPublicacao EP ON E.id = EP.edicao_id
JOIN Pais P ON EP.pais_id = P.id
ORDER BY 
L.titulo, P.nome;


--Ex 4

select livro.titulo 'Livro' , pais.nome 'pais'  from Edicao

join EdicaoPublicacao on Edicao.id = EdicaoPublicacao.edicao_id
join livro on Edicao.id = livro_id
join ListaPodeVender on edicao.id = ListaPodeVender.edicao_id 
join Pais on ListaPodeVender.pais_id = pais.id
join ListaPodePublicar on pais.id = ListaPodePublicar.pais_id

group by  livro.titulo , pais.nome , EdicaoPublicacao.pais_id , ListaPodeVender.pais_id,ListaPodePublicar.pais_id
having  EdicaoPublicacao.pais_id = ListaPodePublicar.pais_id
 
--Ex 5

select livro.titulo 'titulo original' , traducao.titulo 'titulo traduzido' , livro.ano 'ano' , p1.nome 'autor' , p2.nome 'tradutor', Edicao.num 'Numero de Edição'  from Edicao

join Livro on Edicao.livro_id = livro.id
join Autor on Livro.autor_id = Autor.id
join pessoa p1 on Autor.pessoa_id = p1.id

join Traducao on Edicao.traducao_id = traducao.id
join TradutorTraducao on Traducao.id = TradutorTraducao.tradutor_id
join Tradutor on TradutorTraducao.tradutor_id = Tradutor.id
join pessoa p2 on Tradutor.pessoa_id = p2.id

group by livro.titulo , livro.ano , p1.nome , p2.nome, traducao.titulo , Edicao.num



--Ex 6

select pais.nome 'Pais' , livro.titulo 'titulo' , edicao.num 'numero de edição' , traducao.lingua 'Lingua' , a.nome 'autor'  from Edicao

join ListaPodeVender on edicao.id = ListaPodeVender.edicao_id
join pais on ListaPodeVender.pais_id = pais.id
join Traducao on edicao.traducao_id = traducao.id
join livro on edicao.livro_id = livro.id
join autor on livro.autor_id = livro.id
join pessoa a on autor.id = a.id

where ListaPodeVender.pais_id = pais.id
order by pais.nome , traducao.lingua , livro.titulo
