import 'package:duabook/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/localization.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({super.key});

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {

  final List<Map<String, String>> languages = [
    {"name": "English", "flag": "🇺🇸"},
    {"name": "Urdu", "flag": "🇵🇰"},
    {"name": "French", "flag": "🇫🇷"},
    {"name": "German", "flag": "🇩🇪"},
    {"name": "Indonesian", "flag": "🇮🇩"},
    {"name": "Japanese", "flag": "🇯🇵"},
    {"name": "Malay", "flag": "🇲🇾"},
    {"name": "Mandarin", "flag": "🇨🇳"},
    {"name": "Portuguese", "flag": "🇵🇹"},
    {"name": "Russian", "flag": "🇷🇺"},
    {"name": "Spanish", "flag": "🇪🇸"},
    {"name": "Turkish", "flag": "🇹🇷"},
    {"name": "Bengali", "flag": "🇧🇩"},
    {"name": "Arabic", "flag": "🇸🇦"},
    {"name": "Hindi", "flag": "🇮🇳"},
    {"name": "Marathi", "flag": "🇮🇳"},
    {"name": "Telugu", "flag": "🇮🇳"},
    {"name": "Gujarati", "flag": "🇮🇳"},
    {"name": "Tamil", "flag": "🇮🇳"},
    {"name": "Punjabi", "flag": "🇮🇳"},
  ];

  String selectedLanguage = "English"; // Default selected language

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
                    color: Colors.white, // Set closed dropdown background to white
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300), // Optional border for better visibility
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
                        value: language['name'],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${language['flag']} ${language['name']}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            if (selectedLanguage == language['name'])
                              const Icon(Icons.check, color: Colors.green),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                        print(newValue);
                      });
                      Localization.changeLocale(newValue!);
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
