import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '/models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final VoidCallback onLike;
  final Function(String) onComment;

  PostWidget({
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _sharePost() {
    Share.share(widget.post.getShareableContent());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du post
          Image.network(widget.post.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.post.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
          // Boutons de like et de partage
          Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.post.isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: widget.onLike,
              ),
              Text('${widget.post.likes} likes'),
              Spacer(), // Pousse le bouton de partage à droite
              IconButton(
                icon: Icon(Icons.share),
                onPressed: _sharePost,
              ),
            ],
          ),
          // Liste des commentaires
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Commentaires',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...widget.post.comments.map((comment) => Text('- $comment')).toList(),
              ],
            ),
          ),
          // Champ pour ajouter un commentaire
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Ajouter un commentaire...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      widget.onComment(_commentController.text);
                      _commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
