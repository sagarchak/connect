import 'package:get/get.dart';

class GeneralController extends GetxController {
  static GeneralController get to => Get.find(); // add this

  RxBool isLoading = true.obs;
  RxBool isConnected = false.obs;
}
