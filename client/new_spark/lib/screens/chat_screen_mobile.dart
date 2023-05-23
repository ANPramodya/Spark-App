import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/screens/signin_screen.dart';

import '../models/group_model.dart';
import '../models/user_server.dart';
import '../services/authentication.dart';
import '../services/chat_users.dart';
import '../services/group_service.dart';
import '../services/user_service.dart';
import '../widgets/custom_alertbox1.dart';
import '../widgets/gradient_text.dart';
import '../widgets/online_users.dart';
import '../widgets/recent_chats.dart';
import 'create_group.dart';

class ChatScreenMobile extends StatefulWidget {
  const ChatScreenMobile({super.key});

  @override
  State<ChatScreenMobile> createState() => _ChatScreenMobileState();
}

class _ChatScreenMobileState extends State<ChatScreenMobile> {
  //list of online users
  late Future<List<Users>> userFuture;

//list of groups
  late Future<List<Group>> groupFuture;
  bool _isAuthorized = false;

  @override
  void initState() {
    //check jwt token
    _checkAuthorizationStatus();
    //get online users function
    userFuture = UserService().getUser(context);
    //get groups function
    groupFuture = GroupService().getGroups(context);
    super.initState();
  }

  Future<void> _checkAuthorizationStatus() async {
    bool isAuthorized = await Authentication().isAuthorized();
    setState(() {
      _isAuthorized = isAuthorized;
    });
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
                //popup menu
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
                  //create group screen navigation
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
// }
