import 'package:flutter/material.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/widgets/profile_avatar.dart';

import '../models/user_server.dart';

class ProfileImage extends StatelessWidget {
  final Users currentUser;

  const ProfileImage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 38.0,
        backgroundColor: Palette.scaffold,
        child: ProfileAvatar(imageUrl: currentUser.profilePic, size: 35));
  }
}
