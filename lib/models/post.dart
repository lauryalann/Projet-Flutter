// post.dart
class Post {
  final String id;
  final String username;
  final String content;
  final String imageUrl;
  int likes; // Nombre de likes
  bool isLiked; // L'état du like pour l'utilisateur actuel

  Post({
    required this.id,
    required this.username,
    required this.content,
    required this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
  });
}

// Données statiques
List<Post> posts = [
  Post(
    id: '1',
    username: 'JohnDoe',
    content: 'Mon premier post sur Flutter !',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 10,
  ),
  Post(
    id: '2',
    username: 'JaneSmith',
    content: 'Une belle journée pour coder 😍',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 5,
  ),  Post(
    id: '1',
    username: 'JohnDoe',
    content: 'Mon premier post sur Flutter !',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 10,
  ),
  Post(
    id: '2',
    username: 'JaneSmith',
    content: 'Une belle journée pour coder 😍',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 5,
  ),  Post(
    id: '1',
    username: 'JohnDoe',
    content: 'Mon premier post sur Flutter !',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 10,
  ),
  Post(
    id: '2',
    username: 'JaneSmith',
    content: 'Une belle journée pour coder 😍',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 5,
  ),  Post(
    id: '1',
    username: 'JohnDoe',
    content: 'Mon premier post sur Flutter !',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 10,
  ),
  Post(
    id: '2',
    username: 'JaneSmith',
    content: 'Une belle journée pour coder 😍',
    imageUrl: 'https://via.placeholder.com/150',
    likes: 5,
  ),
];
