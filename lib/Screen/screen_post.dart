import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_add_post.dart';
import '../firebase_blog.dart';

class Screen_Posts extends StatefulWidget {
  const Screen_Posts({super.key});

  @override
  State<Screen_Posts> createState() => _Screen_PostsState();
}


class _Screen_PostsState extends State<Screen_Posts> {
  final TextEditingController authorName = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController descrip = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Blog แลกเปลี่ยนความเห็น",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
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
                  itemCount: blogList?.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? blog = blogList?[index];
                    return Card(
                      color: Color(0xFFD1B06B),
                      child: ListTile(
                        /*onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenArticle(article: News),
                            ),
                          );
                        },*/
                        /*leading: Image.network(
                          News?['imageURL'], // ใช้ URL จาก Firestore
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),*/
                        title: Text(blog?['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(blog?['descrip']),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: Container(
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.post_add_rounded),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen_Add_Blog()));
              },
              backgroundColor: Color(0xFFD1B06B),
            ),
          ],
        ),
      ),
    );
  }
}