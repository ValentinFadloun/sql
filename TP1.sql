create database tp1;

CREATE TABLE IF NOT EXISTS tp1.logs (
  id INT NOT NULL auto_increment,
  adresse_ip VARCHAR(40) NOT NULL,
  date_premier_visite DATE NOT NULL,
  date_derniere_visite DATE NOT NULL,
  nb_visite int default 0,
  PRIMARY KEY (id))
ENGINE = InnoDB;

insert into tp1.logs(adresse_ip, date_premier_visite, date_derniere_visite, nb_visite) values	("2001:db8:0:85a3::ac1f:8001", date(now()), date(now()), 1);
update tp1.logs set date_derniere_visite = date(now()), nb_visite = nb_visite+1 where adresse_ip = "2001:db8:0:85a3::ac1f:8001";

set sql_safe_updates = 0;