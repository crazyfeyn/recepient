class User {
  String email;
  String name;
  String imageUrl;
  String uId;
  List<String> likes;
  List<String> saved;

  User(
      {required this.email,
      required this.name,
      required this.imageUrl,
      required this.uId,
      required this.likes,
      required this.saved});
}
