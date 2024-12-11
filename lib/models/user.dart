class UserModel {
  final String id;
  final String username;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.profilePicture,
  });

  // Méthode pour créer un objet UserModel depuis Firestore
  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      username: data['username'],
      profilePicture: data['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profilePicture': profilePicture,
    };
  }
}
