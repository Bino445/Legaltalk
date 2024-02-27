import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../service/firebase_ListGroupChat.dart';
import 'chat/group_chat.dart';
class Screen_chat extends StatefulWidget {
  final String currentUser;
  const Screen_chat({super.key, required this.currentUser});

  @override
  State<Screen_chat> createState() => _Screen_chatState();
}

class _Screen_chatState extends State<Screen_chat> {
  final TextEditingController groupName = TextEditingController();
  final CollectionReference groups = FirebaseFirestore.instance.collection('groups');
  late String admin;
  @override
  void initState() {
    super.initState();
    admin = widget.currentUser;
  }
  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      final Map<String, dynamic> data = {
        "admin": admin,
        "groupName": groupName.text,
        "groupPic": "",
        "members": [],
        "recentMessage":"",
        "recentMessageSender": "",
      };
      await groups.add(data);

      // ล้างข้อมูลในฟอร์ม
      groupName.clear();

    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้างหรืออัปเดตเอกสาร: $e');
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
              child: Text("Group Chat", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        child: Icon(Icons.add),
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
                  child: Container(
                    child: ListView.builder(
                      itemCount: newsList?.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic>? Ima = newsList?[index];
                        return ListTile(
                          /*leading: Image.network(
                            Ima?['groupPic'], // ใช้ URL จาก Firestore
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),*/
                          title: Text(Ima?['groupName']),
                          //subtitle: Text(News?['description']),
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
                        Navigator.of(context).pop();
                        _save();
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context) => Group_chat()));
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

