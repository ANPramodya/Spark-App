import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/models/models.dart';
import 'package:new_spark/models/user_server.dart';
import 'package:new_spark/services/services.dart';
import 'package:new_spark/services/timeago_service.dart';
import 'package:new_spark/widgets/responsive.dart';
import 'package:new_spark/widgets/widgets.dart';

import '../config/palette.dart';

// class PostContainer extends StatelessWidget {
//   final Post post;

//   const PostContainer({super.key, required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//       clipBehavior: Clip.antiAlias,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: _PostHeader(post: post),
//             ),
//             const SizedBox(
//               height: 5.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Text(post.caption),
//             ),
//             const SizedBox(
//               height: 6.0,
//             ),
//             // post.imageUrl != ''
//             //     ? const SizedBox.shrink()
//             //     : const SizedBox(
//             //         height: 6.0,
//             //       ),
//             post.imageUrl == ''
//                 ? const SizedBox.shrink()
//                 : CachedNetworkImage(imageUrl: post.imageUrl),

//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
//               child: _PostStats(post: post),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
class PostContainer extends StatefulWidget {
  late List<Posts> posts;

  PostContainer({Key? key, required this.posts}) : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  List liked = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        // itemCount: posts.length,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          final bool isDesktop = Responsive.isDesktop(context);
          // bool isLiked = false;
          final Posts post = widget.posts[index];
          if (post.isLiked == true) {
            liked.add(post.id);
          }
          var createdTime =
              TimeAgo().convertToAgo(DateTime.parse(post.createdAt), context);

