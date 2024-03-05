import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ScreenArticle extends StatelessWidget {
  final Map<String, dynamic>? article;

  const ScreenArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article?['title'] ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article?['title'] ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Image.network(
                article?['imageURL'] ?? '',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  article?['content'] ?? '',

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}