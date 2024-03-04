import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legaltalk/model/profile.dart';

class Firebase_ListGtoupChat {
  static Future<List<Map<String, dynamic>>> getNewsFromFirestore() async {
    List<Map<String, dynamic>> ListGtoupChat = [];
    try {
      QuerySnapshot<Map<String, dynamic>> ListGtoupChatSnapshot =
      await FirebaseFirestore.instance.collection('groups').get();

      ListGtoupChatSnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();

        // ตรวจสอบเงื่อนไขหรือคัดกรองข้อมูลที่นี่
        if (data['members'] == '${Profile.uid}${Profile.username}') {
          ListGtoupChat.add(data);
        }
      });
      return ListGtoupChat;
    } catch (e) {
      print("Error getting news: $e");
      return [];
    }
  }
}