import 'package:duabook/animations/fadeInAnimationBTT.dart';
import 'package:duabook/animations/fadeInAnimationTTB.dart';
import 'package:duabook/constants/colors.dart';
import 'package:duabook/controller/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../categoryDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> colors = [
    Color(0xff9DD6F4),
    Color(0xffFFD5EB),
    Color(0xffDAFFF7),
    Color(0xffF9FFB5),
    Color(0xffFFE1B5),
    Color(0xffF9D7D6),
    Color(0xffD0FFB9),
    Color(0xffDFF2FF),
    Color(0xffD7D9FF),
    Color(0xffDAD1FE),
    Color(0xffC0E9FF),
    Color(0xffE4FEFF),
  ];

  final List<String> categories = [
    "Salah",
    "Eating",
    "Difficulty",
    "Dressing",
    "Traveling",
    "Duas",
    "Crying",
    "Fasting",
    "Meeting",
    "Masjid & Azan",
    "Quranic Duas",
    "Allah",
  ];

  final List<String> iconList = [
    "assets/images/salah.png",
    "assets/images/eating.png",
    "assets/images/difficulty.png",
    "assets/images/dressing.png",
    "assets/images/travelling.png",
    "assets/images/duas.png",
    "assets/images/crying.png",
    "assets/images/fasting.png",
    "assets/images/meeting.png",
    "assets/images/masjid.png",
    "assets/images/quranic_duas.png",
    "assets/images/Allah.png"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          return Scaffold(
            backgroundColor: rwhite,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //top bar
                  FadeInAnimationTTB(
                    delay: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Assalam o Alaikum",
                              style: TextStyle(color: rhint, fontSize: 12),
                            ),
                            Text(
                              "Ghazanfar",
                              style: TextStyle(color: rtext, fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ],
                        ).marginSymmetric(horizontal: 12),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: themeController.selectedAgeGroup == 0
                                          ? rpink
                                          : themeController.selectedAgeGroup == 1
                                              ? rblue
                                              : rgreen,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.currency_bitcoin,
                                        color: rblack,
                                      ),
                                      Text(
                                        "1200",
                                        style: TextStyle(color: rblack, fontSize: 14),
                                      )
                                    ],
                                  ).paddingSymmetric(horizontal: 12, vertical: 3),
                                )))
                      ],
                    ).marginOnly(top: 8),
                  ),
                  //banner
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: themeController.selectedAgeGroup == 0
                            ? rpink.withOpacity(0.2)
                            : themeController.selectedAgeGroup == 1
                                ? rblue.withOpacity(0.2)
                                : rgreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ready to learn and play?",
                                  style: TextStyle(color: rhint, fontSize: 12),
                                ),
                                Text(
                                  "if you listen to all available duas you unlock all duas",
                                  style: TextStyle(color: rtext, fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                                  child: LinearProgressIndicator(
                                    value: 0.35,
                                    minHeight: 12.0,
                                    backgroundColor: rpurple.withOpacity(0.5), // Unfilled color with 50% opacity
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      rpurple,
                                    ),
                                  ),
                                ).marginOnly(top: 10),
                              ],
                            ).marginOnly(left: 12)),
                        Expanded(flex: 1, child: Image.asset("assets/images/homeBannerImage.png").marginOnly(right: 12))
                      ],
                    ).marginAll(12),
                  ),
                  //age groups
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          themeController.setSelectedAgeGroup(0);
                        },
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              color: themeController.selectedAgeGroup == 0 ? rpink : rwhite,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: themeController.selectedAgeGroup == 0
                                      ? rpink
                                      : themeController.selectedAgeGroup == 1
                                          ? rblue
                                          : rgreen)),
                          alignment: Alignment.center,
                          child: Text(
                            "Little Kids",
                            style: TextStyle(color: rtext, fontWeight: themeController.selectedAgeGroup == 0 ? FontWeight.bold : FontWeight.normal),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          themeController.setSelectedAgeGroup(1);
                        },
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              color: themeController.selectedAgeGroup == 1 ? rblue : rwhite,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: themeController.selectedAgeGroup == 0
                                      ? rpink
                                      : themeController.selectedAgeGroup == 1
                                          ? rblue
                                          : rgreen)),
                          alignment: Alignment.center,
                          child: Text(
                            "Older Kids",
                            style: TextStyle(color: rtext, fontWeight: themeController.selectedAgeGroup == 1 ? FontWeight.bold : FontWeight.normal),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          themeController.setSelectedAgeGroup(2);
                        },
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              color: themeController.selectedAgeGroup == 2 ? rgreen : rwhite,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: themeController.selectedAgeGroup == 0
                                      ? rpink
                                      : themeController.selectedAgeGroup == 1
                                          ? rblue
                                          : rgreen)),
                          alignment: Alignment.center,
                          child: Text(
                            "Grown ups",
                            style: TextStyle(color: rtext, fontWeight: themeController.selectedAgeGroup == 2 ? FontWeight.bold : FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ).marginOnly(top: 12),
                  //grid tiles
                  FadeInAnimationBTT(
                    delay: 1,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width<=450?3:6,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(colors[index % colors.length], categories[index], iconList[index]);
                      },
                    ).marginOnly(top: 12),
                  )
                ],
              ).marginSymmetric(horizontal: 12),
            ),
          );
        },
      ),
    );
  }
}

class CategoryTile extends StatefulWidget {
  Color color;
  String title;
  String icon;

  CategoryTile(this.color, this.title, this.icon, {super.key});

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(CategoryDetailScreen(widget.title,widget.icon,widget.color),transition: Transition.upToDown);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(widget.icon),
            SizedBox(
              height: 4,
            ),
            Text(widget.title)
          ],
        ),
      ),
    );
    ;
  }
}
