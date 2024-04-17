
import 'dart:convert';

import 'package:connect/modules/splashscreen.dart';
import 'package:connect/modules/startscreen.dart';
import 'package:connect/utils/LogoutUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../api_manager/common_http_client.dart';
import '../api_manager/constant/endpoints.dart';
import '../enums/HttpMethod.dart';
import '../utils/SharedPrefer.dart';
import '../utils/common_utils.dart';

class Logout {
  logoutFromServer() async {
    Map<String, dynamic> toJson() => {};
    String url = Endpoints.logOut;
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
          bool status = (resMap['status'] as bool?) ?? false;

            if(status){
              LogoutUtil.logout();

            }
            }
          }
        }
      }
    }
