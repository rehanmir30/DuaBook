import 'package:duabook/controller/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../animations/fadeInAnimationBTT.dart';
import '../../animations/fadeInAnimationTTB.dart';
import '../../constants/colors.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetBuilder<ThemeController>(
            builder: (themeController){
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
                          )
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back,color: rblack,))),
                          FadeInAnimationTTB(
                            delay: 1,
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
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 12),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: rpurpleShade
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(fontSize: 18,color: rblack),
                            border: InputBorder.none, // No border
                          ),
                          style: TextStyle(fontSize: 18,color: rblack),
                          initialValue: "Ghazanfar",
                        ).marginSymmetric(horizontal: 20),
                        Divider(height: 2,color: rwhite,),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 18,color: rblack),
                            border: InputBorder.none, // No border
                          ),
                          style: TextStyle(fontSize: 18,color: rblack),
                          initialValue: "ghazanfar@gmail.com",
                        ).marginSymmetric(horizontal: 20),
                        Divider(height: 2,color: rwhite,),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 18,color: rblack),
                            border: InputBorder.none, // No border
                          ),
                          style: TextStyle(fontSize: 18,color: rblack),
                          initialValue: "********",
                        ).marginSymmetric(horizontal: 20),
                      ],
                    ),
                  ).marginSymmetric(horizontal: 50,vertical: 30),

                  Material(
              borderRadius: BorderRadius.circular(30),
                    elevation: 8,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xff2A158F),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      alignment: Alignment.center,
                      child: Text("Save Changes",style: TextStyle(color: rwhite),).marginAll(12),
                    ),
                  ).marginSymmetric(horizontal: 80),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: rhint.withOpacity(0.5)
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Delete you account",style: TextStyle(color: Colors.red,fontSize: 18),).marginAll(12),
                        Divider(height: 2,color: rwhite,),
                        Text("Restore account",style: TextStyle(color: rblack,fontSize: 18),).marginAll(12),
                        Divider(height: 2,color: rwhite,),
                        Text("Log out",style: TextStyle(color: rblack,fontSize: 18),).marginAll(12),
                      ],
                    ),
                  ).marginSymmetric(horizontal: 50,vertical: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
