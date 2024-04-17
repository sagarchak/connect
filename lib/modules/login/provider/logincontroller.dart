import 'dart:async';
import 'package:connect/enums/loginview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/common_utils.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();


  TextEditingController mobileController = TextEditingController();
  RxString phoneError = ''.obs;
  RxString otpCode = ''.obs;
  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {});


  RxInt secondsRemaining = 60.obs;
  RxBool enableResend = false.obs;

  String takeErrorNote = "";
  String takeSuccessNote = "";

  Rx<LoginView> loginView = LoginView.NUMBER.obs;

  rebuildLogin(){
    mobileController.text  = "";
    phoneError.value = "";
    otpCode.value = "";
    secondsRemaining.value = 60;
     timer.cancel();
    enableResend.value = false;
     takeErrorNote = "";
     takeSuccessNote = "";
     loginView.value = LoginView.NUMBER;
  }

  resendCode() {
    secondsRemaining.value = 60;
    enableResend.value = false;
  }
  validatePhone(BuildContext context, bool callAPI) {

    String phone = mobileController.value.text;
    if (CommonUtils.checkIfNotNull(phone)) {
      phone = phone.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(RegExp(r"\s+"), "").trim();
    } else {

      phoneError.value = 'Please enter a valid phone number';
    }
    if (CommonUtils.isValidPhone(phone)) {

    }
    else
    {
      phoneError.value = 'Please enter a valid phone number';
    }

  }
  startCode() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (LoginController.to.secondsRemaining.value != 0) {
        LoginController.to.secondsRemaining.value--;
      } else {
        LoginController.to.enableResend.value = true;
      }
    });
  }
}
