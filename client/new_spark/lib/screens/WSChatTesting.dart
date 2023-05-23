import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/services/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/message_server.dart';

class WSChatTesting extends StatefulWidget {
  @override
  State<WSChatTesting> createState() => _WSChatTestingState();
}

class _WSChatTestingState extends State<WSChatTesting> {
  late IO.Socket _socket;
  TextEditingController edittingController = TextEditingController();
  final List<Messages> _messages = [];

  // _sendMessage() {
  //   _socket.emit('message', {'message': edittingController.text.trim()});
  //   edittingController.clear();
  // }

  // _connectSocket() {
  //   _socket.connect();
  //   _socket.on('connect', (data) => print("ffuck"));
  //   _socket.onConnect((data) => print("Connection Stablished"));
  //   _socket.onConnectError((data) => print("Connection Errorr $data"));
  //   _socket.onDisconnect((data) => print("Server Disconnected"));
  //   _socket.on('message', (data) => _addNewMessage(Messages.fromJson(data)));
  // }

  _addNewMessage(Messages message) {
    _messages.add(message);
  }

  // @override
  // void initState() {
  //   print("Connecting....");
  //   _socket = IO.io('http://10.20.197.63:3333',
  //       IO.OptionBuilder().setTransports(['websocket']).build());
  //   print("Passed Connection String");
  //   _connectSocket();
  //   super.initState();
  // }

  @override
  void initState() {
    print("Connecting....");
    _socket = SocketService().socket;
    SocketService().connectSocket();
    print("Passed Connection String");
    SocketService().join('Nipun');
    print('sent name....');
    SocketService().findAllmessages();
    edittingController.addListener(() {
      SocketService().isTyping();
    });
    SocketService().catchTypingBroadcast();

    super.initState();
  }

  @override
  void dispose() {
    edittingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Testing Ground'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
                child: TextFormField(
              //onChanged: SocketService().isTyping(),
              decoration: InputDecoration(labelText: "Type Message"),
              controller: edittingController,
            )),
            // new StreamBuilder(
            //     stream: widget.channel.stream,
            //     builder: ((context, snapshot) {
            //       return new Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: new Text(snapshot.hasData ? "${snapshot.data}" : ""),
            //       );
            //     }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_connectSocket();
          if (edittingController.text.isNotEmpty) {
            print('message sent');
            SocketService().sendMessage(edittingController.text);
          }
        },
        child: new Icon(Icons.send),
      ),
    );
  }

  // void _sendMessage() {
  //   if (edittingController.text.isNotEmpty) {
  //     widget.channel.sink.add(edittingController.text);
  //   }
  // }

  // @override
  // void dispose() {
  //   widget.channel.sink.close();
  //   super.dispose();
  // }
}
