import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        // image: DecorationImage(
        //     image: AssetImage('asset/chit_chat_back.JPG'),
        //     fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: 'logo',
                    child: Container(
                        child: Image.asset('asset/chit_chat_logo.png'))),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Chit',
                  style: TextStyle(color: Colors.orange, fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
                child: Text('Start Chatting!'))
          ],
        ),
      ),
    );
  }
}
