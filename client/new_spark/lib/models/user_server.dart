class Users {
  Users({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.username,
    required this.uniEmail,
    required this.hash,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.coverImg,
    required this.university,
    required this.faculty,
    required this.department,
    required this.isOnline,
  });

  String id;
  String createdAt;
  String updatedAt;
  dynamic email;
  String username;
  String uniEmail;
  String hash;
  String firstName;
  String lastName;
  dynamic profilePic;
  dynamic coverImg;
  String university;
  String faculty;
  dynamic department;
  String isOnline;

  static Users fromJson(json) => Users(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      email: json['email'],
      username: json['username'],
      uniEmail: json['uniEmail'],
      hash: json['hash'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePic: json['profilePic'],
      coverImg: json['coverImg'],
      university: json['university'],
      faculty: json['faculty'],
      department: json['department'],
      isOnline: json['isOnline']);

  // factory Users.fromJson(Map<String, dynamic> json) => Users(
  //       id: json["id"],
  //       createdAt: json["createdAt"],
  //       updatedAt: json["updatedAt"],
  //       email: json["email"],
  //       username: json["username"],
  //       uniEmail: json["uniEmail"],
  //       hash: json["hash"],
  //       firstName: json["firstName"],
  //       lastName: json["lastName"],
  //       profilePic: json["profilePic"],
  //       coverImg: json["coverImg"],
  //       university: json["university"],
  //       faculty: json["faculty"],
  //       department: json["department"],
  //     );
}

class LikedUsers {
  String id;
  String createdAt;
  String creatorId;
  String postId;
  Users creator;

  LikedUsers({
    required this.id,
    required this.createdAt,
    required this.creatorId,
    required this.postId,
    required this.creator,
  });

  static LikedUsers fromJson(json) => LikedUsers(
      id: json['id'],
      createdAt: json['createdAt'],
      creatorId: json['creatorId'],
      postId: json['postId'],
      creator: Users.fromJson(json['creator']));
}
