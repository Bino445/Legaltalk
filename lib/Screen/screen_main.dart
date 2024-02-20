import 'package:flutter/material.dart';
import 'package:futer/Screen/screen_home.dart';
import 'package:futer/Screen/screen_news.dart';
import 'package:futer/Screen/screen_post.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int MyCurrentIndex = 0;
  List pages = [Screen_home(),ScreenNews(),Screen_Posts()];

  @override
  Widget build(BuildContext context) {
    Widget MyNavBar = BottomNavigationBar(
        currentIndex: MyCurrentIndex,
        onTap: (int index){
          setState(() {
            MyCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'หน้าหลัก',),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'ข่าว'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add),label: 'โพสต์'),
        ]);

    return Scaffold(
      backgroundColor:Colors.white,
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}

