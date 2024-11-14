DROP TABLE IF EXISTS fait_COURSE;
DROP TABLE IF EXISTS Date;
DROP TABLE IF EXISTS Depart;
DROP TABLE IF EXISTS Arrive;
DROP TABLE IF EXISTS Vehicule;
DROP TABLE IF EXISTS Chauffeur;
DROP TABLE IF EXISTS Heure;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Meteo;


-- Création des tables de dimensions

-- Done
CREATE TABLE Client (
    ID_Client INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Age INT,
    Sexe CHAR(1) CHECK (Sexe IN ('H', 'F')),
    Type_Client VARCHAR(20),
    Langue_Preferee VARCHAR(20),
    Email VARCHAR(50),
    Telephone VARCHAR(15),
    Point_gagnee INT
);

-- Done
CREATE TABLE Chauffeur (
    ID_Chauffeur INT PRIMARY KEY,
    Nom VARCHAR(26),
    Prenom VARCHAR(26),
    Date_Embauche DATE,
    Numero_Permis VARCHAR(20),
    Type_Permis VARCHAR(10),
    Telephone VARCHAR(15),
    Email VARCHAR(50),
    Statut VARCHAR(10) CHECK (Statut IN ('actif', 'inactif')),
    Zone_Principale VARCHAR(50)
);

-- Done
CREATE TABLE Depart (
    ID_DEPART INT PRIMARY KEY,
    Adresse VARCHAR(100) NOT NULL,
    Ville VARCHAR(50),
    Code_Postal VARCHAR(10),
    Distance_Centre INT, -- Distance en mètres
    Zone_Urbaine BOOLEAN,
    Prise_En_Charge VARCHAR(50) CHECK(Prise_En_Charge in ('Prise en charge', 'Annule', 'En_Attente')),
    Description_Depart VARCHAR(255)
);

--Done
CREATE TABLE Vehicule (
    ID_Vehicule INT PRIMARY KEY,
    Marque VARCHAR(30),
    Modele VARCHAR(30),
    Annee INT,
    Type_Vehicule VARCHAR(20) CHECK (Type_Vehicule IN ('Essence', 'Diesel', 'Electrique', 'Hybride')),
    Etat_Vehicule VARCHAR(20) CHECK (Etat_Vehicule IN ('Excellent', 'Bon', 'Mauvais')),
    Km_Parcourus INT,
    Derniere_Revision DATE,
    Consommation FLOAT,
    Assurance_Valide BOOLEAN
);

-- Done
CREATE TABLE Arrivee(
    ID_ARRIVEE INT PRIMARY KEY,
    Adresse VARCHAR(100) NOT NULL,
    Ville VARCHAR(50),
    Code_Postal VARCHAR(10),
    Distance_Centre INT, -- Distance en mètres
    Zone_Urbaine BOOLEAN,
    Description_Arrivee VARCHAR(255)
);

--Done
CREATE TABLE Heure (
    ID_HEURE INT PRIMARY KEY,
    Heure_Complete TIME NOT NULL,
    Periode_Journee VARCHAR(15) CHECK (Periode_Journee IN ('matin', 'apres-midi', 'soir', 'nuit')),
    AM_PM VARCHAR(10) CHECK (AM_PM IN ('AM', 'PM')),
    Heure_Pointe BOOLEAN, 
    Heure_Format24h TIME, 
    Fuseau_Horaire VARCHAR(10),
    Heure_UTC TIME
);

-- Done
CREATE TABLE Date (
    ID_DATE INT PRIMARY KEY,
    Date_Complete DATE NOT NULL,
    Jour INT NOT NULL,
    Mois INT,
    Annee INT,
    Type_Jour VARCHAR(15) CHECK (Type_Jour IN ('semaine', 'weekend', 'ferie')),
    Trimestre INT,
    Jour_Semaine VARCHAR(15) CHECK (Jour_Semaine IN ('lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche')),
    Semaine_Annee INT,
    Est_Weekend BOolEAN, 
    Est_Ferie BOOLEAN,
    Commentaire VARCHAR(255)
);

