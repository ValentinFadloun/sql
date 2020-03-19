USE beer;
# 1
SELECT ventes.NUMERO_TICKET FROM ventes WHERE ventes.ID_ARTICLE = 500;
# 2
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE = "2014-01-15 00:00:00";
# 3
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE = "2014-01-15 00:00:00" and ticket.DATE_VENTE = "2014-01-17 00:00:00";
# 4
SELECT article.* FROM article INNER JOIN ventes ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE ventes.QUANTITE >= 50 ;
# 5
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE LIKE "2014-03-%";
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
SELECT NUMERO_TICKET, SUM(QUANTITE) as quantitetotal FROM ventes GROUP BY NUMERO_TICKET HAVING quantitetotal >= 500 ORDER BY NUMERO_TICKET DESC;
# 12
SELECT NUMERO_TICKET, SUM(QUANTITE) as quantitetotal FROM ventes WHERE QUANTITE < 50 GROUP BY NUMERO_TICKET HAVING quantitetotal >= 500 ORDER BY NUMERO_TICKET DESC;
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
SELECT ventes.ANNEE, ventes.NUMERO_TICKET, SUM(article.PRIX_ACHAT+(article.PRIX_ACHAT*(15/100))) FROM ventes 
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE GROUP BY ventes.NUMERO_TICKET, ventes.ANNEE;
# 17
SELECT ventes.ANNEE, SUM(article.PRIX_ACHAT) as CA, SUM(article.PRIX_ACHAT+(article.PRIX_ACHAT*(15/100))) as CA15 FROM ventes 
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
SELECT pays.NOM_PAYS FROM article 
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