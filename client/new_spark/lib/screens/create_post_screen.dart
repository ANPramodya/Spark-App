import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/services/posts_service.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';
import 'package:new_spark/widgets/gradient_text.dart';

import '../models/models.dart';

class CreatePostScreen extends StatefulWidget {
  final Group group;

  const CreatePostScreen({super.key, required this.group});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  //TODO: get from db
  List<String> items = [
    'Public',
    "Super Public",
    "University",
    "Faculty",
    "Department"
  ];
  String? selectedItem = 'Public';
  TextEditingController postCaptionController = TextEditingController();

  File? image;

//pick post image from gallery or camera
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
      appBar: AppBar(
        title: GradientText(
          text: 'Create Post',
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          gradient:
              LinearGradient(colors: [Colors.purple, Colors.blue.shade400]),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //post caption textfield
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Post Caption',
                      ),
                      controller: postCaptionController,
                      maxLength: 1000,
                    ),
                    //if image empty show default
                    image != null
                        ? Center(
                            child: Image.file(
                              image!,
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(colors: [
                                Colors.purple,
                                Colors.blue.shade400
                              ]),
                            ),
                            //chosse between gallery and camera
                            child: IconButton(
                              onPressed: () {
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
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Colors.purple,
                                                            Colors.blue.shade400
                                                          ],
                                                          begin: Alignment
                                                              .bottomLeft,
                                                          end: Alignment
                                                              .topRight),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  //choose gallery
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        pickImage(ImageSource
                                                            .gallery);
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
                                                          begin: Alignment
                                                              .bottomLeft,
                                                          end: Alignment
                                                              .topRight),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  //choose camera
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        pickImage(
                                                            ImageSource.camera);
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
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
                              icon: Icon(
                                MdiIcons.plusBox,
                                size: 100.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    //set visibility dropdown
                    SizedBox(
                      width: 200.0,
                      child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              hintText: "Choose Visibility",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400))),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                                selectedItem = item;
                              })),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //TODO: save post to publish later
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue.shade400])),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ))),
                  const SizedBox(
                    width: 20.0,
                  ),
                  //publish post button
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue.shade400])),
                      //publish o=post function call
                      child: TextButton(
                          onPressed: () async {
                            try {
                              PostService.publishPost(
                                  postCaptionController.text.trim(),
                                  selectedItem!,
                                  widget.group.id,
                                  image,
                                  'post/image',
                                  context);
                              showInfoSnackbar(context, 'Publishing..');
                            } catch (e) {}
                          },
                          child: const Text(
                            'Publish',
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
