import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:legaltalk/Screen/search_page.dart';
import 'package:legaltalk/model/profile.dart';
import '../service/database_service.dart';
import '../service/firebase_ListGroupChat.dart';
import 'chat/group_chat.dart';
class Screen_chat extends StatefulWidget {
  const Screen_chat({super.key});

  @override
  State<Screen_chat> createState() => _Screen_chatState();
}

class _Screen_chatState extends State<Screen_chat> {
  final firestore = FirebaseFirestore.instance;
  final TextEditingController groupName = TextEditingController();
  final CollectionReference groups = FirebaseFirestore.instance.collection('groups');
  final CollectionReference User = FirebaseFirestore.instance.collection('User');
  late String admin;
  @override
  void initState() {

    super.initState();
    admin = Profile.username.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: Color(0xFF1C243C),
          //leading: IconButton.outlined(onPressed: (){},
          //icon: Icon(Icons.search,), color: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Group Chat",
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Color(0xFFD1B06B),
        child: Icon(Icons.add,size: 30,),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    "Group chat ที่เข้าร่วมแล้ว",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Search_page()),
                        );
                      }, icon: Icon(Icons.search)),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Firebase_ListGtoupChat.getNewsFromFirestore(),
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
                                  onTap: (){
                                    ChatProfile.setChatid(Ima?['groupId']);
                                    ChatProfile.setadmin(Ima?['admin']);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Group_chat(groupId:Ima?['groupId'] , groupName: Ima?['groupName'], userName: Profile.username.toString()),
                                    ));
                                  },
                                ),
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
          /*Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  "แชทที่ยังไม่เข้าร่วม",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
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
                              return
                                Card(
                                  color: Colors.blue,
                                  child: ListTile(
                                    title: Text(Ima?['groupName']),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit), // เปลี่ยนไอคอนตามที่คุณต้องการ
                                      onPressed: () {
                                        ChatProfile.setChatid(Ima?['groupId']);
                                        ChatProfile.setadmin(Ima?['admin']);
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => Group_chat(groupId:Ima?['groupId'] , groupName: Ima?['groupName'], userName: Profile.username.toString(),),
                                        ));
                                      },
                                    ),
                                  ),
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
          )*/
        ],
      ),
    );
  }

  void popUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("สร้างห้องแชท"),
          content: TextFormField(
            controller: groupName,
            decoration: InputDecoration(
              labelText: 'ชื่อห้อง',
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(top: 10, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      onPressed: () async {
                        if(groupName.text==""){

                        }
                        else {
                          await DatabaseService(uid:Profile.uid ).createGroup(Profile.username.toString(), User.id, groupName.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('สร้างห้องแชทสำเร็จ')));
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context) => MainScreen( MyCurrentIndex: 3,)));

                        }
                      },
                      child: Text("สร้าง"),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("ปิด"),
                    ),
                  ),
                ],

              ),
            ),

          ],
        );
      },
    );
  }
}
/*Widget groupList() {
  return FutureBuilder(
    future: Firebase_ListGtoupChat.getNewsFromFirestore(),
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
                child: Container(
                  child: ListView.builder(
                    itemCount: newsList?.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? Ima = newsList?[index];
                      return Card(
                        color: Colors.blue,
                        child: ListTile(
                          title: Text(Ima?['groupName']),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
      }
    },
  );
}*/