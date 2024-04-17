import 'package:connect/modules/startscreen.dart';
import 'package:get/get.dart';
import 'package:connect/database/DBHelper.dart';
import 'package:connect/utils/SharedPrefer.dart';

import '../modules/login/login.dart';

class LogoutUtil {
  static logout() async {
    Future.delayed(const Duration(milliseconds: 100));
    Get.offAll(const StartScreen());
    await deleteAll();
  }

  static deleteAll() async {
    DBHelper.mInstance.deleteAll();
    SharedPrefer.removeAll();
  }
}
