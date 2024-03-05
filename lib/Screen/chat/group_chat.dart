import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legaltalk/Screen/chat/group_info.dart';
import 'package:legaltalk/Screen/chat/message_tile.dart';
import 'package:legaltalk/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/model/profile.dart';
import 'package:legaltalk/service/database_service.dart';

import '../screen_main.dart';

class Group_chat extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const Group_chat(
      {Key? key,
        required this.groupId,
        required this.groupName,
        required this.userName})
      : super(key: key);

  @override
  State<Group_chat> createState() => _Group_chatState();
}

class _Group_chatState extends State<Group_chat> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new_rounded),color: Colors.white,),
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF1C243C),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(
                    builder: (context) => GroupInfo(adminName:admin, groupName: widget.groupName, groupId: widget.groupId,)));
              },
              icon: const Icon(Icons.info), color: Colors.white,)
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade500,
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFD1B06B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(
                message: snapshot.data.docs[index]['message'],
                sender: snapshot.data.docs[index]['sender'],
                sentByMe: widget.userName ==
                    snapshot.data.docs[index]['sender']);
          },
        )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
