import 'package:get/get.dart';
import 'package:duabook/constants/userData.dart' as ud;
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';


class UserController extends GetxController{
  String _userName="";
  String get userName=>_userName;
  int _points=0;
  int get points=>_points;
  bool _isLoggedIn=false;
  bool get isLoggedIn=>_isLoggedIn;
  String _avatar="";
  String get avatar=>_avatar;

  String _selectedLanguage="english";
  String get selectedLanguage=>_selectedLanguage;

  setSelectedLanguage(String selectedLan){
    _selectedLanguage=selectedLan;
    Localization.changeLocale(selectedLan);
    update();
  }

  setUserName(String value){
    _userName=value;
    ud.userName=value;
    update();
  }

  setPoints(int value)async{
    _points=value;
    ud.points=value;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt("userPoints", value);
    update();
  }

  setLoggedIn(bool value){
    _isLoggedIn=value;
    ud.isLoggedIn=value;
    if(value==false){
      ud.userName="Guest User";
    }
    update();
  }

  setAvatar(String value)async{
    _avatar=value;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("userAvatar", value);
    update();
  }
}