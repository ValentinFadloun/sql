/*eleve(numUnique,nom,prenom,adresse,datenaissance) check
seance(date heure, id seriequestion(sur cd)) check
cd(num, nomediteur, 6series(1-6  40q))check
question(libelle, rep, niveau, theme)check(peu etre dans plusieurs series de q, caractérisé par un numero d'ordre)'check
serie projeter sur plusieurs seances check
eleve fautes par series

seriequestion() */

CREATE DATABASE autoecole;

CREATE TABLE IF NOT EXISTS autoecole.eleve_sceance (
	num_eleve INT NOT NULL,
    id_seance INT NOT NULL,
    num_erreur INT NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.adresse (  #
	id_adresse INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    code_postal VARCHAR(5) NOT NULL,
    ville VARCHAR(40) NOT NULL,
    rue VARCHAR(255) NOT NULL,
    numero INT NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.serie_question (
	id_question INT NOT NULL,
    id_serie INT NOT NULL,
    num_question_serie INT NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.theme (  #
	id_theme INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    nom_theme VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS autoecole.question (  #
	id_question INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL,
    reponse VARCHAR(50) NOT NULL,
    niveau int NOT NULL,
    id_theme int NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.serie (    #
	id_serie INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    num_cd INT NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.cd (   #
	num_cd INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    nom_editeur VARCHAR(35) NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.seance (  #
	id_seance INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
	date_seance DATETIME NOT NULL,
    num_cd int NOT NULL,
    num_serie int NOT NULL,
    is_exam bool NOT NULL default false
);

CREATE TABLE IF NOT EXISTS autoecole.eleve  (   #
  num_eleve INT NOT NULL UNIQUE auto_increment,
  nom VARCHAR(40) NOT NULL,
  prenom VARCHAR(40) NOT NULL,
  id_adresse int NOT NULL,
  date_naissance date NOT NULL,
  PRIMARY KEY (num_eleve)
);

ALTER TABLE autoecole.eleve add constraint FK_adresse_eleve foreign key (id_adresse) references autoecole.adresse(id_adresse) on update cascade on delete restrict;
ALTER TABLE autoecole.seance add constraint FK_cd_seance foreign key (num_cd) references autoecole.cd(num_cd) on update cascade on delete restrict;
ALTER TABLE autoecole.serie add constraint FK_cd_serie foreign key (num_cd) references autoecole.cd(num_cd) on update cascade on delete restrict;
ALTER TABLE autoecole.serie_question add constraint FK_question_serie_question foreign key (id_question) references autoecole.question(id_question) on update cascade on delete restrict;
ALTER TABLE autoecole.serie_question add constraint FK_serie_serie_question foreign key (id_serie) references autoecole.serie(id_serie) on update cascade on delete restrict;
ALTER TABLE autoecole.question add constraint FK_theme_question foreign key (id_theme) references autoecole.theme(id_theme) on update cascade on delete restrict;
ALTER TABLE autoecole.eleve_sceance add constraint FK_eleve_eleve_sceance foreign key (num_eleve) references autoecole.eleve(num_eleve) on update cascade on delete restrict;
ALTER TABLE autoecole.eleve_sceance add constraint FK_seance_eleve_sceance foreign key (id_seance) references autoecole.seance(id_seance) on update cascade on delete restrict;
ALTER TABLE autoecole.seance add constraint FK_serie_sceance foreign key (num_serie) references autoecole.serie(id_serie) on update cascade on delete restrict;

INSERT INTO autoecole.cd (nom_editeur) VALUES 
("éditeur 1"),
("éditeur 2"),
("éditeur 3"),
("éditeur 4"),
("éditeur 5"),
("éditeur 6");
INSERT INTO autoecole.serie (num_cd) VALUES (1),(1),(1),(1),(1),(1),(2),(2),(2),(2),(2),(2),(3),(3),(3),(3),(3),(3),(4),(4),(4),(4),(4),(4),(5),(5),(5),(5),(5),(5),(5),(6),(6),(6),(6),(6),(6);
INSERT INTO autoecole.adresse (code_postal,ville,rue,numero) VALUES 
(59000,"Lille","Rue Gustave Delory", 20),
(59000,"Lille","Avenue St Cécile", 59),
(59000,"Lille","Rue Adolphe", 11),
(59000,"Lille","Rue de Calais", 420),
(59000,"Lille","Rue du Port", 2),
(59000,"Lille","Blvd Vauban", 701),
(59000,"Lille","Rue Gustave Delory", 51),
(59000,"Lille","Avenue St Cécile", 12),
(59000,"Lille","Rue Adolphe", 34),
(59000,"Lille","Rue de Calais", 120),
(59000,"Lille","Rue du Port", 10),
(59000,"Lille","Blvd Vauban", 39),
(59000,"Lille","Rue Gustave Delory", 99),
(59000,"Lille","Avenue St Cécile", 6),
(59000,"Lille","Rue Adolphe", 66),
(59000,"Lille","Rue de Calais", 81),
(59000,"Lille","Rue du Port", 31),
(59000,"Lille","Blvd Vauban", 302);
INSERT INTO autoecole.eleve (nom,prenom,id_adresse,date_naissance) VALUES 
("Dupont","Paul",1, "1997-10-15"),
("Dupont","Louis",1, "1999-01-10"),
("Desbois","Rémi",2, "1987-02-21"),
("Cailloux","Pierre",4, "1969-04-30"),
("Zakray","Alex",5, "2001-06-01"),
("Zuytan","Ben",6, "2000-02-12"),
("Sarwg","Simon",7, "1997-06-23"),
("Yarma","Yohan",8, "1998-08-09"),
("Kanak","Seb",9, "1985-01-19"),
("Dupond","JéJé",10, "1950-09-27");
INSERT INTO autoecole.theme (nom_theme) VALUES 
("theme 1"),
("theme 2"),
("theme 3"),
("theme 4"),
("theme 5"),
("theme 6");
INSERT INTO autoecole.question (libelle,reponse,niveau,id_theme) VALUES 
("Question 1","reponse 1",1, 1),
("Question 2","reponse 2",2, 1),
("Question 3","reponse 3",3, 1),
("Question 4","reponse 4",1, 2),
("Question 5","reponse 5",2, 2),
("Question 6","reponse 6",3, 2),
("Question 7","reponse 7",1, 3),
("Question 8","reponse 8",2, 3),
("Question 9","reponse 9",3, 3),
("Question 10","reponse 10",1, 4),
("Question 11","reponse 11",2, 4),
("Question 12","reponse 12",3, 4),
("Question 13","reponse 13",1, 5),
("Question 14","reponse 14",2, 5),
("Question 15","reponse 15",3, 5),
("Question 16","reponse 16",1, 6),
("Question 17","reponse 17",2, 6),
("Question 18","reponse 18",3, 6);
INSERT INTO autoecole.seance (date_seance,num_cd,num_serie,is_exam) VALUES 
("2019-12-20",1,3, false),
("2019-12-21",2,5, false),
("2019-12-22",3,1, false),
("2019-12-23",4,6, false),
("2019-12-27",5,2, false),
("2019-12-28",6,2, false),
("2019-12-29",1,4, false),
("2020-01-03",2,3, false),
("2020-01-04",3,5, true),
("2020-01-05",4,1, false),
("2020-01-08",5,5, false),
("2020-01-09",6,6, false),
("2020-01-10",1,1, false),
("2020-01-11",2,2, false),
("2020-01-12",3,6, true),
("2020-01-15",4,2, false),
("2020-01-16",5,1, false),
("2020-01-17",6,4, false),
("2020-01-18",1,5, false),
("2020-01-19",2,1, false),
("2020-01-22",3,2, false),
("2020-01-23",4,5, false),
("2020-01-24",5,3, false),
("2020-01-25",6,4, true),
("2020-01-26",1,6, false);

INSERT INTO autoecole.eleve_sceance (num_eleve ,id_seance ,num_erreur) VALUES
(1,1,20),
(3,1,2),
(7,1,35),
(2,2,12),
(4,2,7),
(9,2,9),
(10,3,16),
(4,3,1),
(6,3,4),
(5,3,30),
(3,4,4),
(9,4,6),
(10,5,10),
(6,5,2),
(4,5,20),
(2,5,22),
(1,5,12),
(8,5,2),
(3,6,1),
(10,6,2),
(8,7,6),
(1,8,31),
(7,8,30),
(2,8,10),
(3,8,1),
(3,9,0),
(4,10,3),
(9,10,3),
(2,10,3),
(4,11,3),
(10,11,3),
(7,11,3),
(1,11,3),
(9,12,3),
(8,12,3),
(6,13,3),
(4,14,3),
(1,14,3),
(9,14,3),
(8,14,3),
(2,15,3),
(8,15,3),
(7,15,3),
(9,16,3),
(10,16,3),
(2,17,3),
(4,17,3),
(5,17,3),
(6,18,3),
(7,18,3),
(8,18,3),
(9,18,3),
(10,19,3),
(8,19,3),
(4,20,3),
(1,20,3),
(6,20,3),
(5,20,3),
(2,20,3),
(10,20,3),
(9,20,3),
(4,21,3),
(1,21,3),
(2,22,3),
(9,23,3),
(10,23,3),
(5,23,3),
(7,25,3),
(6,25,3);

# Nombre erreur moyenne sur cd 14 et serie 5
SELECT AVG(el_seance.num_erreur) as moyenne_erreur FROM autoecole.seance as seance 
INNER JOIN autoecole.eleve_sceance as el_seance ON seance.id_seance = el_seance.id_seance 
WHERE seance.num_cd = 14 AND seance.num_serie = 5;

# Eleves qui se presente a l'exam
SELECT eleve.nom, eleve.prenom FROM autoecole.eleve_sceance as el_seance 
INNER JOIN autoecole.eleve as eleve ON el_seance.num_eleve = eleve.num_eleve 
INNER JOIN autoecole.seance as seance ON el_seance.id_seance = seance.id_seance
WHERE ( SELECT el_seance.num_erreur FROM autoecole.eleve_sceance as el_seance 
			INNER JOIN autoecole.eleve as eleve ON el_seance.num_eleve = eleve.num_eleve 
			INNER JOIN autoecole.seance as seance ON el_seance.id_seance = seance.id_seance
			WHERE eleve.num_eleve = el_seance.num_eleve ORDER BY seance.date_seance ASC LIMIT 5) BETWEEN 0 AND 5;
            
