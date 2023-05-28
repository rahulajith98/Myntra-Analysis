--------------------------------------------------------------------------------------------------------------
-- Selecting first 500 entries from the dataset
SELECT TOP 500 * FROM dbo.myntra ORDER BY CAST(id as INT);
--------------------------------------------------------------------------------------------------------------
--converting datatypes
ALTER TABLE dbo.myntra
ALTER COLUMN id int;
ALTER TABLE dbo.myntra
ALTER COLUMN price float; 
ALTER TABLE dbo.myntra
ALTER COLUMN mrp float;
ALTER TABLE dbo.myntra
ALTER COLUMN ratingTotal float;
---------------------------------------------------------------------------------------------------------------
-- Deleting duplicate entries that have different IDs
DELETE myn FROM  dbo.myntra myn
  INNER JOIN dbo.myntra myn2 ON myn.name=myn2.name
WHERE myn.id > myn2.id AND myn.purl = myn2.purl;
---------------------------------------------------------------------------------------------------------------
-- Selecting 100 shirts based on total ratings under 3 stars in View
CREATE VIEW lowShirts AS
SELECT DISTINCT TOP 100 id, name, price ,mrp, seller, rating, ratingTotal, purl FROM dbo.myntra AS ToplowShirts
WHERE rating<3.0 AND ratingTotal>=1 AND name LIKE '%shirt%'
ORDER BY ratingTotal DESC; 
---------------------------------------------------------------------------------------------------------------
--Selecting 100 watches based on total ratings under 3 stars in View
CREATE VIEW lowWatches as SELECT DISTINCT TOP 100 id, name, price ,mrp, seller, rating, ratingTotal, purl FROM dbo.myntra AS ToplowWatches
WHERE rating<3.0 AND ratingTotal>=1 AND (name LIKE '%watch%')
ORDER BY ratingTotal DESC;

---------------------------------------------------------------------------------------------------------------
-- Selecting 100 footwear based on total ratings under 3 stars in View
CREATE VIEW lowFootwear as
SELECT DISTINCT TOP 100 id, name, price ,mrp, seller, rating, ratingTotal, purl FROM dbo.myntra AS Toplowshoes
WHERE rating<3.0 AND ratingTotal>=1 AND (name LIKE '%shoe%' OR name LIKE '%sneaker%' OR name LIKE '%loafers%' OR name LIKE '%heels%' OR name LIKE '%footwear%' OR name LIKE '%crocs%' OR name LIKE '%sandals%' OR name LIKE '%slipper%' OR name like '%chappal%')
ORDER BY ratingTotal DESC;
---------------------------------------------------------------------------------------------------------------
--Creating table for Visualization
DROP TABLE if exists LowRatedSellers;

CREATE TABLE LowRatedSellers
(
seller varchar(255),
LowRatings float
)
INSERT INTO LowRatedSellers
SELECT seller, SUM(ratingTotal) as LowRatings from dbo.myntra AS totallowrevs
WHERE rating<3.0 AND ratingTotal>=1
GROUP BY seller;

SELECT * from LowRatedSellers ORDER BY LowRatings DESC;

-----------------------------------------------------------------------------------------------------------------
--Creating a View
CREATE VIEW LRS as
SELECT seller, SUM(ratingTotal) as LowRatings from dbo.myntra AS totallowrevs
WHERE rating<3.0 AND ratingTotal>=1
GROUP BY seller;