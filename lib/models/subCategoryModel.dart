// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  int id;
  int number;
  dynamic arabicTranslation;
  String arabicText;
  String tranlitration;
  String english;
  String urdu;
  String mandrain;
  String spanish;
  String french;
  String portugese;
  String russian;
  String german;
  String turkish;
  String hindi;
  String bengali;
  String indonesian;
  String malay;
  String marathi;
  String telugu;
  String gujarati;
  String korean;
  String tamil;
  String japanese;
  String vietnamese;
  String punjabi;
  String pashto;
  String persianFarsi;
  String burmese;
  String sindhi;
  String logo;
  String image;
  String littleKids;
  String olderKids;
  String grownUps;
  int category;
  bool? isComplete=false;

  SubCategoryModel({
    required this.id,
    required this.number,
    required this.arabicTranslation,
    required this.arabicText,
    required this.tranlitration,
    required this.english,
    required this.urdu,
    required this.mandrain,
    required this.spanish,
    required this.french,
    required this.portugese,
    required this.russian,
    required this.german,
    required this.turkish,
    required this.hindi,
    required this.bengali,
    required this.indonesian,
    required this.malay,
    required this.marathi,
    required this.telugu,
    required this.gujarati,
    required this.korean,
    required this.tamil,
    required this.japanese,
    required this.vietnamese,
    required this.punjabi,
    required this.pashto,
    required this.persianFarsi,
    required this.burmese,
    required this.sindhi,
    required this.logo,
    required this.image,
    required this.littleKids,
    required this.olderKids,
    required this.grownUps,
    required this.category,
     this.isComplete
  });

  String getTranslatedText(String languageCode) {
    switch (languageCode) {
      case 'english':
        return english;
      case 'french':
        return french;
      case 'german':
        return german;
      case 'indonesian':
        return indonesian;
      case 'japanese':
        return japanese;
      case 'malay':
        return malay;
      case 'mandarin':
        return mandrain;
      case 'portuguese':
        return portugese;
      case 'russian':
        return russian;
      case 'spanish':
        return spanish;
      case 'turkish':
        return turkish;
      case 'bengali':
        return bengali;
      case 'urdu':
        return urdu;
      case 'arabic':
        return arabicText;
      case 'hindi':
        return hindi;
      case 'marathi':
        return marathi;
      case 'telugu':
        return telugu;
      case 'gujarati':
        return gujarati;
      case 'tamil':
        return tamil;
      case 'punjabi':
        return punjabi;

      default:
        return english; // Fallback to English
    }}

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    id: json["id"],
    number: json["number"],
    arabicTranslation: json["arabicTranslation"],
    arabicText: json["arabicText"],
    tranlitration: json["tranlitration"],
    english: json["english"],
    urdu: json["urdu"],
    mandrain: json["mandrain"],
    spanish: json["spanish"],
    french: json["french"],
    portugese: json["portugese"],
    russian: json["russian"],
    german: json["german"],
    turkish: json["turkish"],
    hindi: json["hindi"],
    bengali: json["bengali"],
    indonesian: json["indonesian"],
    malay: json["malay"],
    marathi: json["marathi"],
    telugu: json["telugu"],
    gujarati: json["gujarati"],
    korean: json["korean"],
    tamil: json["tamil"],
    japanese: json["japanese"],
    vietnamese: json["vietnamese"],
    punjabi: json["punjabai"],
    pashto: json["pashto"],
    persianFarsi: json["persianFarsi"],
    burmese: json["burmese"],
    sindhi: json["sindhi"],
    logo: json["logo"],
    image: json["image"],
    littleKids: json["littleKids"],
    olderKids: json["olderKids"],
    grownUps: json["grownUps"],
    category: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "arabicTranslation": arabicTranslation,
    "arabicText": arabicText,
    "tranlitration": tranlitration,
    "english": english,
    "urdu": urdu,
    "mandrain": mandrain,
    "spanish": spanish,
    "french": french,
    "portugese": portugese,
    "russian": russian,
    "german": german,
    "turkish": turkish,
    "hindi": hindi,
    "bengali": bengali,
    "indonesian": indonesian,
    "malay": malay,
    "marathi": marathi,
    "telugu": telugu,
    "gujarati": gujarati,
    "korean": korean,
    "tamil": tamil,
    "japanese": japanese,
    "vietnamese": vietnamese,
    "punjabai": punjabi,
    "pashto": pashto,
    "persianFarsi": persianFarsi,
    "burmese": burmese,
    "sindhi": sindhi,
    "logo": logo,
    "image": image,
    "littleKids": littleKids,
    "olderKids": olderKids,
    "grownUps": grownUps,
    "category": category,
  };
}
