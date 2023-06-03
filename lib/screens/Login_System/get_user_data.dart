import 'dart:io';

import 'package:ayyami/constants/const.dart';
import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Questions/Are_you_beginner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';

class set_password extends StatefulWidget {
  final contact_number;
  final user_id;

  const set_password({super.key, required this.contact_number, required this.user_id});

  @override
  State<set_password> createState() => _set_passwordState();
}

class _set_passwordState extends State<set_password> {
  //Image variables

  //  _set_passwordState(contact_number, user_id);

  final ImagePicker picker = ImagePicker();
  File? imageData;
  String assetsPath = "assets/images/demo_profile.png";

  Future getImageFromCamera(BuildContext context) async {
    final img = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      if (img != null) {
        imageData = File(img.path);
        Navigator.pop(context);
      } else {
        toast_notification().toast_message("Image not captured");
      }
    });
  }

  Future getImageFromGallery(BuildContext context) async {
    final img = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (img != null) {
        imageData = File(img.path);
        Navigator.pop(context);
      } else {
        toast_notification().toast_message("Image not selected");
      }
    });
  }

  //Data get to firebase
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final userNameController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  // final String contact_number;
  // final String user_id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(
      builder: (c, provider, child) {
        var lang = provider.getLanguage;
        var text = AppTranslate().textLanguage[lang];

        return Scaffold(
          backgroundColor: const Color(0xffF5F5F5),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  Container(
                    height: 150,
                    width: 230,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    child: Form(
                      key: formKey, //Key for Form Start
                      child: Column(children: [
                        Text(
                          text!['set_profile_data']!,
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'DMSans',
                            color: Color(0xff1F3D73),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            //----Dialog Start-----

                            showDialog(
                                context: context,
                                builder: (BuildContext dialogContex) {
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
                                                    padding: EdgeInsets.symmetric(vertical: 30)),
                                                Text(
                                                  text['choose']!,
                                                  style: const TextStyle(
                                                    fontSize: 24.0,
                                                    fontFamily: 'DMSans',
                                                    color: Color(0xff1F3D73),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 30),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(30, 0, 10, 10),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 30),
                                                          child: Column(
                                                            children: [
                                                              InkWell(
                                                                  child: const Icon(
                                                                    Icons.camera_alt,
                                                                    size: 40,
                                                                    color: Color(0xff1F3D73),
                                                                  ),
                                                                  onTap: () {
                                                                    getImageFromCamera(
                                                                        dialogContex);
                                                                  }),
                                                              const SizedBox(height: 5),
                                                              Text(
                                                                text['camera']!,
                                                                style: TextStyle(
                                                                  fontSize: 18.0,
                                                                  fontFamily: 'DMSans',
                                                                  color: Color(0xff1F3D73),
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 40),
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 0),
                                                          child: Column(
                                                            children: [
                                                              InkWell(
                                                                child: const Icon(
                                                                  Icons.image,
                                                                  size: 40,
                                                                  color: Color(0xff1F3D73),
                                                                ),
                                                                onTap: () //Gallery OnTap

                                                                    {
                                                                  getImageFromGallery(dialogContex);
                                                                },
                                                              ),
                                                              const SizedBox(height: 5),
                                                              Text(
                                                                text['gallery']!,
                                                                style: TextStyle(
                                                                  fontSize: 18.0,
                                                                  fontFamily: 'DMSans',
                                                                  color: Color(0xff1F3D73),
                                                                  fontWeight: FontWeight.w400,
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
                                    size: const Size.fromRadius(90),
                                    child: imageData != null
                                        ? Image.file(
                                            imageData!.absolute,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.asset(
                                            assetsPath,
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
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Image.asset("assets/images/camera.png"),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(right: 220),
                          child: Text(
                            text['username']!,
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8F92A1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
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
                                  return text['enter_name'];
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
                  const SizedBox(height: 25),
                  GradientButton(
                    width: 320,
                    title: text['sign_in']!,
                    loading: loading,
                    onPressedButon: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        String? uid = FirebaseAuth.instance.currentUser?.uid;

                        firebase_storage.Reference ref =
                            firebase_storage.FirebaseStorage.instance.ref('/$uid/dp-$uid');

                        if (imageData == null) {
                          await rootBundle.load(assetsPath).then((bytes) async {
                            final Uint8List list = bytes.buffer.asUint8List();
                            firebase_storage.UploadTask uploadImage = ref.putData(list);
                            await Future.value(uploadImage);
                            var newUrl = await ref.getDownloadURL();

                            FirebaseFirestore.instance.collection('users').doc(uid).set({
                              'user_name': userNameController.text.toString(),
                              'contact_no': widget.contact_number,
                              "imgUrl": newUrl,
                              'uid': uid
                            }).then((value) {
                              final provider = Provider.of<UserProvider>(context, listen: false);
                              provider.setUID(uid!);
                              provider.setSadqaAmount(0);
                              setHive(uid!);
                              nextScreen(
                                  context,
                                  first_question(
                                    uid: uid,
                                    darkMode: false,
                                    fromProfile: false,
                                  ));
                            });
                          });
                        } else {
                          firebase_storage.UploadTask uploadImage =
                              ref.putFile(imageData!.absolute);
                          await Future.value(uploadImage);
                          var newUrl = await ref.getDownloadURL();

                          FirebaseFirestore.instance.collection('users').doc(uid).set({
                            'user_name': userNameController.text.toString(),
                            'contact_no': widget.contact_number,
                            "imgUrl": newUrl,
                            'uid': uid
                          }).then((value) {
                            final provider = Provider.of<UserProvider>(context, listen: false);
                            provider.setUID(uid!);
                            provider.setSadqaAmount(0);
                            setHive(uid!);
                            UsersRecord().updateSadqaAmount(uid!, 0);
                            UsersRecord().updateShowSadqa(uid!, true);
                            UsersRecord().updateShowNamaz(uid!, 'show_fajar', true);
                            UsersRecord().updateShowNamaz(uid!, 'show_sunrise', true);
                            UsersRecord().updateShowNamaz(uid!, 'show_duhur', true);
                            UsersRecord().updateShowNamaz(uid!, 'show_asr', true);
                            UsersRecord().updateShowNamaz(uid!, 'show_maghrib', true);
                            UsersRecord().updateShowNamaz(uid!, 'show_isha', true);
                            UsersRecord().updateShowMedicine(uid!, true);
                            UsersRecord().updateShowCycle(uid!, true);

                            provider.setShowFajar(true);
                            provider.setShowSunrise(true);
                            provider.setShowDuhur(true);
                            provider.setShowAsr(true);
                            provider.setShowMaghrib(true);
                            provider.setShowIsha(true);
                            provider.setShowMedicine(true);
                            provider.setShowMedicine(true);
                            provider.setShowCycle(true);
                            nextScreen(
                                context,
                                first_question(
                                  uid: uid,
                                  darkMode: false,
                                  fromProfile: false,
                                ));
                          });
                        }
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
      },
    );
  }

  void setHive(String uid) async {
    var box = await Hive.openBox('aayami');
    box.put('uid', uid);
    box.put('login', true);
  }

  Future<File> getImageFileFromAssets(String assetsPath) async {
    final byteData = await rootBundle.load(assetsPath);

    final file = File('${(await getTemporaryDirectory()).path}/$assetsPath');
    await file
        .writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
}
