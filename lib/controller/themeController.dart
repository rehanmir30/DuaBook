import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{

  int _selectedAgeGroup=0;

  int get selectedAgeGroup=>_selectedAgeGroup;

  setSelectedAgeGroup(int value){
    _selectedAgeGroup=value;
    update();
  }

}