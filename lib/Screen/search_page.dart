import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/chat/group_chat.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:legaltalk/model/profile.dart';
import 'package:legaltalk/service/database_service.dart';
import 'package:legaltalk/service/firebase_ListGroupChat.dart';

class Search_page extends StatefulWidget {
  const Search_page({super.key});

  @override
  State<Search_page> createState() => _Search_pageState();
}

class _Search_pageState extends State<Search_page> {
  final formKey = GlobalKey<FormState>();
  @override
  /*void _runFilter(String Keyword){
    if(Keyword.isEmpty){
      results = Firebase_ListGtoupChatNotJoin.getNewsFromFirestore(search.text) as List<Map<String, dynamic>>;
    }
    else{
      results = Firebase_ListGtoupChatNotJoin.getNewsFromFirestore(search.text) as List<Map<String, dynamic>>;
    }
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: Color(0xFF1C243C),
          leading: IconButton(onPressed: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MainScreen(MyCurrentIndex: 3,)));},
            icon: Icon(Icons.arrow_back_ios_new_rounded),color: Colors.white,),
          //leading: IconButton.outlined(onPressed: (){},
          //icon: Icon(Icons.search,), color: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Search",
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ]
      ),
      body: /*Column(
        children: [
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
            child:*/ Column(
              children:[
            Container(
            child: Expanded(
            child: FutureBuilder(
                future: Firebase_ListGtoupChatNotJoin.getNewsFromFirestore(),
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
            List<Map<String, dynamic>>? newsList = snapshot.data;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: newsList?.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? Ima = newsList?[index];
                      return Card(
                          color: Colors.grey.shade300,
                          child: ListTile(
                            title: Text(Ima?['groupName']),
                            trailing: IconButton(
                              icon: Text("เข้าร่วม",
                                style: TextStyle(color: Colors.green),),
                              onPressed: () {
                                ChatProfile.setChatid(Ima?['groupId']);
                                ChatProfile.setadmin(Ima?['admin']);
                                DatabaseService(uid: Profile.uid)
                                    .toggleGroupJoin(Ima?['groupId'],
                                    Profile.username.toString(),
                                    Ima?['groupName']);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'เข้าร่วมห้องแชทสำเร็จ',
                                      style: TextStyle(
                                          color: Colors.green),
                                    ),
                                    backgroundColor: Color(0xFF1C243C),
                                  ),
                                );
                                Future.delayed(
                                    Duration(milliseconds: 500), () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                        MyCurrentIndex: 3,)));
                                });
                              },
                            ),
                          )
                      );
                    },
                  ),
                ),
              ),
            );
          }
        }
      },
    ),
    ),
    )
              ],
            ),
            ); //List GroupChat
          //],
       // ),
     // );
  }
}
