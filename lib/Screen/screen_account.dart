import 'package:flutter/material.dart';

class Screen_Account extends StatefulWidget {
  const Screen_Account({super.key});

  @override
  State<Screen_Account> createState() => _Screen_AccountState();
}

class _Screen_AccountState extends State<Screen_Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded,),
              disabledColor: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ]
      ),
    );
  }
}
