import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_chat.dart';
import 'package:legaltalk/Screen/screen_home.dart';
import 'package:legaltalk/Screen/screen_news.dart';
import 'package:legaltalk/Screen/screen_post.dart';
import 'package:legaltalk/model/profile.dart';



class MainScreen extends StatefulWidget {
  final String currentUser;
  final int MyCurrentIndex;
  const MainScreen({super.key, required this.currentUser, required this.MyCurrentIndex});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String currentUse;
  late int MyCurrentIndex;
  late List pages;

  @override
  void initState() {
    super.initState();
    MyCurrentIndex = widget.MyCurrentIndex;
    currentUse = widget.currentUser;
    pages = [Screen_home(currentUser: currentUse), Screen_News(), Screen_Posts(currentUser: currentUse,), Screen_chat(currentUser: currentUse)];
  }
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
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black),label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper,color: Colors.black),label: 'ข่าว'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add,color: Colors.black),label: 'โพสต์'),
          BottomNavigationBarItem(icon: Icon(Icons.chat,color: Colors.black,),label: 'แชทกลุ่ม'),
        ]);

    return Scaffold(
      backgroundColor:Colors.white,
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}
