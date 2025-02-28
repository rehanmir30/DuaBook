
import 'package:duabook/controller/themeController.dart';
import 'package:duabook/controller/userController.dart';

import 'package:get/get.dart';

import 'package:duabook/controller/categoryDetailController.dart';

class InitControllers extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ThemeController(),permanent: true);
    Get.put(CategoryDetailController(),permanent: true);
    Get.put(UserController(),permanent: true);
  }

}