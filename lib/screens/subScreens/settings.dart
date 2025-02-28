import 'package:duabook/animations/fadeInAnimationBTT.dart';
import 'package:duabook/animations/fadeInAnimationTTB.dart';
import 'package:duabook/constants/colors.dart';
import 'package:duabook/constants/userData.dart';
import 'package:duabook/controller/themeController.dart';
import 'package:duabook/controller/userController.dart';
import 'package:duabook/screens/auth/signupScreen.dart';
import 'package:duabook/screens/subSettings/accountSettings.dart';
import 'package:duabook/screens/subSettings/downloadSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settingsModel.dart';
import '../subSettings/aboutScreen.dart';
import '../subSettings/languageSettings.dart';
import '../subSettings/premiumSettings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<SettingsModel> settingsList = [
    SettingsModel(title: "Account", subTitle: "Profile settings", icon: Icons.person_2_outlined),
    SettingsModel(title: "Downloads", subTitle: "Audio Downloads", icon: Icons.download),
    SettingsModel(title: "Language", subTitle: "", icon: Icons.language),
    SettingsModel(title: "Premium", subTitle: "Premium Account", icon: Icons.workspace_premium),
    SettingsModel(title: "Share", subTitle: "Share App", icon: Icons.share),
    // SettingsModel(title: "About", subTitle: "Feedback form", icon: Icons.person_3_outlined),
  ];

  accountSettings() {
    if (Get.find<UserController>().isLoggedIn) {
      Get.to(AccountSettings(), transition: Transition.fade);
    } else {
      Get.snackbar(
        colorText: Colors.white,
        "Not logged in",
        "You are not logged in currently. Please login to your account.",
        backgroundColor: Colors.red,
      );
    }
  }

  downloadSettings() {
    Get.to(DownloadSettings(), transition: Transition.fade);
  }

  languageSettings() {
    Get.to(LanguageSettings(), transition: Transition.fade);
  }

  premiumSettings() {
    Get.to(PremiumSettings(), transition: Transition.fade);
  }

  shareApp() {}

  about() {
    Get.to(AboutScreen(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    List functionsList = [accountSettings, downloadSettings, languageSettings, premiumSettings, shareApp, about];
    return SafeArea(
        child: Scaffold(
      backgroundColor: rwhite,
      body: SingleChildScrollView(
        child: GetBuilder<ThemeController>(
          builder: (themeController) {
            return Column(
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
                      builder: (userController){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                  child: userController.avatar!=""?ClipOval(child: Image.asset(userController.avatar)):SizedBox(),
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
                FadeInAnimationTTB(
                  delay: 1,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width <= 450 ? 1 : 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 5),
                    itemCount: settingsList.length,
                    itemBuilder: (context, index) {
                      return SettingTile(settingsList[index], functionsList[index]);
                    },
                  ).marginOnly(top: 12),
                ),
                GetBuilder<UserController>(builder: (userController) {
                  return InkWell(
                    onTap: ()async{
                      if(userController.isLoggedIn){
                        SharedPreferences prefs=await SharedPreferences.getInstance();
                        prefs.clear();
                        userController.setLoggedIn(false);
                      }else{
                        Get.to(SignupScreen(),transition: Transition.downToUp);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: userController.isLoggedIn ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            userController.isLoggedIn ? Icons.logout : Icons.contact_mail_outlined,
                            color: rwhite,
                          ),
                          Text(
                            userController.isLoggedIn ? "Logout" : "Login",
                            style: TextStyle(color: rwhite),
                          ).marginOnly(left: 8),
                        ],
                      ).paddingAll(12),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ),
    ));
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

}

Widget _avatarOption(BuildContext context, String imagePath) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context, imagePath); // Return selected image path
    },
    child: Image.asset(imagePath, width: 80, height: 80),
  );
}


class SettingTile extends StatefulWidget {
  final SettingsModel _settingsModel;
  final function;

  const SettingTile(this._settingsModel, this.function, {super.key});

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.function();
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(color: Color(0xff89A2FB), borderRadius: BorderRadius.circular(19)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              widget._settingsModel.icon,
              color: rblack.withOpacity(0.6),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget._settingsModel.title,
                  style: TextStyle(color: rblack, fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget._settingsModel.subTitle,
                  style: TextStyle(color: rblack.withOpacity(0.6), fontSize: 19),
                ),
              ],
            )
          ],
        ).marginSymmetric(horizontal: 20),
      ),
    );
  }
}
