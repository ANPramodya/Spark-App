import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/widgets/profile_avatar.dart';

import '../models/user_server.dart';
import '../services/timeago_service.dart';

class LikesSheet extends StatelessWidget {
  final Future<List<LikedUsers>> likedUsers;

  const LikesSheet({super.key, required this.likedUsers});
  @override
  Widget build(BuildContext context) {
    // List<String> dummyData = [
    //   "A",
    //   "B",
    //   "C",
    //   "D",
    //   "E",
    //   "F",
    //   "G",
    //   "H",
    //   "I",
    // ];

    return Container(
      decoration: const BoxDecoration(
          color: Palette.scaffold,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      height: MediaQuery.of(context).size.height * 0.75,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text(
              'Likes',
              style: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(
              color: Colors.black12,
              thickness: 2.0,
              indent: 100.0,
              endIndent: 100.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(MdiIcons.thumbUp),
                  color: Palette.facebookBlue,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.heart),
                    color: Colors.red),
                IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.emoticonHappy),
                    color: Colors.orange),
                IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.emoticonAngry),
                    color: Colors.redAccent),
                IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.emoticonSad),
                    color: Colors.orange),
                IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.plusCircleOutline),
                    color: Colors.orange[700])
              ],
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder<List<LikedUsers>>(
                    future: likedUsers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.hasError}');
                      } else if (snapshot.hasData) {
                        final likes = snapshot.data!;
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            // scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: likes.length,
                            itemBuilder: ((context, index) {
                              final LikedUsers likedUser = likes[index];
                              var createdTime = TimeAgo().convertToAgo(
                                  DateTime.parse(likedUser.createdAt), context);

                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProfileAvatar(
                                            imageUrl: (likedUser
                                                        .creator.profilePic ==
                                                    null)
                                                ? 'https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png'
                                                : likedUser.creator.profilePic,
                                            size: 20.0),
                                        const SizedBox(width: 15.0),
                                        Column(
                                          children: [
                                            Text(
                                              '${likedUser.creator.firstName} ${likedUser.creator.lastName}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '·$createdTime',
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 40.0,
                                        ),
                                        Spacer(),
                                        Icon(
                                          MdiIcons.thumbUp,
                                          color: Palette.facebookBlue,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                      } else {
                        return Text('No Data');
                      }
                    })

                //  ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     // scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     itemCount: likedUsers.length,
                //     itemBuilder: ((context, index) {
                //       final String listItem = dummyData[index];
                //       return Padding(
                //         padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                //         child: Container(
                //           color: Colors.white,
                //           child: Padding(
                //             padding: const EdgeInsets.all(15.0),
                //             child: Text(listItem),
                //           ),
                //         ),
                //       );
                //     })),
                )
          ],
        ),
      ),
    );
  }
}
