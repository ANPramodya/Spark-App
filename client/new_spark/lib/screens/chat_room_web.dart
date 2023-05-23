import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/services/socket_service.dart';

import '../models/group_model.dart';
import '../models/message_server.dart';
import '../services/authentication.dart';
import '../widgets/build_message.dart';
import '../widgets/profile_avatar.dart';
import 'chat_screen_web.dart';
import 'group_screen.dart';

class ChatRoomWeb extends StatefulWidget {
  final Group group;
  const ChatRoomWeb({super.key, required this.group});

  @override
  State<ChatRoomWeb> createState() => _ChatRoomWebState();
}

class _ChatRoomWebState extends State<ChatRoomWeb> {
  late Stream<Messages> messageStream;
  ScrollController messageScroller = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SocketService().connectSocket();
    SocketService().join('WebUser');
    SocketService().catchTypingBroadcast();
    _fetchMessages();
    SocketService().catchMessages();
    messageStream = SocketService().catchMessages();
    //messageStream = messagesBuilder();
  }

  void _fetchMessages() async {
    final messages = await SocketService().findAllmessages();
    setState(() {
      myDataList.addAll(messages);
      print(myDataList);
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  // Stream<Messages> messagesBuilder() async* {
  //   await Future.delayed(const Duration(seconds: 4));

  //   yield dummyMessages[0];
  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[1];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[2];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[3];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[4];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[5];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[6];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[7];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[8];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[9];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[10];

  //   await Future.delayed(const Duration(seconds: 2));
  //   yield dummyMessages[11];
  // }

  List<Messages> myDataList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.scaffold,
      child: Row(
        children: [
          //  12,1,23
          Flexible(flex: 12, child: ChatScreenWeb()),
          const Spacer(),
          Flexible(
              flex: 23,
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          floating: true,
                          foregroundColor: Colors.black87,
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                          titleSpacing: 0.0,
                          title: GestureDetector(
                            onTap: () {
                              //
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => GroupScreen(
                                            group: widget.group,
                                          )));
                            },
                            child: Row(
                              children: [
                                ProfileAvatar(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1532170579297-281918c8ae72?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1484&q=80'
                                    //user.profilePic
                                    ,
                                    size: 20.0),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  //user.firstName,
                                  widget.group.groupName,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          actions: [
                            IconButton(
                                onPressed: () async {},
                                icon: Icon(MdiIcons.phone)),
                            PopupMenuButton(
                                itemBuilder: ((context) => [
                                      PopupMenuItem(
                                          value: 1,
                                          child: Text('View Profile')),
                                      PopupMenuItem(
                                          value: 2, child: Text('Media')),
                                      PopupMenuItem(
                                          value: 3,
                                          child: Text('Notifications')),
                                      PopupMenuItem(
                                          value: 4, child: Text('Block'))
                                    ])),
                          ],
                        ),
                      ]),
                  // body: FutureBuilder<List<Messages>>(
                  //     //future: ,
                  //     builder: (context, snapshot) {
                  //   if (snapshot.connectionState == ConnectionState.waiting) {
                  //     return Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   } else if (snapshot.hasError) {
                  //     return Text('${snapshot.hasError}');
                  //   } else if (snapshot.hasData) {
                  //     final messages = snapshot.data!;
                  //     return buildMessage(messages);
                  //   } else {
                  //     return Text('No Data');
                  //   }
                  // })

                  body: StreamBuilder<Messages>(
                      stream: messageStream,
                      builder: ((context, snapshot) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (messageScroller.hasClients) {
                            messageScroller.animateTo(
                                messageScroller.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          }
                        });
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Text('error Occured');
                        } else if (snapshot.hasData) {
                          //Messages? message = snapshot.data[];
                          myDataList.add(snapshot.data!);

                          return buildMessage(
                              myDataList, messageScroller, 'WebUser');

                          // ListTile(
                          //   title: Text('${message!.text}'),
                          // );

                          //     ListView.builder(

                          //   itemCount: myDataList.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     Messages msg = myDataList[index];
                          //     return ListTile(
                          //       title: Text(msg.text),
                          //     );
                          //   },
                          // );

                          //return buildMessage(message, snapshot);
                        } else {
                          return const Text('No Messages');
                        }
                      })),
                )

                // CustomScrollView(
                //   slivers: [
                // SliverAppBar(
                //   floating: true,
                //   foregroundColor: Colors.black87,
                //   backgroundColor: Colors.white,
                //   elevation: 0.0,
                //   titleSpacing: 0.0,
                //   title: GestureDetector(
                //     onTap: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (_) => const GroupScreen()));
                //     },
                //     child: Row(
                //       children: [
                //         ProfileAvatar(imageUrl: user.imageUrl, size: 20.0),
                //         const SizedBox(
                //           width: 10.0,
                //         ),
                //         Text(
                //           user.name,
                //           style: const TextStyle(
                //               color: Colors.black87, fontWeight: FontWeight.w600),
                //         )
                //       ],
                //     ),
                //   ),
                //   actions: [
                //     IconButton(
                //         onPressed: () async {
                //           print('trying getting');
                //           var response =
                //               await Authentication().get('post').catchError((err) {});
                //           if (response == null) return;
                //           print(response);
                //           debugPrint(response);
                //           var posts = postsFromJson(response);
                //         },
                //         icon: Icon(MdiIcons.phone)),
                //     PopupMenuButton(
                //         itemBuilder: ((context) => [
                //               PopupMenuItem(value: 1, child: Text('View Profile')),
                //               PopupMenuItem(value: 2, child: Text('Media')),
                //               PopupMenuItem(value: 3, child: Text('Notifications')),
                //               PopupMenuItem(value: 4, child: Text('Block'))
                //             ])),
                //   ],
                // ),
                //     SliverList(
                //         delegate: SliverChildBuilderDelegate((context, index) {
                //       final Message message = messages[index];
                //       final bool isMe = message.sender.id == currentUser.id;
                //       return BuildMessage(
                //         message: message,
                //         isMe: isMe,
                //       );
                //     }, childCount: messages.length)),
                //   ],
                // ),
                ,
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    controller: messageController,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3),
                    decoration: InputDecoration(
                        hintText: 'Type message...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        suffixIcon: IconButton(
                          icon: const Icon(MdiIcons.send),
                          onPressed: () async {
                            SocketService().sendMessage(messageController.text);
                            messageController.clear();
                          },
                        ),
                        suffixIconColor: Colors.orange[700]),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
