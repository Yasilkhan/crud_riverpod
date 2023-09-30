import 'package:crud_riverpod/common/obsecuretext.dart';
import 'package:crud_riverpod/constant/logos.dart';
import 'package:crud_riverpod/features/controller/userLoginController/userSignInController.dart';
import 'package:crud_riverpod/models/user_model.dart';
import 'package:crud_riverpod/theme/color_bundel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  RegExp emailValidator =
      RegExp(r"(^[a-zA-Z0-9_-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
  RegExp passwordValidator =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool taped = true;


  void newUserSignIn (){

    ref.read(userSignInControllerProvider).newUserSignIn(
        email_controller.text,
        password_controller.text
    );
    email_controller.clear();
    password_controller.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: w * 0.8,
                child: Image.network(Logo.theamlogo),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email_controller,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!emailValidator.hasMatch(value!)) {
                    return "not Valid";
                  }
                },
                decoration: InputDecoration(
                    hintText: "E-mail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: taped==false? false:true,
                controller: password_controller,
                validator: (value) {
                  if (!passwordValidator.hasMatch(value!)) {
                    return "Not Valid";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {

                        setState(() {
                          taped=!taped;
                        });
                      },
                        child: taped == false
                            ? Icon(CupertinoIcons.eye_fill)
                            : Icon(CupertinoIcons.eye_slash_fill)),
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: w * 0.06,
              ),
              InkWell(
                onTap: () {

                  if(email_controller!=""&&password_controller!=""){
                    newUserSignIn();
                    Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    const CircularProgressIndicator();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account created")));
                  }
                  else{
                    email_controller==""?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not valid email"))):
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: SnackBar(content: Text("Not valid password"),)));
                  }
                },
                child: Container(
                  height: w * 0.15,
                  width: w * 0.8,
                  decoration: BoxDecoration(
                    color: ColorBundle.themeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                    "Sign In",
                    style: TextStyle(color: ColorBundle.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
