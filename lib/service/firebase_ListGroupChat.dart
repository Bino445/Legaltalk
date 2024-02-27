import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase_ListGtoupChat {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<List<Map<String, dynamic>>> getNewsFromFirestore() async {
    List<Map<String, dynamic>> ListGtoupChat = [];
    try {
      QuerySnapshot<Map<String, dynamic>> ListGtoupChatSnapshot =
      await FirebaseFirestore.instance.collection('groups').get();
      ListGtoupChatSnapshot.docs.forEach((doc) {
        ListGtoupChat.add(doc.data());
      });
      return ListGtoupChat;
    } catch (e) {
      print("Error getting news: $e");
      return [];
    }
  }
}