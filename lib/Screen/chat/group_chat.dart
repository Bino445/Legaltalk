

import 'package:flutter/material.dart';

class Group_chat extends StatefulWidget {
  const Group_chat({super.key});

  @override
  State<Group_chat> createState() => _Group_chatState();
}

class _Group_chatState extends State<Group_chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
        body: Column(
          children: [
            // ส่วนที่แสดงรายการข้อความ
            /*Expanded(
              child: ListView.builder(
                itemCount: 10, // จำนวนข้อความตัวอย่าง
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Message $index'),
                  );
                },
              ),
            ),*/
            // ช่องให้ป้อนข้อความ
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // เมื่อกดส่งข้อความ
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: Group_chat(),
  ));
}
