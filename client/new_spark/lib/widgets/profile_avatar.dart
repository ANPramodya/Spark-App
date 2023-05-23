import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_spark/config/palette.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;
  final double size;

  const ProfileAvatar(
      {super.key,
      required this.imageUrl,
      this.isActive = false,
      this.hasBorder = false,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          //radius: size,
          backgroundColor: Colors.orange[700],
          child: CircleAvatar(
            radius: hasBorder ? 18.0 : 20.0,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.online,
                      border: Border.all(color: Colors.white, width: 2.0)),
                ))
            : const SizedBox.shrink()
      ],
    );
  }
}
