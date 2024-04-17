import 'package:connect/database/entity/rewards_entity.dart';
import 'package:connect/modules/rewards/provider/reward_provider.dart';
import 'package:get/get.dart';


class RewardController extends GetxController {
  static RewardController get to => Get.find();
  RxList<RewardsEntity> giftListControl = <RewardsEntity>[].obs;
  RxList<RewardsEntity> redeemedListControl = <RewardsEntity>[].obs;
  RxList<RewardsEntity> earnedListControl = <RewardsEntity>[].obs;

  RxInt currentIndex = 0.obs;

  callRewardAPI() async {
    await RewardProvider().getRewardFromServer(onSuccess1: (List<RewardsEntity>? giftList) async {
      giftListControl.clear();
      if (giftList != null) {
        giftListControl.value = giftList;
      }
    }, onSuccess2: (List<RewardsEntity>? redeemedList) async {
      redeemedListControl.clear();
      if (redeemedList != null) {
        redeemedListControl.value = redeemedList;
      }
    }, onSuccess3: (List<RewardsEntity>? earnedList) async {
      earnedListControl.clear();
      if (earnedList != null) {
        earnedListControl.value = earnedList;
      }
    });
  }

  redeemedPoints(int i) {
    RewardProvider().redeemPointFromServer(
      RewardController.to.giftListControl[i].giftId!,
      onSuccess1: (List<RewardsEntity>? giftList) async {
        giftListControl.clear();
        if (giftList != null) {
          giftListControl.value = giftList;
        }
      },
      onSuccess2: (List<RewardsEntity>? redeemedList) async {
        redeemedListControl.clear();
        if (redeemedList != null) {
          redeemedListControl.value = redeemedList;
        }
      },
    );


  }
}
