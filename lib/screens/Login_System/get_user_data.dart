import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';


class set_password extends StatefulWidget {
  final contact_number;
  final user_id;

  const set_password(
      {super.key, required this.contact_number, required this.user_id});

  @override
  State<set_password> createState() => _set_passwordState();
}

class _set_passwordState extends State<set_password> {
  //Image variables

  //  _set_passwordState(contact_number, user_id);

  final ImagePicker picker = ImagePicker();
  File? imageData;

  Future getImageFromCamera() async {
    final img =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      if (img != null) {
        imageData = File(img.path);
      } else {
        toast_notification().toast_message("Image not captured");
      }
    });
  }

  Future getImageFromGallery() async {
    final img =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (img != null) {
        imageData = File(img.path);
      } else {
        toast_notification().toast_message("Image not selected");
      }
    });
  }

  //Data get to firebase
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final databaseRef = FirebaseDatabase.instance.ref("Users");
  final userNameController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  // final String contact_number;
  // final String user_id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Container(
                height: 150,
                width: 230,
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: 40),
              Container(
                child: Form(
                  key: formKey, //Key for Form Start
                  child: Column(children: [
                    const Text(
                      "Set Profile Data",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'DMSans',
                        color: Color(0xff1F3D73),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () 
                          { 
                            //----Dialog Start-----

                             showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: 250,
                                        child: Column(
                                          children: [
                                            const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 30)),
                                            const Text(
                                              "Choose",
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontFamily: 'DMSans',
                                                color: Color(0xff1F3D73),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 0, 10, 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 30),
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                              child: const Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                size: 40,
                                                                color: Color(
                                                                    0xff1F3D73),
                                                              ),
                                                              onTap: () {
                                                                getImageFromCamera();
                                                              
                                                              }),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text(
                                                            "Camera",
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontFamily:
                                                                  'DMSans',
                                                              color: Color(
                                                                  0xff1F3D73),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 40),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0),
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                            child: const Icon(
                                                              Icons.image,
                                                              size: 40,
                                                              color: Color(
                                                                  0xff1F3D73),
                                                            ),
                                                            onTap:
                                                                () //Gallery OnTap

                                                                {
                                                              getImageFromGallery();
                                                             
                                                            },
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text(
                                                            "Gallery",
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontFamily:
                                                                  'DMSans',
                                                              color: Color(
                                                                  0xff1F3D73),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: -65,
                                        child: Image.asset(
                                          'assets/images/dialog_icon.png',
                                          height: 100,
                                          width: 100,
                                        ),
                                      )
                                    ],
                                  ));
                            });

                          }, //----Dialog End-----
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 100,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(90),
                                child: imageData != null
                                    ? Image.file(
                                        imageData!.absolute,
                                      
                                        fit: BoxFit.fitWidth,
                                      )
                                    : Image.asset(
                                        "assets/images/demo_profile.png",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: -5,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: Image.asset("assets/images/camera.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    const Padding(
                      padding: const EdgeInsets.only(right: 220),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8F92A1),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 46, left: 46),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: userNameController,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "",
                            icon: Icon(
                              Icons.person_outline,
                              color: Color(0xff171717),
                              size: 25,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your Name";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ]),
                ),
              ),
              const Divider(
                color: Color(0xff8F92A1),
                thickness: 1,
                indent: 35,
                endIndent: 35,
              ),
              SizedBox(height: 25),
              GradientButton(
                title: "Sign In",
                loading: loading,
                onPressedButon: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    String uid =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/AyyamiApplication$uid');

                    firebase_storage.UploadTask uploadImage =
                        ref.putFile(imageData!.absolute);
                    await Future.value(uploadImage);
                    var newUrl = await ref.getDownloadURL();

                    databaseRef.child(uid).set({
                      'user_name': userNameController.text.toString(),
                      'contact_no': widget.contact_number,
                      "title": newUrl.toString(),
                      'u_id': uid
                    });

                    toast_notification().toast_message("uploadImage");

                

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => first_question()));
                  } else {
                    setState(() {
                      loading = false;
                    });
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}