--Done 
CREATE TABLE Meteo (
    ID_METEO INT PRIMARY KEY,
    Date_Meteo DATE NOT NULL,
    Temperature FLOAT,
    Humidite INT CHECK (Humidite BETWEEN 0 AND 100),
    Precipitations FLOAT CHECK (Precipitations >= 0),
    Vent_Vitesse FLOAT CHECK (Vent_Vitesse >= 0),
    Vent_Direction VARCHAR(10),
    Condition_Meteo VARCHAR(50),
    Pression_Atmospherique FLOAT,
    Indice_UV INT CHECK (Indice_UV BETWEEN 0 AND 11)
);

-- Création de la table fait_COURSE
CREATE TABLE fait_COURSE (
    ID_DATE INT, -- Référence vers la dimension Trajet
    ID_ARRIVEE INT, -- Référence vers la dimension Arrivee
    ID_DEPART INT, -- Référence vers la dimension Depart
    ID_CLIENT INT, -- Référence vers la dimension Client
    ID_HEURE INT, -- Référence vers la dimension Heure
    ID_CHAUFFEUR INT, -- Référence vers la dimension Chauffeur
    ID_VEHICULE INT, -- Référence vers la dimension Vehicule
    ID_METEO INT, -- Référence vers la dimension Meteo

    Prix FLOAT, -- Prix total de la course
    Distance_Parcourue FLOAT, -- Distance parcourue en m
    Duree_Du_Trajet INT, -- Durée du trajet en minutes
    Nombre_Passagers INT, -- Nombre de passagers
    Statut_Course VARCHAR(20) CHECK(Statut_Course IN('Demande', 'Confirmation', 'Prise_en_Charge', 'Termine')), -- Statut de la course
    Temps_dattente_client INT, -- Temps d'attente du client en minutes
    Code_Promo VARCHAR(10), -- Code promotionnel utilisé
    Motif_Annulation VARCHAR(255), -- Motif d'annulation de la course
    Revenue_moyen_par_course FLOAT, -- Revenu moyen par course
    Indice_Satisfaction_Client FLOAT, -- Indice de satisfaction du client

    -- Définition de la clé primaire composite
    PRIMARY KEY (ID_DATE, ID_ARRIVEE, ID_DEPART, ID_CLIENT, ID_HEURE, ID_CHAUFFEUR, ID_VEHICULE, ID_METEO),

    FOREIGN KEY (ID_DATE) REFERENCES Date(ID_DATE),
    FOREIGN KEY (ID_ARRIVEE) REFERENCES Arrivee(ID_ARRIVEE),
    FOREIGN KEY (ID_DEPART) REFERENCES Depart(ID_DEPART),
    FOREIGN KEY (ID_CLIENT) REFERENCES Client(ID_Client),
    FOREIGN KEY (ID_HEURE) REFERENCES Heure(ID_HEURE),
    FOREIGN KEY (ID_CHAUFFEUR) REFERENCES Chauffeur(ID_Chauffeur),
    FOREIGN KEY (ID_VEHICULE) REFERENCES Vehicule(ID_Vehicule),
    FOREIGN KEY (ID_METEO) REFERENCES Meteo(ID_METEO)
);


