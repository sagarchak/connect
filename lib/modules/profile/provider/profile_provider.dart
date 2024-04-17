import 'dart:convert';

import '../../../api_manager/common_http_client.dart';
import '../../../api_manager/constant/endpoints.dart';
import '../../../database/DBHelper.dart';
import '../../../database/entity/user_entity.dart';
import '../../../enums/HttpMethod.dart';
import '../../../utils/common_utils.dart';

class HomeProvider {
  getProfileServer(Function(UserEntity) onSuccess) async {
    String url = Endpoints.getProfile;
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
          UserEntity? user = UserEntity.fromJson(resMap);
          if (user != null) {
            DBHelper.mInstance.putUser(user);
            onSuccess(user);
          }
        }
      }
    }
  }
}
