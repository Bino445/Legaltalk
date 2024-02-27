import 'package:flutter/material.dart';

class Screen_Privacy extends StatefulWidget {
  const Screen_Privacy({super.key});

  @override
  State<Screen_Privacy> createState() => _Screen_PrivacyState();
}

class _Screen_PrivacyState extends State<Screen_Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded,), disabledColor: Colors.white),
        title: Center(
          child: Text("นโยบายความเป็นส่วนตัว",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(

          ),
        ],
      ),
    );
  }
}
