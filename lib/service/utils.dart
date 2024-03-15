import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/model/profile.dart';
//import 'package:image_picker/image_picker.dart';

//ของหน้าแอคเคาท์
/*
pickImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print('No image selected');
}*/
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference userCollection = FirebaseFirestore.instance.collection("User");

class StoreData{
  Future<String> uplodeImageToStorage(String childname,Uint8List file) async{
    Reference ref = _storage.ref().child(childname).child('id');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({required Uint8List file})
  async {
    String resp = "Error";
    try{
      String imageUrl = await uplodeImageToStorage('profileImage', file);
      DocumentReference userDocumentReference = userCollection.doc(Profile.uid);
      await userDocumentReference.update({
        "imageLink": imageUrl
      });
      resp = "success";
    }
        catch(err){
      resp = err.toString();
        }
        return resp;
  }
}

