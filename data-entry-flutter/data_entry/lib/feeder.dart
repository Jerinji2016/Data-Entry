import 'dart:convert';

import 'package:data_entry/constants.dart';
import 'package:data_entry/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Feeder extends StatefulWidget {
  @override
  _FeederState createState() => _FeederState();
}

class _FeederState extends State<Feeder> {
  TextEditingController _nameController = new TextEditingController(),
      _idController = new TextEditingController(),
      _phoneController = new TextEditingController(),
      _emailController = new TextEditingController(),
      _imgUrlController = new TextEditingController();

  String idError, nameError, phoneError, emailError, imageError;

  bool isFeedingData = false;

  @override
  void dispose() {
    super.dispose();

    _nameController?.dispose();
    _idController?.dispose();
    _phoneController?.dispose();
    _emailController?.dispose();
    _imgUrlController?.dispose();
  }

  bool validateData() {
    bool hasError = false;

    if (_idController.text.trim().isEmpty) {
      idError = "ID cannot be empty";
      hasError = true;
    }
    if (_nameController.text.isEmpty) {
      nameError = "Name cannot be empty";
      hasError = true;
    }
    if (_phoneController.text.isEmpty) {
      phoneError = "Phone No. cannot be empty";
      hasError = true;
    }
    if (_emailController.text.isEmpty) {
      emailError = "Email cannot be empty";
      hasError = true;
    }
    if (_imgUrlController.text.isEmpty) {
      imageError = "Image URL Cannot be empty";
      hasError = true;
    }
    if (User.validImageUrl(_imgUrlController.text.trim())) {
      imageError = "Image URL not valid!";
      hasError = true;
    }

    if (hasError) setState(() {});
  }

  feedData() async {
    if (!(validateData()) || isFeedingData) return;

    setState(() => isFeedingData = true);

    User user = new User(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        imgUrl: _imgUrlController.text.trim());

    Response r = await http.post(ADD_USER, body: jsonEncode(user.toMap()));
    print(r.body);

    setState(() => isFeedingData = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed Data"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelledTextField(
                      labelText: "ID :",
                      hintText: "Enter a unique ID",
                      controller: _idController,
                      errorText: idError,
                      onChanged: (text) {
                        if (idError != null)
                          setState(() {
                            idError = null;
                          });
                      },
                    ),
                    labelledTextField(
                      labelText: "Name :",
                      hintText: "Enter you name",
                      controller: _nameController,
                      errorText: nameError,
                      onChanged: (text) {
                        if (nameError != null)
                          setState(() {
                            nameError = null;
                          });
                      },
                    ),
                    labelledTextField(
                      labelText: "Phone No. :",
                      hintText: "Enter your phone",
                      controller: _phoneController,
                      errorText: phoneError,
                      onChanged: (text) {
                        if (phoneError != null)
                          setState(() {
                            phoneError = null;
                          });
                      },
                    ),
                    labelledTextField(
                      labelText: "Email :",
                      hintText: "Enter your email",
                      controller: _emailController,
                      errorText: emailError,
                      onChanged: (text) {
                        if (emailError != null)
                          setState(() {
                            emailError = null;
                          });
                      },
                    ),
                    labelledTextField(
                      labelText: "Image Url :",
                      hintText: "Enter an image URL",
                      controller: _imgUrlController,
                      errorText: imageError,
                      onChanged: (text) {
                        if (imageError != null)
                          setState(() {
                            imageError = null;
                          });
                      },
                    ),
                    Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: isFeedingData
                            ? Colors.grey[600]
                            : Colors.green[900],
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: feedData,
                          highlightColor: isFeedingData
                              ? Colors.transparent
                              : Colors.green[500],
                          splashColor: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 20.0),
                            child: Text(
                              isFeedingData ? "Submitting..." : "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (isFeedingData)
              LinearProgressIndicator(
                minHeight: 7,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                backgroundColor: Colors.white,
              )
          ],
        ),
      ),
    );
  }

  Widget labelledTextField({
    @required String labelText,
    TextEditingController controller,
    String errorText,
    String hintText,
    Function onChanged,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                labelText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  errorText: errorText,
                  hintText: hintText,
                ),
                onChanged: onChanged,
              ),
            )
          ],
        ),
      );
}
