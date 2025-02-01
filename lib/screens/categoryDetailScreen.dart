import 'package:duabook/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../animations/fadeInAnimationBTT.dart';

class CategoryDetailScreen extends StatefulWidget {
  String catName;
  String icon;
  Color color;

  CategoryDetailScreen(this.catName, this.icon, this.color, {super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
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
                            child: Image.asset(widget.icon),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FadeInAnimationBTT(
                            delay: 1,
                            child: Text(
                              "${widget.catName}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
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
                itemCount: 6,
                itemBuilder: (context, index) {
                  return DuaTile(
                    widget.color,
                    index
                  );
                }).marginSymmetric(horizontal: 20),
            SizedBox(height: 20,)
          ],
        ),
      ),
    ));
  }
}

class DuaTile extends StatefulWidget {
  Color color;
  int index;
  DuaTile(this.color,this.index,{super.key});

  @override
  State<DuaTile> createState() => _DuaTileState();
}

class _DuaTileState extends State<DuaTile> {
  @override
  Widget build(BuildContext context) {
    return FadeInAnimationBTT(
      delay: double.parse((widget.index).toString()),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.color
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dua section ${widget.index}",style: TextStyle(color: rblack.withOpacity(0.6),fontSize: 24),),
              Icon(Icons.navigate_next,color: rblack,)
            ],
          ).marginSymmetric(horizontal: 50,vertical: 20),
        ),
      ).marginOnly(top: 20),
    );
  }
}

