import 'package:new_spark/models/user_server.dart';

class Post {
  final Users user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final int likes;
  final int comments;
  final int shares;

  const Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
  static Post fromJson(json) => Post(
        user: json['user'],
        caption: json['caption'],
        timeAgo: json['timeAgo'],
        imageUrl: json['imageUrl'],
        likes: json['likes'],
        comments: json['comments'],
        shares: json['shares'],
      );
}
