from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv
import routes

load_dotenv()

app = Flask(__name__)
CORS(app)

app.register_blueprint(routes.api)

if __name__ == "__main__":
    app.run(debug=True)