import 'package:connect/database/DBHelper.dart';
import 'package:connect/modules/profile/profile.dart';
import 'package:connect/modules/startscreen.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:connect/utils/SharedPrefer.dart';
import 'package:get/get.dart';

import '../database/entity/user_entity.dart';
import 'home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() async {
    String? token = await SharedPrefer.getString(SharedPrefer.TOKEN);
    UserEntity? user = DBHelper.mInstance.getMainUser();
    if (CommonUtils.checkIfNotNull(token) && user != null) {
      Get.offAll(const Profile());
    } else {
      Get.offAll(const StartScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {

      if (mounted) {
        Future.delayed(const Duration(seconds: 1), () => changeScreen());

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
