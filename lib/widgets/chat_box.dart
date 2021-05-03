import 'package:flutter/material.dart';

Widget chatBox(String sender, String message, String currentUser) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
        child: Column(
      crossAxisAlignment: sender == currentUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: sender == currentUser
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              sender == currentUser ? 'You' : '\'$sender\' says',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        Material(
          borderRadius: sender == currentUser
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0))
              : BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
          elevation: 5.0,
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ],
    )),
  );
}
