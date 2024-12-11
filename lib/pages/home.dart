import 'package:flutter/material.dart';
import '/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fonction pour gérer les likes
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Réseau Social'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image du post
                Image.network(post.imageUrl),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.content,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      // Bouton "Like"
                      IconButton(
                        icon: Icon(
                          post.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: post.isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => toggleLike(post),
                      ),
                      // Nombre de likes
                      Text('${post.likes} likes'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
