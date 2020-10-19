import 'package:data_entry/user_modal.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;
  UserCard(this.user);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(10.0),
        child: Material(
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(100.0),
                    elevation: 8.0,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        image: User.validImageUrl(user.imgUrl)
                            ? DecorationImage(
                                image: NetworkImage(user.imgUrl),
                                fit: BoxFit.cover)
                            : null,
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(color: Colors.grey[300], width: 3.0),
                      ),
                      child: User.validImageUrl(user.imgUrl)
                          ? null
                          : Center(
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            user.id,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.email_outlined,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    user.email,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.phone_android,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(user.phone),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    elevation: 10.0,
                    color: Colors.red[700],
                    child: InkWell(
                      onTap: () => deleteAction(user.id, context),
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void deleteAction(id, context) async {
    bool confirm = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text("Confirm Delete"),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "Are your sure you want to delete this user? This action is irreversible!",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      color: Colors.red[700],
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Container(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: FlatButton(
                      color: Colors.green[700],
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Container(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
