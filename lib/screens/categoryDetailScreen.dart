import 'package:duabook/constants/colors.dart';
import 'package:duabook/controller/categoryDetailController.dart';
import 'package:duabook/models/categoryModel.dart';
import 'package:duabook/models/subCategoryModel.dart';
import 'package:duabook/screens/openDuasScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../animations/fadeInAnimationBTT.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  final Color color;

  const CategoryDetailScreen(this.categoryModel, this.color, {super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {

  @override
  void initState() {
    Get.find<CategoryDetailController>().getSubCategories(widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: GetBuilder<CategoryDetailController>(
        builder: (catDetailController) {
          int completedCount = catDetailController.subCategories.where((item) => item.isComplete!).length;
          int threshold = (catDetailController.subCategories.length / 2).ceil();

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            color: widget.color, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back)),
                            ).marginSymmetric(horizontal: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FadeInAnimationBTT(
                                  delay: 1,
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                    child: Lottie.asset(widget.categoryModel.animation),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FadeInAnimationBTT(
                                    delay: 1,
                                    child: Text(
                                      "${widget.categoryModel.title}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                    ).marginOnly(top: 8))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: catDetailController.subCategories.length,
                        itemBuilder: (context, index) {
                          // Determine if the item should be clickable
                          bool isClickable = completedCount >= threshold || index < threshold;
                          return SubCategoryTile(widget.color, catDetailController.subCategories[index], index, isClickable: isClickable);
                        }).marginSymmetric(horizontal: 20),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: catDetailController.isLoading,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: rwhite.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()))
            ],
          );
        },
      ),
    ));
  }

}

class SubCategoryTile extends StatefulWidget {
  final Color color;
  final SubCategoryModel subCategoryModel;
  final int index;
  final bool isClickable;

  const SubCategoryTile(this.color, this.subCategoryModel, this.index, {super.key, required this.isClickable});

  @override
  State<SubCategoryTile> createState() => _SubCategoryTileState();
}

class _SubCategoryTileState extends State<SubCategoryTile> {
  @override
  Widget build(BuildContext context) {
    return FadeInAnimationBTT(
      delay: double.parse((widget.index).toString()),
      child: InkWell(
        onTap: widget.isClickable ? () {
          Get.find<CategoryDetailController>().getDuas(widget.subCategoryModel);
          Get.to(OpenDuasScreen(widget.subCategoryModel));
        } : null,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: widget.color),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${widget.subCategoryModel.getTranslatedText(Get.locale?.languageCode ?? 'english')}",
                    style: TextStyle(color: rblack.withOpacity(0.6), fontSize: 20),
                  ),
                ),
                Icon(
                  widget.isClickable?Icons.navigate_next:Icons.lock_outline,
                  color: rblack,
                )
              ],
            ).marginSymmetric(horizontal: 50, vertical: 20),
          ),
        ).marginOnly(top: 20),
      ),
    );
  }
}