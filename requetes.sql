SELECT journaliste_id, COUNT(article_id) FROM article_journaliste GROUP BY journaliste_id;
SELECT journaliste.nom, journaliste.prenom, COUNT(article_journaliste.article_id) FROM article_journaliste INNER JOIN journaliste ON article_journaliste.journaliste_id = journaliste.id GROUP BY journaliste_id;
SELECT journaliste.nom, journaliste.prenom, COUNT(article_journaliste.article_id) AS nbArticle FROM article_journaliste INNER JOIN journaliste ON article_journaliste.journaliste_id = journaliste.id GROUP BY journaliste_id ORDER BY nbArticle;
SELECT journaliste.nom, journaliste.prenom, COUNT(article_journaliste.article_id) AS nbArticle FROM journaliste INNER JOIN article_journaliste ON article_journaliste.journaliste_id = journaliste.id INNER JOIN article ON article_journaliste.article_id = article.id INNER JOIN rubrique ON article.rubrique_id = rubrique.id  WHERE rubrique.nom = "tech" GROUP BY journaliste_id ORDER BY nbArticle;
DELETE FROM article WHERE article.id IN (SELECT article.id FROM article INNER JOIN rubrique ON article.rubrique_id = rubrique.id INNER JOIN article_journaliste ON article_journaliste.article_id = article.id  WHERE rubrique.nom = 'tech' AND article_journaliste.journaliste_id = 10);

