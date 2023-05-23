import 'package:flutter/material.dart';
import 'package:new_spark/models/message_model.dart';
import 'package:new_spark/widgets/profile_avatar.dart';

class RecentContacts extends StatelessWidget {
  const RecentContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0))),
      child: ListView.builder(
          itemCount: favorites.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ProfileAvatar(imageUrl: favorites[index].imageUrl, size: 20.0),
                Text(favorites[index].name)
              ],
            );
          }),
    );
  }
}
