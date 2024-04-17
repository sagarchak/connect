


import 'dart:convert';

import 'package:connect/database/entity/add_refer_entity.dart';
import 'package:connect/modules/refer_&_win/provider/refercontroller.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../api_manager/common_http_client.dart';
import '../../../api_manager/constant/endpoints.dart';
import '../../../enums/HttpMethod.dart';
import '../../../utils/common_utils.dart';
import '../../home/provider/homecontroller.dart';

String name = "name";
String mobile = "mobile";
String product = "product";

class ReferProvider
{

  postReferToServer( Function(List<AddReferEntity> ) success) async {
    Map<String, dynamic> toJson() => {
      name: ReferController.to.nameController.text,
      mobile: ReferController.to.mobileController.text,
      product:ReferController.to.productController.text,

    };
    String url = Endpoints.addRefer;
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
          if (status && resMap["data"] != null) {
            List addReferEntity  =  resMap["data"];
            success(addReferEntity.map((e) => AddReferEntity.fromJson(e)).toList());

          }
        }
      }
    }
  }

  getReferToServer( Function(List<AddReferEntity> ) success) async {

    String url = Endpoints.addRefer;
    final response = await CommonHttpClient(url, method: HttpMethod.Get, showLoading: true, ).getResponse();
    if (response != null) {
      var resBody = response.body;
      if (CommonUtils.checkIfNotNull(resBody)) {
        Map<String, dynamic>? resMap = jsonDecode(resBody);
        if (resMap != null) {
          String message = (resMap['message'] as String?) ?? '';
          if (CommonUtils.checkIfNotNull(message)) {
            CommonUtils.showCommonToast('Info', message);
            ReferController.to.showAPIErrors(resMap);
          }
          bool status = (resMap['status'] as bool?) ?? false;
          if (status && resMap["data"] != null) {
            List addReferEntity  =  resMap["data"];
            success(addReferEntity.map((e) => AddReferEntity.fromJson(e)).toList());

          }
        }
      }
    }
  }
}