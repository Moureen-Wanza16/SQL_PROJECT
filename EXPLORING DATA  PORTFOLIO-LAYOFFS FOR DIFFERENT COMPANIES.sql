
SELECT*
FROM layoffs_staging2;

SELECT max(total_laid_off)
FROM layoffs_staging2;

SELECT max(total_laid_off),max(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY  total_laid_off DESC;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY  funds_raised_millions DESC;

SELECT  company,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY  sum(total_laid_off) DESC;
 
 SELECT  company,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

SELECT min(`DATE`),max(`DATE`)
FROM layoffs_staging2;


SELECT  industry,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY  sum(total_laid_off) DESC;

SELECT  country,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY  sum(total_laid_off) DESC;

SELECT  year(`DATE`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY year(`DATE`)
ORDER BY  sum(total_laid_off) DESC;

SELECT  stage,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY  sum(total_laid_off) DESC;

SELECT substring(`date`,1,7) AS MONTH ,sum(total_laid_off)
FROM layoffs_staging2
WHERE Substring(`date`,1,7) IS NOT NULL
GROUP BY  MONTH
ORDER BY  1 ASC;

WITH  ROLLING_TOTAL AS
(
SELECT substring(`date`,1,7) AS MONTH ,sum(total_laid_off) AS TOTAL_OFF
FROM layoffs_staging2
WHERE Substring(`date`,1,7) IS NOT NULL
GROUP BY  MONTH
ORDER BY  1 ASC
)
SELECT `MONTH` ,total_off
,SUM(TOTAL_OFF) OVER (ORDER BY `MONTH` ) AS rolling_total
FROM ROLLING_TOTAL ;

SELECT  company, year(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
order by company asc;

SELECT  company, year(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
order by 3 desc;

WITH  company_year(company,years,total_laid_off) AS
(
SELECT  company, year(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
)
SELECT* ,
 Dense_rank() OVER (PARTITION BY Years ORDER BY TOTAL_LAID_OFF DESC) as ranking
FROM company_year
WHERE Years IS NOT NULL
ORDER BY  Ranking ASC;

WITH  company_year(company,years,total_laid_off) AS
(
SELECT  company, year(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
) ,company_year_rank as
(SELECT* ,
 Dense_rank() OVER (PARTITION BY Years ORDER BY TOTAL_LAID_OFF DESC) as ranking
FROM company_year
WHERE Years IS NOT NULL)
SELECT*
FROM Company_year_rank
where ranking <=5;
