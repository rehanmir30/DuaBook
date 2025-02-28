import 'package:duabook/constants/userData.dart';
import 'package:duabook/screens/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../animations/fadeInAnimationBTT.dart';
import '../../animations/fadeInAnimationTTB.dart';
import '../../constants/colors.dart';
import '../../controller/themeController.dart';
import '../../controller/userController.dart';
import '../../services/authService.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rwhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ThemeController>(
            builder: (themeController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 8,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffEEB6A3),
                          Color(0xffC3CCF6),
                        ],
                      )),
                      alignment: Alignment.center,
                      child: GetBuilder<UserController>(
                        builder: (userController) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: rblack,
                                  ).marginSymmetric(horizontal: 12),
                                ),
                              ),
                              FadeInAnimationTTB(
                                delay: 1,
                                child: InkWell(
                                  onTap: _showAvatarPopup,
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(
                                          color: themeController.selectedAgeGroup == 0
                                              ? rpink
                                              : themeController.selectedAgeGroup == 1
                                                  ? rblue
                                                  : rgreen,
                                          width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: userController.avatar != "" ? ClipOval(child: Image.asset(userController.avatar)) : SizedBox(),
                                  ),
                                ),
                              ),
                              FadeInAnimationBTT(
                                  delay: 1,
                                  child: Text(
                                    "${userName}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ).marginOnly(top: 8))
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(fontSize: 18, color: rblack, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (name) {
                            if (name == null) {
                              return "Name is required";
                            } else {
                              nameController.text == name;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ).marginOnly(top: 10),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 18, color: rblack, fontWeight: FontWeight.bold),
                        ).marginOnly(top: 20),
                        TextFormField(
                          controller: emailController,
                          validator: (email) {
                            if (email == null) {
                              return "Email is required";
                            } else {
                              emailController.text = email;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ).marginOnly(top: 12),
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 18, color: rblack, fontWeight: FontWeight.bold),
                        ).marginOnly(top: 20),
                        TextFormField(
                          controller: passwordController,
                          validator: (password) {
                            if (password == null) {
                              return "Password is required";
                            } else {
                              passwordController.text = password;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ).marginOnly(top: 12),
                        Text(
                          "Confirm Password",
                          style: TextStyle(fontSize: 18, color: rblack, fontWeight: FontWeight.bold),
                        ).marginOnly(top: 20),
                        TextFormField(
                          controller: cPasswordController,
                          validator: (cPassword) {
                            if (cPassword == null||cPassword.isEmpty) {
                              return "Confirm your password";
                            } else if(passwordController.text!=cPassword){
                              return "Passwords don't match";
                            }else {
                              cPasswordController.text = cPassword;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ).marginOnly(top: 12),
                        InkWell(
                          onTap: () async{
                            if (formKey.currentState != null && formKey.currentState!.validate()) {
                              await AuthService().register(emailController.text, passwordController.text,nameController.text,cPasswordController.text);

                            } else {
                              return;
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rbluedark),
                            child: Text(
                              "Create an account",
                              style: TextStyle(color: rwhite),
                            ),
                          ).marginOnly(top: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: rblack),
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(LoginScreen(), transition: Transition.downToUp);
                                  },
                                  child: Text(
                                    "Login now! ",
                                    style: TextStyle(color: rbluedark, fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ).marginSymmetric(horizontal: 20, vertical: 20),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showAvatarPopup() async {
    String? avatarPath = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Your Avatar"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _avatarOption(context, "assets/images/male.png"),
              _avatarOption(context, "assets/images/female.png"),
            ],
          ),
        );
      },
    );

    if (avatarPath != null) {
      Get.find<UserController>().setAvatar(avatarPath);
    }
  }

  Widget _avatarOption(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, imagePath); // Return selected image path
      },
      child: Image.asset(imagePath, width: 80, height: 80),
    );
  }
}
