

import 'dart:convert';

import 'package:connect/database/entity/post_details_entity.dart';
import 'package:connect/database/entity/rewards_entity.dart';
import 'package:connect/modules/rewards/provider/reward_controller.dart';

import '../../../api_manager/common_http_client.dart';
import '../../../api_manager/constant/endpoints.dart';
import '../../../database/DBHelper.dart';
import '../../../database/entity/user_entity.dart';
import '../../../enums/HttpMethod.dart';
import '../../../utils/common_utils.dart';
import '../../home/provider/homecontroller.dart';


String giftId = "giftId";
String quantity = 'quantity';
class RewardProvider
{
  getRewardFromServer({ required Function(List<RewardsEntity> )
  onSuccess1, required Function(List<RewardsEntity> ) onSuccess2,required Function(List<RewardsEntity> ) onSuccess3 }) async {
    String url = Endpoints.getReward;
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
          var giftList = resMap["data"] ["gifts"] as List;
          var redeemedList = resMap["data"] ["redeemed"] as List;
          var earnedList =  resMap["data"] ["earned"] as List;

          if( giftList != null && redeemedList != null && earnedList!=null)
          {
            onSuccess1( giftList.map((e) => RewardsEntity.fromJson(e)).toList()) ;
            onSuccess2( redeemedList.map((e) => RewardsEntity.fromJson(e)).toList()) ;
            onSuccess3( earnedList.map((e) => RewardsEntity.fromJson(e)).toList()) ;

          }


        }
      }
    }
  }
  redeemPointFromServer(int points, { required Function(List<RewardsEntity> )
  onSuccess1, required Function(List<RewardsEntity> ) onSuccess2}) async {
    Map<String, dynamic> toJson() => { giftId: "${points}" , quantity: "1" };
    String url = Endpoints.postRedeem;
    var body = toJson();
    final response = await CommonHttpClient(url, method: HttpMethod.Post, showLoading: true, body: body).getResponse();
    if (response != null) {
      print(response);
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

             UserEntity? user = DBHelper.mInstance.getMainUser();
              if(user != null)
              {
                int point = resMap["data"] ["points"]?? 0;
                 user.points = point;
                 DBHelper.mInstance.putUser(user);
                 HomeController.to.mUser.value = user;
                  var giftList = resMap["data"] ["gifts"] as List;
                  var redeemedList = resMap["data"] ["redeemed"] as List;
                  if( giftList != null && redeemedList != null)
                  {
                    onSuccess1( giftList.map((e) => RewardsEntity.fromJson(e)).toList()) ;
                    onSuccess2( redeemedList.map((e) => RewardsEntity.fromJson(e)).toList()) ;

                  }



              }



          }
        }
      }
    }
  }
}

