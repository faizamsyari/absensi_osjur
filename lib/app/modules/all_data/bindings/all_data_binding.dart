import 'package:get/get.dart';

import '../controllers/all_data_controller.dart';

class AllDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllDataController>(
      () => AllDataController(),
    );
  }
}
