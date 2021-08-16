import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Createlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.green[400]), home: Login());
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: _Loginform(),
    );
  }
}

class _Loginform extends StatefulWidget {
  @override
  __LoginformState createState() => __LoginformState();
}

class __LoginformState extends State<_Loginform> {
  String s1 = '';
  String s2 = '';
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            
            margin: EdgeInsets.all(12),
            
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  //key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          width: 350,
                          child: TextField(
                              onChanged: (value) {
                                s1 = value;
                              },
                              decoration:
                                  InputDecoration(hintText: 'Email'))),
                      SizedBox(
                          width: 350,
                          
                          child: TextField(
                              onChanged: (value) {
                                s2 = value;
                              },
                              decoration:
                                  InputDecoration(hintText: 'Password'))),
                      FlatButton(
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            Firebase.initializeApp();
                            __validate(context, s1, s2);
                          },
                          color: Colors.green[400],
                          child: Text('Submit'))
                      //PasswordWidget
                      //SubmitButton
                    ],
                  ),
                )
              ],
            )));
  }
}

Future<void> __validate(BuildContext context, String un, String pw) async {
  try {
    
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: un, password: pw);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListItems()));
  } catch (e) {
    print(e);
  }
}
