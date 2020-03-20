USE beer;
# 1
SELECT ventes.NUMERO_TICKET FROM ventes WHERE ventes.ID_ARTICLE = 500;
# 2
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE = "2014-01-15 00:00:00";
# 3
SELECT * FROM ticket WHERE DATE_VENTE = "2014-01-15 00:00:00" or DATE_VENTE = "2014-01-17 00:00:00";
# 4
SELECT article.* FROM article INNER JOIN ventes ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE ventes.QUANTITE >= 50 ;
# 5
SELECT DISTINCT ticket.* FROM ticket WHERE ticket.DATE_VENTE LIKE "2014-03-%";
SELECT DISTINCT ticket.* FROM ticket WHERE month(DATE_VENTE) = "03" and annee = "2014";
# 6
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE BETWEEN "2014-03-01 00:00:00" AND "2014-04-30 00:00:00";
# 7
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE LIKE "2014-03-%" OR ticket.DATE_VENTE LIKE "2014-06-%";
# 8 j'affiche aussi le nom de la couleur pour que on vois bien que c'est classé 
SELECT article.ID_ARTICLE, article.NOM_ARTICLE, couleur.NOM_COULEUR FROM article INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur ORDER BY couleur.NOM_COULEUR;
# 8 sans le nom de couleur
SELECT article.ID_ARTICLE, article.NOM_ARTICLE FROM article INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur ORDER BY couleur.NOM_COULEUR;
# 9
SELECT ID_ARTICLE, NOM_ARTICLE FROM article WHERE ID_Couleur IS NULL;
# 10
SELECT NUMERO_TICKET, SUM(QUANTITE) FROM ventes GROUP BY NUMERO_TICKET ORDER BY NUMERO_TICKET DESC;
# 11
SELECT NUMERO_TICKET, SUM(QUANTITE) as quantitetotal FROM ventes GROUP BY NUMERO_TICKET HAVING quantitetotal > 500 ORDER BY NUMERO_TICKET DESC;
# 12
SELECT NUMERO_TICKET, SUM(QUANTITE) as quantitetotal FROM ventes WHERE QUANTITE < 50 GROUP BY NUMERO_TICKET HAVING quantitetotal > 500 ORDER BY NUMERO_TICKET DESC;
# 13
SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, article.TITRAGE FROM article INNER JOIN type ON type.ID_TYPE = article.ID_TYPE WHERE type.NOM_TYPE = "Trappiste";
# 14
SELECT marque.* FROM  marque 
INNER JOIN pays ON pays.ID_PAYS = marque.ID_PAYS 
INNER JOIN continent ON continent.ID_CONTINENT = pays.ID_CONTINENT
WHERE continent.NOM_CONTINENT = "Afrique";
# 15
SELECT article.* FROM article 
INNER JOIN marque ON marque.ID_MARQUE = article.ID_MARQUE 
INNER JOIN pays ON pays.ID_PAYS = marque.ID_PAYS 
INNER JOIN continent ON continent.ID_CONTINENT = pays.ID_CONTINENT
WHERE continent.NOM_CONTINENT = "Afrique";
# 16 
SELECT ventes.ANNEE, ventes.NUMERO_TICKET, ROUND(SUM((article.PRIX_ACHAT+(article.PRIX_ACHAT*(15/100)))*ventes.QUANTITE)) FROM ventes 
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE GROUP BY ventes.NUMERO_TICKET, ventes.ANNEE;
# 17
SELECT ventes.ANNEE, ROUND(SUM(article.PRIX_ACHAT)*ventes.QUANTITE) as CA, ROUND(SUM(article.PRIX_ACHAT*1.15)*ventes.QUANTITE) as CA15 FROM ventes 
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE GROUP BY ventes.ANNEE;
# 18
SELECT article.NOM_ARTICLE, SUM(ventes.QUANTITE) FROM ventes INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE WHERE ventes.ANNEE = 2016 GROUP BY article.NOM_ARTICLE;
# 19
SELECT ventes.ANNEE, article.NOM_ARTICLE, SUM(ventes.QUANTITE) FROM ventes INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE GROUP BY article.NOM_ARTICLE,ventes.ANNEE;
# 20
SELECT NOM_ARTICLE from article 
WHERE NOM_ARTICLE NOT IN (SELECT article.NOM_ARTICLE FROM ventes 
							INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE 
							WHERE ventes.ANNEE = 2014 GROUP BY article.NOM_ARTICLE) 
