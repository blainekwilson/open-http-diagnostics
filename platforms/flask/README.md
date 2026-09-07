# Flask

Flask is a Python WSGI application framework rather than an HTTP server. This
mapping covers Flask request handling and WSGI middleware; the deployment
server, such as Gunicorn, uWSGI, or Waitress, should be mapped separately when
its own access logs are used.

| OHD level | Status | Method |
|---|---|---|
| 1 | Planned | WSGI middleware or structured application logging |
| 2 | Planned | Flask or WSGI middleware using W3C Trace Context |
| 3 | Planned | Flask or WSGI middleware |
| 4 | Application-specific | Selective diagnostics by the application or hosting environment |

The [Flask implementation](../../implementations/flask/README.md) is the
planned reference path. Start with [Level 1](level-1.md).