          return Card(
            margin: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: isDesktop ? 5.0 : 0.0),
            elevation: isDesktop ? 1.0 : 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          //group pic
                          //ProfileAvatar(imageUrl: post.groupId, size: 20.0),
                          ProfileAvatar(
                              imageUrl: (post.group!.groupImage == null)
                                  ? 'https://maa.net/wp-content/uploads/2021/11/team-placeholder.png'
                                  : post.group!.groupImage!,
                              // "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80",
                              size: 20.0),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //group name
                                Text(post.group!.groupName),
                                Row(
                                  children: [
                                    Text('$createdTime ·'),
                                    const Icon(
                                      Icons.public,
                                      color: Colors.grey,
                                      size: 12.0,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz))
                        ],
                      )),

                  const SizedBox(
                    height: 5.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(post.caption),
                  ),

                  const SizedBox(
                    height: 6.0,
                  ),

                  // post.imageUrl != ''

                  //     ? const SizedBox.shrink()

                  //     : const SizedBox(

                  //         height: 6.0,

                  //       ),

                  post.postImg == ''
                      ? const SizedBox.shrink()
                      : CachedNetworkImage(imageUrl: post.postImg),

                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 2.0),
                      child: Column(
                        children: [
                          const Divider(
                            indent: 130.0,
                            endIndent: 130.0,
                            thickness: 4.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  MdiIcons.thumbUp,
                                  size: 16.0,
                                  color: Colors.orange[700],
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Expanded(child: Text('${post.postLikesCount}')),
                                Text('${post.commentsCount} Comments'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(
                            height: 10.0,
                            thickness: 2.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onLongPress: () {
                                    Future<List<LikedUsers>> postLikes =
                                        PostService()
                                            .getAllLikes(post.id, context);

                                    showModalBottomSheet(
                                        isDismissible: false,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: ((BuildContext context) {
                                          return LikesSheet(
                                            likedUsers: postLikes,
                                          );
                                        }));
                                  },
                                  onPressed: () async {
                                    //change icon
                                    //run liking method if not liked

                                    dynamic likeState = await PostService()
                                        .likeUnlikePost(post.id, context);

                                    if (likeState == 201) {
                                      setState(() {
                                        liked.add(post.id);
                                      });
                                    } else {
                                      setState(() {
                                        liked.remove(post.id);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 25.0,
                                    width: 100.0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // liked.contains(index)
                                        liked.contains(post.id)
                                            ? Icon(
                                                MdiIcons.thumbUp,
                                                color: Palette.facebookBlue,
                                              )
                                            : Icon(MdiIcons.thumbUpOutline),

                                        // Icon(MdiIcons.thumbUp),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Like',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // _PostButton(
                                //     onLongPress: () => showModalBottomSheet(
                                //         isDismissible: false,
                                //         isScrollControlled: true,
                                //         backgroundColor: Colors.transparent,
                                //         context: context,
                                //         builder: ((BuildContext context) {
                                //           return LikesSheet();
                                //         })),
                                //     onTap: () async {
                                //       // setState(() {
                                //       //   isLiked = true;
                                //       // });

                                //       //change icon
                                //       //run liking method if not liked
                                //       dynamic likeState = await PostService()
                                //           .likeUnlikePost(
                                //               "dae2d0bd-30fa-44b3-b2a5-69546a7de8be",
                                //               post.id);
                                //       if (likeState == 201) {
                                //         setState(() {
                                //           isLiked = true;
                                //         });
                                //       } else {
                                //         setState(() {
                                //           isLiked = false;
                                //         });
                                //       }
                                //       print(isLiked);
                                //       //else unlike
                                //     },
                                //     label: 'Like',
                                //     icon: isLiked
                                //         ? Icon(
                                //             MdiIcons.thumbUp,
                                //             color: Palette.facebookBlue,
                                //           )
                                //         : Icon(MdiIcons.thumbUpOutline)
                                //     //     const Icon(
                                //     //   MdiIcons.thumbUpOutline,
                                //     //   size: 20.0,
                                //     //   color: Palette.facebookBlue,
                                //     // )
                                //     ),
                                //Button to comment, passing screen to comment sheet with comments from server
                                _PostButton(
                                    onTap: () async {
                                      showModalBottomSheet(
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          20.0))),
                                          context: context,
                                          builder: ((BuildContext context) {
                                            return CommentSheet(
                                              postId: post.id,
                                            );
                                          }));
                                    },
                                    label: 'Comment',
                                    icon: const Icon(MdiIcons.commentOutline,
                                        size: 20.0)),
                                _PostButton(
                                    onTap: () async {
                                      PostService().sharePost(
                                          post.postImg, post.caption, context);
                                    },
                                    label: 'Share',
                                    icon: const Icon(
                                      MdiIcons.shareOutline,
                                      size: 25.0,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
}

// Widget postContainer(List<Posts> posts) => ListView.builder(
//     shrinkWrap: true,
//     itemCount: posts.length,
//     itemBuilder: (context, index) {
//       final bool isDesktop = Responsive.isDesktop(context);
//       final bool isLiked = false;
//       final Posts post = posts[index];
//       var createdTime = TimeAgo().convertToAgo(DateTime.parse(post.createdAt));

//       return Card(
//         margin: EdgeInsets.symmetric(
//             vertical: 5.0, horizontal: isDesktop ? 5.0 : 0.0),
//         elevation: isDesktop ? 1.0 : 0.0,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//         clipBehavior: Clip.antiAlias,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30.0),
//             color: Colors.white,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       //group pic
//                       //ProfileAvatar(imageUrl: post.groupId, size: 20.0),
//                       ProfileAvatar(
//                           imageUrl:
//                               "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80",
//                           size: 20.0),
//                       const SizedBox(
//                         width: 10.0,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //group name
//                             Text(post.group!.groupName),
//                             Row(
//                               children: [
//                                 Text('$createdTime ·'),
//                                 const Icon(
//                                   Icons.public,
//                                   color: Colors.grey,
//                                   size: 12.0,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                           onPressed: () {}, icon: const Icon(Icons.more_horiz))
//                     ],
//                   )),

//               const SizedBox(
//                 height: 5.0,
//               ),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(post.caption),
//               ),

//               const SizedBox(
//                 height: 6.0,
//               ),

//               // post.imageUrl != ''

//               //     ? const SizedBox.shrink()

//               //     : const SizedBox(

//               //         height: 6.0,

//               //       ),

//               post.postImg == ''
//                   ? const SizedBox.shrink()
//                   : CachedNetworkImage(imageUrl: post.postImg),

//               Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 2.0),
//                   child: Column(
//                     children: [
//                       const Divider(
//                         indent: 130.0,
//                         endIndent: 130.0,
//                         thickness: 4.0,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                         child: Row(
//                           children: [
//                             Icon(
//                               MdiIcons.thumbUp,
//                               size: 16.0,
//                               color: Colors.orange[700],
//                             ),
//                             const SizedBox(
//                               width: 6.0,
//                             ),
//                             Expanded(child: Text('${post.postLikes}')),
//                             Text('${post.comments} Comments'),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10.0,
//                       ),
//                       const Divider(
//                         height: 10.0,
//                         thickness: 2.0,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _PostButton(
//                                 onLongPress: () => showModalBottomSheet(
//                                     isDismissible: false,
//                                     isScrollControlled: true,
//                                     backgroundColor: Colors.transparent,
//                                     context: context,
//                                     builder: ((BuildContext context) {
//                                       return LikesSheet();
//                                     })),
//                                 onTap: () {
//                                   //change icon
//                                   //run liking method if not liked
//                                   //else unlike
//                                 },
//                                 label: 'Like',
//                                 icon: const Icon(
//                                   MdiIcons.thumbUpOutline,
//                                   size: 20.0,
//                                   color: Palette.facebookBlue,
//                                 )),
//                             //Button to comment, passing screen to comment sheet with comments from server
//                             _PostButton(
//                                 onTap: () async {
//                                   print(post.id);

//                                   var comments = await CommentService()
//                                       .getComments(post.id);

//                                   showModalBottomSheet(
//                                       isDismissible: true,
//                                       isScrollControlled: true,
//                                       backgroundColor: Colors.transparent,
//                                       shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.vertical(
//                                               top: Radius.circular(20.0))),
//                                       context: context,
//                                       builder: ((BuildContext context) {
//                                         return CommentSheet(
//                                           postId: post.id,
//                                         );
//                                       }));
//                                 },
//                                 label: 'Comment',
//                                 icon: const Icon(MdiIcons.commentOutline,
//                                     size: 20.0)),
//                             _PostButton(
//                                 onTap: () => print('Shared'),
//                                 label: 'Share',
//                                 icon: const Icon(
//                                   MdiIcons.shareOutline,
//                                   size: 25.0,
//                                 ))
//                           ],
//                         ),
//                       )
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       );
//     });

// Widget _postHeader(List<Posts> posts) => ListView.builder(
//     shrinkWrap: true,
//     itemCount: posts.length,
//     itemBuilder: ((context, index) {
//       final Posts post = posts[index];
//       return Row(
//         children: [
//           //group pic
//           ProfileAvatar(imageUrl: post.groupId, size: 20.0),
//           const SizedBox(
//             width: 10.0,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //group name
//                 Text(post.groupId),
//                 Row(
//                   children: [
//                     Text('${post.createdAt} ·'),
//                     const Icon(
//                       Icons.public,
//                       color: Colors.grey,
//                       size: 12.0,
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
//         ],
//       );
//     }));

// class _PostStats extends StatelessWidget {
//   final Post post;

//   const _PostStats({required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Divider(
//           indent: 130.0,
//           endIndent: 130.0,
//           thickness: 4.0,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5.0),
//           child: Row(
//             children: [
//               Icon(
//                 MdiIcons.thumbUp,
//                 size: 16.0,
//                 color: Colors.orange[700],
//               ),
//               const SizedBox(
//                 width: 6.0,
//               ),
//               Expanded(child: Text('${post.likes}')),
//               Text('${post.comments} Comments'),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 10.0,
//         ),
//         const Divider(
//           height: 10.0,
//           thickness: 2.0,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _PostButton(
//                   onLongPress: () => showModalBottomSheet(
//                       isScrollControlled: true,
//                       backgroundColor: Colors.transparent,
//                       context: context,
//                       builder: ((BuildContext context) {
//                         return LikesSheet();
//                       })),
//                   onTap: () => print('Liked'),
//                   label: 'Like',
//                   icon: const Icon(MdiIcons.thumbUpOutline, size: 20.0)),
//               _PostButton(
//                   onTap: () {
//                     showModalBottomSheet(
//                         isScrollControlled: true,
//                         backgroundColor: Colors.transparent,
//                         shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(20.0))),
//                         context: context,
//                         builder: ((BuildContext context) {
//                           return const CommentSheet();
//                         }));
//                   },
//                   label: 'Comment',
//                   icon: const Icon(MdiIcons.commentOutline, size: 20.0)),
//               _PostButton(
//                   onTap: () => print('Shared'),
//                   label: 'Share',
//                   icon: const Icon(
//                     MdiIcons.shareOutline,
//                     size: 25.0,
//                   ))
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

// Widget _postStats(List<Posts> posts) => ListView.builder(
//     shrinkWrap: true,
//     itemCount: posts.length,
//     itemBuilder: (context, index) {
//       final Posts post = posts[index];
//       return Column(
//         children: [
//           const Divider(
//             indent: 130.0,
//             endIndent: 130.0,
//             thickness: 4.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5.0),
//             child: Row(
//               children: [
//                 Icon(
//                   MdiIcons.thumbUp,
//                   size: 16.0,
//                   color: Colors.orange[700],
//                 ),
//                 const SizedBox(
//                   width: 6.0,
//                 ),
//                 Expanded(child: Text('${post.postLikes}')),
//                 Text('${post.comments} Comments'),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           const Divider(
//             height: 10.0,
//             thickness: 2.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _PostButton(
//                     onLongPress: () => showModalBottomSheet(
//                         isScrollControlled: true,
//                         backgroundColor: Colors.transparent,
//                         context: context,
//                         builder: ((BuildContext context) {
//                           return LikesSheet();
//                         })),
//                     onTap: () => print('Liked'),
//                     label: 'Like',
//                     icon: const Icon(MdiIcons.thumbUpOutline, size: 20.0)),
//                 _PostButton(
//                     onTap: () {
//                       showModalBottomSheet(
//                           isScrollControlled: true,
//                           backgroundColor: Colors.transparent,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(20.0))),
//                           context: context,
//                           builder: ((BuildContext context) {
//                             return const CommentSheet();
//                           }));
//                     },
//                     label: 'Comment',
//                     icon: const Icon(MdiIcons.commentOutline, size: 20.0)),
//                 _PostButton(
//                     onTap: () => print('Shared'),
//                     label: 'Share',
//                     icon: const Icon(
//                       MdiIcons.shareOutline,
//                       size: 25.0,
//                     ))
//               ],
//             ),
//           )
//         ],
//       );
//     });

class _PostButton extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final Icon icon;
  final VoidCallback? onLongPress;

  const _PostButton(
      {super.key,
      required this.onTap,
      required this.label,
      required this.icon,
      this.onLongPress});

  @override
  State<_PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<_PostButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Container(
          height: 25.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(
                width: 10.0,
              ),
              Text(widget.label)
            ],
          ),
        ),
      ),
    );
  }
}
