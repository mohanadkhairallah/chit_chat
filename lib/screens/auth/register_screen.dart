import 'package:chit_chat/services/auth.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  String nickname = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Hero(
                tag: 'logo',
                child: Image.asset('asset/chit_chat_logo2.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chit',
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 75,
                        fontFamily: 'Dancing'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dancing'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Your nickname'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter Your nickname' : null,
                        onChanged: (val) {
                          setState(() => nickname = val);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Your Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Your Password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Navigator.pop(context);
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            Navigator.pop(context);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('I already have an account!'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

