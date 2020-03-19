USE beer;

SELECT ventes.NUMERO_TICKET FROM ventes INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE article.ID_ARTICLE = 500;

SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE = "2014-01-15 00:00:00";

SELECT DISTINCT ticket.* FROM ventes INNER JOIN ticket ON ventes.NUMERO_TICKET = ticket.NUMERO_TICKET AND ventes.ANNEE = ticket.ANNEE WHERE ticket.DATE_VENTE BETWEEN "2014-01-15 00:00:00" and "2014-01-17 00:00:00";
