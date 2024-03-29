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
#   Delete User based on user_id (_id)
async def deleteUser(request):
    user_id = (await request.body()).decode()
    print("Deleteing user ", user_id)
    query = {"_id": user_id}

    request.state.db.users.delete_one(query)
    print("Delete successfull")

    return JSONResponse({"result": True})



#   =========================================================
#   Check if the id in paramter is unique
async def checkIdAvailablility(request):
    id = (await request.body()).decode()
    print(id)
    return JSONResponse({'available': True})


routes = [
    Route('/add', addData, methods=["POST"]),
    Route('/check-availability', checkIdAvailablility,
          methods=["POST"]),
    Route('/get-users', fetchUsers, methods=["GET"]),
    Route('/delete-user', deleteUser, methods=["POST"])
]

app = Starlette(debug=True, routes=routes, middleware=middleware)
