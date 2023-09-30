import 'package:crud_riverpod/constant/logos.dart';
import 'package:crud_riverpod/common/loginButton.dart';
import 'package:crud_riverpod/features/controller/userLoginController/userSignInController.dart';
import 'package:crud_riverpod/features/screens/auth/sign_in.dart';
import 'package:crud_riverpod/features/screens/home_page.dart';
import 'package:crud_riverpod/theme/color_bundel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var h;
var w;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  RegExp emailValidator =
      RegExp(r"(^[a-zA-Z0-9_-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
  RegExp passwordValidator =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  loginOnUser() {
    ref
        .read(userSignInControllerProvider)
        .loginOnUser(email_controller.text, password_controller.text);
    email_controller.clear();
    password_controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
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
                controller: email_controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!emailValidator.hasMatch(value!)) {
                    return "Not Valid";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
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
                controller: password_controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!passwordValidator.hasMatch(value!)) {
                    return "Not Valid";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: w * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You don't have account ? ",
                    style: TextStyle(color: ColorBundle.grey),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ));
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: ColorBundle.themeColor),
                      )),
                ],
              ),
              SizedBox(
                height: w * 0.06,
              ),
              InkWell(
                onTap: () {
                  if(email_controller.text!=""&&password_controller.text!=""){
                    loginOnUser();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Figma(),));
                  }
                  else{
                    email_controller.text==""?
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter E-mail"))):
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Password")));

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
                    "Login",
                    style: TextStyle(color: ColorBundle.white),
                  )),
                ),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              Text(
                "Continue with google account",
                style: TextStyle(color: ColorBundle.grey),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorBundle.white,
                    backgroundImage: NetworkImage(Logo.googleLogo),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
