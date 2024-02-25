import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_news.dart';
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
                      "Welcome to Law",
                      style: TextStyle(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Community!",
                      style: TextStyle(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),//ตัวหนังสือ "มีอะไรให้ช่วยไหม?"
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
                      suffixIcon: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.search,),disabledColor: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),//ช่องค้นหา
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
            ),//หัวข้อ (บริการ)
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context)
                        {
                          return Screen_News();
                        }));
                      },
                      child: Card(
                        color: Color(0xFF1C243C),
                        child: Column(
                          children: <Widget>[
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

                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context)
                        {
                          return Screen_News();
                        }));
                      },
                      child: Card(
                        color: Color(0xFF1C243C),
                        child: Column(
                          children: <Widget>[
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

                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (
                            context)
                        {
                          return Screen_News();
                        }));
                      },
                      child: Card(
                        color: Color(0xFF1C243C),
                        child: Column(
                          children: <Widget>[
                            Center(

                                child: Text(
                                  "Group chat",
                                  style: TextStyle(color: Color(0xFFFBFBFB), fontSize: 20),
                                    textAlign: TextAlign.center
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Image.asset('images/Chatting_online.png', height: 150),
                            )
                          ],
                        ),
                      ),
                    ),

                  ),
                ],
              ),
            ),//ตัวเลือกหัวข้อบริการ
            Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    "บทความยอดนิยม",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),//หัวข้อ (บทความ)
          ],
        ),
      ),
    );
  }
}
