import 'package:flutter/material.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController Username = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController CF_Password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            color: Color(0xFF1C243C),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Text("สมัครสมาชิก",
                    style: TextStyle(color: Colors.white, fontSize: 26),
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
                              decoration: InputDecoration(labelText: 'Username'),
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
                          SizedBox(width: 20.0,),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: 'Email'),
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
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),

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
                      ),

                    ],
                  ),
                ),
                ),
              ],
            ),
          ),
         ],
      ),
    );
  }
}