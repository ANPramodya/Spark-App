import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/models/user_model.dart';
import 'package:new_spark/widgets/profile_avatar.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(imageUrl: user.imageUrl, size: 30.0),
          const SizedBox(
            width: 6.0,
          ),
          Text(user.name, style: const TextStyle(fontSize: 16.0))
        ],
      ),
    );
  }
}
