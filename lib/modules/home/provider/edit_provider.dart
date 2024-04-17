import 'dart:convert';

import 'package:connect/generated/json/user_entity.g.dart';
import 'package:connect/modules/home/provider/homecontroller.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api_manager/common_http_client.dart';
import '../../../api_manager/constant/endpoints.dart';
import '../../../database/DBHelper.dart';
import '../../../database/entity/user_entity.dart';
import '../../../enums/HttpMethod.dart';
import '../../../utils/common_utils.dart';

String email = "email";
String address = "address";
String dob = "dob";
String aadhaar = "aadhaar";
String pan = "pan";
String aboutMe = "aboutMe";

class EditProvider {
  handleResponse(Response? response) {
    if (response != null) {
      var resBody = response.body;
      if (CommonUtils.checkIfNotNull(resBody)) {
        Map<String, dynamic>? resMap = jsonDecode(resBody);
        if (resMap != null) {
          String message = (resMap['message'] as String?) ?? '';
          if (CommonUtils.checkIfNotNull(message)) {
            CommonUtils.showCommonToast('Info', message);
            HomeController.to.showAPIErrors(resMap);
          }
          bool status = (resMap['status'] as bool?) ?? false;
          if (status && resMap["user"] != null) {

            UserEntity? user = DBHelper.mInstance.getMainUser();
            user = UserEntity.fromJson(resMap["user"]);

            DBHelper.mInstance.putUser(user);
            HomeController.to.mUser.value = user;
          }
        }
      }
    }
  }

  postDataToServer() async {
    Map<String, dynamic> toJson() => {
          email: HomeController.to.emailController.text,
          address: HomeController.to.addressController.text,
          dob: HomeController.to.dobController.text,
          aadhaar: HomeController.to.aadhaarController.text,
          pan: HomeController.to.panController.text,
          aboutMe: HomeController.to.aboutMeController.text,
        };
    String url = Endpoints.updateProfile;
    var body = toJson();
    final response = await CommonHttpClient(url, method: HttpMethod.Post, showLoading: true, body: body).getResponse();
    handleResponse(response);
  }

  profileImageUploadAPI({
    required List<XFile> imageAssetList,
  }) async {
    String url = Endpoints.updateProfile;
    if (imageAssetList.isNotEmpty) {
      final response =
          await CommonHttpClient(url, method: HttpMethod.Post, showLoading: true).getResponse(key: 'image', imageAssetList: imageAssetList);

      handleResponse(response);
    } else {
      CommonUtils.showCommonDialog('Profile Image Change', 'Please select an image for profile image');
    }
  }
}
