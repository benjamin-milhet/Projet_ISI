import sqlite3

# Exercice 1
def lower_tag(_tag):
    return _tag.lower()

con = sqlite3.connect("examen.db")
cur = con.cursor()

con.create_function("lower_tag", 1, lower_tag)
res = cur.execute("SELECT * FROM tags WHERE lower_tag(tag) LIKE '%funny%'")
print(res.fetchall())

#Exerice 2
class smallest_tag: 
    def __init__(self):
        self.count = 10000000
        self.tag = ""
    def step(self, value):
        if self.count > len(value):
            self.count = len(value)
            self.tag = value
    def finalize(self):
        return self.tag
    
con.create_aggregate("smallest_tag", 1, smallest_tag)
res = cur.execute("SELECT smallest_tag(tag) FROM tags")
print(res.fetchone()[0])

