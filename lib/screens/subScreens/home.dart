import 'package:duabook/animations/fadeInAnimationBTT.dart';
import 'package:duabook/animations/fadeInAnimationTTB.dart';
import 'package:duabook/constants/colors.dart';
import 'package:duabook/controller/themeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/categoryModel.dart';
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

  final List<CategoryModel> catList=[
    CategoryModel(id: 2, title: "RemembranceOfAllah".tr, image: "assets/svgs/remem.svg", animation: "assets/animations/rememberanceOfAllah.json"),
    CategoryModel(id: 34, title: "QuranicDuas".tr, image: "assets/svgs/quranic.svg", animation: "assets/animations/quran.json"),
    CategoryModel(id: 3, title: "SleepAndWakingUp".tr, image: "assets/svgs/sleep.svg", animation: "assets/animations/sleep.json"),
    CategoryModel(id: 4, title: "Dressing".tr, image: "assets/svgs/dressing.svg", animation: "assets/animations/dressing.json"),
    CategoryModel(id: 5, title: "Toilet".tr, image: "assets/svgs/toilet.svg", animation: "assets/animations/toilet.json"),
    CategoryModel(id: 6, title: "Wudu".tr, image: "assets/svgs/wudu.svg", animation: "assets/animations/wudu.json"),
    CategoryModel(id: 7, title: "InAndOutOfHouse".tr, image: "assets/svgs/inandout.svg", animation: "assets/animations/inAndOut.json"),
    CategoryModel(id: 8, title: "MasjidAndAzan".tr, image: "assets/svgs/masjid.svg", animation: "assets/animations/masjid.json"),
    CategoryModel(id: 9, title: "Salah".tr, image: "assets/svgs/salah.svg", animation: "assets/animations/salah.json"),
    CategoryModel(id: 10, title: "ZikrAfterSalah".tr, image: "assets/svgs/zikr.svg", animation: "assets/animations/zikrAfterSalah.json"),
    CategoryModel(id: 11, title: "MorningAndEveningAdkar".tr, image: "assets/svgs/morningAndEveningazkar.svg", animation: "assets/animations/morningAndEveningAdkar.json"),
    CategoryModel(id: 12, title: "Eating".tr, image: "assets/svgs/eating.svg", animation: "assets/animations/eating.json"),
    CategoryModel(id: 13, title: "Traveling".tr, image: "assets/svgs/traveling.svg", animation: "assets/animations/traveling.json"),
    CategoryModel(id: 14, title: "MeetingAndGreeting".tr, image: "assets/svgs/greeting.svg", animation: "assets/animations/meeting.json"),
    CategoryModel(id: 15, title: "ForKnowledge".tr, image: "assets/svgs/knowledge.svg", animation: "assets/animations/knowledge.json"),
    CategoryModel(id: 16, title: "Emotions".tr, image: "assets/svgs/emotions.svg", animation: "assets/animations/emotions.json"),
    CategoryModel(id: 17, title: "Thinking".tr, image: "assets/svgs/thanking.svg", animation: "assets/animations/thanking.json"),
    CategoryModel(id: 18, title: "Sneezing".tr, image: "assets/svgs/sneezing.svg", animation: "assets/animations/sneezing.json"),
    CategoryModel(id: 19, title: "Worrying".tr, image: "assets/svgs/worrying.svg", animation: "assets/animations/worrying.json"),
    CategoryModel(id: 20, title: "NaturalEvents".tr, image: "assets/svgs/naturalEvents.svg", animation: "assets/animations/raining.json"),
    CategoryModel(id: 21, title: "PainAndIllness".tr, image: "assets/svgs/pain.svg", animation: "assets/animations/illness.json"),
    CategoryModel(id: 35, title: "Ruqyah".tr, image: "assets/svgs/ruqyah.svg", animation: "assets/animations/rukya.json"),
    CategoryModel(id: 22, title: "Manners".tr, image: "assets/svgs/manners.svg", animation: "assets/animations/manners.json"),
    CategoryModel(id: 23, title: "ProtectionAndComfort".tr, image: "assets/svgs/comfort.svg", animation: "assets/animations/protectionAndComfort.json"),
    CategoryModel(id: 24, title: "Fasting".tr, image: "assets/svgs/fasting.svg", animation: "assets/animations/fasting.json"),
    CategoryModel(id: 30, title: "Hajj".tr, image: "assets/svgs/hajj.svg", animation: "assets/animations/hajj.json"),
    CategoryModel(id: 31, title: "FamilyAndWedding".tr, image: "assets/svgs/wedding.svg", animation: "assets/animations/family.json"),
    CategoryModel(id: 26, title: "Repentance".tr, image: "assets/svgs/repentance.svg", animation: "assets/animations/repentance.json"),
    CategoryModel(id: 27, title: "Difficulty".tr, image: "assets/svgs/difficulty.svg", animation: "assets/animations/difficulty.json"),
    CategoryModel(id: 29, title: "FuneralAndDeath".tr, image: "assets/svgs/funeral.svg", animation: "assets/animations/funeral.json"),
    CategoryModel(id: 33, title: "ProtectionFromDajjal".tr, image: "assets/svgs/dajjal.svg", animation: "assets/animations/dajjal.json")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          List<CategoryModel> filteredCatList = catList.where((category) {
            if (category.id == 31) {
              return themeController.selectedAgeGroup == 2; // Include only if age group is 2
            }
            return true; // Include all other categories
          }).toList();
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
                      itemCount: filteredCatList.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(colors[index % colors.length], filteredCatList[index]);
                        // return CategoryTile(colors[index % colors.length], catList[index]);
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
  final Color color;
  final CategoryModel categoryModel;

  const CategoryTile(this.color,this.categoryModel, {super.key});

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(CategoryDetailScreen(widget.categoryModel,widget.color),transition: Transition.upToDown);
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
            SvgPicture.asset("${widget.categoryModel.image}",width: 40,height: 40,),
            SizedBox(
              height: 4,
            ),
            Text(widget.categoryModel.title,textAlign: TextAlign.center,).marginSymmetric(horizontal: 5)
          ],
        ),
      ),
    );
  }
}
