# 🐾 System Kliniki Weterynaryjnej (SQL)

Projekt bazy danych realizujący obsługę wizyt, właścicieli oraz pacjentów (zwierząt) w klinice weterynaryjnej.

## 🛠️ Technologie
* **Silnik:** T-SQL / MS SQL Server
* **Główne funkcje:** Relacje 1:N, więzy integralności (FOREIGN KEY, CHECK), zapytania agregujące.

## 📊 Schemat Bazy
Baza składa się z 5 powiązanych tabel:
* `Gatunki` - słownik rodzajów zwierząt.
* `Wlasciciele` - dane kontaktowe klientów.
* `Zwierzeta` - profil pacjenta.
* `Weterynarze` - lista personelu medycznego.
* `Wizyty` - historia leczenia i diagnoz.

## 🔍 Przykładowe Zapytanie
W projekcie zawarłem 10 zapytań, w tym m.in. wyszukiwanie właścicieli z wieloma zwierzętami:
```sql
SELECT Imie, Nazwisko FROM Wlasciciele
WHERE WlascicielID IN (
    SELECT WlascicielID FROM Zwierzeta
    GROUP BY WlascicielID
    HAVING COUNT(*) > 1
);