INSERT INTO Client (ID_Client, Nom, Prenom, Age, Sexe, Type_Client, Langue_Preferee, Email, Telephone, Point) VALUES
(1, 'Dupont', 'Alice', 34, 'F', 'VIP', 'Français', 'alice.dupont@example.com', '0123456789', 120),
(2, 'Martin', 'Pierre', 29, 'H', 'Standard', 'Français', 'pierre.martin@example.com', '0123456790', 50),
(3, 'Smith', 'John', 45, 'H', 'Premium', 'Anglais', 'john.smith@example.com', '0123456791', 95),
(4, 'Durand', 'Marie', 40, 'F', 'VIP', 'Français', 'marie.durand@example.com', '0123456792', 110),
(5, 'Lopez', 'Carlos', 30, 'H', 'Standard', 'Espagnol', 'carlos.lopez@example.com', '0123456793', 30),
(6, 'Garcia', 'Ana', 36, 'F', 'Premium', 'Espagnol', 'ana.garcia@example.com', '0123456794', 80),
(7, 'Johnson', 'Linda', 28, 'F', 'Standard', 'Anglais', 'linda.johnson@example.com', '0123456795', 45),
(8, 'Schmidt', 'Hans', 50, 'H', 'VIP', 'Allemand', 'hans.schmidt@example.com', '0123456796', 130),
(9, 'Yamada', 'Taro', 32, 'H', 'Standard', 'Japonais', 'taro.yamada@example.com', '0123456797', 60),
(10, 'Wong', 'Mei', 25, 'F', 'Standard', 'Chinois', 'mei.wong@example.com', '0123456798', 40),
(11, 'Brown', 'Emma', 38, 'F', 'Premium', 'Anglais', 'emma.brown@example.com', '0123456799', 85),
(12, 'Kim', 'Jin', 31, 'H', 'Standard', 'Coréen', 'jin.kim@example.com', '0123456800', 55),
(13, 'Kumar', 'Anil', 42, 'H', 'Premium', 'Hindi', 'anil.kumar@example.com', '0123456801', 75),
(14, 'Omar', 'Youssef', 37, 'H', 'VIP', 'Arabe', 'youssef.omar@example.com', '0123456802', 115),
(15, 'Nguyen', 'Linh', 27, 'F', 'Standard', 'Vietnamien', 'linh.nguyen@example.com', '0123456803', 35);

INSERT INTO Chauffeur (ID_Chauffeur, Nom, Prenom, Date_Embauche, Numero_Permis, Type_Permis, Telephone, Email, Statut, Zone_Principale) VALUES
(1, 'Bernard', 'Luc', '2020-01-15', '1234567890', 'B', '0123456792', 'luc.bernard@example.com', 'actif', 'Paris'),
(2, 'Legrand', 'Sophie', '2018-07-10', '0987654321', 'B', '0123456793', 'sophie.legrand@example.com', 'actif', 'Marseille'),
(3, 'Lambert', 'Paul', '2019-03-22', '1122334455', 'B', '0123456794', 'paul.lambert@example.com', 'inactif', 'Lyon'),
(4, 'Nguyen', 'Van', '2022-02-18', '2233445566', 'B', '0123456795', 'van.nguyen@example.com', 'actif', 'Paris'),
(5, 'Rossi', 'Giulia', '2021-09-10', '3344556677', 'B', '0123456796', 'giulia.rossi@example.com', 'actif', 'Milan'),
(6, 'Wilson', 'Mark', '2019-11-15', '4455667788', 'B', '0123456797', 'mark.wilson@example.com', 'inactif', 'Londres'),
(7, 'Müller', 'Laura', '2021-03-28', '5566778899', 'B', '0123456798', 'laura.muller@example.com', 'actif', 'Berlin'),
(8, 'Hernandez', 'Miguel', '2020-06-30', '6677889900', 'B', '0123456799', 'miguel.hernandez@example.com', 'inactif', 'Madrid'),
(9, 'Chen', 'Li', '2020-05-12', '7788990011', 'B', '0123456800', 'li.chen@example.com', 'actif', 'Shanghai'),
(10, 'Garcia', 'Luis', '2017-12-05', '8899001122', 'B', '0123456801', 'luis.garcia@example.com', 'actif', 'Barcelona'),
(11, 'Johnson', 'Sara', '2018-04-18', '9900112233', 'B', '0123456802', 'sara.johnson@example.com', 'actif', 'New York'),
(12, 'Patel', 'Amit', '2021-08-01', '1011121314', 'B', '0123456803', 'amit.patel@example.com', 'actif', 'Mumbai'),
(13, 'Brown', 'Emily', '2019-05-05', '1112131415', 'B', '0123456804', 'emily.brown@example.com', 'inactif', 'Sydney'),
(14, 'Davis', 'Jake', '2018-10-24', '1213141516', 'B', '0123456805', 'jake.davis@example.com', 'actif', 'Chicago'),
(15, 'Ali', 'Aisha', '2022-07-15', '1314151617', 'B', '0123456806', 'aisha.ali@example.com', 'actif', 'Dubai');

