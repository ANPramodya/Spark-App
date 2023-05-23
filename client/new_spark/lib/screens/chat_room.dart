import 'package:flutter/material.dart';

import 'package:new_spark/models/models.dart';

import '../widgets/responsive.dart';
import 'chat_room_mobile.dart';
import 'chat_room_web.dart';

class ChatRoom extends StatefulWidget {
  //final Users user;
  final Group group;

  const ChatRoom({super.key, required this.group});

  //const ChatRoom({super.key, required this.user});
  //const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //show according to screen resoultion(responsiveness)
          body: Responsive(
        mobile: ChatRoomMobile(
          group: widget.group,
        ),
        desktop: ChatRoomWeb(
          group: widget.group,
        ),
      )),
    );
  }
}
