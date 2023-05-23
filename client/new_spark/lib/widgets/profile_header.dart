import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/palette.dart';
import '../models/user_server.dart';

class ProfileHeader extends StatelessWidget {
  Users user;
  ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: Palette.storyGradient),
          child: (user.coverImg != null)
              ? CachedNetworkImage(
                  imageUrl: user.coverImg,
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl:
                      "https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image.png",
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          color: Palette.scaffold,
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '54',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700]),
                    ),
                    const Text(
                      'Friends',
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.edit_document))
              ],
            ),
          ),
        ),
        //Profile Picture
        CircleAvatar(
          radius: 55.0,
          backgroundColor: Palette.scaffold,
          child: CircleAvatar(
            radius: 53.0,
            backgroundImage: (user.profilePic != null)
                ? CachedNetworkImageProvider(user.profilePic)
                : CachedNetworkImageProvider(
                    "https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png"
                    //currentUser.imageUrl
                    ),
          ),
        )
      ],
    );
  }
}
