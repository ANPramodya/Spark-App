import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/screens/add_member_screen.dart';
import 'package:new_spark/services/group_service.dart';
import 'package:new_spark/widgets/gradient_text.dart';

import '../models/models.dart';
import '../widgets/group_members.dart';
import 'screens.dart';

class GroupScreen extends StatefulWidget {
  //passing group data
  final Group group;

  const GroupScreen({super.key, required this.group});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late String groupId;
  late Future<List<Posts>> groupPosts;
  late Future<List<UsersOnGroups>> groupFuture;

  @override
  void initState() {
    super.initState();
    groupId = widget.group.id;
    //get group data
    groupFuture = GroupService().getGroup(groupId, context);
    //get group post function call
    groupPosts = GroupService().getGroupPosts(groupId, context);
  }

  bool showDescription = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(
            text: 'Group Descripion',
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            gradient:
                LinearGradient(colors: [Colors.purple, Colors.blue.shade400])),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        leading: const BackButton(),
        actions: [
          PopupMenuButton<int>(
              elevation: 0.0,
              itemBuilder: ((context) => [
                    const PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.public),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Pending Posts')
                          ],
                        )),
                    const PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.badge),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Change Admins')
                          ],
                        )),
                    const PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(Icons.report),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Report')
                          ],
                        )),
                    const PopupMenuItem(
                        value: 4,
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Exit Group')
                          ],
                        ))
                  ])),
        ],
      ),
      body: SingleChildScrollView(
        //controller: controller,
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            //group image
            Center(
              child: CircleAvatar(
                radius: 70.0,
                backgroundColor: Colors.amber,
                backgroundImage: (widget.group.groupImage == null)
                    ? const CachedNetworkImageProvider(
                        'https://maa.net/wp-content/uploads/2021/11/team-placeholder.png')
                    : CachedNetworkImageProvider(widget.group.groupImage!),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            //group name
            Text(
              widget.group.groupName,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            //group desciption
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //tap to view more
              child: GestureDetector(
                onTap: () {
                  showDescription = true;
                },
                child: ExpandablePanel(
                  collapsed: Text(
                    widget.group.groupDescription,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    maxLines: 2,
                  ),
                  expanded: Text(
                    widget.group.groupDescription,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                height: 50.0,
                color: Colors.grey,
              ),
            ),
            //row of buttons (post, call, add members)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            gradient: LinearGradient(
                                colors: [Colors.purple, Colors.blue.shade400],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => new CreatePostScreen(
                                            group: widget.group,
                                          )));
                            },
                            icon: const Icon(
                              Icons.public,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    const Text('Post')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue.shade400],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            MdiIcons.phone,
                            color: Colors.white,
                          )),
                    ),
                    const Text('Call')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue.shade400],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight)),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddMemberScreen(
                                          groupId: widget.group.id,
                                        )));
                          },
                          icon: const Icon(
                            MdiIcons.accountPlus,
                            color: Colors.white,
                          )),
                    ),
                    const Text('Add')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue.shade400],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    ),
                    const Text('Search')
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              height: 400.0,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Media",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Gallery()));
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(
                                  'See More',
                                  style: TextStyle(color: Colors.orange[700]),
                                )))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  //post images corousal
                  FutureBuilder<List<Posts>>(
                      future: groupPosts,
                      builder: (((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.hasError}');
                        } else if (snapshot.hasData) {
                          final post = snapshot.data!;
                          if (post.length == 0) {
                            return const Text("No data");
                          } else {
                            return CarouselSlider.builder(
                                itemCount: post.length,
                                itemBuilder: (context, index, realIndex) {
                                  final urlImage = post[index].postImg;
                                  return _buildImage(urlImage, index);
                                },
                                options: CarouselOptions(
                                    height: 300.0,
                                    autoPlay: true,
                                    enlargeCenterPage: true));
                          }
                        } else {
                          return const Text('No Data');
                        }
                      })))
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              width: MediaQuery.of(context).size.width * 0.95,
              ////////////////////////////////////////////////////////////////////
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Participants',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddMemberScreen(
                                        groupId: widget.group.id,
                                      )));
                        },
                        child: const Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.add,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                            Text('Add Participants')
                          ],
                        ),
                      ),
                    ),
                  ),
                  //users on groups column
                  FutureBuilder<List<UsersOnGroups>>(
                      future: groupFuture,
                      builder: ((context, snapshot) {
                        //check data
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.hasError}');
                        } else if (snapshot.hasData) {
                          final user = snapshot.data!;
                          return groupMembers(user);
                        } else {
                          return const Text('No Data');
                        }
                      }))
                ],
              ),
            ),
            const SizedBox(
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String urlImage, int index) => Container(
        color: Colors.grey,
        child: CachedNetworkImage(
          imageUrl: urlImage,
          fit: BoxFit.fill,
        ),
      );
}
