import 'package:flutter/material.dart';
import 'package:new_spark/models/user_server.dart';
import 'package:new_spark/screens/chat_screen_mobile.dart';
import 'package:new_spark/widgets/widgets.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/responsive.dart';
import 'chat_screen_web.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<List<Users>> userFuture;
  //future user data flow from server
  late Future<List<Group>> groupFuture;
  //future group data flow from server

  @override
  void initState() {
    userFuture = UserService().getUser(context);
    groupFuture = GroupService().getGroups(context);
    super.initState();
    print(userFuture);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          drawer: const CustomDrawer(), //left-side custom drawer widget
          //according to screen size responsiveness
          body: Responsive(
            mobile: ChatScreenMobile(),
            desktop: ChatScreenWeb(),
          )),
    );
  }
}
