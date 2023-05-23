import 'package:flutter/material.dart';
import 'package:new_spark/models/message_server.dart';

// class BuildMessage extends StatelessWidget {
//   final Message message;
//   final bool isMe;

//   const BuildMessage({super.key, required this.message, required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//         margin: isMe
//             ? EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width * 0.25, right: 10.0)
//             : EdgeInsets.only(
//                 right: MediaQuery.of(context).size.width * 0.25, left: 10.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           color: isMe ? Colors.amber : Colors.grey[300],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(message.text,
//                 style: const TextStyle(fontSize: 16.0, color: Colors.black)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(message.time,
//                     style:
//                         const TextStyle(fontSize: 12.0, color: Colors.black)),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget buildMessage(List<Messages> messages, ScrollController scrollController,
        String myName) =>
    ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          Messages message = messages[index];
          print('buildMessage in Work');
          //current user uses static data
          //should use saved current user id
          //final bool isMe = message.sender.id == currentUser.id;
          final bool isMe = message.sender == myName;

          return Container(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    // margin: isMe
                    //     ? EdgeInsets.only(
                    //         left: MediaQuery.of(context).size.width * 0.25,
                    //         right: 10.0)
                    //     : EdgeInsets.only(
                    //         right: MediaQuery.of(context).size.width * 0.25,
                    //         left: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: isMe ? Colors.amber : Colors.grey[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isMe
                            ? const SizedBox.shrink()
                            : Text(
                                message.sender,
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                        Text(message.text,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black)),
                        Text(message.time,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.black))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });


 // Row(
                      //   // mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text(message.time,
                      //         style: const TextStyle(
                      //             fontSize: 12.0, color: Colors.black)),
                      //   ],
                      // )