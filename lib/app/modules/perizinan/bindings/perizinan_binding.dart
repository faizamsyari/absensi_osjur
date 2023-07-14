import 'package:get/get.dart';

import '../controllers/perizinan_controller.dart';

class PerizinanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanController>(
      () => PerizinanController(),
    );
  }
}
