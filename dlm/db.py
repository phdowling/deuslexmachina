import psycopg2
from dlm.model import Employee

db = psycopg2.connect("host=localhost port=5432 user=redash password=XXXXXXX dbname=enron")


def get_all_employees():
    cur = db.cursor()
    cur.execute("select * from employees;")
    return [Employee(*row)._asdict() for row in cur.fetchall()]


