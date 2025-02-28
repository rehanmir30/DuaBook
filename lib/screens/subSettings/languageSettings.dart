import 'package:duabook/constants/colors.dart';
import 'package:duabook/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/localization.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({super.key});

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {

  final List<Map<String, String>> languages = [
    {"name": "english", "flag": "🇺🇸"},
    {"name": "urdu", "flag": "🇵🇰"},
    {"name": "french", "flag": "🇫🇷"},
    {"name": "german", "flag": "🇩🇪"},
    {"name": "indonesian", "flag": "🇮🇩"},
    {"name": "japanese", "flag": "🇯🇵"},
    {"name": "malay", "flag": "🇲🇾"},
    {"name": "mandarin", "flag": "🇨🇳"},
    {"name": "portuguese", "flag": "🇵🇹"},
    {"name": "russian", "flag": "🇷🇺"},
    {"name": "spanish", "flag": "🇪🇸"},
    {"name": "turkish", "flag": "🇹🇷"},
    {"name": "bengali", "flag": "🇧🇩"},
    {"name": "arabic", "flag": "🇸🇦"},
    {"name": "hindi", "flag": "🇮🇳"},
    {"name": "marathi", "flag": "🇮🇳"},
    {"name": "telugu", "flag": "🇮🇳"},
    {"name": "gujarati", "flag": "🇮🇳"},
    {"name": "tamil", "flag": "🇮🇳"},
    {"name": "punjabi", "flag": "🇮🇳"},
  ];

  String selectedLanguage = Get.find<UserController>().selectedLanguage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Languages",style: TextStyle(color: rblack,fontSize: 20,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.88,
            decoration: BoxDecoration(
              color: rpurple,
              borderRadius: BorderRadius.only(topRight:Radius.circular(24),topLeft: Radius.circular(24))
            ),
            alignment: Alignment.center,
            child: Center(
              child: DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    items: languages.map((language) {
                      return DropdownMenuItem<String>(
                        value: language['name']!,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${language['flag']} ${language['name']!.capitalize}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            if (selectedLanguage == language['name'])
                              const Icon(Icons.check, color: Colors.green),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async{
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      prefs.setString("selectedLanguage", newValue!);

                      print(prefs.getString("selectedLanguage"));

                      Get.find<UserController>().setSelectedLanguage(newValue);
                    },
                  ),
                ),
              ).marginSymmetric(horizontal: MediaQuery.of(context).size.width*0.1)
              ,
            ),
          ),
        ),
      ),
    );
  }
}
