// To parse this JSON data, do
//
//     final duaModel = duaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DuaModel duaModelFromJson(String str) => DuaModel.fromJson(json.decode(str));

String duaModelToJson(DuaModel data) => json.encode(data.toJson());

class DuaModel {
  int id;
  String arabicText;
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
  int duaTextId;
  String arabicAudio;
  String englishAudio;
  String tranlitration;
  String childArabicAudio;
  String grownUps;
  String littleKids;
  String olderKids;
  String teacherChildArabicAudio;
  String urduAudio;
  dynamic customId;
  String arabicTranslation;
  dynamic childArabicAudioUri;
  dynamic englishAudioUri;
  dynamic teacherChildArabicAudioUri;
  dynamic urduAudioUri;
  dynamic done;

  DuaModel({
    required this.id,
    required this.arabicText,
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
    required this.duaTextId,
    required this.arabicAudio,
    required this.englishAudio,
    required this.tranlitration,
    required this.childArabicAudio,
    required this.grownUps,
    required this.littleKids,
    required this.olderKids,
    required this.teacherChildArabicAudio,
    required this.urduAudio,
    required this.customId,
    required this.arabicTranslation,
    required this.childArabicAudioUri,
    required this.englishAudioUri,
    required this.teacherChildArabicAudioUri,
    required this.urduAudioUri,
    required this.done,
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

  factory DuaModel.fromJson(Map<String, dynamic> json) => DuaModel(
    id: json["id"],
    arabicText: json["arabicText"],
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
    duaTextId: json["duaText_id"],
    arabicAudio: json["arabicAudio"],
    englishAudio: json["englishAudio"],
    tranlitration: json["tranlitration"],
    childArabicAudio: json["childArabicAudio"],
    grownUps: json["grownUps"],
    littleKids: json["littleKids"],
    olderKids: json["olderKids"],
    teacherChildArabicAudio: json["teacherChildArabicAudio"],
    urduAudio: json["urduAudio"],
    customId: json["custom_id"],
    arabicTranslation: json["arabicTranslation"],
    childArabicAudioUri: json["childArabicAudioURI"],
    englishAudioUri: json["englishAudioURI"],
    teacherChildArabicAudioUri: json["teacherChildArabicAudioURI"],
    urduAudioUri: json["urduAudioURI"],
    done: json["done"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "arabicText": arabicText,
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
    "duaText_id": duaTextId,
    "arabicAudio": arabicAudio,
    "englishAudio": englishAudio,
    "tranlitration": tranlitration,
    "childArabicAudio": childArabicAudio,
    "grownUps": grownUps,
    "littleKids": littleKids,
    "olderKids": olderKids,
    "teacherChildArabicAudio": teacherChildArabicAudio,
    "urduAudio": urduAudio,
    "custom_id": customId,
    "arabicTranslation": arabicTranslation,
    "childArabicAudioURI": childArabicAudioUri,
    "englishAudioURI": englishAudioUri,
    "teacherChildArabicAudioURI": teacherChildArabicAudioUri,
    "urduAudioURI": urduAudioUri,
    "done": done,
  };
}
