
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/model/profile.dart';
import 'package:legaltalk/service/database_service.dart';


class Screen_Account extends StatefulWidget {

  const Screen_Account({super.key});

  @override
  State<Screen_Account> createState() => _Screen_Account();
}
Stream? profile;
class _Screen_Account extends State<Screen_Account> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool edit = true;
  @override
  void initState() {
    super.initState();
    _usernameController.text = Profile.username.toString();
    _emailController.text = Profile.Email.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              readOnly: edit,
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              'Email',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              readOnly: edit,
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                     if(await DatabaseService().CheckUser(_usernameController.text)){
                       if(_usernameController.text==Profile.username);
                       {
                       }
                       if(_usernameController.text!=Profile.username) {
                         String newUsername = _usernameController.text;
                         String newEmail = _emailController.text;
                         Profile.setUsername(newUsername);
                         Profile.setEmail(newEmail);
                         DatabaseService().updateUser(Profile.username.toString(), Profile.uid.toString(),Profile.Email);
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Profile updated successfully')),
                         );
                       }
                       setState(()
                       {
                         edit = true;
                       });
                     }
                     else{
                       edit = false;
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           content: Text('Connot updatad profile',
                             style: TextStyle(color: Colors.red),
                           ),
                           backgroundColor: Color(0xFF1C243C),
                         ),
                       );
                     }

                    // ทำการบันทึกข้อมูลโปรไฟล์ลงใน Firebase Cloud Firestore หรือที่อื่นตามที่คุณต้องการ
                    // แสดงข้อความว่าบันทึกสำเร็จ
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (edit) {
                        edit = false;
                      } else {
                        edit = true;
                      }
                    });
                  },
                  child: Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}