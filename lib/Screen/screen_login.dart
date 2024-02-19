import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Login'),
      ),
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
              SizedBox(height: 10.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.login), label: Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 20))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
