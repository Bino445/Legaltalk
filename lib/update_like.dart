import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class like {
  final CollectionReference blogCollection =
  FirebaseFirestore.instance.collection("blog");

  Future createPost(String authorName, String title, String descrip, String imageURL) async {
    DocumentReference postDocumentReference = await blogCollection.add({
      "authorName": authorName,
      "title": title,
      "descrip": descrip,
      "postId": "",
      "Likes": [],
      "image": imageURL,
    });
    // update the members
    await postDocumentReference.update({
      //"Likes": FieldValue.arrayUnion(["${uid}$userName"]),
      "postId": postDocumentReference.id,
    });
  }
  Future<bool> CheckLike(String username) async {
    QuerySnapshot snapshot =
    await blogCollection.where("Likes", arrayContains: username).get();
    if (snapshot.docs.isEmpty)
    {
      return false;
    }
    else{
      return true;
    }
    //return snapshot;
  }
}