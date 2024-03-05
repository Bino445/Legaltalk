import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_account.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:legaltalk/Screen/screen_news.dart';
import 'package:legaltalk/model/profile.dart';

import '../service/firebase_blog.dart';

class Screen_home extends StatefulWidget {
  const Screen_home({super.key});
  @override
  State<Screen_home> createState() => _Screen_homeState();
}

class _Screen_homeState extends State<Screen_home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สวัสดี ${Profile.username}'),
        leading: Container(
          margin: EdgeInsets.all(10),
          child: Icon(Icons.waving_hand_rounded),
        ),
        actions: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.account_circle),
              color: Colors.black,
              iconSize: 30,
              //hoverColor: Color(0xFFD1B06B),
              highlightColor: Color(0xFFD1B06B),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Screen_Account();
                }));
              },
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => MainScreen(MyCurrentIndex: 1,)));
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
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => MainScreen(MyCurrentIndex: 2,)));
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
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => MainScreen(MyCurrentIndex: 3,)));
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
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: FutureBuilder(
                future: Firebase_Blog.getblogFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<Map<String, dynamic>>? blogList = snapshot.data;
                      int itemCount = blogList?.length ?? 0; // นับจำนวนรายการบล็อก
                      int topblog = itemCount >= 5 ? 5 : itemCount; // กำหนดจำนวนรายการที่จะแสดง
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5, // เปลี่ยนค่านี้ตามความเหมาะสม
                        child: ListView.builder(
                          itemCount:topblog,
                          itemBuilder: (context, index) {
                            Map<String, dynamic>? blog = blogList?[index];
                            return Card(
                              color: Color(0xFFD1B06B),
                              child: ListTile(
                                title: Text(blog?['title'] ?? ''),
                                subtitle: Text(blog?['descrip'] ?? ''),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}