import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_login.dart';
import 'package:legaltalk/Screen/screen_privacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/database_service.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController Username = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final TextEditingController CF_Password = TextEditingController();
  final CollectionReference User = FirebaseFirestore.instance.collection('User');

  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      DatabaseService().savingUserData(
          Username.text, Email.text, Password.text);

      // ล้างข้อมูลในฟอร์ม
      Username.clear();
      Email.clear();
      Password.clear();
      CF_Password.clear();

    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้างหรืออัปเดตเอกสาร: $e');
    }
  }

  bool passwordVisible = false; // hide password

  bool isChecked = false;
  bool isCheckboxError = false;
  // Test Function to handle checkbox validation
  void validateCheckbox() {
    setState(() {
      // Check if the checkbox is checked
      if (isChecked) {
        isCheckboxError = false;
        // Checkbox is checked, perform desired actions
      } else {
        isCheckboxError = true;
        // Checkbox is not checked, show error message or perform desired actions
      }
    });
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  } //password visible

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Center(
              child: Image(image: AssetImage('assets/images/logotext.png'),
                width: 200,
                height: 200,
              ),
            ),
          ),
          Card(
            color: Color(0xFF1C243C),
            margin: EdgeInsets.only(left: 20, right: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: Text("สมัครสมาชิก",
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                ),
                Divider(),
                Padding(padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person_2_rounded),
                                  //hintText: "Username",
                                  //fillColor: Colors.white,
                                  //filled: true,
                                ),
                                style: TextStyle(color: Colors.white),
                                controller: Username,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ), //Username
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email_rounded),
                                ),
                                style: TextStyle(color: Colors.white),
                                controller: Email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ), //Email
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.password_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                controller: Password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ), //password
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.password_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                controller: CF_Password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  if (value != Password.text) {
                                    return 'กรุณากรอกรหัสผ่านให้ถูกต้อง';
                                  }
                                  return null;
                                },

                              ),
                            ),
                          ],
                        ), //confirm password
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'ฉันยอมรับใน '),
                    TextSpan(text: 'นโยบายความปลอดภัย',style: TextStyle(color: Colors.blue),recognizer: TapGestureRecognizer()..onTap=(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Screen_Privacy()));

                    }),
                    TextSpan(text: 'รวมถึงเงื่อนไขการใช้งาน')
                  ]),
            ),
            leading: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
          if (isCheckboxError) //pls check privacy
            Text(
              'กรุณากดยอมรับนโยบายความเป็นส่วนตัว และเงื่อนไขการใช้งาน!',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          Center(
              child: SizedBox(
                  height: 50, //height of button
                  width: 200, //width of button
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD1B06B), //background color of button
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(50)
                          ),
                          padding: EdgeInsets.all(10) //content padding inside button
                      ),
                      onPressed: () async {
                        if(await DatabaseService().CheckUser(Username.text)){
                          if (Username.text == "" || Password.text == "" ||
                              Email.text == "" || CF_Password.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('กรุณากรอกข้อมูลให้ครบถ้วน',
                                  style: TextStyle(color: Colors.red),
                                ),
                                backgroundColor: Color(0xFF1C243C),
                              ),
                            );
                            return null;
                          }
                          if(CF_Password.text != Password.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('กรุณากรอกรหัสผ่านให้ถูกต้อง',
                                  style: TextStyle(color: Colors.red),
                                ),
                                backgroundColor: Color(0xFF1C243C),
                              ),
                            );
                            return null;
                          }
                          else if (Username.text != "" && Password.text != "" &&
                              Email.text != "" && CF_Password.text != "" &&
                              isChecked) {
                            validateCheckbox();
                            _save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                  'สมัครสมาชิกสำเร็จ! กรุณาเข้าสู่ระบบอีกครั้ง')),
                            );
                            Navigator.pop(context,
                                MaterialPageRoute(builder: (context) {
                                  return Screen_login();
                                }));
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('ไม่สามารถบันทึกข้อมูลได้',
                                  style: TextStyle(color: Colors.red),
                                ),
                                backgroundColor: Color(0xFF1C243C),
                              ),
                            );
                            return null;
                          }
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('มีผู้ใช้นี้มีคนใช้ไปแล้ว!!',
                                style: TextStyle(color: Colors.red),
                              ),
                              backgroundColor: Color(0xFF1C243C),
                            ),
                          );
                        }
                      },
                      //saveData();
                      //validateCheckbox();
                      //_save();
                      /*Navigator.push(context,MaterialPageRoute(
                                builder: (context){
                                  return MainScreen(); เปลี่ยนเป็นหน้า login
                                })
                            );*/
                      child: Text("สมัครสมาชิก",
                        style: TextStyle(color: Colors.white),)
                  )
              )
          ) //regis button
        ],
      ),
    );
  }
}