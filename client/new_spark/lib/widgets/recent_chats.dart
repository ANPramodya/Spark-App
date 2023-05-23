import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_spark/models/group_model.dart';

import 'package:new_spark/screens/chat_room.dart';

// class RecentChats extends StatelessWidget {
//   final Message chat;

//   const RecentChats({super.key, required this.chat});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//         child: Row(
//           children: [
//             const SizedBox(
//               width: 5.0,
//             ),
//             CircleAvatar(
//               backgroundImage: CachedNetworkImageProvider(chat.sender.imageUrl),
//               radius: 25.0,
//             ),
//             const SizedBox(
//               width: 15.0,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   chat.sender.name,
//                   style: const TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: Text(chat.text,
//                       style: const TextStyle(
//                           fontSize: 16.0,
//                           color: Colors.black54,
//                           overflow: TextOverflow.ellipsis)),
//                 )
//               ],
//             ),
//             const SizedBox(
//               width: 10.0,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   chat.time,
//                   style: const TextStyle(fontSize: 12.0, color: Colors.black45),
//                 ),
//                 chat.unread == true
//                     ? Container(
//                         padding: const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
//                         decoration: BoxDecoration(
//                             color: Colors.orange[700],
//                             gradient: LinearGradient(
//                                 colors: [Colors.purple, Colors.blue.shade400],
//                                 begin: Alignment.bottomLeft,
//                                 end: Alignment.topRight),
//                             borderRadius: BorderRadius.circular(10.0)),
//                         child: const Text(
//                           'New',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400, color: Colors.white),
//                         ),
//                       )
//                     : const SizedBox.shrink()
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget recentChats(List<Group> groups) => ListView.builder(
    shrinkWrap: true,
    itemCount: groups.length,
    itemBuilder: (context, index) {
      final Group group = groups[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatRoom(
                        group: group,
                      )

                  // GroupScreen(
                  //       group: group,

                  //     )
                  ));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                CircleAvatar(
                  backgroundImage: (group.groupImage == null)
                      ? CachedNetworkImageProvider(
                          "https://maa.net/wp-content/uploads/2021/11/team-placeholder.png")
                      : CachedNetworkImageProvider(group.groupImage!),
                  radius: 25.0,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.groupName,
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(group.groupDescription,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis)),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   "CreatedAt",
                    //   //group.createdAt,
                    //   style: const TextStyle(
                    //       fontSize: 12.0, color: Colors.black45),
                    // ),
                    // user. == true
                    //     ? Container(
                    //         padding:
                    //             const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    //         decoration: BoxDecoration(
                    //             color: Colors.orange[700],
                    //             gradient: LinearGradient(
                    //                 colors: [Colors.purple, Colors.blue.shade400],
                    //                 begin: Alignment.bottomLeft,
                    //                 end: Alignment.topRight),
                    //             borderRadius: BorderRadius.circular(10.0)),
                    //         child: const Text(
                    //           'New',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w400,
                    //               color: Colors.white),
                    //         ),
                    //       )
                    //     : const SizedBox.shrink()
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
