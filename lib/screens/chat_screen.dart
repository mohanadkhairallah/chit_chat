import 'package:chit_chat/modules/myUser.dart';
import 'package:chit_chat/services/auth.dart';
import 'package:chit_chat/services/database.dart';
import 'package:chit_chat/widgets/chat_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _database = DatabaseService();
  final messageTextController = TextEditingController();
  String messageText;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    print(DatabaseService().chatCollection);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'logo',
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset('asset/chit_chat_logo2.png'),
                        ),
                      ),
                      Text(
                        'hit',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 30,
                            fontFamily: 'Dancing'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(
                            fontFamily: 'Dancing',
                            color: Colors.lightBlue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0.0),),
                    onPressed: () async {
                    await _auth.signOut();
                  },
                  icon:Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ), label: Text(''),),

                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseService().chatCollectionsSorted.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data.docs.reversed;
                List<Widget> messagesList = [];

                final user = Provider.of<MyUser>(context);

                for (var message in messages) {
                  final messageBody = message.data();
                  final messageBox =
                      chatBox(messageBody['sender'], messageBody['message'], user.email);

                  messagesList.add(messageBox);
                }
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.none,
                        image: AssetImage('asset/Chit chat background.jpg'),
                      ),
                    ),
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messagesList,
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type Your message here !',
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 2.0),
                          ),
                        ),
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all(0.0)),
                    onPressed: () async {
                      messageTextController.clear();
                      User sender = await _database.getCurrentUser();
                      await _database.addNewMessage(sender.email, messageText);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.lightBlue,
                    ),
                    label: Text(''),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
