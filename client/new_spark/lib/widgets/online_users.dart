import 'package:flutter/material.dart';

import 'package:new_spark/widgets/widgets.dart';

import '../models/user_server.dart';

// class OnlineUsers extends StatefulWidget {
//   final List<Users> onlineUser;

//   const OnlineUsers({
//     super.key,
//     required this.onlineUser,
//   });

//   @override
//   State<OnlineUsers> createState() => _OnlineUsersState();
// }

// class _OnlineUsersState extends State<OnlineUsers> {
//   Future<List<Users>> userFuture = UserService().getUser();
//   @override
//   Widget build(BuildContext context) {
//     return
//     Card(
//       clipBehavior: Clip.antiAlias,
//       elevation: 1.0,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30.0),
//               bottomLeft: Radius.circular(30.0))),
//       child: SizedBox(
//         height: 60.0,
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30.0),
//               bottomLeft: Radius.circular(30.0)),
//           child: ListView.builder(
//               itemCount: u,
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
//               //  itemCount: onlineUsers.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (BuildContext context, int index) {
//                 final Users user = onlineUsers[index];

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: ProfileAvatar(
//                     imageUrl: user.profilePic,
//                     isActive: true,
//                     size: 20.0,
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }

Widget onlineUsers(List<Users> users) => Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0))),
      child: SizedBox(
        height: 60.0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0)),
          //ListView of building horizontal scrollable online users
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
              //  itemCount: onlineUsers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final Users user = users[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProfileAvatar(
                    imageUrl: (user.profilePic == null)
                        ? "https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png"
                        : user.profilePic,
                    //imageUrl: user.profilePic,
                    isActive: true,
                    size: 20.0,
                  ),
                );
              }),
        ),
      ),
    );
