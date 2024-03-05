import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Screen_SeePost extends StatelessWidget {
  final Map<String, dynamic>? seepost;

  const Screen_SeePost({Key? key, required this.seepost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Center(
          child: Image.asset("assets/images/logotext.png",
            width: 80,
            height: 80,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 8)),
              Center(
                child: Text(
                  seepost?['title'] ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ชื่อผู้เขียน: ',
                      style: TextStyle(fontSize: 14,),
                    ),
                    Text(seepost?['authorName'] ?? '',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              ),
              /*Image.network(
                seepost?['imageURL'] ?? '',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),*/
              SizedBox(height: 10),
              Center(
                child: Card(
                  color: Color(0xFF1C243C),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      seepost?['descrip'] ?? '',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


