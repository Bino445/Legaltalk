import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legaltalk/Screen/screen_chat.dart';
import 'package:legaltalk/Screen/screen_home.dart';
import 'package:legaltalk/Screen/screen_news.dart';
import 'package:legaltalk/Screen/screen_post.dart';



class MainScreen extends StatefulWidget {
  final String currentUser;
  const MainScreen({super.key, required this.currentUser});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String currentUse;
  int MyCurrentIndex = 0;
  late List pages;


  @override
  void initState() {
    super.initState();
    currentUse = widget.currentUser;
    pages = [Screen_home(currentUser: currentUse), Screen_News(), Screen_Posts(), Screen_chat(currentUser: currentUse,)];
  }

  @override
  Widget build(BuildContext context) {
    Widget MyNavBar = BottomNavigationBar(
        selectedItemColor: Color(0xFF1C243C),
        unselectedItemColor: Colors.grey.shade400,

        currentIndex: MyCurrentIndex,
        onTap: (int index){
          setState(() {
            MyCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'ข่าว'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add),label: 'โพสต์'),
          BottomNavigationBarItem(icon: Icon(Icons.chat,),label: 'แชทกลุ่ม'),
        ]);

    return Scaffold(
      backgroundColor:Colors.white,
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}