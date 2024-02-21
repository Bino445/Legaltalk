import 'dart:async';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/register.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen_login extends StatefulWidget {
  const Screen_login({super.key});

  @override
  State<Screen_login> createState() => _Screen_loginState();

}


class _Screen_loginState extends State<Screen_login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController Username = TextEditingController();
  final TextEditingController Password = TextEditingController();
  bool passwordVisible = false;


  void initState() {
    super.initState();
    passwordVisible = true;

  } //password visible
  void checkUsernameAndPassword() async {
    await Firebase.initializeApp();

    final firestore = FirebaseFirestore.instance;
    final Users = Username.text;
    final Pass = Password.text;

    //Stream<QuerySnapshot> snapshots = firestore.collection('User').where('User', isEqualTo: Users).snapshots();
    Stream<QuerySnapshot> snapshots = firestore.collection('User').snapshots();

    snapshots.listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc['User'.toString()] == Users && doc['Password'].toString() == Pass) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (
              context)
          {
            return MainScreen();
          }));
        }
      }
    });
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFFfbfbfb),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/logotext.png",
                  height: 150.0,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: Username,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(

                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  obscureText: passwordVisible,
                  controller: Password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    }
                  ),

                ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenRegister(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'hero',
                    child: Text(
                      "ยังไม่ได้เป็นสมาชิกใช่ไหม? สมัครเลยตอนนี้",
                      style: TextStyle(color: Color(0xFF1C243C)),
                    ),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton.icon(onPressed: () {
                    checkUsernameAndPassword();

                  },
                      icon: Icon(Icons.login),
                      label: Text(
                          "เข้าสู่ระบบ", style: TextStyle(fontSize: 20))),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }