import sqlite3

class tailleString:
	def __init__(self):
		self.count = 0
	def step(self, value):
		self.count = len(value)
	def finalize(self):
		return self.count

def getAllJournaliste(_nom, _prenom):
	return _nom + " " + _prenom;

def getAllJournalisteBis(_nom):
	return _nom;

def getJournalisteById(_id):
	con = sqlite3.connect("PROJETISI.db")
	cur = con.cursor()

	con.create_function("test", 2, getAllJournaliste)

	res = cur.execute("SELECT test(nom, prenom) FROM journaliste WHERE id = " + str(_id))
	return res.fetchone()

def plusGrandNom(liste):
	print(liste)
	tmp = 0
	for i in liste:
		if len(i[0]) > tmp:
			tmp = len(i[0])
	return tmp

con = sqlite3.connect("PROJETISI.db")
cur = con.cursor()

res = cur.execute("SELECT * FROM article")
print(res.fetchall())

cur.execute("INSERT INTO journaliste (nom, prenom) VALUES ('test', 'jean')")

res = cur.execute("SELECT * FROM journaliste")
print(res.fetchall())

cur.execute("INSERT INTO journaliste (nom, prenom) VALUES ('test', 'jean')")
con.commit()

res = cur.execute("SELECT * FROM journaliste")
print(res.fetchall())

con.create_function("test", 2, getAllJournaliste)

res = cur.execute("SELECT test(nom, prenom) FROM journaliste")
print(res.fetchall())

print(getJournalisteById(5))

con.create_aggregate("countTest", 1, tailleString)
res = cur.execute("SELECT countTest(nom) FROM journaliste")
print(res.fetchone()[0])

con.create_function("testbis", 1, getAllJournalisteBis)
res = cur.execute("SELECT testbis(nom) FROM journaliste")
print(plusGrandNom(res.fetchall()))


