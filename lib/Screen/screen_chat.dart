import 'package:flutter/material.dart';
class Screen_chat extends StatefulWidget {
  const Screen_chat({super.key});

  @override
  State<Screen_chat> createState() => _Screen_chatState();
}

class _Screen_chatState extends State<Screen_chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          leading: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.search,),disabledColor: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Group Chat", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ]
      ),
    );
  }
}
