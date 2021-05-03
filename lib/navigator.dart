import 'package:chit_chat/screens/auth/login_screen.dart';
import 'package:chit_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/myUser.dart';

class Navi extends StatefulWidget {
  @override
  _NaviState createState() => _NaviState();
}

class _NaviState extends State<Navi> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    if (user == null) {
      return LoginScreen();
    } else {
      return ChatScreen();
    }
  }




}


