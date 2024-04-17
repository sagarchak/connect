import 'package:connect/modules/refer_&_win/provider/refer_provider.dart';
import 'package:connect/modules/refer_&_win/provider/refercontroller.dart';
import 'package:connect/modules/refer_&_win/provider/refercontroller.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/common_utils.dart';
import '../../utils/theme_fonts.dart';

class ReferAndWin extends StatefulWidget {
  const ReferAndWin({Key? key}) : super(key: key);

  @override
  State<ReferAndWin> createState() => _ReferAndWinState();
}

class _ReferAndWinState extends State<ReferAndWin> {
  @override
  void initState() {
    super.initState();
    ReferController.to.getReferAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
          title: Text(
            "Refer & Win",
            style: ThemeFonts.bold(20),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
          onPressed: () => Get.bottomSheet(Container(
            height: Get.height * 0.5,
            width: double.maxFinite,
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(16)), color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                    child: TextField(
                        controller: ReferController.to.nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        )),
                  ),
                  if (CommonUtils.checkIfNotNull(ReferController.to.nameError.value))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                      child: Text(ReferController.to.nameError.value,
                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                    child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: ReferController.to.mobileController,
                        decoration: const InputDecoration(
                          labelText: "Mobile No.",
                        )),
                  ),
                  if (CommonUtils.checkIfNotNull(ReferController.to.mobileError.value))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                      child: Text(ReferController.to.mobileError.value,
                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * .07),
                    child: TextField(
                        controller: ReferController.to.productController,
                        decoration: const InputDecoration(
                          labelText: "Product",
                        )),
                  ),
                  if (CommonUtils.checkIfNotNull(ReferController.to.productError.value))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 3, 15, 10),
                      child: Text(ReferController.to.productError.value,
                          style: TextStyle(color: HexColor.getColor(DARK_ERROR_COLOR_HEX), fontSize: 12, fontFamily: FONT_REGULAR)),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          ReferController.to.submitReferAPI();

                          if (ReferController.to.nameController.text.isNotEmpty &&
                              ReferController.to.mobileController.text.isNotEmpty &&
                              ReferController.to.productController.text.isNotEmpty) {
                            ReferController.to.nameController.text = "";
                            ReferController.to.mobileController.text = "";
                            ReferController.to.productController.text = "";
                            Get.back();
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), minimumSize: Size(300, 45)),
                        child: Text("Save")),
                  ),
                ],
              ),
            ),
          )),
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Center(
            child: Obx(
              () => ReferController.to.addList.isEmpty
                  ? Text("No Data yet!!!")
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 2,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8),
                                  title: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                    child: Row(
                                      children: [
                                        if (CommonUtils.checkIfNotNull(ReferController.to.addList[i].name))
                                          SizedBox(
                                            width: Get.width * 0.8,
                                            child: Text(
                                              ReferController.to.addList[i].name!,
                                              style: ThemeFonts.bold(16).copyWith(color: HexColor.getColor(PRIMARY_COLOR_HEX)),
                                              softWrap: true,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (CommonUtils.checkIfNotNull(ReferController.to.addList[i].mobile))
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 1),
                                          child: Row(
                                            children: [
                                              Text(
                                                ReferController.to.addList[i].mobile!,
                                                style: ThemeFonts.p2Regular(textColor: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (CommonUtils.checkIfNotNull(ReferController.to.addList[i].product))
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.8,
                                                child: Text(
                                                  ReferController.to.addList[i].product!,
                                                  style: ThemeFonts.p2Regular(textColor: Colors.black54),
                                                  softWrap: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                      itemCount: ReferController.to.addList.length,
                    ),
            ),
          ),
        ));
  }
}