INSERT INTO Depart (ID_DEPART, Adresse, Ville, Code_Postal, Distance_Centre, Zone_Urbaine, Prise_En_Charge, Description_Depart) VALUES
(1, '10 Rue de la Paix', 'Paris', '75002', 1000, TRUE, 'Prise en charge', 'Proche de la place Vendôme'),
(2, '25 Avenue du Prado', 'Marseille', '13006', 2000, TRUE, 'En_Attente', 'Centre ville'),
(3, '5 Boulevard des Belges', 'Lyon', '69006', 3000, FALSE, 'Annule', 'Quartier résidentiel'),
(4, '12 Rue du Bac', 'Paris', '75007', 1500, TRUE, 'Prise en charge', 'Près de la Tour Eiffel'),
(5, '50 Rue Nationale', 'Lille', '59800', 500, TRUE, 'Prise en charge', 'Proche de la gare Lille Flandres'),
(6, '8 Rue de Rivoli', 'Paris', '75004', 1800, TRUE, 'En_Attente', 'Près de l’Hôtel de Ville'),
(7, '3 Place Bellecour', 'Lyon', '69002', 2700, TRUE, 'Annule', 'Centre de Lyon'),
(8, '14 Cours Mirabeau', 'Aix-en-Provence', '13100', 3200, TRUE, 'Prise en charge', 'Près de la Fontaine de la Rotonde'),
(9, '22 Rue Espariat', 'Marseille', '13001', 1900, TRUE, 'En_Attente', 'Centre historique'),
(10, '7 Avenue Montaigne', 'Paris', '75008', 1400, TRUE, 'Prise en charge', 'Proche des Champs-Élysées'),
(11, '9 Rue du Louvre', 'Paris', '75001', 900, TRUE, 'Annule', 'Près du musée du Louvre'),
(12, '30 Rue de la Liberté', 'Dijon', '21000', 400, FALSE, 'Prise en charge', 'Centre de Dijon'),
(13, '6 Rue Saint-Dominique', 'Paris', '75007', 1300, TRUE, 'En_Attente', 'Près des Invalides'),
(14, '3 Rue Sainte-Catherine', 'Bordeaux', '33000', 1200, TRUE, 'Prise en charge', 'Centre de Bordeaux'),
(15, '24 Place Stanislas', 'Nancy', '54000', 800, FALSE, 'Prise en charge', 'Centre historique de Nancy');

INSERT INTO Vehicule (ID_Vehicule, Marque, Modele, Annee, Type_Vehicule, Couleur, Immatriculation, Statut) VALUES
(1, 'Toyota', 'Corolla', 2020, 'Berline', 'Blanc', 'AB-123-CD', 'Disponible'),
(2, 'Peugeot', '308', 2018, 'Hatchback', 'Rouge', 'EF-456-GH', 'En_Cours'),
(3, 'BMW', 'X5', 2021, 'SUV', 'Noir', 'IJ-789-KL', 'Disponible'),
(4, 'Renault', 'Clio', 2019, 'Citadine', 'Bleu', 'MN-012-OP', 'En_Cours'),
(5, 'Mercedes', 'Classe A', 2022, 'Berline', 'Gris', 'QR-345-ST', 'Disponible'),
(6, 'Audi', 'A4', 2021, 'Berline', 'Blanc', 'UV-678-WX', 'En_Cours'),
(7, 'Ford', 'Fiesta', 2017, 'Citadine', 'Jaune', 'YZ-901-AB', 'Disponible'),
(8, 'Volvo', 'XC90', 2020, 'SUV', 'Vert', 'CD-234-EF', 'En_Cours'),
(9, 'Opel', 'Corsa', 2016, 'Citadine', 'Orange', 'GH-567-IJ', 'Disponible'),
(10, 'Hyundai', 'Tucson', 2019, 'SUV', 'Violet', 'KL-890-MN', 'En_Cours'),
(11, 'Peugeot', '3008', 2020, 'SUV', 'Gris', 'OP-123-QR', 'Disponible'),
(12, 'Kia', 'Rio', 2018, 'Hatchback', 'Bleu', 'ST-456-UV', 'En_Cours'),
(13, 'Citroën', 'C3', 2022, 'Citadine', 'Blanc', 'WX-789-YZ', 'Disponible'),
(14, 'Mazda', 'CX-5', 2021, 'SUV', 'Rouge', 'AB-012-CD', 'En_Cours'),
(15, 'Nissan', 'Juke', 2020, 'SUV', 'Vert', 'EF-345-GH', 'Disponible');

