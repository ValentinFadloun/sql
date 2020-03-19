USE beer;

SELECT ventes.NUMERO_TICKET FROM ventes INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE article.ID_ARTICLE = 500;