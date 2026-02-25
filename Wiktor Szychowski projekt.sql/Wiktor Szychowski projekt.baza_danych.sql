--Wiktor Szychowski projekt
-- USUÑ TABELKI JEŒLI ISTNIEJ¥ 
DROP TABLE IF EXISTS Wizyty;
DROP TABLE IF EXISTS Zwierzeta;
DROP TABLE IF EXISTS Weterynarze;
DROP TABLE IF EXISTS Wlasciciele;
DROP TABLE IF EXISTS Gatunki;

-- TWORZENIE TABEL
CREATE TABLE Gatunki (
    GatunekID INT PRIMARY KEY IDENTITY(1,1),
    Nazwa VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Wlasciciele (
    WlascicielID INT PRIMARY KEY IDENTITY(1,1),
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Telefon VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Zwierzeta (
    ZwierzeID INT PRIMARY KEY IDENTITY(1,1),
    Imie VARCHAR(50) NOT NULL,
    GatunekID INT NOT NULL,
    Wiek INT CHECK (Wiek >= 0),
    WlascicielID INT NOT NULL,
    FOREIGN KEY (GatunekID) REFERENCES Gatunki(GatunekID),
    FOREIGN KEY (WlascicielID) REFERENCES Wlasciciele(WlascicielID)
);

CREATE TABLE Weterynarze (
    WeterynarzID INT PRIMARY KEY IDENTITY(1,1),
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Specjalizacja VARCHAR(100)
);

CREATE TABLE Wizyty (
    WizytaID INT PRIMARY KEY IDENTITY(1,1),
    DataWizyty DATETIME NOT NULL,
    ZwierzeID INT NOT NULL,
    WeterynarzID INT NOT NULL,
    Diagnoza TEXT,
    FOREIGN KEY (ZwierzeID) REFERENCES Zwierzeta(ZwierzeID),
    FOREIGN KEY (WeterynarzID) REFERENCES Weterynarze(WeterynarzID)
);

-- DODAWANIE DANYCH
INSERT INTO Gatunki (Nazwa) VALUES ('Pies'), ('Kot'), ('Królik'), ('Papuga'), ('Chomik');

INSERT INTO Wlasciciele (Imie, Nazwisko, Telefon, Email)
VALUES 
('Anna', 'Kowalska', '600111222', 'anna.kowalska@example.com'),
('Piotr', 'Nowak', '601222333', 'piotr.nowak@example.com'),
('Ewa', 'Malinowska', '602333444', 'ewa.m@example.com');

INSERT INTO Zwierzeta (Imie, GatunekID, Wiek, WlascicielID)
VALUES 
('Reksio', 1, 5, 1),
('Mruczek', 2, 3, 1),
('Bunny', 3, 2, 2),
('Coco', 4, 1, 3);

INSERT INTO Weterynarze (Imie, Nazwisko, Specjalizacja)
VALUES 
('Jan', 'Zielinski', 'Choroby psów'),
('Maria', 'Szymanska', 'Choroby kotów i gryzoni');

INSERT INTO Wizyty (DataWizyty, ZwierzeID, WeterynarzID, Diagnoza)
VALUES 
('2024-05-01 10:00', 1, 1, 'Alergia pokarmowa'),
('2024-05-03 11:30', 2, 2, 'Infekcja ucha'),
('2024-05-04 12:00', 3, 2, 'Z³amanie ³apy');