group by NOM_ARTICLE;
# 21 - 1
SELECT DISTINCT pays.NOM_PAYS FROM article 
INNER JOIN type ON type.ID_TYPE = article.ID_TYPE
INNER JOIN marque ON marque.ID_MARQUE = article.ID_MARQUE
INNER JOIN pays ON pays.ID_PAYS = marque.ID_PAYS
WHERE type.NOM_TYPE = "Trappiste";
# 21 - 2
SELECT DISTINCT pays.NOM_PAYS FROM pays
INNER JOIN marque ON marque.ID_PAYS = pays.ID_PAYS
WHERE marque.ID_MARQUE IN (SELECT marque.ID_MARQUE FROM marque 
							INNER JOIN article ON marque.ID_MARQUE = article.ID_MARQUE
                            INNER JOIN type ON type.ID_TYPE = article.ID_TYPE
							WHERE type.NOM_TYPE = "Trappiste");
# 21 - 3
SELECT DISTINCT pays.NOM_PAYS FROM pays
INNER JOIN marque ON marque.ID_PAYS = pays.ID_PAYS
WHERE marque.ID_MARQUE IN (SELECT marque.ID_MARQUE FROM marque 
							INNER JOIN article ON marque.ID_MARQUE = article.ID_MARQUE
                            WHERE article.ID_ARTICLE IN (SELECT article.ID_ARTICLE FROM article
															INNER JOIN type ON type.ID_TYPE = article.ID_TYPE
															WHERE type.NOM_TYPE = "Trappiste"));
# 22
SELECT DISTINCT ticket.* FROM ticket 
INNER JOIN ventes ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE
WHERE ventes.ID_ARTICLE IN (SELECT ID_ARTICLE FROM ventes WHERE NUMERO_TICKET = 856 AND ANNEE = 2014);
# 23
SELECT NOM_ARTICLE, TITRAGE FROM article WHERE TITRAGE > (SELECT MAX(article.TITRAGE) FROM article
													INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
                                                    WHERE type.NOM_TYPE = "Trappiste");
# 24
SELECT SUM(ventes.QUANTITE), couleur.NOM_COULEUR FROM article
INNER JOIN ventes ON ventes.ID_ARTICLE = article.ID_ARTICLE
INNER JOIN couleur ON couleur.ID_Couleur = article.ID_Couleur
WHERE ventes.ANNEE = 2014
GROUP BY couleur.NOM_COULEUR;
# 25
SELECT fabricant.NOM_FABRICANT, COUNT(DISTINCT ventes.NUMERO_TICKET) FROM fabricant
INNER JOIN marque ON fabricant.ID_FABRICANT = marque.ID_FABRICANT
INNER JOIN article ON marque.ID_MARQUE = article.ID_MARQUE
INNER JOIN ventes USING(ID_ARTICLE)
WHERE ventes.ANNEE = 2014
GROUP BY fabricant.NOM_FABRICANT;
# 26
SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, SUM(ventes.QUANTITE) as quantitet FROM article
INNER JOIN ventes ON article.ID_ARTICLE = ventes.ID_ARTICLE
WHERE ventes.ANNEE = 2016
GROUP BY article.NOM_ARTICLE ORDER BY quantitet DESC LIMIT 20;
# 27
SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, SUM(ventes.QUANTITE) as quantite FROM article
INNER JOIN ventes ON article.ID_ARTICLE = ventes.ID_ARTICLE
INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
WHERE ventes.ANNEE = 2016 AND type.NOM_TYPE = "Trappiste"
GROUP BY article.NOM_ARTICLE ORDER BY quantite DESC LIMIT 5;
# 28
SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, quantite2015.quantite2015 as quantite_2015, quantite2016.quantite2016 as quantite_2016 FROM article
INNER JOIN (SELECT ventes.ID_article as id_art ,SUM(ventes.QUANTITE) as quantite2015 FROM ventes
			WHERE ventes.ANNEE = 2015
			GROUP BY ventes.ID_ARTICLE) as quantite2015 ON quantite2015.id_art = article.ID_ARTICLE
INNER JOIN (SELECT ventes.ID_article as id_art ,SUM(ventes.QUANTITE) as quantite2016 FROM ventes
			WHERE ventes.ANNEE = 2016
			GROUP BY ventes.ID_ARTICLE) as quantite2016 ON quantite2016.id_art = article.ID_ARTICLE AND quantite2016.id_art = quantite2015.id_art
WHERE (((quantite2016.quantite2016-quantite2015.quantite2015)/quantite2016.quantite2016)*100 BETWEEN -1 AND 1 );
# 29
SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, quantite2015.quantite2015 as quantite_2015, quantite2016.quantite2016 as quantite_2016 , ((quantite2016.quantite2016-quantite2015.quantite2015)) as variation ,(((quantite2016.quantite2016-quantite2015.quantite2015)/quantite2015.quantite2015)*100) as variationPct  FROM article
INNER JOIN (SELECT ventes.ID_article as id_art ,SUM(ventes.QUANTITE) as quantite2015 FROM ventes
			WHERE ventes.ANNEE = 2015
			GROUP BY ventes.ID_ARTICLE) as quantite2015 ON quantite2015.id_art = article.ID_ARTICLE