INSERT INTO Arrivee (ID_Arrivee, Adresse, Ville, Code_Postal, Heure_Arrivee, ID_Vehicule) VALUES
(1, '15 Rue de Rivoli', 'Paris', '75001', '2024-11-14 08:15:00', 1),
(2, '22 Avenue des Champs-Élysées', 'Paris', '75008', '2024-11-14 08:45:00', 2),
(3, '30 Boulevard de la République', 'Lyon', '69001', '2024-11-14 09:00:00', 3),
(4, '12 Rue Montmartre', 'Paris', '75002', '2024-11-14 09:30:00', 4),
(5, '18 Rue de la Paix', 'Paris', '75002', '2024-11-14 10:00:00', 5),
(6, '25 Avenue de la Liberté', 'Marseille', '13001', '2024-11-14 10:15:00', 6),
(7, '20 Rue de la Garonne', 'Toulouse', '31000', '2024-11-14 10:45:00', 7),
(8, '10 Rue du Faubourg', 'Lille', '59000', '2024-11-14 11:00:00', 8),
(9, '8 Rue des Tuileries', 'Paris', '75001', '2024-11-14 11:30:00', 9),
(10, '14 Boulevard Saint-Germain', 'Paris', '75005', '2024-11-14 12:00:00', 10),
(11, '7 Rue de la Plage', 'Nice', '06000', '2024-11-14 12:15:00', 11),
(12, '28 Rue de la Gare', 'Lyon', '69007', '2024-11-14 12:45:00', 12),
(13, '9 Avenue des Alpes', 'Grenoble', '38000', '2024-11-14 13:00:00', 13),
(14, '6 Boulevard de la Côte', 'Marseille', '13006', '2024-11-14 13:30:00', 14),
(15, '17 Rue du Général Leclerc', 'Bordeaux', '33000', '2024-11-14 14:00:00', 15);

INSERT INTO Heure (ID_HEURE, Heure_Complete, Periode_Journee, AM_PM, Heure_Pointe, Heure_Format24h, Fuseau_Horaire, Heure_UTC) VALUES
(1, '08:00:00', 'matin', 'AM', FALSE, '08:00:00', 'CET', '06:00:00'),
(2, '09:30:00', 'matin', 'AM', TRUE, '09:30:00', 'CET', '07:30:00'),
(3, '12:00:00', 'apres-midi', 'PM', TRUE, '12:00:00', 'CET', '10:00:00'),
(4, '13:15:00', 'apres-midi', 'PM', FALSE, '13:15:00', 'CET', '11:15:00'),
(5, '16:00:00', 'apres-midi', 'PM', TRUE, '16:00:00', 'CET', '14:00:00'),
(6, '17:30:00', 'soir', 'PM', FALSE, '17:30:00', 'CET', '15:30:00'),
(7, '19:00:00', 'soir', 'PM', TRUE, '19:00:00', 'CET', '17:00:00'),
(8, '21:00:00', 'soir', 'PM', TRUE, '21:00:00', 'CET', '19:00:00'),
(9, '22:45:00', 'nuit', 'PM', FALSE, '22:45:00', 'CET', '20:45:00'),
(10, '00:15:00', 'nuit', 'AM', FALSE, '00:15:00', 'CET', '22:15:00'),
(11, '02:00:00', 'nuit', 'AM', TRUE, '02:00:00', 'CET', '00:00:00'),
(12, '03:30:00', 'nuit', 'AM', FALSE, '03:30:00', 'CET', '01:30:00'),
(13, '05:00:00', 'matin', 'AM', TRUE, '05:00:00', 'CET', '03:00:00'),
(14, '06:30:00', 'matin', 'AM', FALSE, '06:30:00', 'CET', '04:30:00'),
(15, '07:45:00', 'matin', 'AM', TRUE, '07:45:00', 'CET', '05:45:00');

