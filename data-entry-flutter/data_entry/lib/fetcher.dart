import 'dart:convert';

import 'package:data_entry/constants.dart';
import 'package:data_entry/user_card.dart';
import 'package:data_entry/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Fetcher extends StatefulWidget {
  @override
  _FetcherState createState() => _FetcherState();
}

class _FetcherState extends State<Fetcher> {
  bool isDataLoaded = false;
  List<User> users = new List<User>();

  fetchData() async {
    setState(() => isDataLoaded = false);

    Response response = await http.post(GET_USERS);

    List<dynamic> allUser = jsonDecode(response.body);

    users.clear();
    allUser.forEach((user) {
      print(user['image']);
      users.add(User.fromMap(user));
    });

    this.mounted ? setState(() => isDataLoaded = true) : null;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: isDataLoaded
            ? ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, index) => UserCard(users[index]))
            : Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 6,
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Loading datas...",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                  if (!isDataLoaded)
                    LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                    ),
                ],
              ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: fetchData,
        child: Icon(Icons.sync),
        heroTag: null,
      ),
    );
  }
}
