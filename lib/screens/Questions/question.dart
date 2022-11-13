
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_button.dart';

class Question_Upload extends StatefulWidget {
  const Question_Upload({super.key});

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
          GradientButton(
              title: "Upload",
              onPressedButon:(){
               String q_id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(q_id).set({
                       'Question': questionController.text.toString(),
                       'Q_id':q_id,

                    });

                 String question = questionController.text.toString();
                  final snackBar = SnackBar(
            content:  Text('$question'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: (){},
            ));
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            
            ,

        )
        ],
      ),
    );
  }
}
