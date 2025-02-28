import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class PremiumSettings extends StatefulWidget {
  const PremiumSettings({super.key});

  @override
  State<PremiumSettings> createState() => _PremiumSettingsState();
}

class _PremiumSettingsState extends State<PremiumSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Premium",
          style: TextStyle(color: rblack, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: BoxDecoration(color: rpurple, borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Rs 590.00/ lifetime",
                  style: TextStyle(fontSize: 21, color: rblack, fontWeight: FontWeight.bold),
                ).marginOnly(top: 20),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(color: rwhite, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                          elevation: 12,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: rbluedark, borderRadius: BorderRadius.circular(24)),
                            alignment: Alignment.center,
                            child: Text(
                              'Purchase Premium',
                              style: TextStyle(color: rwhite),
                            ).marginSymmetric(vertical: 5),
                          )).marginSymmetric(horizontal: 20).marginOnly(top: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Expanded(
                              child: Text(
                            "Your purchase will help us fund projects of dawah of Quran and Hadith as well as books and Apps for children’s education",
                          style: TextStyle(fontSize: 10),
                              ))
                        ],
                      ).marginSymmetric(horizontal: 12).marginOnly(top: 10,bottom: 12)
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(color: rwhite, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16),
                      ).marginSymmetric(horizontal: 12).marginOnly(top: 18),
                      Material(
                          elevation: 12,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: rpurple, borderRadius: BorderRadius.circular(24)),
                            alignment: Alignment.center,
                            child: Text(
                              'Log in',
                              style: TextStyle(color: rwhite),
                            ).marginSymmetric(vertical: 5),
                          )).marginSymmetric(horizontal: 20).marginOnly(top: 18,bottom: 18),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
