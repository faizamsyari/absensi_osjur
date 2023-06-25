import 'package:get/get.dart';

import '../controllers/blank_pagee_controller.dart';

class BlankPageeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlankPageeController>(
      () => BlankPageeController(),
    );
  }
}
