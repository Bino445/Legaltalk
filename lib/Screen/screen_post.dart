import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/like_button.dart';
import 'package:legaltalk/Screen/screen_add_post.dart';
import 'package:legaltalk/Screen/screen_see_post.dart';
import 'package:legaltalk/update_like.dart';
import '../model/profile.dart';
import '../service/firebase_blog.dart';

class Screen_Posts extends StatefulWidget {

  const Screen_Posts({super.key,});

  @override
  State<Screen_Posts> createState() => _Screen_PostsState();
}


class _Screen_PostsState extends State<Screen_Posts> {
  final TextEditingController authorName = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController descrip = TextEditingController();

//user
 /* final currentUser = Profile.uid;
  bool isLiked = false;
  bool real = like().CheckLike(Profile.username.toString()) as bool;
  @override
  void initState() {
    super.initState();
    isLiked = real;
  }

  //toggle
  toggleLike(String post){
    setState(() {
      isLiked = !isLiked;
    });

    //firebase
    DocumentReference postRef = FirebaseFirestore.instance.collection('blog').doc(post);

    if (isLiked){
      postRef.update({
        'Likes': FieldValue.arrayUnion([Profile.username])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([Profile.username])
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C243C),
        shadowColor: Colors.black,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text("Blog",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
        ),]
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: Firebase_Blog.getblogFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>>? blogList = snapshot.data;
                return Container(
                  child: ListView.builder(
                    //ikes: List<String>.from(blog)
                    itemCount: blogList?.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? blog = blogList?[index];
                      return Card(
                        color: Colors.grey.shade300,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Screen_SeePost(seepost: blog,),
                              ),
                            );
                          },
                          /*leading: Image.network(
                            News?['imageURL'], // ใช้ URL จาก Firestore
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),*/
                          title: Text(blog?['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(
                              blog?['authorName']),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          /*Column(
                            children: [
                              LikeButton(
                                  isLiked: isLiked,
                                  onTap: toggleLike(blog?['postId']))
                            ],
                          ),*/
                        ),
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton:
            FloatingActionButton(
              child: Icon(Icons.post_add_rounded),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen_Add_Blog()));
              },
              elevation: 0,
              backgroundColor: Color(0xFFD1B06B),
            ),
    );
  }
}