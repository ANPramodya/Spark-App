import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/group_model.dart';
import '../models/user_server.dart';
import '../services/chat_users.dart';
import '../services/group_service.dart';
import '../services/user_service.dart';
import '../widgets/custom_alertbox1.dart';
import '../widgets/gradient_text.dart';
import '../widgets/online_users.dart';
import '../widgets/recent_chats.dart';
import 'create_group.dart';

class ChatScreenWeb extends StatefulWidget {
  const ChatScreenWeb({super.key});

  @override
  State<ChatScreenWeb> createState() => ChatScreenWebState();
}

class ChatScreenWebState extends State<ChatScreenWeb> {
  late Future<List<Users>> userFuture;
  //future user data flow from server
  late Future<List<Group>> groupFuture;
//future group data flow from server

  @override
  void initState() {
    userFuture = UserService().getUser(context);
    groupFuture = GroupService().getGroups(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              SliverAppBar(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                floating: true,
                centerTitle: true,
                title: GradientText(
                  text: 'Chats',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.7),
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue.shade400]),
                ),
                actions: [
                  IconButton(
                      //popup menu icon button
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlertBox(
                                title: 'Search Things',
                                description: 'Search anything you like',
                                text: 'Cancel',
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                        size: 30.0,
                      )),
                  PopupMenuButton(
                      onSelected: (result) {
                        if (result == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CreateGroupScreen()));
                        }
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 0, child: Text('Create Group')),
                            PopupMenuItem(
                              onTap: () async {
                                var response = await ChatUsers()
                                    .getUsers("users")
                                    .catchError((err) {});
                                print(response);
                              },
                              value: 1,
                              child: Text('Block Contact'),
                            ),
                            PopupMenuItem(value: 2, child: Text('Settings'))
                          ])
                ],
              ),
            ]),
        body: Column(
          children: [
            //horizontal user selection
            FutureBuilder<List<Users>>(
                future: userFuture,
                builder: (((context, snapshot) {
                  //circular progerss indication till connection establishment
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    //data flow has error
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.hasError}');
                    //if data flow has data
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    //UI for show recieved data
                    return onlineUsers(user);
                    //if no data or 0 data
                  } else {
                    return Text('No Data');
                  }
                }))),
            //recent chats
            Expanded(
              //list of groups from server
              child: FutureBuilder<List<Group>>(
                  future: groupFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //circular progerss indication till connection establishment
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      //data flow has error
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.hasError}');
                      //if data flow has data
                    } else if (snapshot.hasData) {
                      final group = snapshot.data!;
                      return recentChats(group);
                      //if no data or 0 data
                    } else {
                      return Text('No Data');
                    }
                  }),
            ),
          ],
        ));
  }
}
