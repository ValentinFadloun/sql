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

CREATE TABLE IF NOT EXISTS autoecole.adresse (
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

CREATE TABLE IF NOT EXISTS autoecole.theme (
	id_theme INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    nom_theme VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS autoecole.question (
	id_question INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL,
    reponse VARCHAR(50) NOT NULL,
    niveau int NOT NULL,
    id_theme int NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.serie (
	id_serie INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    num_cd INT NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.cd (
	num_cd INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
    nom_editeur VARCHAR(35) NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.seance (
	id_seance INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
	date_seance DATETIME NOT NULL,
    num_cd int NOT NULL,
    num_serie int NOT NULL
);

CREATE TABLE IF NOT EXISTS autoecole.eleve  (
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