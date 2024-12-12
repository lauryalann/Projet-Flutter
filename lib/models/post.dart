class Post {
  final String id;
  final String username;
  final String content;
  final String imageUrl;
  int likes;
  bool isLiked;
  List<String> comments; // Liste des commentaires

  Post({
    required this.id,
    required this.username,
    required this.content,
    required this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
    this.comments = const [], // Initialise avec une liste vide
  });

  String getShareableContent() {
    return 'Post de $username :\n$content\n\nRegarde cette image : $imageUrl';
  }
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
  ),
];

