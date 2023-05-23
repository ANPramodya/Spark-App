class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  const User(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.isOnline});

  static User fromJson(json) => User(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        isOnline: json['isOnlie'],
      );
}
