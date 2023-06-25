import 'package:get/get.dart';

import '../controllers/read_presence_controller.dart';

class ReadPresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadPresenceController>(
      () => ReadPresenceController(),
    );
  }
}
