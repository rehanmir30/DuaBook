import 'package:duabook/services/categoryDetailService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/categoryDetailController.dart';
import '../../models/categoryModel.dart';
import '../../models/subCategoryModel.dart';
import '../openDuasScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SubCategoryModel> allSubCategories = [];
  List<SubCategoryModel> filteredSubCategories = [];

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
  void initState() {
    super.initState();
    getAllSubCategories();
    _searchController.addListener(_filterSubCategories);
  }

  getAllSubCategories() async {
    allSubCategories = await CategoryDetailService().getAllSubCategories(catList);
    setState(() {
      filteredSubCategories = allSubCategories;
    });
  }

  void _filterSubCategories() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredSubCategories = allSubCategories
          .where((subCategory) => subCategory.english.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue.withOpacity(0.3),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),

          // Results List
          Expanded(
            child: filteredSubCategories.isEmpty
                ? Center(child: Text("No results found", style: TextStyle(color: Colors.black)))
                : ListView.builder(
              itemCount: filteredSubCategories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    // if(filteredSubCategories[index].isComplete??true){
                      Get.find<CategoryDetailController>().getDuas(filteredSubCategories[index]);
                      Get.to(OpenDuasScreen(filteredSubCategories[index]));
                    // }
                    // else{
                    //   Get.snackbar("Locked", "This category is locked for you", backgroundColor: Colors.red);
                    // }

                  },
                  child: ListTile(
                    title: Text(filteredSubCategories[index].english, style: TextStyle(color: Colors.black)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
