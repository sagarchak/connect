import 'dart:convert';
import 'package:connect/database/entity/user_entity.dart';
import 'package:connect/generated/json/user_entity.g.dart';
import 'package:connect/modules/login/provider/logincontroller.dart';
import 'package:connect/modules/profile/profile.dart';
import 'package:connect/utils/SharedPrefer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_manager/common_http_client.dart';
import '../../../api_manager/constant/endpoints.dart';
import '../../../database/DBHelper.dart';
import '../../../enums/HttpMethod.dart';
import '../../../utils/common_utils.dart';
import '../../home/home.dart';

String mobile = "mobile";
String status = 'status';
String otp = 'otp';

class LoginProvider {
  resetDatabase() async {
    DBHelper.mInstance.deleteAll();
  }

  giveDataToServer(Function(bool) onComplete) async {
    Map<String, dynamic> toJson() => {mobile: LoginController.to.mobileController.text};
    String url = Endpoints.send_Otp;
    var body = toJson();
    final response = await CommonHttpClient(url, method: HttpMethod.Post, showLoading: true, body: body).getResponse();
    if (response != null) {
      var resBody = response.body;
      if (CommonUtils.checkIfNotNull(resBody)) {
        Map<String, dynamic>? resMap = jsonDecode(resBody);
        if (resMap != null) {
          String message = (resMap['message'] as String?) ?? '';
          if (CommonUtils.checkIfNotNull(message)) {
            CommonUtils.showCommonToast('Info', message);
          }
          onComplete((resMap[status] as bool?) ?? false);
        }
      }
    }
  }

  resendOtpToServer(Function(bool) onComplete) async {
    Map<String, dynamic> toJson() => {mobile: LoginController.to.mobileController.text};
    String url = Endpoints.resendOtp;
    var body = toJson();
    final response = await CommonHttpClient(url, method: HttpMethod.Post, showLoading: true, body: body).getResponse();
    if (response != null) {
      var resBody = response.body;
      if (CommonUtils.checkIfNotNull(resBody)) {
        Map<String, dynamic>? resMap = jsonDecode(resBody);
        if (resMap != null) {
          String message = (resMap['message'] as String?) ?? '';
          if (CommonUtils.checkIfNotNull(message)) {
            CommonUtils.showCommonToast('Info', message);
          }
          onComplete((resMap[status] as bool?) ?? false);
        }
      }
    }
  }

  verifyOtpToServer() async {
    Map<String, dynamic> toJson() => {mobile: LoginController.to.mobileController.text, otp: LoginController.to.otpCode.value};
    String url = Endpoints.verifyOtp;
    var body = toJson();
    final response = await CommonHttpClient(url, method: HttpMethod.Post, showLoading: true, body: body).getResponse();
    if (response != null) {
      var resBody = response.body;
      if (CommonUtils.checkIfNotNull(resBody)) {
        Map<String, dynamic>? resMap = jsonDecode(resBody);
        if (resMap != null) {
          await resetDatabase();
          String message = (resMap['message'] as String?) ?? '';
          if (CommonUtils.checkIfNotNull(message)) {
            CommonUtils.showCommonToast('Info', message);
          }
          bool status = (resMap['status'] as bool?) ?? false;
          if (status && resMap["user"] != null) {
            UserEntity user = UserEntity.fromJson(resMap["user"]);
            if (user != null && CommonUtils.checkIfNotNull(user.mobile)) {
                DBHelper.mInstance.putUser(user);
              String token = (resMap['token'] as String?) ?? "";
              if(CommonUtils.checkIfNotNull(token)){
                SharedPrefer.saveString(SharedPrefer.TOKEN, token);
                Get.offAll(const Profile());

              }

            }
          }
        }
      }
    }
  }
}
