CREATE TABLE IF NOT EXISTS studenter (
    studentid INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fornavn VARCHAR(30),
    etternavn VARCHAR(30),
    fodt DATE
);

CREATE TABLE IF NOT EXISTS kurs (
    kurskode VARCHAR(15) PRIMARY KEY,
    navn VARCHAR(50),
    studiepoeng INT
);

CREATE TABLE IF NOT EXISTS tar_kurs (
    studentid INT UNSIGNED,
    kurskode VARCHAR(15),
    karakter VARCHAR(1),
    PRIMARY KEY(studentid, kurskode),
    FOREIGN KEY (studentid) REFERENCES studenter (studentid) ON DELETE CASCADE,
    FOREIGN KEY (kurskode) REFERENCES kurs (kurskode) ON DELETE CASCADE
);

-- ON DELETE SET NULL --> FOR ONLY FOREIGN KEYS
-- ON DELETE CASCADE --> FOR ATTRIBUTES THAT ARE ALSO PRIMARY KEYS

INSERT INTO studenter VALUES
(NULL, 'Kari', 'Borg', '1993-02-23'),
(NULL, 'Per', 'Nes', '1996-07-08'),
(NULL, 'Mina', 'Gran', '1990-11-03'),
(NULL, 'Carl', 'Smith', '1992-09-05');

INSERT INTO kurs VALUES
('AST1010', 'Astronomi - en kosmisk reise', 10),
('MAT2250', 'Diskret matematikk', 10),
('IN2000', 'Software Engineering med prosjektarbeid', 20),
('BIOS3010', 'Bioinformatikk', 10),
('IN1010', 'Objektorientert programmering', 10),
('IN2090', 'Databaser og datamodellering', 10),
('BIOS3300', 'Marinbiologi', 10),
('IN5360', 'Forskerlinjen II', 15),
('MAT1100', 'Kalkulus', 10),
('IN1150', 'Logiske metoder', 10),
('IN3000', 'Operativsystemer', 20);

INSERT INTO kurs VALUES
('IN2020', 'Metoder i interaksjonsdesign', 10),
('FYS2000', 'Intro til Fysikk', 10),
('INF4000', 'Operativsystemer II', 10);

INSERT INTO tar_kurs VALUES
(1, 'IN2090', 'B'),
(1, 'IN2020', 'C'), --
(2, 'IN2000', 'C'),
(3, 'MAT2250', 'A'),
(1, 'AST1010', 'D'),
(4, 'FYS2000', 'C'), --
(2, 'BIOS3010', 'A'),
(4, 'IN3000', 'C'),
(2, 'INF4000', 'B'), --
(3, 'MAT1100', 'E'); 

SELECT fornavn, etternavn FROM studenter WHERE etternavn LIKE 'g%';

-- Skriv et program (pseudokode, Python- eller Java-kode) som lister opp kurskode og navn på alle kurs med en kurskode som 
-- starter med "IN", som er tatt av studenter som er født etter 1. januar 1992. 
SELECT DISTINCT kurs.kurskode, kurs.navn FROM kurs 
WHERE kurs.kurskode LIKE 'IN%' AND kurs.kurskode IN (
	SELECT tar_kurs.kurskode FROM tar_kurs WHERE tar_kurs.studentid IN (
		SELECT studenter.studentid FROM studenter WHERE studenter.fodt > '1992-01-01'
    )
)
ORDER BY kurs.kurskode;


