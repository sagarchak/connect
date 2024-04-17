import 'dart:io';

import 'package:connect/api_manager/constant/endpoints.dart';
import 'package:connect/database/DBHelper.dart';
import 'package:connect/modules/home/provider/edit_provider.dart';
import 'package:connect/modules/profile/provider/profile_provider.dart';
import 'package:connect/modules/home/provider/homecontroller.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:connect/utils/theme_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../database/entity/user_entity.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    HomeController.to.resetErrors();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        HomeController.to.mUser.value = DBHelper.mInstance.getMainUser();
        if (HomeController.to.mUser.value != null) {
          assignTheData(HomeController.to.mUser.value);
          HomeProvider().getProfileServer((u) {
            HomeController.to.mUser.value = u;
            assignTheData(u);
          });
        }
      }
    });
  }

  assignTheData(UserEntity? user) {
    if (user != null) {
      HomeController.to.nameController.text = user.name ?? "";
      HomeController.to.emailController.text = user.email ?? "";
      HomeController.to.mobileController.text = user.mobile ?? "";
      HomeController.to.aadhaarController.text = user.aadhaar ?? "";
      HomeController.to.aboutMeController.text = user.aboutMe ?? "";
      HomeController.to.panController.text = user.pan ?? "";
      HomeController.to.addressController.text = user.address ?? "";
      HomeController.to.dobController.text = user.dob ?? "";
    }
  }

  //"${Endpoints.baseUrl}/${HomeController.to.mUser.value?.image}"
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor.getColor("002a7f"),
        body: RefreshIndicator(
            onRefresh: () async {
              HomeProvider().getProfileServer((u) {
                assignTheData(u);
              });
            },
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            height: Get.height * 0.55,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              colors: [
                                HexColor.getColor("002a7f"),
                                HexColor.getColor("023ea0"),
                              ],
                            )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          right: 20,
                                        ),
                                        /*TextButton(
                                            onPressed: () {
                                              if (HomeController.to.profileView.value == ProfileView.SAVE) {
                                                HomeController.to.profileView.value = ProfileView.EDIT;
                                                HomeController.to.readOnly.value = true;
                                                EditProvider().postDataToServer();
                                              } else {
                                                HomeController.to.profileView.value = ProfileView.SAVE;
                                                HomeController.to.readOnly.value = false;
                                              }
                                            },
                                            child: HomeController.to.profileView.value == ProfileView.SAVE
                                                ? const Text(
                                                    "Save",
                                                    style: TextStyle(color: Colors.white),
                                                  )
                                                : const Text(
                                                    "Edit",
                                                    style: TextStyle(color: Colors.white),
                                                  )),*/
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Stack(alignment: Alignment.center, children: [
                                        Obx(() => Container(
                                              width: Get.width * .4,
                                              height: Get.width * .4,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular((Get.width * .4) / 2)),
                                                  border: Border.all(color: Colors.white, width: 0.5)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: SizedBox(
                                                  width: Get.width * .4,
                                                  height: Get.width * .4,
                                                  child: (HomeController.to.imageFile.value != null &&
                                                          CommonUtils.checkIfNotNull(HomeController.to.imageFile.value!.path))
                                                      ? ClipOval(
                                                          child: SizedBox.fromSize(
                                                            size: Size.fromRadius((Get.width * .4) / 2),
                                                            child: Image.file(
                                                              File(HomeController.to.imageFile.value!.path),
                                                              width: Get.width * .4,
                                                              height: Get.width * .4,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        )
                                                      : CommonUtils.getCircularNetworkImage(
                                                          "${Endpoints.baseUrl}/${HomeController.to.mUser.value?.image}", Get.width * .4),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                          bottom: 8,
                                          right: 8,
                                          child: InkWell(
                                            onTap: () => HomeController.to.chooseImageDialog(),
                                            child: Image.asset(
                                              'assets/images/camera_upload.png',
                                              height: Get.width * .1,
                                              width: Get.width * .1,
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                    if (CommonUtils.checkIfNotNull(HomeController.to.imageUrlError.value))
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                        child: Text(HomeController.to.imageUrlError.value,
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: FONT_REGULAR)),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  HomeController.to.mUser.value?.name ?? '',
                                  style: ThemeFonts.semiBold(textColor: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    HomeController.to.mUser.value?.mobile ?? '',
                                    style: ThemeFonts.regular(12).copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                /*Container(
                                    height: Get.height * 0.055,
                                    width: Get.width * 0.4,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(padding: const EdgeInsets.only(top: 2, bottom: 2), child: Image.asset("assets/images/coins.png")),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "${HomeController.to.mUser.value?.points ?? 0}",
                                              style: ThemeFonts.semiBold(textColor: Colors.black),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))*/
                              ],
                            ),
                          ),
                          Card(
                            elevation: 5,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                            ),
                            color: HexColor.getColor(WHITE_BG_COLOR_HEX),
                            child: SizedBox(
                              height: Get.height * 1,
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(

                                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                                    child: TextField(
                                        key: HomeController.to.key[0],
                                        onTap: () {
                                          HomeController.to.pickedDate(context);
                                        },
                                        readOnly: true,
                                        controller: HomeController.to.dobController,
                                        decoration: const InputDecoration(labelText: "Date of Birth", prefixIcon: Icon(Icons.calendar_month))),
                                  ),
                                  if (CommonUtils.checkIfNotNull(HomeController.to.dobError.value))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                      child: Text(HomeController.to.dobError.value,
                                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                                    ),
                                  Padding(
                                    key: HomeController.to.key[1],
                                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                                    child: TextField(
                                      readOnly: HomeController.to.readOnly.value,
                                      controller: HomeController.to.emailController,
                                      decoration: const InputDecoration(labelText: "Email"),
                                    ),
                                  ),
                                  if (CommonUtils.checkIfNotNull(HomeController.to.emailError.value))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                      child: Text(HomeController.to.emailError.value,
                                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                                    ),
                                  Padding(
                                    key: HomeController.to.key[2],
                                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                                    child: TextField(
                                      readOnly: HomeController.to.readOnly.value,
                                      controller: HomeController.to.addressController,
                                      decoration: const InputDecoration(labelText: "Address"),
                                    ),
                                  ),
                                  if (CommonUtils.checkIfNotNull(HomeController.to.addressError.value))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                      child: Text(HomeController.to.addressError.value,
                                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                                    ),
                                  Padding(
                                    key: HomeController.to.key[3],
                                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                                    child: TextField(
                                      readOnly: HomeController.to.readOnly.value,
                                      controller: HomeController.to.aadhaarController,
                                      decoration: const InputDecoration(labelText: "Aadhaar No."),
                                    ),
                                  ),
                                  if (CommonUtils.checkIfNotNull(HomeController.to.aadhaarError.value))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                      child: Text(HomeController.to.aadhaarError.value,
                                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                                    ),
                                  Padding(
                                    key: HomeController.to.key[4],
                                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                                    child: TextField(
                                      readOnly: HomeController.to.readOnly.value,
                                      controller: HomeController.to.panController,
                                      decoration: const InputDecoration(labelText: "Pan No."),
                                    ),
                                  ),
                                  if (CommonUtils.checkIfNotNull(HomeController.to.panError.value))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                      child: Text(HomeController.to.panError.value,
                                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    key: HomeController.to.key[5],
                                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                                    child: TextField(
                                      readOnly: HomeController.to.readOnly.value,
                                      controller: HomeController.to.aboutMeController,
                                      decoration: const InputDecoration(labelText: "About Me", border: OutlineInputBorder()),
                                      maxLines: 3,
                                    ),
                                  ),
                                  if (CommonUtils.checkIfNotNull(HomeController.to.aboutMeError.value))
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                                      child: Text(HomeController.to.aboutMeError.value,
                                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          HomeController.to.resetErrors();
                          //HomeController.to.readOnly.value = true;
                          EditProvider().postDataToServer();

                        },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), minimumSize: Size(150, 45)),
                        child: Text("Save")),
                    color: Colors.white,
                  )
                ],
              ),
            )));
  }
}
