class Comment {
  String userId;
  String text;
  DateTime createdAt;

  Comment({
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
