import 'dart:convert';

import 'package:duabook/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  UserController _userController = Get.find<UserController>();

  login(String email, String password) async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    var url = Uri.parse("https://khushiikids.herokuapp.com/auth/jwt/create/");
    Map<String, String> params = {
      'email': email,
      'password': password,
    };

    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("dua_access", responseJson["access"]);
      prefs.setString("dua_refresh", responseJson["refresh"]);
      await getUserData();
      Get.back();
      Get.back();
      Get.snackbar("Success", "Logged in successfully", backgroundColor: Colors.green);
    } else {
      Get.snackbar("Error", "${responseJson["detail"]}", backgroundColor: Colors.red);
      print("${response.statusCode}: ${response.body}");
    }
  }

  Future<void> getUserData()async{
    //https://khushiikids.herokuapp.com/auth/users/me
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearer= prefs.getString("dua_access")??"";
    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer ${bearer}',
    };

    var url = Uri.parse("https://khushiikids.herokuapp.com/auth/users/me");
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);

    if(response.statusCode==200){
      _userController.setLoggedIn(true);
      _userController.setUserName(responseJson["name"]);
    }else{

    }


  }

  register(String mail, String password, String name, String repassword) async{

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    var url = Uri.parse("https://khushiikids.herokuapp.com/auth/users/");
    Map<String, String> params = {
      'email': mail,
      'name': name,
      'password': password,
      're_password': repassword,
    };
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);

    if(response.statusCode==201){
      _userController.setLoggedIn(true);
      _userController.setUserName(responseJson["name"]);
      Get.back();
    }else{
      Get.snackbar("Error", "Provided details have some issue",backgroundColor: Colors.red);

    }
  }
}
