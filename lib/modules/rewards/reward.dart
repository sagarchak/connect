import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/modules/rewards/provider/reward_controller.dart';
import 'package:connect/modules/rewards/provider/reward_provider.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:connect/utils/theme_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api_manager/constant/endpoints.dart';
import '../../utils/app_constants.dart';
import '../home/provider/homecontroller.dart';

class Reward extends StatefulWidget {
  const Reward({Key? key}) : super(key: key);

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  void initState() {
    RewardController.to.currentIndex.value = 0;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        RewardController.to.callRewardAPI();
      }
    });
  }

  int lengthOfList() {
    if (RewardController.to.currentIndex == 0) {
      return RewardController.to.giftListControl.length;
    } else if (RewardController.to.currentIndex == 1) {
      return RewardController.to.redeemedListControl.length;
    } else {
      return RewardController.to.earnedListControl.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: Get.height * 0.15,
              width: double.maxFinite,
              decoration: BoxDecoration(color: HexColor.getColor("4640d7")),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Rewards",
                  style: ThemeFonts.semiBold(textColor: Colors.white),
                ),
              ))),
          Container(
            margin: const EdgeInsets.all(15),
            height: 150,
            width: 150,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: Colors.grey, width: 15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Points",
                  style: ThemeFonts.c1(),
                ),
                Obx(() => Text(
                      "${HomeController.to.mUser.value?.points ?? ""}",
                      style: ThemeFonts.h3Medium(),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.582,
            width: double.maxFinite,
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(
                              icon: Icon(
                                Icons.card_giftcard,
                              ),
                              child: Text(
                                "Gift",
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.takeout_dining,
                              ),
                              child: Text(
                                "Withdrawal",
                              ),
                            ),
                            Tab(
                              icon: Icon(Icons.point_of_sale),
                              text: 'Point Earned',
                            )
                          ],
                          labelColor: Colors.indigoAccent,
                          unselectedLabelColor: Colors.grey,
                          onTap: (int sel) {
                            RewardController.to.currentIndex.value = sel;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      height: Get.height * 0.47,
                      child: Obx(
                        () => ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              if (RewardController.to.currentIndex == 0) {
                                return Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    child: (RewardController.to.giftListControl.isNotEmpty)
                                        ? Card(
                                            elevation: 10,
                                            child: ListTile(
                                              contentPadding: const EdgeInsets.all(8),
                                              leading: CircleAvatar(
                                                child: CachedNetworkImage(
                                                  imageUrl: "${Endpoints.baseUrl}/${RewardController.to.giftListControl[i].image ?? ""}",
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context, url, progress) => Center(
                                                    child: SizedBox(
                                                      height: Get.height * .18,
                                                      width: Get.height * .18,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, progress) => Center(child: Image.asset('assets/images/icon.png')),
                                                ),
                                              ),
                                              title: CommonUtils.checkIfNotNull(RewardController.to.giftListControl[i].title)
                                                  ? Text(RewardController.to.giftListControl[i].title!)
                                                  : const SizedBox.shrink(),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  if (CommonUtils.checkIfNotNull(RewardController.to.giftListControl[i].description))
                                                    Text(
                                                      RewardController.to.giftListControl[i].description!,
                                                      style: ThemeFonts.p2Regular(),
                                                    ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    '${(RewardController.to.giftListControl[i].point ?? 0)}',
                                                    style: ThemeFonts.semiBold(textColor: HexColor.getColor(PRIMARY_COLOR_HEX)),
                                                  ),
                                                ],
                                              ),
                                              trailing: TextButton(
                                                onPressed: () {
                                                  CommonUtils.showCommonFunDialog(
                                                      "Do you really want to redeem this gift which worth ${RewardController.to.giftListControl[i].point} points ? ",
                                                      "Once redeemed, ${RewardController.to.giftListControl[i].point} points with be deducted from your account and the gift will be delivered to your address.",
                                                      onConfirm: () {
                                                    if (RewardController.to.giftListControl[i].giftId != null) {
                                                      RewardController.to.redeemedPoints(i);
                                                    }
                                                  }, onCancel: () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("Redeem"),
                                              ),
                                            ))
                                        : const SizedBox.shrink());
                              }
                              if (RewardController.to.currentIndex == 1) {
                                return Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    child: (RewardController.to.redeemedListControl.isNotEmpty)
                                        ? Card(
                                            elevation: 10,
                                            child: ListTile(
                                              contentPadding: const EdgeInsets.all(8),
                                              leading: CircleAvatar(
                                                child: CachedNetworkImage(
                                                  imageUrl: "${Endpoints.baseUrl}/${RewardController.to.redeemedListControl[i].image ?? ""}",
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context, url, progress) => Center(
                                                    child: SizedBox(
                                                      height: Get.height * .18,
                                                      width: Get.height * .18,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, progress) => Center(child: Image.asset('assets/images/icon.png')),
                                                ),
                                              ),
                                              title: CommonUtils.checkIfNotNull(RewardController.to.redeemedListControl[i].title)
                                                  ? Text(RewardController.to.redeemedListControl[i].title!)
                                                  : const SizedBox.shrink(),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  if (CommonUtils.checkIfNotNull(RewardController.to.redeemedListControl[i].description))
                                                    Text(
                                                      RewardController.to.redeemedListControl[i].description!,
                                                      style: ThemeFonts.p2Regular(),
                                                    ),
                                                  Text(
                                                    RewardController.to.redeemedListControl[i].createdAt!,
                                                    style: ThemeFonts.p3Regular(),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    '${(RewardController.to.redeemedListControl[i].point ?? 0)}',
                                                    style: ThemeFonts.semiBold(textColor: HexColor.getColor(PRIMARY_COLOR_HEX)),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        : const SizedBox.shrink());
                              }
                              if (RewardController.to.currentIndex == 2) {
                                return Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    child: (RewardController.to.earnedListControl.isNotEmpty)
                                        ? Card(
                                            elevation: 10,
                                            child: ListTile(
                                              contentPadding: const EdgeInsets.all(8),
                                              leading: CircleAvatar(
                                                  child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Image.asset(
                                                  "assets/images/coins.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              )),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  if (CommonUtils.checkIfNotNull(RewardController.to.earnedListControl[i].description))
                                                    Text(
                                                      RewardController.to.earnedListControl[i].description!,
                                                      style: ThemeFonts.p2Regular(),
                                                    ),
                                                  Text(
                                                    RewardController.to.earnedListControl[i].createdAt!,
                                                    style: ThemeFonts.p3Regular(),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    '${(RewardController.to.earnedListControl[i].point ?? 0)}',
                                                    style: ThemeFonts.semiBold(textColor: HexColor.getColor(PRIMARY_COLOR_HEX)),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        : const SizedBox.shrink());
                              }
                            },
                            itemCount: lengthOfList()),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
