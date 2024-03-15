import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/chat/group_chat.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:legaltalk/model/profile.dart';

import '../../service/database_service.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo(
      {Key? key,
      required this.adminName,
      required this.groupName,
      required this.groupId})
      : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {

  DeletMember() async {
    await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot> snapshots = firestore.collection('User').where(
        'groups', arrayContains: '${ChatProfile.Chatid}_${widget.groupName}').snapshots();
    snapshots.listen((snapshot) {
      for (var doc in snapshot.docs) {
        List<dynamic> groups = doc['groups'];
        if (groups.contains("${ChatProfile.Chatid}_${widget.groupName}")) {
          // ลบค่า '${ChatProfile.Chatid}_${widget.groupName}' ออกจาก list
          //groups.remove("${ChatProfile.Chatid}_${widget.groupName}");
          // อัปเดตเอกสาร
          doc.reference.update({'groups': FieldValue.arrayRemove(["${ChatProfile.Chatid}_${widget.groupName}"])}).then((_)
          {
          }).catchError((error) {
          });
        }
      }
    });
  }

  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DatabaseService(uid: Profile.uid)
        .getGroupMembers(widget.groupId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF1C243C),
        title: const Text("ข้อมูลห้องแชท", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Leave group?"),
                        content:
                            const Text("Are you sure you leave the group? "),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if(ChatProfile.admin.toString()=="User_"'${Profile.username}'.toString())
                              {
                                popUpDialog(context);
                              }
                              else {
                                DatabaseService(
                                    uid: Profile.uid)
                                    .toggleGroupJoin(
                                    widget.groupId,
                                    Profile.username.toString(),
                                    widget.groupName)
                                    .whenComplete(() {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          MainScreen(MyCurrentIndex: 3,)));
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.exit_to_app), color: Colors.white,)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFD1B06B),
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Group: ${widget.groupName}",
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Admin: ${getName(widget.adminName)}",
                          softWrap: true,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(getName(snapshot.data['members'][index])),
                      subtitle: Text(getId(snapshot.data['members'][index])),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS"),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS"),
            );
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
      },
    );
  }
  void popUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ลบห้องแชท"),
          content: Text("คุณต้องการลบห้องแชทนี้หรือไม่"),
          actions: [
            Container(
              margin: EdgeInsets.only(top: 10, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      onPressed: () {
                        DeletMember();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('ลบห้องแชทสำเร็จ',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0xFF1C243C),
                          ),
                        );
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => MainScreen(MyCurrentIndex: 3,)));
                        FirebaseFirestore.instance.collection('groups').doc(ChatProfile.Chatid).get().then((doc) {
                          if (doc.exists) {
                            // ลบทุกคอลเล็กชันภายในเอกสาร
                            doc.reference.collection('messages').get().then((snapshot) {
                              for (DocumentSnapshot ds in snapshot.docs) {
                                ds.reference.delete();
                              }
                            });
                            // ลบเอกสาร
                            doc.reference.delete();
                          }
                        });
                      },
                      child: Text("ลบ"),
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
