from flask import Flask

from ohd_logging import OHD_FIELDS, OHDLogMiddleware

app = Flask(__name__)
app.wsgi_app = OHDLogMiddleware(app.wsgi_app, "/tmp/ohd-access.tsv")


@app.get("/")
def index():
    return "ok\n"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
