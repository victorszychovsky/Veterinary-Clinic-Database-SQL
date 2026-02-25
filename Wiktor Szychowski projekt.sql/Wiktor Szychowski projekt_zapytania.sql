--Wiktor Szychowski projekt.
--Zapytania SELECT 

-- 1. Lista wszystkich zwierz¹t z ich w³aœcicielem
SELECT Z.Imie AS ImieZwierzecia, G.Nazwa AS Gatunek, W.Imie + ' ' + W.Nazwisko AS Wlasciciel
FROM Zwierzeta Z
JOIN Gatunki G ON Z.GatunekID = G.GatunekID
JOIN Wlasciciele W ON Z.WlascicielID = W.WlascicielID;

-- 2. Zwierzêta z wiêcej ni¿ jedn¹ wizyt¹
SELECT Z.Imie, COUNT(*) AS LiczbaWizyt
FROM Wizyty V
JOIN Zwierzeta Z ON V.ZwierzeID = Z.ZwierzeID
GROUP BY Z.Imie
HAVING COUNT(*) > 1;

-- 3. Œredni wiek zwierz¹t
SELECT AVG(Wiek) AS SredniWiek FROM Zwierzeta;

-- 4. Najczêœciej odwiedzany weterynarz
SELECT TOP 1 W.Imie + ' ' + W.Nazwisko AS Weterynarz, COUNT(*) AS LiczbaWizyt
FROM Wizyty V
JOIN Weterynarze W ON V.WeterynarzID = W.WeterynarzID
GROUP BY W.Imie, W.Nazwisko
ORDER BY COUNT(*) DESC;

-- 5. Lista wizyt z nazw¹ zwierzêcia i diagnoz¹
SELECT V.DataWizyty, Z.Imie, V.Diagnoza
FROM Wizyty V
JOIN Zwierzeta Z ON V.ZwierzeID = Z.ZwierzeID;

-- 6. Lista w³aœcicieli z liczb¹ posiadanych zwierz¹t
SELECT W.Imie + ' ' + W.Nazwisko AS Wlasciciel, COUNT(Z.ZwierzeID) AS LiczbaZwierzat
FROM Wlasciciele W
LEFT JOIN Zwierzeta Z ON W.WlascicielID = Z.WlascicielID
GROUP BY W.Imie, W.Nazwisko;

-- 7. Zwierzêta m³odsze ni¿ 3 lata
SELECT Imie FROM Zwierzeta WHERE Wiek < 3;

-- 8. Lista gatunków z liczb¹ zwierz¹t
SELECT G.Nazwa, COUNT(Z.ZwierzeID) AS LiczbaZwierzat
FROM Gatunki G
LEFT JOIN Zwierzeta Z ON G.GatunekID = Z.GatunekID
GROUP BY G.Nazwa;

-- 9. Zwierzêta, które by³y u weterynarza specjalizuj¹cego siê w "kotach"
SELECT DISTINCT Z.Imie
FROM Wizyty V
JOIN Zwierzeta Z ON V.ZwierzeID = Z.ZwierzeID
JOIN Weterynarze W ON V.WeterynarzID = W.WeterynarzID
WHERE W.Specjalizacja LIKE '%kot%';

-- 10. W³aœciciele, którzy maj¹ wiêcej ni¿ jedno zwierzê (podzapytanie)
SELECT Imie, Nazwisko FROM Wlasciciele
WHERE WlascicielID IN (
    SELECT WlascicielID FROM Zwierzeta
    GROUP BY WlascicielID
    HAVING COUNT(*) > 1
);

-- 4. Przyk³adowe operacje DML (INSERT, UPDATE, DELETE)

-- Dodanie nowego zwierzêcia
INSERT INTO Zwierzeta (Imie, GatunekID, Wiek, WlascicielID) VALUES ('Fafik', 1, 4, 2);

-- Aktualizacja diagnozy
UPDATE Wizyty SET Diagnoza = 'Poprawa po leczeniu' WHERE WizytaID = 1;

-- Usuniêcie zwierzêcia
DELETE FROM Zwierzeta WHERE Imie = 'Coco';