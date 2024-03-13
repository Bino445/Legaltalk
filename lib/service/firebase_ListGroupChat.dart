
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
        List<dynamic> members = data['members'];
        if (members.contains("${Profile.uid}_${Profile.username}")) {
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


class Firebase_ListGtoupChatNotJoin {

  static Future<List<Map<String, dynamic>>> getNewsFromFirestore() async {
    List<Map<String, dynamic>> ListGroupChat = [];
    try {
      QuerySnapshot<Map<String, dynamic>> ListGtoupChatSnapshot =
      await FirebaseFirestore.instance.collection('groups').get();
      ListGtoupChatSnapshot.docs.forEach((doc) async {
        Map<String, dynamic> data = doc.data();
        List<dynamic> members = data['members'];
        //if(search.isEmpty) {
          //List<dynamic> Name = data['groupName'];
          if (!members.contains("${Profile.uid}_${Profile.username}")) {
            //if(search==""||Name.contains(search)) {
            ListGroupChat.add(data);
            //}
          }
        //}
        /*else{
          QuerySnapshot<Map<String, dynamic>> ListGtoupChatSnapshotw =
          await FirebaseFirestore.instance.collection('groups').where((name)=>name['groupName'].contains(search)).get();
          ListGroupChat = ListGtoupChatSnapshotw as List<Map<String, dynamic>>;
        }*/
      });

      return ListGroupChat;
    } catch (e) {
      print("Error getting news: $e");
      return [];
    }
  }
}