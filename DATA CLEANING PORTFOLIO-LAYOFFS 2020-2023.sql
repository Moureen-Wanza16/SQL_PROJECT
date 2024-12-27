
SELECT*
FROM world_layoffs.layoffs
;

CREATE TABLE LAYOFFS_STAGING
LIKE world_layoffs.layoffs
;
INSERT INTO  LAYOFFS_STAGING
SELECT*
FROM world_layoffs.layoffs
;
SELECT*
FROM world_layoffs.layoffs_staging
;

SELECT*,
ROW_NUMBER () OVER(
partition by COMPANY, location, industry, total_laid_off, percentage_laid_off, `date`,stage,country,funds_raised_millions) AS ROW_num
FROM world_layoffs.layoffs_staging
;
 WITH DUPLICATE_CTE AS
 (SELECT*,
ROW_NUMBER () OVER(
partition by COMPANY, location, industry, total_laid_off, percentage_laid_off, `date`,stage,country,funds_raised_millions) AS ROW_num
FROM world_layoffs.layoffs_staging)
SELECT*
FROM DUPLICATE_CTE 
WHERE ROW_num > 1
;

 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `ROW_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
  
  SELECT*
  FROM world_layoffs.layoffs_staging2;
  INSERT INTO world_layoffs.layoffs_staging2
SELECT*,
ROW_NUMBER () OVER(
partition by COMPANY, location, industry, total_laid_off, percentage_laid_off, `date`,stage,country,funds_raised_millions) AS ROW_num
FROM world_layoffs.layoffs_staging;

SELECT*
FROM world_layoffs.layoffs_staging2
WHERE ROW_num >1 ;
DELETE 
FROM world_layoffs.layoffs_staging2
WHERE ROW_num >1
;

SELECT*
FROM world_layoffs.layoffs_staging2;
SELECT company
FROM world_layoffs.layoffs_staging2;
SELECT COMPANY, trim(COMPANY)
FROM world_layoffs.layoffs_staging2;
UPDATE layoffs_staging2
SET COMPANY =TRIM(COMPANY);
SELECT distinct industry
FROM world_layoffs.layoffs_staging2
ORDER BY 1;
SELECT*
FROM world_layoffs.layoffs_staging2
WHERE INDUSTRY  LIKE'CRYPTO%';
UPDATE layoffs_staging2
SET INDUSTRY = 'CRYPTO'
WHERE INDUSTRY LIKE 'CRYPTO%';
SELECT DISTINCT location
FROM world_layoffs.layoffs_staging2
ORDER BY 1;
SELECT DISTINCT COUNTRY
FROM world_layoffs.layoffs_staging2
ORDER BY 1;

SELECT distinct country ,trim(COUNTRY)
FROM world_layoffs.layoffs_staging2;

SELECT distinct country ,trim(TRAILING '.' FROM COUNTRY)
FROM world_layoffs.layoffs_staging2;
 UPDATE layoffs_staging2
 SET COUNTRY = trim(TRAILING '.' FROM COUNTRY)
 WHERE COUNTRY LIKE 'UNITED STATES%'
 ;
 SELECT `DATE`
 FROM world_layoffs.layoffs_staging2;

  SELECT `DATE`,
  str_to_date(`DATE`, '%m/%d/%Y')
 FROM world_layoffs.layoffs_staging2;
 UPDATE layoffs_staging2
 SET `DATE`=   str_to_date(`DATE`, '%m/%d/%Y');
 ALTER TABLE layoffs_staging2
 MODIFY COLUMN `DATE` DATE;
 SELECT*
 FROM world_layoffs.layoffs_staging2;
 
SELECT*
 FROM world_layoffs.layoffs_staging2;
 SELECT*
 FROM world_layoffs.layoffs_staging2
 where total_laid_off is null
 and percentage_laid_off is null;
 
 SELECT*
 FROM world_layoffs.layoffs_staging2
 where industry  is null 
 or industry = '';
 
 update layoffs_staging2
 set industry= null
 where industry ='';
 SELECT*
 FROM world_layoffs.layoffs_staging2 T1
 JOIN world_layoffs.layoffs_staging2 T2
 ON T1.company=T2.company
 WHERE (T1.industry IS NULL OR T1.industry ='')
 AND T2.industry IS NOT NULL;
 
UPDATE world_layoffs.layoffs_staging2 T1
 JOIN world_layoffs.layoffs_staging2 T2
 ON T1.company=T2.company
 SET T1.industry= T2.industry
  WHERE (T1.industry IS NULL OR T1.industry ='')
 AND T2.industry IS NOT NULL;
 SELECT*
 FROM world_layoffs.layoffs_staging2;
 
SELECT*
 FROM world_layoffs.layoffs_staging2;
 
 ALTER TABLE layoffs_staging2
 DROP ROW_num;

