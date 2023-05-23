import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/data/data.dart';
import 'package:new_spark/screens/edit_profile_screen.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/services/user_service.dart';
import 'package:new_spark/widgets/widgets.dart';

import '../models/user_server.dart';
import '../services/authentication.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Users> userMe;
  bool _isAuthorized = false;
  @override
  void initState() {
    _checkAuthorizationStatus();
    userMe = UserService().getMe(context);
    super.initState();
  }

//check jwt token function call
  Future<void> _checkAuthorizationStatus() async {
    bool isAuthorized = await Authentication().isAuthorized();
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(), //left-side drawer widget
        backgroundColor: Palette.scaffold,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.orange[700],
          titleSpacing: 10.0,
        ),
        //user data future builder
        body: FutureBuilder(
            future: userMe,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.hasError}');
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return Profile(
                  user: user,
                );
              } else {
                return const Text("No Data");
              }
            })));
  }
}
// }

class Profile extends StatelessWidget {
  final Users user;
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProfileHeader(user: user),
        Center(
          child: Text(
            //currentUser.name,
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
                color: Colors.deepOrange),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              //university
              ProfileData(
                  user, MdiIcons.school, 'Studies At ${user.university}'),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    //faculty
                    ProfileData(
                        user, MdiIcons.domain, 'Faculty of ${user.faculty}'),
                    //department
                    ProfileData(user, MdiIcons.officeBuilding,
                        (user.department == null) ? 'Empty' : user.department),
                  ],
                ),
              ),
              //TODO: change hardcoded data
              //school
              ProfileData(
                  user, MdiIcons.school, 'Studied At Royal College, Colombo'),
              //current town
              ProfileData(
                  user, MdiIcons.homeAccount, 'Current town/city Gampaha'),
              //home town
              ProfileData(user, MdiIcons.mapMarker, 'HomeTown Kaduwela'),
              //relationship status
              ProfileData(user, MdiIcons.heartMultiple, 'Relationship status'),
              //hobbies
              ProfileData(user, MdiIcons.run, 'Hobbies'),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 150.0,
                child: Center(
                  //edit profile page navigation
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditProfile(
                                    user: user,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue.shade400]),
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.pencilOutline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const MyImages(), //IMage Carousel for my images widget
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              //cv view and edit navigation
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My CV',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const MyCV()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.orange[700]),
                      ),
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 500.0,
        ),
      ],
    );
  }
}

Widget ProfileData(Users user, IconData icon, String data) => Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30.0,
            color: Colors.grey[600],
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            data,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          )
        ],
      ),
    );
