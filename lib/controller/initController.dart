import 'package:duabook/controller/themeController.dart';

import 'package:get/get.dart';

class InitControllers extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ThemeController(),permanent: true);
  }

}