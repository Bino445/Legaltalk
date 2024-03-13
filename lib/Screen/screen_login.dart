import 'dart:async';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/register.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/profile.dart';

class Screen_login extends StatefulWidget {
  const Screen_login({super.key});

  @override
  State<Screen_login> createState() => _Screen_loginState();

}


class _Screen_loginState extends State<Screen_login> {
  //Profile profile = Profile();
  final formKey = GlobalKey<FormState>();
  final TextEditingController Username = TextEditingController();
  final TextEditingController Password = TextEditingController();
  bool passwordVisible = false;
  String currentUser = "";


  void initState() {
    super.initState();
    passwordVisible = true;

  } //password visible
  void checkUsernameAndPassword() async {
    await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instance;
    final Users = Username.text;
    final Pass = Password.text;

    Stream<QuerySnapshot> snapshots = firestore.collection('User').where('User', isEqualTo: Users).snapshots();
    //Stream<QuerySnapshot> snapshots = firestore.collection('User').snapshots();

    snapshots.listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc['User'.toString()] == Users && doc['Password'].toString() == Pass) {
          String uid= doc.id;
          Profile.setUid(uid);
          Profile.setUsername(Users);
          currentUser = doc['User'.toString()];
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (context) => MainScreen(MyCurrentIndex: 0,)));
          break;
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ไม่พบบัญชีผู้ใช้ กรุณากรอกใหม่ให้ถูกต้อง',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Color(0xFF1C243C),
            ),
          );
          break;
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfbfbfb),
      body: SingleChildScrollView(
        child: Padding(
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
                  /*validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  }*/
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
                Padding(padding: const EdgeInsets.only(top: 20)),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 20)),
                SizedBox(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        checkUsernameAndPassword();
                  },
                    style: ElevatedButton.styleFrom(
                        //primary: Color(0xFFD1B06B), //background color of button
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(50)
                        ),
                        padding: EdgeInsets.all(20) //content padding inside button
                    ),
                      icon: Icon(Icons.login, color: Colors.white,),
                      label: Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(fontSize: 20,
                            color: Colors.white,
        
                          ),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}