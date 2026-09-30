CREATE DATABASE KutuphaneOtomasyonu
GO

USE KutuphaneOtomasyonu
GO

CREATE TABLE Uye
(
    UyeID INT IDENTITY(1,1) PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Telefon VARCHAR(20),
    Adres VARCHAR(100)
)

CREATE TABLE Personel
(
    PersonelID INT IDENTITY(1,1) PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Gorev VARCHAR(50)
)

CREATE TABLE Kategori
(
    KategoriID INT IDENTITY(1,1) PRIMARY KEY,
    KategoriAdi VARCHAR(50)
)

CREATE TABLE Yayinevi
(
    YayineviID INT IDENTITY(1,1) PRIMARY KEY,
    YayineviAdi VARCHAR(50)
)

CREATE TABLE Yazar
(
    YazarID INT IDENTITY(1,1) PRIMARY KEY,
    YazarAdi VARCHAR(50)
)

CREATE TABLE Kitap
(
    KitapID INT IDENTITY(1,1) PRIMARY KEY,
    KitapAdi VARCHAR(100),
    BasimYili INT,
    KategoriID INT,
    YayineviID INT,
    FOREIGN KEY (KategoriID) REFERENCES Kategori(KategoriID),
    FOREIGN KEY (YayineviID) REFERENCES Yayinevi(YayineviID)
)

CREATE TABLE KitapYazar
(
    KitapID INT,
    YazarID INT,
    PRIMARY KEY (KitapID,YazarID),
    FOREIGN KEY (KitapID) REFERENCES Kitap(KitapID),
    FOREIGN KEY (YazarID) REFERENCES Yazar(YazarID)
)

CREATE TABLE Odunc
(
    OduncID INT IDENTITY(1,1) PRIMARY KEY,
    UyeID INT,
    KitapID INT,
    PersonelID INT,
    AlisTarihi DATE,
    TeslimTarihi DATE,
    FOREIGN KEY (UyeID) REFERENCES Uye(UyeID),
    FOREIGN KEY (KitapID) REFERENCES Kitap(KitapID),
    FOREIGN KEY (PersonelID) REFERENCES Personel(PersonelID)
)

INSERT INTO Uye
VALUES
('Mert','Cakirel','05551111111','Sinop'),
('Ali','Yilmaz','05552222222','Ankara'),
('Ayse','Demir','05553333333','Istanbul')

INSERT INTO Personel
VALUES
('Ahmet','Kaya','Memur'),
('Mehmet','Can','Mudur')

INSERT INTO Kategori
VALUES
('Roman'),
('Bilim'),
('Tarih'),
('Hikaye')

INSERT INTO Yayinevi
VALUES
('Pegasus'),
('Can'),
('Yapi Kredi')

INSERT INTO Yazar
VALUES
('Sabahattin Ali'),
('Orhan Pamuk'),
('Yasar Kemal'),
('Ilber Ortayli')

INSERT INTO Kitap
VALUES
('Kurk Mantolu Madonna',1943,1,1),
('Benim Adim Kirmizi',1998,1,2),
('Ince Memed',1955,1,3),
('Turklerin Tarihi',2016,3,2)

INSERT INTO KitapYazar
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(1,2)

INSERT INTO Odunc
VALUES
(1,1,1,'2026-05-01','2026-05-15'),
(1,2,2,'2026-05-05','2026-05-20'),
(2,3,1,'2026-05-10','2026-05-25'),
(3,4,2,'2026-05-12','2026-05-27'),
(1,3,1,'2026-05-18','2026-06-01')

SELECT Uye.Ad,Uye.Soyad,Kitap.KitapAdi
FROM Uye
INNER JOIN Odunc
ON Uye.UyeID=Odunc.UyeID
INNER JOIN Kitap
ON Kitap.KitapID=Odunc.KitapID

SELECT KitapAdi,KategoriAdi
FROM Kitap
INNER JOIN Kategori
ON Kitap.KategoriID=Kategori.KategoriID

SELECT KitapAdi,YayineviAdi
FROM Kitap
INNER JOIN Yayinevi
ON Kitap.YayineviID=Yayinevi.YayineviID

SELECT KitapAdi,YazarAdi
FROM Kitap
INNER JOIN KitapYazar
ON Kitap.KitapID=KitapYazar.KitapID
INNER JOIN Yazar
ON Yazar.YazarID=KitapYazar.YazarID

SELECT UyeID,COUNT(*) AS KitapSayisi
FROM Odunc
GROUP BY UyeID
HAVING COUNT(*)>=2

SELECT YazarID,COUNT(*) AS KitapSayisi
FROM KitapYazar
GROUP BY YazarID
HAVING COUNT(*)>1

SELECT KategoriID,COUNT(*) AS ToplamKitap
FROM Kitap
GROUP BY KategoriID
HAVING COUNT(*)>1