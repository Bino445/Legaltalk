import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_article.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../firebase.dart';

class Screen_News extends StatefulWidget {
  const Screen_News({super.key});
  @override
  _Screen_News createState() => _Screen_News();
}

class _Screen_News extends State<Screen_News> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          leading: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.search,),disabledColor: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("ข่าวสาร", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ]
      ),
      body: FutureBuilder(
        future: FirebaseService.getNewsFromFirestore(),
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
              return Container(
                child: ListView.builder(
                  itemCount: newsList?.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? News = newsList?[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenArticle(article: News),
                          ),
                        );
                      },
                      leading: Image.network(
                        News?['imageURL'], // ใช้ URL จาก Firestore
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(News?['title']),
                      subtitle: Text(News?['description']),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}