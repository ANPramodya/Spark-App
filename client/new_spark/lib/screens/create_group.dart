import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_spark/services/services.dart';

import '../widgets/gradient_text.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();

  File? image;

//pick image from gallery or camera and store temporarily to show
  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);

      //ImagePicker.pickVideo()
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick Image ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: GradientText(
          text: 'Create Group',
          style: const TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.bold, letterSpacing: 1.7),
          gradient:
              LinearGradient(colors: [Colors.purple, Colors.blue.shade400]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  //choose between gallery and camera
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 80.0,
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
                                    padding: const EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.purple,
                                              Colors.blue.shade400
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    //choose gallery
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          pickImage(ImageSource.gallery);
                                        },
                                        icon: const Icon(
                                          Icons.image_outlined,
                                          size: 30.0,
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.purple,
                                              Colors.blue.shade400
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        // choose camera
                                        onPressed: () {
                                          pickImage(ImageSource.camera);
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
                        );
                      });
                },
                //image circle
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 70.0,
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    //if image, show, else default image
                    child: (image != null)
                        ? Image.file(
                            image!,
                            height: 300.0,
                            width: 300.0,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/profile.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              //group name textfield
              TextFormField(
                controller: groupNameController,
                decoration: const InputDecoration(hintText: 'Group Name'),
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(),
                textAlign: TextAlign.center,
                autovalidateMode: AutovalidateMode.always,
              ),
              const SizedBox(
                height: 20.0,
              ),
              //group description textfield
              TextFormField(
                controller: groupDescriptionController,
                decoration:
                    const InputDecoration(hintText: 'Group Description'),
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(),
                textAlign: TextAlign.center,
                autovalidateMode: AutovalidateMode.always,
              ),
              const SizedBox(
                height: 20.0,
              ),
              //create group function call
              MaterialButton(
                  onPressed: () {
                    GroupService().createGroup(groupNameController.text,
                        groupDescriptionController.text, image, context);

                    groupNameController.clear();
                    groupDescriptionController.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  color: Colors.green,
                  child: const Text('Create'))
            ],
          ),
        ),
      ),
    );
  }
}
