import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/services/comment_service.dart';
import 'package:new_spark/services/timeago_service.dart';
import 'package:new_spark/widgets/profile_avatar.dart';

import '../models/models.dart';

class CommentSheet extends StatefulWidget {
  final String postId;

  const CommentSheet({super.key, required this.postId});
  // final Future<List<Comment>> comments;

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  late Future<List<Comment>> getComments;
  TextEditingController commentEdittingController = TextEditingController();

  // @override
  // void initState() {
  //   getComments = CommentService().getComments(widget.postId);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Palette.scaffold,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(children: [
          Expanded(
            child: SizedBox(
                height: 500.0,
                child: Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Comments',
                        style: TextStyle(
                            color: Colors.orange[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      const Divider(
                        color: Colors.black12,
                        thickness: 2.0,
                        indent: 100.0,
                        endIndent: 100.0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: StreamBuilder<List<Comment>>(
                                stream: CommentService()
                                    .getCommentsStream(widget.postId, context),
                                builder: ((context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    print("comment circular");
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.hasError}');
                                  } else if (snapshot.hasData) {
                                    print("comment data");

                                    final comments = snapshot.data!;
                                    print(comments);
                                    // return Comments(comments: comments);
                                    return _comment(comments);
                                  } else {
                                    return Text('No data');
                                  }
                                }))
                            // FutureBuilder<List<Comment>>(
                            //     future: getComments,
                            //     builder: ((((context, snapshot) {
                            //       if (snapshot.connectionState ==
                            //           ConnectionState.waiting) {
                            //         print("comment circular");
                            //         return Center(
                            //           child: CircularProgressIndicator(),
                            //         );
                            //       } else if (snapshot.hasError) {
                            //         return Text('${snapshot.hasError}');
                            //       } else if (snapshot.hasData) {
                            //         print("comment data");

                            //         final comments = snapshot.data!;
                            //         print(comments);
                            //         // return Comments(comments: comments);
                            //         return _comment(comments);
                            //       } else {
                            //         return Text('No data');
                            //       }
                            //     })))),
                            ),
                      ),
                    ],
                  ),
                )),
          ),
          TextField(
            controller: commentEdittingController,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 500,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3),
            decoration: InputDecoration(
                hintText: 'Type Comment...',
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                suffixIcon: IconButton(
                  icon: const Icon(MdiIcons.send),
                  onPressed: () async {
                    await CommentService().postComment(
                        commentEdittingController.text, widget.postId, context);
                    print('posted comment');
                    commentEdittingController.clear();

                    FocusManager.instance.primaryFocus?.unfocus();

                    setState(() {});
                  },
                ),
                suffixIconColor: Colors.orange[700]),
          )
        ]),
      ),
    );
  }
}

// class Comments extends StatelessWidget {
//   final Comment comments;

//   const Comments({super.key, required this.comments});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       color: Colors.white,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //profile Avatar
//           ProfileAvatar(
//               imageUrl:
//                   'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
//               size: 20.0),
//           const SizedBox(
//             width: 15.0,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   //name
//                   Text(
//                     'first name',
//                     style: const TextStyle(
//                         fontSize: 16.0, fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(
//                     width: 10.0,
//                   ),
//                   //timeago
//                   Text(
//                     '· 17 min ago',
//                     style: const TextStyle(fontSize: 12.0, color: Colors.grey),
//                   )
//                 ],
//               ),
//               //comment
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.75,
//                 child: Text(
//                   comments.comment,
//                   style: const TextStyle(
//                       fontSize: 15.0, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(
//                 height: 5.0,
//               ),

//               //likes

//               Row(
//                 children: [
//                   Icon(
//                     MdiIcons.thumbUp,
//                     size: 16.0,
//                     color: Colors.orange[700],
//                   ),
//                   const SizedBox(
//                     width: 5.0,
//                   ),
//                   Text(
//                     '15',
//                     style: const TextStyle(
//                       fontSize: 15.0,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

Widget _comment(List<Comment> comments) => SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: ((context, index) {
            final Comment comment = comments[index];

            var createdTime = TimeAgo()
                .convertToAgo(DateTime.parse(comment.createdAt), context);

            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //profile Avatar

                    ProfileAvatar(
                        imageUrl: (comment.creator.profilePic == null)
                            ? 'https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png'
                            : comment.creator.profilePic,
                        size: 20.0),

                    const SizedBox(
                      width: 15.0,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            //name

                            Text(
                              "${comment.creator.firstName} ${comment.creator.lastName}",
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w700),
                            ),

                            //timeago
                          ],
                        ),

                        Text(
                          '· $createdTime',
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.grey),
                        ),

                        //comment

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(
                            comment.comment,
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500),
                          ),
                        ),

                        const SizedBox(
                          height: 5.0,
                        ),

                        //likes

                        Row(
                          children: [
                            Icon(
                              MdiIcons.thumbUpOutline,
                              size: 16.0,
                              color: Colors.orange[700],
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Text(
                              '0',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          })),
    );
