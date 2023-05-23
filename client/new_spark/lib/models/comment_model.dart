import 'package:new_spark/models/user_server.dart';

// class Comment {
//   final Users user;
//   final String comment;
//   final String timeAgo;
//   final int likes;

//   const Comment(
//       {required this.user,
//       required this.comment,
//       required this.timeAgo,
//       required this.likes});
// }

class Comment {
  String id;
  String createdAt;
  String creatorId;
  String postId;
  String comment;
  Users creator;

  Comment(
      {required this.id,
      required this.createdAt,
      required this.creatorId,
      required this.postId,
      required this.comment,
      required this.creator});

  static Comment fromJson(json) => Comment(
      id: json['id'],
      createdAt: json['createdAt'],
      creatorId: json['creatorId'],
      postId: json['postId'],
      comment: json['comment'],
      creator: Users.fromJson(json["creator"]));
}
