-- data cleaning
select * 
from layoffs;

-- data cleaning steps for now:
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null or Blank values
-- 4. Remove Any irrelevant Columns


-- we're creating a copy of the raw database to change, work on it
create table layoffs_staging
like layoffs;

select * 
from layoffs_staging;

-- we've inserted all data in our dummy db
insert layoffs_staging
select *
from layoffs;

-- there's no ids column her, we'll make a one, using 
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num 
from layoffs_staging;

with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num 
from layoffs_staging
)

select *
from duplicate_cte
where row_num >1;

select *
from layoffs_staging
where company = '100 Thieves';






CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging_2;

insert into layoffs_staging_2
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num 
from layoffs_staging;

select *
from layoffs_staging_2
where row_num >1;

delete
from layoffs_staging_2
where row_num >1;

select *
from layoffs_staging_2
where company ='100 Thieves';

-- no duplicates



-- now standardizing data:
SELECT DISTINCT(trim(company))
from layoffs_staging_2;

SELECT company, trim(company)
from layoffs_staging_2;

update layoffs_staging_2
set company = trim(company);

SELECT DISTINCT(industry)
from layoffs_staging_2
order by 1;


select *
from layoffs_staging_2
where industry like 'crypto%';

update layoffs_staging_2
set industry = 'Crypto'
where industry like 'crypto%';

select *
from layoffs_staging_2
where industry like 'crypto%';

select distinct industry
from layoffs_staging_2;


select distinct location
from layoffs_staging_2
order by 1;


select distinct country
from layoffs_staging_2
order by 1;

select *
from layoffs_staging_2
where country like 'united states%'
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging_2;

update layoffs_staging_2
set country = trim(trailing '.' from country)
where country like 'united states%';

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging_2;

update layoffs_staging_2
set `date` = str_to_date(`date`,'%m/%d/%Y');

select `date`
from layoffs_staging_2;

alter table layoffs_staging_2
modify column `date` date;




-- checking the nulls and blanks:
select *
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging_2
where industry is null
or industry ='';

select *  
from layoffs_staging_2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging_2 t1
join layoffs_staging_2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;

update layoffs_staging_2
set industry  = null
where industry = '';

UPDATE  layoffs_staging_2 t1
join layoffs_staging_2 t2 
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;


select *
from layoffs_staging_2
where company like 'bally%';

delete 
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;	

alter table layoffs_staging_2
drop column row_num;


-- cleaned final data 
select *
from layoffs_staging_2;

