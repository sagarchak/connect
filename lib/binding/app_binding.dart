import 'package:connect/modules/login/provider/logincontroller.dart';
import 'package:connect/modules/postdetails/provider/web_controller.dart';
import 'package:connect/modules/refer_&_win/provider/refercontroller.dart';
import 'package:connect/modules/rewards/provider/reward_controller.dart';
import 'package:get/get.dart';
import 'package:connect/controller/general_controller.dart';

import '../modules/home/provider/homecontroller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<GeneralController>(GeneralController(), permanent: true);
    Get.put<LoginController>(LoginController(), permanent: false);
    Get.put<HomeController>(HomeController(), permanent: false);
    Get.put<WebController>(WebController(), permanent: false);
    Get.put<RewardController>(RewardController(), permanent: false);
    Get.put<ReferController>(ReferController(), permanent: false);
  }
}
