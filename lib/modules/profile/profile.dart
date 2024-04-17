import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/modules/home/provider/homecontroller.dart';
import 'package:connect/modules/logout.dart';
import 'package:connect/modules/postdetails/postdetails.dart';
import 'package:connect/modules/refer_&_win/refer&win.dart';
import 'package:connect/objectbox.g.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/LogoutUtil.dart';
import 'package:connect/utils/SharedPrefer.dart';
import 'package:connect/utils/ShowNotification.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:connect/utils/theme_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_manager/constant/endpoints.dart';
import '../../database/DBHelper.dart';
import '../../database/entity/user_entity.dart';
import '../../enums/profileview.dart';
import '../home/home.dart';
import '../rewards/reward.dart';
import 'provider/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  checkIfNotificationSubscribed() async {
    bool isSubscribed = await SharedPrefer.getBoolean(SharedPrefer.SUBSCRIBED);
    if (!isSubscribed) {
      await ShowNotification.instance.subscribeToTopics();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted) {
        UserEntity? user = DBHelper.mInstance.getMainUser();
        if (user != null) {
          assignTheData(user);
          HomeProvider().getProfileServer((u) {
            assignTheData(u);
          });
        }
        await checkIfNotificationSubscribed();
      }
    });
  }

  assignTheData(UserEntity? user) {
    if (user != null) {
      HomeController.to.mUser.value = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height * .7,
              width: double.maxFinite,
              child: Image.asset(
                "assets/images/app_bg_bottom_rounded.png",
                fit: BoxFit.fill,
                height: double.maxFinite,
                width: double.maxFinite,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .09,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: const EdgeInsets.all(10),
                            height: Get.height * 0.25,
                            width: Get.width * 0.38,
                            child: Obx(() => CommonUtils.checkIfNotNull(HomeController.to.mUser.value?.image)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: "${Endpoints.baseUrl}/${HomeController.to.mUser.value?.image}",
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
                                      errorWidget: (context, url, progress) => Center(
                                        child: Image.asset('assets/images/icon.png')),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                                    margin: const EdgeInsets.all(10),
                                    height: Get.height * 0.25,
                                    width: Get.width * 0.38,
                                    child: Image.asset('assets/images/avatar.png'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 3),
                                  child: SizedBox(
                                      width: Get.width * 0.46,
                                      child: Obx(
                                        () => Text(
                                          HomeController.to.mUser.value?.name ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: ThemeFonts.semiBold(textColor: Colors.white),
                                        ),
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 0, right: 5, left: 5, bottom: 10),
                                    child: Obx(
                                      () => Text(
                                        HomeController.to.mUser.value?.mobile ?? "",
                                        style: ThemeFonts.p3Medium(textColor: Colors.white),
                                      ),
                                    )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Get.to(const Home()),
                                      child: Container(
                                          height: Get.height * 0.055,
                                          width: Get.width * 0.4,
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  HexColor.getColor("fa9016"),
                                                  HexColor.getColor("fa5d03"),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: Icon(
                                                    Icons.manage_accounts,
                                                    size: 22,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "Profile",
                                                  style: ThemeFonts.semiBold(textColor: Colors.white),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                   /* Container(
                                        height: Get.height * 0.055,
                                        width: Get.width * 0.4,
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                                                  child: Image.asset(
                                                    "assets/images/coins.png",
                                                    fit: BoxFit.contain,
                                                  )),
                                              Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Obx(
                                                    () => Text(
                                                      "${HomeController.to.mUser.value?.points ?? 0}",
                                                      style: ThemeFonts.semiBold(textColor: Colors.black),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )),*/
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About Me:", style: ThemeFonts.semiBold(textColor: Colors.white)),
                            const SizedBox(
                              height: 2,
                            ),
                            Obx(
                              () => Text(
                                HomeController.to.mUser.value?.aboutMe ?? "",
                                maxLines: 6,
                                style: ThemeFonts.p3Medium(textColor: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                            color: HexColor.getColor(WHITE_BG_COLOR_HEX)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () => Get.to(PostDetails(Endpoints.getPostDetails1)),
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * .11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/money.png", height: 30, width: 30, fit: BoxFit.contain),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Mutual Fund",
                                      style: ThemeFonts.p1Medium(textColor: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * .11),
                              child: Divider(height: 0, thickness: 1.2, color: HexColor.getColor("0a1a42").withOpacity(.6)),
                            ),
                            InkWell(
                              onTap: () => Get.to(PostDetails(Endpoints.getPostDetails2)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * .11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/save-money.png", height: 30, width: 30, fit: BoxFit.contain),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Stock Broking",
                                        style: ThemeFonts.p1Medium(textColor: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * .11),
                              child: Divider(height: 0, thickness: 1.2, color: HexColor.getColor("0a1a42").withOpacity(.6)),
                            ),
                            InkWell(
                                onTap: () => Get.to(PostDetails(Endpoints.getPostDetails3)),
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * .11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/investment.png", height: 30, width: 30, fit: BoxFit.contain),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Investment",
                                      style: ThemeFonts.p1Medium(textColor: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * .11),
                              child: Divider(height: 0, thickness: 1.2, color: HexColor.getColor("0a1a42").withOpacity(.6)),
                            ),
                            InkWell(
                              onTap: (){Get.to(ReferAndWin());},
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * .11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/gift.png", height: 30, width: 30, fit: BoxFit.contain),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Refer & Win",
                                        style: ThemeFonts.p1Medium(textColor: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * .11),
                              child: Divider(height: 0, thickness: 1.2, color: HexColor.getColor("0a1a42").withOpacity(.6)),
                            ),
                            InkWell(
                              onTap: ()=>
                                CommonUtils.showCommonFunDialog("Logging Out", "Are you sure you want to logout?",
                                    onCancel: ()=> Get.back(),
                                    onConfirm: () =>  Logout().logoutFromServer() ),


                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * .11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: 30,
                                      color: HexColor.getColor("0a1a42"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Log Out",
                                        style: ThemeFonts.p1Medium(textColor: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
