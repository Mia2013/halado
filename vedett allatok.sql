--SELECT nev, ev FROM allat;

--SELECT CONCAT(nev,' - ', ev) AS Védett_állatok FROM allat;

--SELECT * FROM allat
--WHERE ev IS NULL;

--SELECT DISTINCT ev FROM allat
--WHERE ev IS NOT NULL
--ORDER BY ev ASC;

--SELECT nev FROM allat
--WHERE ev = 1993;

--SELECT allat.nev AS Faj, kategoria.nev AS Kategória FROM allat
--JOIN kategoria ON allat.katid = kategoria.id
--WHERE ev = 1993;

SELECT ev FROM allat
WHERE nev = 'parlagi vipera';

--SELECT CONCAT(ertek.forint, 'Ft') AS 'Parlagi_vipera_eszmei_értéke' FROM allat
--JOIN ertek ON ertek.id=allat.ertekid
--WHERE nev LIKE 'parlagi vipera';

--SELECT nev FROM allat
--WHERE nev LIKE 'magyar%';

--SELECT nev, ev FROM allat
--WHERE ev > 1990 AND ev <2000
--ORDER BY ev ASC;

--SELECT nev, ev FROM allat
--WHERE nev LIKE '%sas%' AND katid=3
--ORDER BY ev DESC;

--SELECT forint FROM ertek;

SELECT * FROM allat
WHERE ev IS NOT NULL AND ev = (SELECT MAX(ev) FROM allat WHERE ev is not null);
