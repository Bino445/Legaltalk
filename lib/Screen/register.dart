import 'package:flutter/material.dart';
//เหลือทำให้กดปุ่มแล้วหน้าอื่น+เงื่อนไขถ้าไม่กรอกข้อมูล+หน้านโยบาย

void main() {
  runApp(ScreenRegister());
}

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

  bool passwordVisible=false; // hide password

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
              child: Image(image: AssetImage('assets/images/logo.png'),
                width: 200,
                height: 200,
              ),
            ),
          ),
          Card(
            color: Color(0xFF1C243C),
            margin: EdgeInsets.only(left: 50, right: 50),
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
                                decoration: InputDecoration(labelText: 'Username',
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
                        ),//Username
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(labelText: 'Email',
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
                        ),//Email
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(labelText: 'Password',
                                  prefixIcon: Icon(Icons.password_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: (){
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
                        ),//password
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.password_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: (){
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
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),//confirm password
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('ฉันยอมรับใน "นโยบายความปลอดภัย" รวมถึงเงื่อนไขการใช้งาน'),
            leading: Checkbox(
              value: isChecked,
              onChanged: (value){
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
          Center(
              child: SizedBox(
                  height:50, //height of button
                  width:200, //width of button
                  child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFD1B06B), //background color of button
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(50)
                          ),
                          padding: EdgeInsets.all(20) //content padding inside button
                      ),
                      onPressed: validateCheckbox,
                      child: Text("สมัครสมาชิก",
                        style: TextStyle(color: Colors.white),)
                  )
              )
          )//regis button
        ],
      ),
    );
  }
}