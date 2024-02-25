import 'package:flutter/material.dart';
class Screen_Posts extends StatefulWidget {
  const Screen_Posts({super.key});

  @override
  State<Screen_Posts> createState() => _Screen_PostsState();
}

class _Screen_PostsState extends State<Screen_Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          leading: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.search,),disabledColor: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("กระทู้บทความ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ]
      ),
    );
  }
}