INNER JOIN (SELECT ventes.ID_article as id_art ,SUM(ventes.QUANTITE) as quantite2016 FROM ventes
			WHERE ventes.ANNEE = 2016
			GROUP BY ventes.ID_ARTICLE) as quantite2016 ON quantite2016.id_art = article.ID_ARTICLE AND quantite2016.id_art = quantite2015.id_art
ORDER BY ((quantite2016.quantite2016-quantite2015.quantite2015)) DESC;
# 30
SELECT * from ticket WHERE NUMERO_TICKET NOT IN (SELECT NUMERO_TICKET FROM ventes);
SELECT * FROM ticket WHERE CONCAT(NUMERO_TICKET,ANNEE) NOT IN (SELECT CONCAT(NUMERO_TICKET,ANNEE) FROM ventes);
# 31
SELECT article.*,SUM(ventes.QUANTITE) FROM article
INNER JOIN ventes USING(ID_ARTICLE)
WHERE ventes.ANNEE = 2016 
GROUP BY article.ID_ARTICLE
HAVING SUM(ventes.QUANTITE) >= (SELECT SUM(QUANTITE-(QUANTITE*15/100)) as quantite FROM ventes
									WHERE ANNEE = 2016 GROUP BY ID_ARTICLE ORDER BY quantite DESC LIMIT 1);
# 32
UPDATE article INNER JOIN type USING(ID_TYPE) INNER JOIN couleur ON couleur.ID_Couleur = article.ID_COULEUR
SET article.PRIX_ACHAT = article.PRIX_ACHAT+(article.PRIX_ACHAT*10/100) 
WHERE type.NOM_TYPE = "Trappiste" AND couleur.NOM_COULEUR = "Blonde";
# 32 select test
SELECT article.PRIX_ACHAT+(article.PRIX_ACHAT*10/100), article.PRIX_ACHAT FROM article
INNER JOIN type USING(ID_TYPE)
INNER JOIN couleur ON couleur.ID_Couleur = article.ID_COULEUR
WHERE type.NOM_TYPE = "Trappiste" AND couleur.NOM_COULEUR = "Blonde";
# 33
UPDATE article as art
INNER JOIN type USING(ID_TYPE)
INNER JOIN couleur USING(ID_Couleur)
INNER JOIN (SELECT MIN(TITRAGE) as newtitrage, ID_TYPE, ID_Couleur FROM article GROUP BY ID_TYPE, ID_Couleur ) as arti ON arti.ID_TYPE = type.ID_TYPE
SET art.TITRAGE = arti.newtitrage
WHERE art.TITRAGE IS NULL AND arti.ID_TYPE = art.ID_TYPE AND arti.ID_Couleur = art.ID_Couleur;
# 33 requete test
SELECT art.*, (SELECT MIN(article.TITRAGE) FROM article 
				INNER JOIN type USING(ID_TYPE)
				INNER JOIN couleur USING(ID_Couleur)
				WHERE type.ID_TYPE = art.ID_TYPE and couleur.ID_Couleur = art.ID_Couleur) FROM article as art;
SELECT MIN(TITRAGE) as newtitrage, ID_TYPE, ID_Couleur FROM article GROUP BY ID_TYPE, ID_Couleur ORDER BY ID_TYPE, ID_Couleur;
SELECT * FROM article WHERE TITRAGE IS NULL;
# 34 
DELETE art FROM article as art
INNER JOIN type as ty USING(ID_TYPE)
WHERE ty.NOM_TYPE = "Bière Aromatisée";

SELECT * FROM article INNER JOIN type as ty USING(ID_TYPE)
WHERE ty.NOM_TYPE = "Bière Aromatisée";
# 35
DELETE FROM ticket WHERE NUMERO_TICKET NOT IN (SELECT NUMERO_TICKET FROM ventes);
SELECT * from ticket WHERE NUMERO_TICKET NOT IN (SELECT NUMERO_TICKET FROM ventes);

SELECT  QUANTITE, NUMERO_TICKET, ANNEE
 FROM beer.ventes
ORDER BY QUANTITE DESC;


SELECT ventes.ANNEE, ventes.NUMERO_TICKET, SUM(article.PRIX_ACHAT*1.15) as PRIX_VENTE FROM ticket
INNER JOIN ventes ON ventes.ANNEE = ticket.ANNEE AND ticket.NUMERO_TICKET = ventes.NUMERO_TICKET
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE
GROUP BY ticket.NUMERO_TICKET, ticket.ANNEE;

SELECT ventes.ANNEE, ventes.NUMERO_TICKET, ROUND(SUM((article.PRIX_ACHAT+(article.PRIX_ACHAT*(15/100)))*ventes.QUANTITE)) FROM ventes 
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE GROUP BY ventes.NUMERO_TICKET, ventes.ANNEE;

