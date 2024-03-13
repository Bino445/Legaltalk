import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_main.dart';

class Screen_Add_Blog extends StatefulWidget {
  const Screen_Add_Blog({super.key});

  @override
  State<Screen_Add_Blog> createState() => _Screen_Add_BlogState();
}

class _Screen_Add_BlogState extends State<Screen_Add_Blog> {

  //final picker = ImagePicker();
  final TextEditingController authorName = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController descrip = TextEditingController();
  final CollectionReference blog = FirebaseFirestore.instance.collection('blog');


  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      final Map<String, dynamic> data = {
        "authorName": authorName.text,
        "title": title.text,
        "descrip": descrip.text,
      };
      await blog.add(data);

      // ล้างข้อมูลในฟอร์ม
      authorName.clear();
      title.clear();
      descrip.clear();

    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้างหรืออัปเดตเอกสาร: $e');
    }
  }
  /*Future pickImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }
    print('ไม่ได้เลือกรูป');
  }

  Unit8List?   _image;
  void selectImage() async{
    Unit8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }*/



  //late String authorName, title, descrip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
            Image.asset("assets/images/logotext.png",
              width: 80,
              height: 80,
            ),
            /*Text(
              "LegalTalk",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF1C243C),
                  fontWeight: FontWeight.bold),)*/
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon: Icon(Icons.upload_rounded),
                color: Colors.black,
                iconSize: 30,
                //hoverColor: Color(0xFFD1B06B),
                highlightColor: Color(0xFFD1B06B),
                onPressed: (){
                  if(title.text == "" || authorName.text == "" || descrip.text == ""){
                    showDialog(
                      //barrierColor: Color(0xFFD1B06B),
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFFD1B06B),
                            title: Text("กรุณากรอกข้อมูลให้ครบถ้วน", textAlign: TextAlign.center,),
                          );
                        });
                  }else {
                    _save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('โพสกระทู้สำเร็จ!')),
                    );
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) => MainScreen(MyCurrentIndex: 2,)));
                  }
                },
              ),)
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF1C243C), borderRadius: BorderRadius.circular(6)
              ),
              width: MediaQuery.of(context).size.width,
              child: IconButton(onPressed: (){

              }, icon: Icon(Icons.add_a_photo_rounded),),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "ชื่อผู้เขียน"),
                    keyboardType: TextInputType.text,
                    controller: authorName,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "หัวข้อ"),
                    keyboardType: TextInputType.text,
                    controller: title,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "คำอธิบาย"),
                    keyboardType: TextInputType.text,
                    controller: descrip,
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

//class Unit8List {}

