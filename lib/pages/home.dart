import 'package:flutter/material.dart';
import '/models/post.dart';
import '../models/postwidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void toggleLike(Post post) {
    setState(() {
      if (post.isLiked) {
        post.likes--;
      } else {
        post.likes++;
      }
      post.isLiked = !post.isLiked;
    });
  }

  void addComment(Post post, String comment) {
    setState(() {
      post.comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Réseau Social'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Naviguer vers la page de profil
              Navigator.pushNamed(context, '/pages/profile');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostWidget(
            post: post,
            onLike: () => toggleLike(post),
            onComment: (comment) => addComment(post, comment),
          );
        },
      ),
    );
  }
}
