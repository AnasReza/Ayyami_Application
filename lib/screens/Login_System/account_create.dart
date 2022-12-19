import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';

import 'otp_page.dart';

class account_create extends StatefulWidget {
  const account_create({super.key});

  @override
  State<account_create> createState() => _account_createState();
}

class _account_createState extends State<account_create> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Global key
  final phoneNumberController = TextEditingController();
  bool loading = false;
  String get_contact = "";
  final auth = FirebaseAuth.instance;
  String initialCountry = 'PK'; //country picker
  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 230,
                  child: Image.asset("assets/images/logo.png"),
                ),
                const SizedBox(height: 35),
                Text(
                  "Create an account".tr,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'DMSans',
                    color: Color(0xff1F3D73),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 55),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone Number".tr,
                      style: const TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8F92A1),
                      ),
                    )),
                const SizedBox(height: 5),
                Form(
                  key: formKey,
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 15, left: 30, bottom: 5),
                    child: Column(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            get_contact = number.phoneNumber!;
                            print(get_contact);
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          initialValue: number,
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          textFieldController: phoneNumberController,
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            showFlags: true,
                          ),
                          inputDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Number after country code".tr,
                              hintStyle: const TextStyle(),
                              suffixIcon: const Icon(
                                Icons.check,
                                color: Color(0xffC58DD8),
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xff8F92A1),
                  thickness: 1,
                  indent: 30,
                  endIndent: 30,
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Text(
                    "A 6 digit OTP will be sent via SMS to verify your mobile number"
                        .tr,
                    style: const TextStyle(
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                GradientButton(
                    title: 'Send Code'.tr,
                    loading: loading,
                    onPressedButon: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        auth.verifyPhoneNumber(
                            phoneNumber: get_contact,
                            timeout: const Duration(seconds: 20),
                            verificationCompleted: (_) {
                              setState(() {
                                loading = false;
                              });
                            },
                            verificationFailed: (e) {
                              setState(() {
                                loading = false;
                              });
                              toast_notification().toast_message(e.toString());
                            },
                            codeSent: (String verification_Id, int? token_ID) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => otp_page(
                                            verificationId: verification_Id,
                                            get_number: get_contact,
                                          )));

                              setState(() {
                                loading = true;
                              });
                            },
                            codeAutoRetrievalTimeout: (e) {
                              toast_notification().toast_message(e.toString());
                              setState(() {
                                loading = false;
                              });
                            });
                      }
                    }),
               
                               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
