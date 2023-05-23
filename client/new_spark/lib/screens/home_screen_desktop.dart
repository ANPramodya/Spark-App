import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/screens/chat_screen.dart';

import '../models/post_server.dart';
import '../models/user_server.dart';
import '../services/posts_service.dart';
import '../services/user_service.dart';
import '../widgets/online_users.dart';
import '../widgets/post_container.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({super.key});

  @override
  State<HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  late Future<List<Posts>> postFuture;
  //future data flow posts
  late Future<List<Users>> userFuture;
  //future data flow users

  @override
  void initState() {
    postFuture = PostService().getPost(context);
    userFuture = UserService().getUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 12,1,12,1,8
        Flexible(
            flex: 12,
            child: Padding(
                padding: const EdgeInsets.all(12.0), child: ChatScreen())),
        const Spacer(),
        Container(
          width: 600.0,
          child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: ((context, innerBoxIsScrolled) => []),
              body: Column(
                children: [
                  //horizontal user selection
                  FutureBuilder<List<Users>>(
                      future: userFuture,
                      builder: (((context, snapshot) {
                        //circular progress till connection stablishment
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print("Circular");
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          //if data flow has errors
                        } else if (snapshot.hasError) {
                          print("error msg");
                          print(snapshot.error);
                          return Text('${snapshot.hasError}');
                          // if data flow has data
                        } else if (snapshot.hasData) {
                          print("data Showing");
                          print(snapshot.data);
                          final user = snapshot.data!;
                          //showing online users in custom widget
                          return onlineUsers(user);
                          //if no data or 0 users
                        } else {
                          print("No Data");
                          return Text('No Data');
                        }
                      }))),

                  Expanded(
                    // building posts from server future data
                    child: FutureBuilder<List<Posts>>(
                      future: postFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        //circular progress till connection stablishment
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          //if data steam has error
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('${snapshot.hasError}');
                          //if has data show in UI
                        } else if (snapshot.hasData) {
                          final post = snapshot.data!;
                          //custom widget for posts UI
                          return PostContainer(posts: post);
                          //if no data or 0 posts
                        } else {
                          return Text('No Data');
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
        const Spacer(),
        Flexible(
          flex: 8,
          child: Container(
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
