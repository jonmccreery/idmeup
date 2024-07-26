from flask import Flask
from datetime import datetime
import MySQLdb

app = Flask(__name__)

def create_one_row():
    now = datetime.now()
    db = MySQLdb.connect(host="db",
                     user="idmeup",
                     passwd="password",
                     db="idmeup")

    cur = db.cursor()
    cur.execute("INSERT INTO idmeup (time) values ('{}')".format(now.strftime("%Y-%m-%d %H:%M:%S")))
    db.commit()

@app.route("/")
def hello_world():
    create_one_row()
    return "<p>Hello, World!</p>"
