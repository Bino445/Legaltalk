import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase_Blog {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<List<Map<String, dynamic>>> getblogFromFirestore() async {
    List<Map<String, dynamic>> blogList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> newsSnapshot =
      await FirebaseFirestore.instance.collection('blog').get();
      newsSnapshot.docs.forEach((doc) {
        blogList.add(doc.data());
      });
      return blogList;
    } catch (e) {
      print("Error getting news: $e");
      return [];
    }
  }
}