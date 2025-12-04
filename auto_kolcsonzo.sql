----1 feladat
--SELECT * INTO szgk2 
--FROM db1.dbo.szgk;

--SELECT * INTO ugyfel2
--FROM db1.dbo.ugyfel;

--2. feladat
--SELECT gyarto, YEAR(GETDATE())-MIN(evjarat) AS Kor from szgk2
--GROUP BY szgk2.gyarto

----3. feladat
--SELECT  LEN(CONCAT(gyarto, ' ', tipus)) AS Nev_hossz, Count(LEN(CONCAT(gyarto, ' ', tipus))) AS darab FROM szgk2
--GROUP BY LEN(CONCAT(gyarto, ' ', tipus))
--;

----4.feladat
--SELECT gyarto, tipus, ar,
--CASE
--	WHEN ar< 6000 THEN 'Budget'
--	WHEN ar > 11000 THEN 'Luxury'
--	ELSE 'Normal'
--END Kategória
--FROM szgk2
--WHERE kolcsonozheto = 1;

--GO
----5. FELADAT
--CREATE VIEW v_toyotak AS
--SELECT * FROM szgk2
--WHERE gyarto= 'Toyota'
--WITH CHECK OPTION
--;

--6. feladat
--CREATE UNIQUE INDEX idx_unique_orszag ON orszag (orszag);
--INSERT [h07_tmualq].[dbo].[orszag] ([orszagID], [orszag]) VALUES ('AUT', 'Ausztria');

----7. feladat
--SELECT ugyfel2.nev, COUNT(*) AS Szám FROM kolcsonzes
--JOIN ugyfel2 ON ugyfel2.ugyfelID = kolcsonzes.ugyfelID 
--GROUP BY ugyfel2.nev
--HAVING AVG(DATEDIFF(DAY, kolcsonzes.kidat, kolcsonzes.visszadat)) >6;

--8. feladat
SELECT ugyfel2.nev FROM ugyfel2
JOIN kolcsonzes ON ugyfel2.ugyfelID = kolcsonzes.ugyfelID
JOIN szgk2 ON szgk2.rendszam = kolcsonzes.rendszam
WHERE szgk2.gyarto IN ('Chevrolet', 'BMW')
GROUP BY ugyfel2.ugyfelID, ugyfel2.nev 
HAVING COUNT(DISTINCT szgk2.gyarto) = 2;

--9. FELADAT
SELECT nev FROM ugyfel2
JOIN kolcsonzes ON kolcsonzes.ugyfelID=ugyfel2.ugyfelID
JOIN szgk2 ON szgk2.rendszam=kolcsonzes.rendszam
JOIN( SELECT ugyfelID, MAX(kolcsonzes.kidat) AS Utolso_datum
FROM kolcsonzes
GROUP BY ugyfelID
) as utolso_datum_segedTabla ON kolcsonzes.ugyfelID = utolso_datum_segedTabla.ugyfelID AND kolcsonzes.kidat = utolso_datum_segedTabla.Utolso_datum
WHERE szgk2.gyarto = 'Opel' 
ORDER BY kolcsonzes.kidat DESC;

--SELECT ugyfel2.nev
--FROM ugyfel2
--JOIN kolcsonzes ON ugyfel2.ugyfelID = kolcsonzes.ugyfelID
--JOIN szgk2 ON kolcsonzes.rendszam = szgk2.rendszam
--JOIN (
--    -- Ez a rész keresi meg mindenkinél a legutolsó dátumot
--    SELECT ugyfelID, MAX(kidat) AS LegutolsoDatum
--    FROM kolcsonzes
--    GROUP BY ugyfelID
--) AS Utolso_Datumok_Segedtabla 
--  -- Itt kapcsoljuk össze: csak akkor marad meg a sor, ha a dátum egyezik a legutolsóval
--  ON kolcsonzes.ugyfelID = Utolso_Datumok_Segedtabla.ugyfelID 
--  AND kolcsonzes.kidat = Utolso_Datumok_Segedtabla.LegutolsoDatum
--WHERE szgk2.gyarto = 'Opel';

------10. feladat
--SELECT szgk2.rendszam, 
--		gyarto, 
--		tipus, 
--		DATEDIFF(month, MIN(kolcsonzes.kidat), GETDATE()) AS eltelt_honapok
--		FROM szgk2
--JOIN kolcsonzes ON kolcsonzes.rendszam = szgk2.rendszam
--GROUP BY szgk2.rendszam, szgk2.gyarto, szgk2.tipus

--11. feladat
--SELECT s1.gyarto, s1.tipus, s1.evjarat
--FROM szgk2 s1
--WHERE NOT EXISTS (
--    SELECT * FROM szgk2 s2 
--    WHERE s1.evjarat = s2.evjarat   -- Ugyanaz az évjárat
--      AND s1.rendszam != s2.rendszam -- De MÁSIK autó (más a rendszáma) <>-nem egyenlõ !=
--) AND s1.evjarat is not null;

--12. feladat
select felsz,  COUNT(szgk_felsz.rendszam) AS Darab from felszereltseg
JOIN szgk_felsz ON felszereltseg.felszID=szgk_felsz.felszID
JOIN szgk2 ON szgk_felsz.rendszam= szgk2.rendszam
GROUP BY felsz
HAVING COUNT(felsz) BETWEEN 10 AND 20;

-- 12. feladat
WITH Felszereltseg_Stat AS (
    -- BELSÕ RÉSZ: Itt végezzük el a számolást
    SELECT felszereltseg.felsz, COUNT(szgk_felsz.rendszam) AS Darabszam
    FROM felszereltseg
    JOIN szgk_felsz ON felszereltseg.felszID = szgk_felsz.felszID
    JOIN szgk2 ON szgk_felsz.rendszam = szgk2.rendszam
    GROUP BY felszereltseg.felsz
)
-- KÜLSÕ RÉSZ: Itt szûrünk és rendezünk az "ideiglenes táblából"
SELECT felsz, Darabszam
FROM Felszereltseg_Stat
WHERE Darabszam >= 10 AND Darabszam <= 20 -- Vagy használhatod a BETWEEN 10 AND 20-at is
