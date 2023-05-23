import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/screens/profile_screen.dart';
import 'package:new_spark/services/user_service.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';

import '../config/palette.dart';
import '../models/user_server.dart';

class EditProfile extends StatefulWidget {
  //passing user data
  final Users user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? profilePic;

//pick image from gallery or camera
  Future<File> pickImage(ImageSource imageSource) async {
    Completer<File> completer = Completer();
    try {
      final image = await ImagePicker().pickImage(source: imageSource);

      //ImagePicker.pickVideo()
      if (image == null) {
        completer.complete(null);
      } else {
        final imageFile = File(image.path);
        completer.complete(imageFile);
      }
    } on PlatformException catch (e) {
      completer.completeError('Failed to Pick Image: $e');
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          //TODO: check something to be saved
          leading: const BackButton(),
          title: const Text('Edit Profile'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profile Picture',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    //choose between camera or gallery
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    height: 100.0,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text('Gallery or Camera'),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.purple,
                                                        Colors.blue.shade400
                                                      ],
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              //chose gallery
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () async {
                                                    try {
                                                      var pickedImage =
                                                          await pickImage(
                                                              ImageSource
                                                                  .gallery);
                                                      //update profile pic function call
                                                      if (pickedImage != null) {
                                                        showInfoSnackbar(
                                                            context,
                                                            'Uploading Profile picture');
                                                        UserService.editProfilePic(
                                                            pickedImage,
                                                            'users/profilePic',
                                                            widget.user.id,
                                                            context);
                                                        showSuccessSnackbar(
                                                            context,
                                                            'SuccessFully Uploaded');
                                                      }
                                                    } catch (e) {
                                                      showErrorSnackbar(context,
                                                          'Upload Failed! Something went wrong');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.image_outlined,
                                                    size: 30.0,
                                                  )),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.purple,
                                                        Colors.blue.shade400
                                                      ],
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              //chose camera
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    pickImage(
                                                        ImageSource.camera);
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 30.0,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16.0),
                        ))
                  ],
                ),
                //profile picture circle avatar
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.white,
                  backgroundImage: (widget.user.profilePic != null)
                      ? CachedNetworkImageProvider(widget.user.profilePic)
                      : const CachedNetworkImageProvider(
                          "https://www.kirkham-legal.co.uk/wp-content/uploads/2017/02/profile-placeholder.png"),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cover Photo',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    //choose between camera and gallery
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    height: 100.0,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text('Gallery or Camera'),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.purple,
                                                        Colors.blue.shade400
                                                      ],
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              //chose gallery
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () async {
                                                    try {
                                                      var pickedImage =
                                                          await pickImage(
                                                              ImageSource
                                                                  .gallery);

                                                      if (pickedImage != null) {
                                                        showInfoSnackbar(
                                                            context,
                                                            "Uploading cover photo");
                                                        UserService.editCoverPhoto(
                                                            pickedImage,
                                                            'users/profilePic',
                                                            widget.user.id,
                                                            context);
                                                        showSuccessSnackbar(
                                                            context,
                                                            'Successfully Uploaded');
                                                      }
                                                    } catch (e) {
                                                      showErrorSnackbar(context,
                                                          'Upload Failed! Something went wrong');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.image_outlined,
                                                    size: 30.0,
                                                  )),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.purple,
                                                        Colors.blue.shade400
                                                      ],
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              //chose camera
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    pickImage(
                                                        ImageSource.camera);
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 30.0,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16.0),
                        ))
                  ],
                ),
                //cover photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: (widget.user.coverImg != null)
                        ? CachedNetworkImage(
                            imageUrl: widget.user.coverImg, fit: BoxFit.cover)
                        : CachedNetworkImage(
                            imageUrl:
                                'https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Public Details',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          try {
                            throw Exception('Example exception');
                          } catch (e) {
                            showSuccessSnackbar(context,
                                'Showing error with some other infomation which will over flow this and we will see how it handles the overflow and i am excited');
                          }
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16.0),
                        ))
                  ],
                ),
                const SizedBox(height: 15.0),
                Column(
                  children: [
                    //university
                    ProfileData(widget.user, MdiIcons.school,
                        'Studies At ${widget.user.university}'),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          //faculty
                          ProfileData(widget.user, MdiIcons.domain,
                              'Faculty of ${widget.user.faculty}'),
                          ProfileData(
                              widget.user,
                              MdiIcons.officeBuilding,
                              (widget.user.department == null)
                                  ? 'Empty'
                                  : widget.user.department),
                        ],
                      ),
                    ),
                    //TODO: remove hardcoded data
                    //school
                    ProfileData(widget.user, MdiIcons.school,
                        'Studied At Royal College, Colombo'),
                    //current town
                    ProfileData(widget.user, MdiIcons.homeAccount,
                        'Current town/city Gampaha'),
                    //home town
                    ProfileData(
                        widget.user, MdiIcons.mapMarker, 'HomeTown Kaduwela'),
                    //hobbies
                    ProfileData(widget.user, MdiIcons.run, 'Hobbies'),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Contact Details',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        //TODO: edit contacts
                        onPressed: () {},
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16.0),
                        ))
                  ],
                ),
                Column(
                  children: [
                    //uniemail
                    ProfileData(
                        widget.user, MdiIcons.emailLock, widget.user.uniEmail),
                    //moibile phone
                    ProfileData(
                        widget.user, MdiIcons.cellphoneLock, '+9476 70 65 262'),
                    //fixed line
                    ProfileData(
                        widget.user, MdiIcons.phoneLock, '011 2 450 405'),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Basic Info',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16.0),
                        ))
                  ],
                ),
                //TODO: change hardcoded data
                //gender
                ProfileData(widget.user, MdiIcons.account, 'Male'),
                //birth date
                ProfileData(widget.user, MdiIcons.cake, '6 July 1998'),
                const SizedBox(
                  height: 30.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Relationship Info',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        //TODO: edit relationship status
                        onPressed: () {},
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16.0),
                        ))
                  ],
                ),
                //TODO: change hard coded data
                //relationship status
                ProfileData(widget.user, MdiIcons.heartMultiple, 'Single'),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ));
  }
}
