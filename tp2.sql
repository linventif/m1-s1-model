-- =====================================
-- Création de la base
-- =====================================
CREATE DATABASE IF NOT EXISTS GestionActivites;
USE GestionActivites;

-- =====================================
-- Table Service
-- =====================================
CREATE TABLE Service (
    codeService INT PRIMARY KEY,
    nomService VARCHAR(100) NOT NULL,
    directeur INT UNIQUE
    -- FK vers Employé (ajout après création Employé)
);

-- =====================================
-- Table Employé
-- =====================================
CREATE TABLE Employe (
    matricule INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    codeService INT,
    CONSTRAINT fk_employe_service
        FOREIGN KEY (codeService) REFERENCES Service(codeService)
);

-- Ajout de la FK directeur (car Employé doit exister avant)
ALTER TABLE Service
ADD CONSTRAINT fk_service_directeur
FOREIGN KEY (directeur) REFERENCES Employe(matricule);

-- =====================================
-- Table Activité
-- =====================================
CREATE TABLE Activite (
    codeActivite INT PRIMARY KEY,
    libelle VARCHAR(150) NOT NULL
);

-- =====================================
-- Table SessionActivite
-- =====================================
CREATE TABLE SessionActivite (
    idSession INT PRIMARY KEY AUTO_INCREMENT,
    dateSession DATE NOT NULL,
    duree INT NOT NULL,
    codeActivite INT NOT NULL,
    CONSTRAINT fk_session_activite
        FOREIGN KEY (codeActivite) REFERENCES Activite(codeActivite)
);

-- =====================================
-- Table Inscription (relation Employé ↔ SessionActivité)
-- =====================================
CREATE TABLE Inscription (
    matricule INT NOT NULL,
    idSession INT NOT NULL,
    dateInscription DATE NOT NULL,
    PRIMARY KEY (matricule, idSession),
    CONSTRAINT fk_inscription_employe
        FOREIGN KEY (matricule) REFERENCES Employe(matricule),
    CONSTRAINT fk_inscription_session
        FOREIGN KEY (idSession) REFERENCES SessionActivite(idSession)
);

-- =====================================
-- Table Moyen
-- =====================================
CREATE TABLE Moyen (
    numMoyen INT PRIMARY KEY,
    intitule VARCHAR(100) NOT NULL,
    codeService INT NOT NULL,
    CONSTRAINT fk_moyen_service
        FOREIGN KEY (codeService) REFERENCES Service(codeService)
);

-- =====================================
-- Table Réservation (relation Employé ↔ Moyen ↔ SessionActivité)
-- =====================================
CREATE TABLE Reservation (
    matricule INT NOT NULL,
    numMoyen INT NOT NULL,
    idSession INT NOT NULL,
    dateReservation DATE NOT NULL,
    dateRestitution DATE,
    PRIMARY KEY (matricule, numMoyen, idSession, dateReservation),
    CONSTRAINT fk_resa_employe
        FOREIGN KEY (matricule) REFERENCES Employe(matricule),
    CONSTRAINT fk_resa_moyen
        FOREIGN KEY (numMoyen) REFERENCES Moyen(numMoyen),
    CONSTRAINT fk_resa_session
        FOREIGN KEY (idSession) REFERENCES SessionActivite(idSession)
);
