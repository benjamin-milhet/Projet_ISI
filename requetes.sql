SELECT journaliste_id, COUNT(article_id) FROM article_journaliste GROUP BY journaliste_id;

SELECT journaliste.nom, journaliste.prenom, COUNT(article_journaliste.article_id) FROM article_journaliste INNER JOIN journaliste ON article_journaliste.journaliste_id = journaliste.id GROUP BY journaliste_id;

SELECT journaliste.nom, journaliste.prenom, COUNT(article_journaliste.article_id) AS nbArticle FROM article_journaliste INNER JOIN journaliste ON article_journaliste.journaliste_id = journaliste.id GROUP BY journaliste_id ORDER BY nbArticle;

SELECT journaliste.nom, journaliste.prenom, COUNT(article_journaliste.article_id) AS nbArticle FROM journaliste INNER JOIN article_journaliste ON article_journaliste.journaliste_id = journaliste.id INNER JOIN article ON article_journaliste.article_id = article.id INNER JOIN rubrique ON article.rubrique_id = rubrique.id  WHERE rubrique.nom = "tech" GROUP BY journaliste_id ORDER BY nbArticle;

DELETE FROM article WHERE article.id IN (SELECT article.id FROM article INNER JOIN rubrique ON article.rubrique_id = rubrique.id INNER JOIN article_journaliste ON article_journaliste.article_id = article.id  WHERE rubrique.nom = 'tech' AND article_journaliste.journaliste_id = 10);

SELECT *, COUNT(article.id) FROM journaliste INNER JOIN article_journaliste ON article_journaliste.journaliste_id = journaliste.id INNER JOIN article ON article_journaliste.article_id = article.id INNER JOIN rubrique ON article.rubrique_id = rubrique.id WHERE rubrique.nom = 'tech' GROUP BY journaliste.id HAVING COUNT(article.id) > 30;

SELECT *, COUNT(article.id) FROM rubrique INNER JOIN article ON article.rubrique_id = rubrique.id INNER JOIN article_journaliste ON article_journaliste.article_id = article.id GROUP BY article_journaliste.journaliste_id, rubrique.id;

CREATE VIEW articles_tech (id_article, id_rubrique, titre, rubrique)
AS SELECT article.id, rubrique.id, article.titre, rubrique.nom FROM article INNER JOIN rubrique ON article.rubrique_id = rubrique.id WHERE rubrique.nom = 'tech' LIMIT 10;

SELECT DISTINCT(article_journaliste.journaliste_id) FROM article_journaliste INNER JOIN article ON article_journaliste.article_id = article.id WHERE article.rubrique_id = (SELECT rubrique.id FROM rubrique WHERE rubrique.nom = 'tech') ORDER BY article_journaliste.journaliste_id;

SELECT DISTINCT(article_journaliste.journaliste_id) FROM article_journaliste INNER JOIN articles_tech ON article_journaliste.article_id = articles_tech.id_article WHERE articles_tech.id_rubrique = (SELECT id_rubrique FROM articles_tech WHERE articles_tech.rubrique = 'tech') ORDER BY article_journaliste.journaliste_id;

SELECT DISTINCT(article_journaliste.journaliste_id) FROM article_journaliste INNER JOIN articles_tech ON article_journaliste.article_id = articles_tech.id_article WHERE articles_tech.rubrique = 'tech' ORDER BY article_journaliste.journaliste_id;

CREATE TABLE nb_articles_par_rubrique AS 
SELECT rubrique.nom as nomrubrique, COUNT(article.id) as nbArticle 
FROM rubrique INNER JOIN article ON article.rubrique_id = rubrique.id 
GROUP BY rubrique.nom;

/* Ne marche pas */
CREATE TRIGGER updateTableInsert
AFTER INSERT OR UPDATE OR DELETE
ON article FOR EACH ROW
UPDATE nb_articles_par_rubrique SET nomrubrique,nbArticle AS SELECT rubrique.nom as nomrubrique, COUNT(article.id) as nbArticle 
FROM rubrique INNER JOIN article ON article.rubrique_id = rubrique.id 
GROUP BY rubrique.nom; 

