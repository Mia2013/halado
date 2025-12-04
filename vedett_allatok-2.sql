SELECT CONCAT( 'A védetté nyilvánított állatok száma:', COUNT(*),'.') AS '1. feladat' FROM allat;

SELECT CONCAT('Az állatok átlagos eszmei értéke:', CAST(AVG(CAST(ertek.forint AS decimal(12,1)))  AS decimal(12,1)), ' Ft')   AS '2. feladat' FROM allat
JOIN ertek ON ertek.id= allat.ertekid;

SELECT TOP 1 ev AS [3-elsõ védetté nyilvánítás] FROM allat
WHERE ev IS NOT NULL
ORDER BY ev ASC;

SELECT allat.*, ertek.forint, 
CASE 
WHEN allat.katId =7 OR  allat.katID = 8  THEN 'Túl alacsony'
FROM allat
JOIN ertek ON ertek.id= allat.ertekid
GROUP BY ertek.forint
;