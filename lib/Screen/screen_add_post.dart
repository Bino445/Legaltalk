//import 'dart:html';
//import 'dart:html';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legaltalk/Screen/screen_main.dart';
import 'package:legaltalk/Screen/screen_post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legaltalk/service/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../update_like.dart';

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
  final CollectionReference blog = FirebaseFirestore.instance.collection(
      'blog');


  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      like().createPost(authorName.text, title.text, descrip.text, imageURL);

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

  Uint8List?   _image;
  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }*/
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //StorageReference firebaseStorage = FirebaseStorage.instance.ref().child("blogImage").child(path);

  final CollectionReference blogCollection =
  FirebaseFirestore.instance.collection("blog");

  final ImagePicker _picker = ImagePicker();
  File? _photo;

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  String imageURL = '';

  //late String authorName, title, descrip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logotext.png",
              width: 80,
              height: 80,
            ),
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
            onPressed: () {
              if (title.text == "" || authorName.text == "" ||
                  descrip.text == "") {
                showDialog(
                  //barrierColor: Color(0xFFD1B06B),
                    context: context,
                    builder: (BuildContext context) {
                      return SnackBar(
                        backgroundColor: Color(0xFF1C243C),
                        content: Text(
                          "กรุณากรอกข้อมูลให้ครบถ้วน!", style: TextStyle(
                            color: Colors.white),),
                      );
                    });
              } else {
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
              child: _photo != null
              ? ClipRect(
                child: Image.network(
                  width: MediaQuery.of(context).size.width,
                  '' ,
                ),

              )
                  : Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: BoxDecoration(
                    color: Color(0xFF1C243C),
                    borderRadius: BorderRadius.circular(6)
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              )
              /*child: IconButton(onPressed: () async {
                ImagePicker picker = ImagePicker();
                XFile? file = await picker.pickImage(
                    source: ImageSource.gallery);

                if (file == null) return;
                String uniqueFileName = DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toString();

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('image');

                Reference referenceImageToUpload = referenceDirImages.child(
                    uniqueFileName);

                try {
                  referenceImageToUpload.putFile(File(file!.path));
                  imageURL = await referenceImageToUpload.getDownloadURL();
                } catch (error) {}
              }, icon: Icon(Icons.add_a_photo_rounded),),*/
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}




