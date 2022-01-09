-- Verificando a base

select *
from revenue.. revenue;

-- Campaign, adgroup e ad possuem o nome da vari�vels antes da representante n�merica, vamos deixar apenas o n�mero

	-- Avaliando forma de separar
	select date,
	PARSENAME(Replace(adgroup, ' ', '.'),1) as adgroup,
	PARSENAME(REPLACE(ad, ' ', '.'), 1) as ad
	from revenue..revenue;

	-- Hora de implementar na tabela
	alter table revenue..revenue
	add ad_group int;

	alter table revenue..revenue
	add ads int;

	update revenue..revenue
	set ad_group = PARSENAME(Replace(adgroup, ' ', '.'),1);

	update revenue..revenue
	set ads = PARSENAME(REPLACE(ad, ' ', '.'), 1);

	select *
	from revenue..revenue;


-- Verificando quantas impress�es s�o realizadas diariamente, por adgroup

select date, ad_group, sum(impressions) as impressions
from revenue..revenue
group by date, ad_group
order by date;

-- click rating por groupo a cada dia
alter table revenue..revenue
alter column clicks int;

With rating as ( select date, ad_group, sum(clicks) as clicks, sum(impressions) as impressions
from revenue..revenue
group by date, ad_group)

select date, ad_group, Round((Convert(decimal(5,1), clicks)/impressions),2) as click_rating
from rating
order by date;


-- Verificando se quanto maior o custo mais convers�es s�o obtidas
select cost, conversions
from revenue..revenue
order by cost desc;


-- Analisando se quanto maior o click rating maior � a convers�o
select Round(((Convert(decimal(5,1), clicks))/impressions),2) as click_rating, conversions
from revenue..revenue
order by click_rating desc;

--