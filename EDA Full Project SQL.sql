-- EXPLORATORY DATA ANALYSIS
use world_layoff;

select *
from laysoff_staging;

select max(total_laid_off), max(percentage_laid_off)
from laysoff_staging;

select *
from laysoff_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select company, sum(total_laid_off)
from laysoff_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from laysoff_staging2;

select country, sum(total_laid_off)
from laysoff_staging2
group by country 
order by 2 desc;

select substring(`date`,6,2) as 'month'
from laysoff_staging;

select company, YEAR(`date`), sum(total_laid_off)
from laysoff_staging2
group by company, YEAR(`date`)
order by 3 desc;


WITH company_year as 
(
select company, YEAR(`date`), sum(total_laid_off)
from laysoff_staging2
group by company, YEAR(`date`)
order by 3 desc
)
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
order by ranking asc;