INSERT INTO Meteo (ID_METEO, Date, Temperature, Humidite, Precipitations, Vent_Vitesse, Vent_Direction, Condition_Meteo, Pression_Atmospherique, Indice_UV) VALUES
(1, '2024-11-14', 15.3, 65, 0.0, 5.2, 'Nord', 'Ensoleillé', 1013.5, 3),
(2, '2024-11-14', 12.8, 70, 1.2, 4.5, 'Est', 'Nuageux', 1012.0, 2),
(3, '2024-11-14', 18.2, 60, 0.0, 6.1, 'Ouest', 'Partiellement nuageux', 1015.3, 4),
(4, '2024-11-14', 10.0, 80, 2.0, 3.4, 'Sud', 'Pluvieux', 1011.2, 1),
(5, '2024-11-14', 22.5, 55, 0.0, 7.0, 'Nord-Ouest', 'Ensoleillé', 1014.0, 5),
(6, '2024-11-14', 14.0, 75, 0.5, 4.8, 'Sud-Ouest', 'Brumeux', 1012.5, 3),
(7, '2024-11-14', 16.3, 62, 0.0, 3.2, 'Nord-Est', 'Ciel clair', 1013.0, 4),
(8, '2024-11-14', 13.7, 68, 1.0, 5.4, 'Sud', 'Pluie légère', 1010.8, 2),
(9, '2024-11-14', 19.1, 59, 0.0, 4.2, 'Est', 'Soleil intermittent', 1015.8, 4),
(10, '2024-11-14', 9.5, 82, 3.0, 6.7, 'Ouest', 'Orageux', 1011.9, 1),
(11, '2024-11-14', 20.8, 66, 0.0, 2.9, 'Nord', 'Ensoleillé', 1014.3, 5),
(12, '2024-11-14', 11.4, 74, 1.3, 5.1, 'Sud-Est', 'Nuageux', 1012.3, 3),
(13, '2024-11-14', 17.0, 60, 0.0, 3.8, 'Nord-Ouest', 'Partiellement nuageux', 1016.0, 4),
(14, '2024-11-14', 14.9, 72, 0.0, 4.6, 'Est', 'Ciel clair', 1012.7, 4),
(15, '2024-11-14', 18.7, 64, 0.0, 6.3, 'Ouest', 'Ensoleillé', 1014.5, 5);

