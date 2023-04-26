CREATE TABLE IF NOT EXISTS journaliste (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  prenom TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rubrique (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS article (
  id INTEGER PRIMARY KEY,
  titre TEXT NOT NULL,
  rubrique_id INTEGER NOT NULL,
  FOREIGN KEY (rubrique_id) REFERENCES rubrique(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS article_journaliste (
  article_id INTEGER NOT NULL,
  journaliste_id INTEGER NOT NULL,
  PRIMARY KEY (article_id, journaliste_id),
  FOREIGN KEY (article_id) REFERENCES article(id) ON DELETE CASCADE,
  FOREIGN KEY (journaliste_id) REFERENCES journaliste(id) ON DELETE CASCADE
);
