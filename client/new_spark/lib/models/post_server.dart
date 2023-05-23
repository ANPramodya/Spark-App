// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'models.dart';

class Posts {
  String id;
  String createdAt;
  String caption;
  String postImg;
  String visibility;
  String groupId;

  Group? group;
  int? postLikesCount;
  int? commentsCount;
  bool isLiked;
  Posts(
      {required this.id,
      required this.createdAt,
      required this.caption,
      required this.postImg,
      required this.visibility,
      required this.groupId,
      this.group,
      this.postLikesCount,
      this.commentsCount,
      required this.isLiked});

  //comments and likesshouldhave good types
  //group id should return with the name

  static Posts fromJson(json) => Posts(
        id: json['id'],
        caption: json['caption'],
        createdAt: json['createdAt'],
        postImg: json['postImg'],
        visibility: json['visibility'],
        commentsCount: json['commentsCount'],
        groupId: json['groupId'],
        isLiked: json['isLiked'],
        group: Group.fromJson(json["group"]),
        postLikesCount: json['postLikesCount'],
      );

  static Posts fromGroupJson(json) => Posts(
      id: json['id'],
      createdAt: json['createdAt'],
      caption: json['caption'],
      postImg: json['postImg'],
      visibility: json['visibility'],
      groupId: json['groupId'],
      isLiked: json['isLiked']);
}

class LikesOnPosts {
  String postId;
  int likes;

  LikesOnPosts({required this.postId, required this.likes});
}
