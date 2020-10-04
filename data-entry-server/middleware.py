import pymongo
from pymongo import MongoClient
from starlette.middleware import Middleware
from starlette.middleware.base import BaseHTTPMiddleware
import ssl

CLUSTER_URL = "mongodb+srv://jerinji2016:zr6LE5B1Ia1y1lKc@datas.p07cg.mongodb.net/data_entry?retryWrites=true&w=majority"
DATABASE = "data_entry"
COLLECTION = "users"


class DatabaseMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        cluster = MongoClient(CLUSTER_URL, ssl_cert_reqs=ssl.CERT_NONE)
        db = cluster[DATABASE]
        request.state.db = db
        response = await call_next(request)
        return response

middleware = [
    Middleware(DatabaseMiddleware)
]