import 'package:new_spark/models/user_server.dart';

class Group {
  String id;
  String createdAt;
  String creatorId;
  String groupName;
  String groupDescription;
  String? groupImage;
  List<UsersOnGroups>? users;
  List<PostsOnGroup>? posts;

  Group(
      {required this.id,
      required this.createdAt,
      required this.creatorId,
      required this.groupName,
      required this.groupDescription,
      this.groupImage,
      this.users,
      this.posts});

  // Group.groupFromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       createdAt = json['createdAt'],
  //       creatorId = json['creatorId'],
  //       groupName = json['groupName'],
  //       groupDescription = json['groupDescription'];

  // factory Group.groupFromJson(Map<String, dynamic> json) => Group(
  //       id: json["id"],
  //       createdAt: json["createdAt"],
  //       creatorId: json["creatorId"],
  //       groupName: json["groupName"],
  //       groupDescription: json["groupDescription"],
  //       users: List<UsersOnGroups>.from(
  //           json["users"].map((x) => UsersOnGroups.fromJson(x))),
  //       posts: List<PostsOnGroup>.from(
  //           json["posts"].map((x) => PostsOnGroup.fromJson(x))),
  //     );

  static Group fromJson(json) => Group(
        id: json['id'],
        createdAt: json['createdAt'],
        creatorId: json['creatorId'],
        groupName: json['groupName'],
        groupImage: json['groupImage'],
        groupDescription: json['groupDescription'],
      );

  // static Group groupFromJson(json) => Group(
  //       id: json['notkn'],
  //       createdAt: json['createdAt'],
  //       creatorId: json['creatorId'],
  //       groupName: json['groupName'],
  //       groupDescription: json['groupDescription'],
  //       users: UsersOnGroups.fromJson(json["users"]),
  //       posts: Posts.fromJson(json["posts"]),
  //     );
}

class UsersOnGroups {
  String userId;
  String groupId;
  String userRole;
  Users user;

  UsersOnGroups(
      {required this.userId,
      required this.groupId,
      required this.userRole,
      required this.user});

  static UsersOnGroups fromJson(json) => UsersOnGroups(
      userId: json['userId'],
      groupId: json["groupId"],
      userRole: json['userRole'],
      user: Users.fromJson(json['user']));
}

class PostsOnGroup {
  String id;
  String createdAt;
  String caption;
  String postImg;
  String visibility;
  String groupId;

  PostsOnGroup({
    required this.id,
    required this.createdAt,
    required this.caption,
    required this.postImg,
    required this.visibility,
    required this.groupId,
  });

  factory PostsOnGroup.fromJson(Map<String, dynamic> json) => PostsOnGroup(
        id: json["id"],
        createdAt: json["createdAt"],
        caption: json["caption"],
        postImg: json["postImg"],
        visibility: json["visibility"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "caption": caption,
        "postImg": postImg,
        "visibility": visibility,
        "groupId": groupId,
      };
}
