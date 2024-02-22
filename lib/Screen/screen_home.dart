import 'package:flutter/material.dart';
import 'package:legaltalk/model/profile.dart';

class Screen_home extends StatefulWidget {
  const Screen_home({super.key});

  @override
  State<Screen_home> createState() => _Screen_homeState();
}

class _Screen_homeState extends State<Screen_home> {
  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สวัสดี"),
        leading: Container(
          margin: EdgeInsets.all(10),
          child: Icon(Icons.book),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Icon(Icons.account_circle_outlined),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "มีอะไรให้พวกเรา",
                      style: TextStyle(color: Colors.black, fontSize: 50),
                    ),
                    Text(
                      "ช่วยไหม?",
                      style: TextStyle(color: Colors.black, fontSize: 50),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.11),
                    blurRadius: 40,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหา',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    "บริการ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      color: Color(0xFF1C243C),
                      child: Column(
                        children: [
                          Text(
                            "ข่าวสาร",
                            style: TextStyle(color: Color(0xFFFBFBFB), fontSize: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('images/Law_book.png', height: 150),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Color(0xFF1C243C),
                      child: Column(
                        children: [
                          Text(
                            "กระทู้ถามตอบ",
                            style: TextStyle(color: Color(0xFFFBFBFB), fontSize: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('images/Content_management.png', height: 150),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Color(0xFF1C243C),
                      child: Column(
                        children: [
                          Text(
                            "ข่าวสาร",
                            style: TextStyle(color: Color(0xFFFBFBFB), fontSize: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('images/Law_book.png', height: 150),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
