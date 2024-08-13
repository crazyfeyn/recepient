class UserModel {
  String email;
  String name;
  String imageUrl;
  String uId;
  List<String> likes;
  List<String> saved;

  UserModel({
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.uId,
    required this.likes,
    required this.saved,
  });

  // Only include fields that you want to store in Firebase
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'uId': uId,
      'likes': likes, // Excluded from Firebase
      'saved': saved, // Excluded from Firebase
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      uId: json['uId'],
      likes: List<String>.from(json['likes'] ?? []),
      saved: List<String>.from(json['saved'] ?? []),
    );
  }
}
