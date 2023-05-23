import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/services/authentication.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  final padding = const EdgeInsets.symmetric(horizontal: 20.0);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Palette.scaffold,
        child: ListView(
          children: [
            buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  buildMenuItem(
                      text: 'People', icon: Icons.people, onClick: () {}),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'Favourites',
                      icon: Icons.favorite_border,
                      onClick: () {}),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'WorkFlow',
                      icon: Icons.workspaces_outline,
                      onClick: () {}),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'Updates', icon: Icons.update, onClick: () {}),
                  const Divider(
                    color: Colors.white60,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'Plugins',
                      icon: Icons.account_tree_outlined,
                      onClick: () {}),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'Notifications',
                      icon: Icons.notifications_outlined,
                      onClick: () {}),
                  const Divider(
                    color: Colors.white60,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'Settings',
                      icon: Icons.settings_outlined,
                      onClick: () {}),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout_outlined,
                      onClick: () async {
                        //delete AccessToken
                        await Authentication().logout(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SigninScreen()));
                        //navigate to login page
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClick}) {
    const color = Colors.black;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onClick,
    );
  }

  Widget buildHeader() {
    return InkWell(
      onTap: () {},
      child: Stack(children: [
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl:
                "https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image.png",
            //imageUrl: stories[3].imageUrl,
          ),
        ),
        Container(
          height: 203.0,
          width: 300.0,
          decoration: const BoxDecoration(
            gradient: Palette.storyGradient,
          ),
        ),
        Positioned(
          bottom: 15.0,
          left: 15.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: CachedNetworkImageProvider(
                    //currentUser.imageUrl
                    "https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png"),
              ),
              const SizedBox(
                width: 50.0,
              ),
              // Text(
              //   //currentUser.name,
              //   "Red Riding Hood",
              //   style: const TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20.0),
              // )
            ],
          ),
        ),
      ]),
    );
  }
}
