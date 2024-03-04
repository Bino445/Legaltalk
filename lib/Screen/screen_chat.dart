import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/model/profile.dart';
import '../service/database_service.dart';
import '../service/firebase_ListGroupChat.dart';
import 'chat/group_chat.dart';
class Screen_chat extends StatefulWidget {
  final String currentUser;
  const Screen_chat({super.key, required this.currentUser});

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
    admin = widget.currentUser;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          leading: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.search,),disabledColor: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Group Chat", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ]
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        popUpDialog(context);
      },
      elevation: 0,
      child: Icon(Icons.add,size: 30,),
    ),
      body: FutureBuilder(
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
                              /*leading: Image.network(
                                Ima?['groupPic'], // ใช้ URL จาก Firestore
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),*/
                              title: Text(Ima?['groupName']),
                              //subtitle: Text(News?['description']),
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
                      onPressed: () {
                        if(groupName.text==""){

                        }
                        else {
                          Navigator.of(context).pop();
                          DatabaseService(uid:Profile.uid ).createGroup(widget.currentUser, User.id, groupName.text);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('สร้างห้องแชทสำเร็จ')));
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
groupList() {
  return StreamBuilder(
    stream: groups,
    builder: (context, AsyncSnapshot snapshot) {
      // make some checks
      if (snapshot.hasData) {
        if (snapshot.data['groups'] != null) {
          if (snapshot.data['groups'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data['groups'].length,
              itemBuilder: (context, index) {
                int reverseIndex = snapshot.data['groups'].length - index - 1;
                return GroupTile(
                    groupId: getId(snapshot.data['groups'][reverseIndex]),
                    groupName: getName(snapshot.data['groups'][reverseIndex]),
                    userName: snapshot.data['fullName']);
              },
            );
          } else {
            return noGroupWidget();
          }
        } else {
          return noGroupWidget();
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor),
        );
      }
    },
  );
}

noGroupWidget() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            popUpDialog(context);
          },
          child: Icon(
            Icons.add_circle,
            color: Colors.grey[700],
            size: 75,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
}

