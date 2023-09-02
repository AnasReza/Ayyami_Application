import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';

class Question_Upload extends StatefulWidget {
  String uid;

  Question_Upload({required this.uid, super.key});

  @override
  State<Question_Upload> createState() => _Question_UploadState();
}

class _Question_UploadState extends State<Question_Upload> {
  final questionController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("Question");
  final userNameController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   return Consumer<UserProvider>(builder: (c,provider,child){
     var lang=provider.getLanguage;
     var text=AppTranslate().textLanguage[lang];

     return Scaffold(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(
             child: Padding(
               padding: EdgeInsets.only(left: 30, right: 30),
               child: TextFormField(
                   keyboardType: TextInputType.text,
                   controller: questionController,
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
                   validator: (value) {}),
             ),
           ),
           SizedBox(height: 35),
           GradientButton(width: 320,
             title: text!['upload']!,
             onPressedButon: () {
               String question = questionController.text.toString();
               QuestionRecord().uploadQuestion(widget.uid, question);
               final snackBar = SnackBar(
                   content: Text('$question'),
                   action: SnackBarAction(
                     label: text['undo']!,
                     onPressed: () {},
                   ));
               ScaffoldMessenger.of(context).showSnackBar(snackBar);
             },
           )
         ],
       ),
     );
   });
  }
}
