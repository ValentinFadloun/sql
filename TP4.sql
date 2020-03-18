CREATE DATABASE tp4;

CREATE TABLE IF NOT EXISTS tp4.user (
  id_user INT NOT NULL auto_increment,
  nom VARCHAR(40) NOT NULL,
  prenom VARCHAR(40) NOT NULL,
  password VARCHAR(500) NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_user)
);

CREATE TABLE IF NOT EXISTS tp4.article (
  id_article INT NOT NULL auto_increment,
  nom_article VARCHAR(40) NOT NULL,
  prix int NOT NULL,
  PRIMARY KEY (id_article)
);

CREATE TABLE IF NOT EXISTS tp4.panier (
  id_panier INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_user INT NOT NULL,
  id_article INT NOT NULL,
  quantite INT default 1,
  nom_panier VARCHAR(20) NULL
);

CREATE TABLE IF NOT EXISTS tp4.historique (
  id_panier INT NOT NULL,
  date_achat datetime NOT NULL default now(),
  PRIMARY KEY (id_panier, date_achat)
);

ALTER TABLE tp4.panier add constraint FK_user_panier foreign key (id_user) references tp4.user(id_user) on update cascade on delete restrict;
ALTER TABLE tp4.panier add constraint FK_article_panier foreign key (id_article) references tp4.article(id_article) on update cascade on delete restrict;
ALTER TABLE tp4.historique add constraint FK_panier_historique foreign key (id_panier) references tp4.panier(id_panier) on update cascade on delete restrict;

INSERT INTO tp4.user (nom, prenom, password, email) values ("Dupont", "Pascal", "D65fs6as6za1s6zdzda68","lalalal@gmail.com"),("Dupond", "George", "D65fs6udgziaba6zdzda68", "test@gmail.com"),("Desbois", "Pierre", "LSzdfz5azDFs6zdzda68", "cailloux@gmail.com");
INSERT INTO tp4.article (nom_article, prix) values ("pomme", 1),("Ordinateur", 1000),("steak", 2),("poire", 1),("creme", 2),("television", 500);
INSERT INTO tp4.panier (id_user, id_article,quantite, nom_panier) values (1, 1, 5, "panier1"),(1, 3, 2, "panier1"),(1, 4, 10, "panier1"),(2, 2, 1, "le panier"),(3, 6, 1, "mon panier"),(3, 4, 3, "mon panier"),(3, 1, 1, "mon panier"),(3, 5, 7, "mon panier");
INSERT INTO tp4.historique (id_panier, date_achat) values (1,"2004-05-23T14:25:10"),(2,"2004-05-23T14:25:10"),(3,"2004-05-23T14:25:10"),(4,date(now())),(5,"2015-10-23T16:05:10"),(6,"2015-10-23T16:05:10"),(7,"2015-10-23T16:05:10"),(8,"2015-10-23T16:05:10");