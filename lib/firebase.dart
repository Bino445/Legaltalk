import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<List<Map<String, dynamic>>> getNewsFromFirestore() async {
    List<Map<String, dynamic>> newsList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> newsSnapshot =
      await FirebaseFirestore.instance.collection('News').get();
      newsSnapshot.docs.forEach((doc) {
        newsList.add(doc.data());
      });
      return newsList;
    } catch (e) {
      print("Error getting news: $e");
      return [];
    }
  }
}