INSERT INTO Date (ID_DATE, Date_Complete, Jour, Mois, Annee, Type_Jour, Trimestre, Jour_Semaine, Semaine_Annee, Est_Weekend, Est_Ferie, Commentaire) VALUES
(1, '2024-11-14', 14, 11, 2024, 'semaine', 4, 'jeudi', 46, FALSE, FALSE, 'Aucune particularité'),
(2, '2024-11-13', 13, 11, 2024, 'semaine', 4, 'mercredi', 46, FALSE, FALSE, 'Aucune particularité'),
(3, '2024-11-12', 12, 11, 2024, 'semaine', 4, 'mardi', 46, FALSE, FALSE, 'Aucune particularité'),
(4, '2024-11-11', 11, 11, 2024, 'ferie', 4, 'lundi', 46, FALSE, TRUE, 'Jour férié - Armistice'),
(5, '2024-11-10', 10, 11, 2024, 'weekend', 4, 'dimanche', 45, TRUE, FALSE, 'Aucune particularité'),
(6, '2024-11-09', 9, 11, 2024, 'weekend', 4, 'samedi', 45, TRUE, FALSE, 'Aucune particularité'),
(7, '2024-11-08', 8, 11, 2024, 'semaine', 4, 'vendredi', 45, FALSE, FALSE, 'Aucune particularité'),
(8, '2024-11-07', 7, 11, 2024, 'semaine', 4, 'jeudi', 45, FALSE, FALSE, 'Aucune particularité'),
(9, '2024-11-06', 6, 11, 2024, 'semaine', 4, 'mercredi', 45, FALSE, FALSE, 'Aucune particularité'),
(10, '2024-11-05', 5, 11, 2024, 'semaine', 4, 'mardi', 45, FALSE, FALSE, 'Aucune particularité'),
(11, '2024-11-04', 4, 11, 2024, 'semaine', 4, 'lundi', 45, FALSE, FALSE, 'Aucune particularité'),
(12, '2024-11-03', 3, 11, 2024, 'weekend', 4, 'dimanche', 44, TRUE, FALSE, 'Aucune particularité'),
(13, '2024-11-02', 2, 11, 2024, 'weekend', 4, 'samedi', 44, TRUE, FALSE, 'Aucune particularité'),
(14, '2024-11-01', 1, 11, 2024, 'ferie', 4, 'vendredi', 44, FALSE, TRUE, 'Jour férié - Toussaint'),
(15, '2024-10-31', 31, 10, 2024, 'semaine', 4, 'jeudi', 44, FALSE, FALSE, 'Aucune particularité');

INSERT INTO fait_COURSE (
    ID_DATE, ID_ARRIVEE, ID_DEPART, ID_CLIENT, ID_HEURE, ID_CHAUFFEUR, ID_VEHICULE, ID_METEO, 
    Prix, Distance_Parcourue, Duree_Du_Trajet, nombre_passagers, Statut_Course, Temps_dattente_client, 
    Code_Promo, Motif_Annulation, Revenue_moyen_par_course, Indice_Satisfaction_Client
) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 25.50, 5000, 15, 2, 'Termine', 5, 'PROMO10', NULL, 12.75, 4.5),
(2, 2, 2, 2, 3, 2, 2, 2, 30.00, 7000, 20, 1, 'Confirmation', 8, 'PROMO20', NULL, 15.00, 3.8),
(3, 3, 3, 3, 5, 3, 3, 3, 18.75, 3000, 10, 3, 'Prise_en_Charge', 12, NULL, 'Annulation client', 10.50, 4.0),
(4, 4, 4, 4, 7, 4, 4, 4, 40.00, 10000, 30, 4, 'Termine', 4, 'PROMO15', NULL, 20.00, 4.8),
(5, 5, 5, 5, 9, 5, 5, 5, 22.50, 4500, 12, 1, 'Demande', 2, NULL, 'Motif inconnu', 11.00, 3.5),
(6, 6, 6, 6, 11, 6, 6, 6, 28.00, 6000, 18, 2, 'Termine', 6, NULL, NULL, 14.00, 4.3),
(7, 7, 7, 7, 13, 7, 7, 7, 35.00, 8000, 25, 3, 'Confirmation', 10, 'PROMO30', NULL, 18.25, 4.6),
(8, 8, 8, 8, 15, 8, 8, 8, 50.00, 12000, 35, 4, 'Prise_en_Charge', 15, NULL, 'Problème véhicule', 22.50, 4.7),
(9, 9, 9, 9, 10, 9, 9, 9, 45.00, 11000, 30, 3, 'Demande', 4, 'PROMO25', NULL, 21.00, 3.9),
(10, 10, 10, 10, 12, 10, 10, 10, 38.00, 9500, 22, 2, 'Termine', 7, 'PROMO5', NULL, 19.75, 4.2);

