with comissoes_cte as (
	select
  		Comprador,
		Vendedor,
		Data,
		valor,
		rank() over (partition by Vendedor order by valor desc, Data asc) as rank_valor
	from comissoes
)
,comissoes_rank as (
    select 
        Comprador,
        Vendedor,
        Data,
        valor
    from comissoes_cte
    where rank_valor <= 3
)

select Vendedor 
from comissoes_rank
group by Vendedor
having sum(valor) >= 1024