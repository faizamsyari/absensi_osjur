import 'package:get/get.dart';

import '../controllers/chooseperizinan_controller.dart';

class ChooseperizinanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseperizinanController>(
      () => ChooseperizinanController(),
    );
  }
}
