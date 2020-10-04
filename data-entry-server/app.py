from starlette.applications import Starlette
from starlette.routing import Route
from starlette.responses import JSONResponse
from middleware import middleware
import pymongo
from pymongo import MongoClient
import urllib.parse as urlparse
from urllib.parse import parse_qs
import json


#   =========================================================
#   Add User to Database
async def addData(request):
    data = (await request.body()).decode()
    data = data[5:]
    user = json.loads(data)

    # user is an "Associate array in PHP" or like a "Map" in Java or Dart
    request.state.db.users.insert_one({
        "_id": user['id'],
        "name": user['name'],
        "phone": user['phone'],
        "email": user['email'],
        "image": user['imageURL']
    })
    print("Data inserted")
    return JSONResponse({'result': True})


#   =========================================================
#   Get all users from database
async def fetchUsers(request):
    print('Fetching data from db...')
    allUsers = request.state.db.users.find()

    l = []
    for user in allUsers:
        l.append(user)

    return JSONResponse(l)


#   =========================================================
#   Check if the id in paramter is unique
async def checkIdAvailablility(request):
    id = (await request.body()).decode()
    print(id)
    return JSONResponse({'available': True})


routes = [
    Route('/add', addData, methods=["GET", "POST"]),
    Route('/check-availability', checkIdAvailablility,
          methods=["GET", "POST"]),
    Route('/get-users', fetchUsers, methods=["GET", "POST"])
]

app = Starlette(debug=True, routes=routes, middleware=middleware)
