import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Screen_News extends StatefulWidget {
  const Screen_News({super.key});
  @override
  _Screen_News createState() => _Screen_News();
}

class _Screen_News extends State<Screen_News> {
  List<dynamic> _newsArticles = [];

  @override
  void initState() {
    super.initState();
    _fetchNewsArticles();
  }

  void _fetchNewsArticles() async {
    final response = await http.get(Uri.parse('https://tna.mcot.net//'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _newsArticles = jsonData['articles'];
      });
    } else {
      print('Error fetching data');
    }
  }

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
    );
  }
}