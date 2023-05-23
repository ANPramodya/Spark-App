import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/screens/screens.dart';

import '../models/post_server.dart';
import '../models/user_server.dart';
import '../services/authentication.dart';
import '../services/posts_service.dart';
import '../services/timeago_service.dart';
import '../services/user_service.dart';
import '../widgets/gradient_text.dart';
import '../widgets/online_users.dart';
import '../widgets/post_container.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  //future data flow posts
  late Future<List<Posts>> postFuture;
  //future data flow users
  late Future<List<Users>> userFuture;
  //late Future<bool> _isAuthorized;
  bool _isAuthorized = false;

  @override
  void initState() {
    // _isAuthorized = Authentication().isAuthorized();
    _checkAuthorizationStatus();
    //get post function call
    postFuture = PostService().getPost(context);
    //get online users function call
    userFuture = UserService().getUser(context);
    super.initState();
  }

//check jwt token function call
  Future<void> _checkAuthorizationStatus() async {
    bool isAuthorized = await Authentication().isAuthorized();
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if not authorized redirect to login sdcreen
    if (!_isAuthorized) {
      return AlertDialog(
        title: const Text('Login required'),
        content: const Text('Please Login to continue'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SigninScreen()));
              },
              child: const Text('Log In'))
        ],
      );
      //else show home screen
    } else {
      return NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  centerTitle: true,
                  foregroundColor: Colors.black,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  backgroundColor: Colors.white,
                  title: GradientText(
                    //gradient custom widget
                    text: 'Unity',
                    style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.7),
                    gradient: LinearGradient(colors: [
                      Colors.purple,
                      Colors.blue.shade400,
                    ]),
                  ),
                  actions: [
                    //TODO: post and posts from groups search function
                    IconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.search),
                      color: Colors.black54,
                      iconSize: 28.0,
                    )
                  ],
                )
              ]),
          body: Column(
            children: [
              //horizontal user selection
              FutureBuilder<List<Users>>(
                  future: userFuture,
                  builder: (((context, snapshot) {
                    //circular progress till connection stablishment
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("Circular");
                      return const Center(
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
                      return const Text('No Data');
                    }
                  }))),

              Expanded(
                // building posts from server future data
                child: FutureBuilder<List<Posts>>(
                  future: postFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //circular progress till connection stablishment
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
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
                      // return postContainer(post);
                      return PostContainer(posts: post);
                      //if no data or 0 posts
                    } else {
                      return const Text('No Data');
                    }
                  },
                ),
              ),
            ],
          ));
    }
  }
}
