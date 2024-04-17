

import 'dart:convert';

import 'package:connect/database/entity/post_details_entity.dart';

import '../../../api_manager/common_http_client.dart';
import '../../../api_manager/constant/endpoints.dart';
import '../../../database/DBHelper.dart';
import '../../../enums/HttpMethod.dart';
import '../../../utils/common_utils.dart';

class WebProvider
{
  getPostFromServer(String url, Function(PostDetailsEntity) onSuccess) async {
    final response = await CommonHttpClient(
      url,
      method: HttpMethod.Get,
      showLoading: true,
    ).getResponse();
    if (response != null) {
      var resBody = response.body;
      if (CommonUtils.checkIfNotNull(resBody)) {
        Map<String, dynamic>? resMap = jsonDecode(resBody);
        if (resMap != null) {
          PostDetailsEntity? postDetails =  PostDetailsEntity.fromJson(resMap["data"]);
          if (postDetails != null) {
            onSuccess(postDetails);
          }
        }
      }
    }
  }
}

