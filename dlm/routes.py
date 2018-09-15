from flask import jsonify

from dlm.db import get_all_employees
from dlm.server import app


@app.route("/employees")
def all_employees_endpoint():
    return jsonify(get_all_employees())