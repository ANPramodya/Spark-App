import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/models/message_server.dart';
import 'package:new_spark/models/models.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/services/socket_service.dart';

import '../services/authentication.dart';
import '../widgets/widgets.dart';

class ChatRoomMobile extends StatefulWidget {
  //final Users user;
  final Group group;

  const ChatRoomMobile({super.key, required this.group});

  @override
  State<ChatRoomMobile> createState() => _ChatRoomMobileState();
}

class _ChatRoomMobileState extends State<ChatRoomMobile> {
  late Stream<Messages> messageStream;
  ScrollController messageScroller = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //connect socket service
    SocketService().connectSocket();
    //join room as ''
    SocketService().join('Abhiru');

//isTyping
    SocketService().catchTypingBroadcast();

    //recieve messages
    _fetchMessages();
    SocketService().catchMessages();
    // messageController.addListener(_printLatestValue);
    //SocketService().isTyping();

    //pass catched messages to a Stream
    messageStream = SocketService().catchMessages();
  }

//get all past messages related to rrom
  void _fetchMessages() async {
    final messages = await SocketService().findAllmessages();
    setState(() {
      myDataList.addAll(messages);
      print(myDataList);
    });
  }

  // void _printLatestValue() {
  //   print('textField value: $messageController.text');
  // }

// dispose message textfield
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

//temorary store of coming messages to view
  List<Messages> myDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                foregroundColor: Colors.black87,
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleSpacing: 0.0,
                //navigation to groupscreen
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => GroupScreen(
                                  group: widget.group,
                                )));
                    print(widget.group.groupName);
                  },
                  child: Row(
                    children: [
                      ProfileAvatar(
                          imageUrl: (widget.group.groupImage == null)
                              ? 'https://maa.net/wp-content/uploads/2021/11/team-placeholder.png'
                              : widget.group.groupImage!
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
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                //popup menu items
                actions: [
                  IconButton(
                      onPressed: () async {
                        // var posts = postsFromJson(response);
                      },
                      icon: Icon(MdiIcons.phone)),
                  PopupMenuButton(
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                                value: 1, child: Text('View Profile')),
                            PopupMenuItem(value: 2, child: Text('Media')),
                            PopupMenuItem(
                                value: 3, child: Text('Notifications')),
                            PopupMenuItem(value: 4, child: Text('Block'))
                          ])),
                ],
              ),
            ]),
        // message Stream builder
        body: StreamBuilder<Messages>(
            //stream of coming messages
            stream: messageStream,
            builder: ((context, snapshot) {
              //scroll down when new messages load
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (messageScroller.hasClients) {
                  messageScroller.animateTo(
                      messageScroller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                }
              });
              //data snapshot check
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('error Occured');
              } else if (snapshot.hasData) {
                //Messages? message = snapshot.data[];
                myDataList.add(snapshot.data!);

                return buildMessage(myDataList, messageScroller, 'Abhiru');
              } else {
                return const Text('No Messages');
              }
            })),
      ),
      //bottom textfield
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TextField(
          controller: messageController,
          //isTyping function call
          onChanged: (text) {
            //sendong typing status
            print('messageTextChanging: $text');
            SocketService().isTyping();
          },
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.3),
          decoration: InputDecoration(
              hintText: 'Type message...',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              suffixIcon: IconButton(
                icon: const Icon(MdiIcons.send),
                //send message
                onPressed: () async {
                  SocketService().sendMessage(messageController.text);
                  messageController.clear();
                },
              ),
              suffixIconColor: Colors.orange[700]),
        ),
      ),
    );
  }
}
