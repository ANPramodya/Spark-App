import 'dart:async';

import 'package:new_spark/services/authentication.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/message_server.dart';

class SocketService {
  final IO.Socket socket =
      IO.io(socketUrl, IO.OptionBuilder().setTransports(['websocket']).build());
  late StreamController<Messages> _streamController;
  //Stream<Messages> messageStream;

  SocketService() {
    _streamController = StreamController<Messages>.broadcast();
    //messageStream = _streamController.stream;
  }

  connectSocket() {
    socket.connect();
    socket.on('connect', (data) => print("connected"));
    socket.onConnect((data) => print("Connection Stablished"));
    socket.onConnectError((data) => print("Connection Errorr $data"));
    socket.onDisconnect((data) => print("Server Disconnected"));
    // _socket.on('message', (data) => _addNewMessage(Messages.fromJson(data)));
  }

  sendMessage(String messageText) {
    socket.emitWithAck('createMessage', {"text": messageText, "name": "Abhiru"},
        ack: (response) {
      print('sendMessage: $response');
    });
  }

  Future<List<Messages>> findAllmessages() async {
    List<Messages> messages = [];
    socket.emitWithAck("findAllMessages", {}, ack: (response) {
      response.forEach((message) {
        messages.add(Messages.fromJson(message));
      });
      print('findAllMessages: $response');
    });
    return messages;
  }

  //A name providing for identification
  join(String name) {
    socket.emitWithAck('join', {"name": name}, ack: (response) {
      print('join: $response');
    });
  }

//joining a chatroom
  joinRoom() {}

  leaveRoom() {}

  isTyping() {
    socket.emit('typing', {"isTyping": true});
    Timer(
      Duration(milliseconds: 2000),
      () {
        socket.emit('typing', {"isTyping": false});
      },
    );
  }

//not working
//data gets an object of name and isTyping
//but cannot output isTyping individually
//returns null
//think it returns null before getting data
//but async await not working
  catchTypingBroadcast() async {
    //var data = {"name": "isTyping"};0
    socket.on('typing', (data) async {
      var responseData = await data;
      if (true) {
        if (responseData['isTyping'] == true) {
          print('catchTypingBroadcast: ${responseData['name']} is Typing');
        } else {
          null;
        }
      }
    });
  }

  Stream<Messages> catchMessages() {
    socket.on('message', (response) async {
      _streamController.add(Messages.fromJson(response));
      //print("Recieved Messages: $response");
      print("Received Text: ${response['text']}");
    });
    return _streamController.stream;
  }

//   void dispose() {
//     _streamController.close();
//   }
}

//if (data[1]) {print('${data[0]} is typing...')}
//{name, isTyping}
////data object {name: admin cer, isTyping: true}
