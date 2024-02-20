import 'package:flutter/material.dart';
import 'package:futer/Screen/register.dart';
import 'package:futer/Screen/screen_main.dart';

class Screen_login extends StatefulWidget {
  const Screen_login({super.key});

  @override
  State<Screen_login> createState() => _Screen_loginState();
}

class _Screen_loginState extends State<Screen_login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfbfbfb),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                height: 150.0,
              ),
              SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
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
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MainScreen();
                  }));
                }, icon: Icon(Icons.login), label: Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 20))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
