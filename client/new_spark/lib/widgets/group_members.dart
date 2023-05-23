import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

Widget groupMembers(List<UsersOnGroups> groupmembers) => ListView.builder(
    shrinkWrap: true,
    itemCount: groupmembers.length,
    itemBuilder: ((context, index) {
      final UsersOnGroups usersOnGroups = groupmembers[index];
      return GestureDetector(
          child: Card(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30.0,
              backgroundImage: (usersOnGroups.user.profilePic == null)
                  ? CachedNetworkImageProvider(
                      'https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png')
                  : CachedNetworkImageProvider(usersOnGroups.user.profilePic),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
                '${usersOnGroups.user.firstName} ${usersOnGroups.user.lastName}'),
            Spacer(),
            Text(usersOnGroups.userRole)
          ],
        ),
      ));
    }));
