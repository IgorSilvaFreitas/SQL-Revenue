-- Verificando a base

select *
from revenue.. revenue;

-- Campaign, adgroup e ad possuem o nome da vari?vels antes da representante n?merica, vamos deixar apenas o n?mero

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


-- 1-Verificando quantas impress?es s?o realizadas diariamente, por adgroup

select date, ad_group, sum(impressions) as impressions
from revenue..revenue
group by date, ad_group
order by date;

-- 2-click rating por groupo a cada dia
alter table revenue..revenue
alter column clicks int;

With rating as ( select date, ad_group, sum(clicks) as clicks, sum(impressions) as impressions
from revenue..revenue
group by date, ad_group)

select date, ad_group, Round((Convert(decimal(5,1), clicks)/impressions),2) as click_rating
from rating
order by date;


-- 3-Verificando se quanto maior o custo por impress?o mais convers?es s?o obtidas
select (Convert(decimal(8,2), cost)/impressions) as cost_per_impression, conversions
from revenue..revenue
order by 1 desc;


-- 4-Analisando se quanto maior o click rating maior ? a convers?o
select ((Round(Convert(decimal(18,2),2), clicks)/impressions)) as click_rating, conversions
from revenue..revenue
order by click_rating desc;

-- 5-ad group com maior revenue
select ad_group, sum(convert(decimal(18,2),revenue)) as revenue
from revenue..revenue
group by ad_group;

-- 6-rating de revenue por impress?o em cada grupo
select ad_group, sum(convert(decimal(18,2),revenue))/sum(impressions) as revenue_per_impression
from revenue..revenue
group by ad_group
order by 2 desc;