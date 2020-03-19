USE beer;
# 1
SELECT ventes.NUMERO_TICKET FROM ventes INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE article.ID_ARTICLE = 500;
# 2
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE = "2014-01-15 00:00:00";
# 3
SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE BETWEEN "2014-01-15 00:00:00" and "2014-01-17 00:00:00";
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