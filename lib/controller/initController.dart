import 'package:duabook/controller/themeController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class InitControllers extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ThemeController(),permanent: true);
  }

}