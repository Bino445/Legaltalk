//import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legaltalk/service/utils.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legaltalk/model/profile.dart';

class Screen_Account extends StatefulWidget {
  const Screen_Account({super.key});

  @override
  State<Screen_Account> createState() => _Screen_AccountState();
}

class _Screen_AccountState extends State<Screen_Account> {
  /*Uint8List? _image;

  void selectImages() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }*/
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("User");
  //DocumentReference userDocumentReference = userCollection.doc(Profile.uid);
  //QuerySnapshot Profile = await userCollection.where("uid", isEqualTo: Profile.uid).get();
  //DocumentReference realProfile = userCollection.doc(Profile.uid.toString());

  late String URL;

  Future getProfile() async {
    QuerySnapshot profile = await userCollection.where("uid", isEqualTo: Profile.uid).get();
    if (profile.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = profile.docs.first;
      URL = documentSnapshot['imageLink'];
    }
  }

  File? _photo;
  final ImagePicker _picker = ImagePicker();

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

  void saveProfile() async{
    //String resp = await StoreData().saveData(file: _photo!);
    final file = _photo;
    if (file == null) {
      // Handle the case when _photo is null.
      return;
    }
    final bytes = await file.readAsBytes();
    final resp = await StoreData().saveData(file: bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded,),
                disabledColor: Colors.white),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text("Account", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ]
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 64,
                  backgroundColor: Color(0xFF1C243C),
                  child: _photo != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(64),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/legaltalk-b9d26.appspot.com/o/profileImage?alt=media&token=dfd15085-53a4-4560-b8d4-b6568821c0ea',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    /*child: Image.file(
                      //_photo!,
                      URL,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fitWidth,
                    ),*/
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: saveProfile, child: const Text('บันทึก')),
          ],
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
