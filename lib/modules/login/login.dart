
import 'package:connect/enums/loginview.dart';
import 'package:connect/modules/login/provider/logincontroller.dart';
import 'package:connect/modules/login/provider/login_provider.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/theme_fonts.dart';

import '../../utils/common_utils.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
   LoginController.to.rebuildLogin();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child:Obx(() =>  Scaffold(
          body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginbackground.jpeg'),
                fit: BoxFit.fill,
              ),
            ),
            height: double.maxFinite,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .08,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "PARIWAR",
                      style: ThemeFonts.h1Bold(textColor: Colors.white),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.17,
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.only(bottom: 10, top: 50, left: 50, right: 50),
                    child: LoginController.to.loginView.value == LoginView.OTP
                        ? OtpTextField(
                      fillColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                      filled: true,
                      styles: const [
                        TextStyle(color: Colors.white),
                        TextStyle(color: Colors.white),
                        TextStyle(color: Colors.white),
                        TextStyle(color: Colors.white),
                      ],
                      enabledBorderColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                      focusedBorderColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                      onSubmit: (val) {
                        LoginController.to.otpCode.value = val;
                      },
                    )
                        : TextField(
                      onChanged: (text) {
                        LoginController.to.phoneError.value = "";
                        LoginController.to.validatePhone(context, false);
                      },
                      controller: LoginController.to.mobileController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX), width: 0.0),
                            borderRadius: BorderRadius.circular(50)),
                        contentPadding: const EdgeInsets.only(left: 30),
                        hintText: "Mobile No.",
                        hintStyle: const TextStyle(color: Colors.white),
                        fillColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX), width: 0.0),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  if (CommonUtils.checkIfNotNull(LoginController.to.phoneError.value))
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 5, 5),
                        child: Text(LoginController.to.phoneError.value,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: FONT_REGULAR)),
                      ),
                    ),
                  LoginController.to.loginView.value == LoginView.OTP
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !LoginController.to.enableResend.value
                          ? Text("after ${LoginController.to.secondsRemaining} seconds", style: ThemeFonts.p1Regular(textColor: Colors.white))
                          : const SizedBox(),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size(50, 30),
                          ),
                          onPressed: LoginController.to.enableResend.value
                              ? () {
                            LoginProvider().resendOtpToServer((p0) {
                              if (p0) {
                                LoginController.to.resendCode();
                              }
                            });
                          }
                              : null,
                          child: Text(
                            "Resend OTP",
                            style: ThemeFonts.p3Medium(
                              textColor: LoginController.to.enableResend.value ? Colors.white : Colors.grey,
                            ),
                          ))
                    ],
                  )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: HexColor.getColor(BUTTON_COLOR_HEX).withOpacity(0.7),
                          backgroundColor: HexColor.getColor(BUTTON_COLOR_HEX),
                          minimumSize: const Size(180, 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      onPressed: LoginController.to.phoneError.isEmpty
                          ? () {
                        if (LoginController.to.loginView.value == LoginView.NUMBER) {
                          LoginProvider().giveDataToServer((status) {
                            if (status) {
                              LoginController.to.loginView.value = LoginView.OTP;
                              LoginController.to.startCode();
                            }
                          });
                        }
                        if (LoginController.to.loginView.value == LoginView.OTP) {
                          LoginProvider().verifyOtpToServer();
                        }
                      }
                          : null,
                      child: LoginController.to.loginView.value == LoginView.OTP
                          ? Text(
                        "Submit",
                        style: ThemeFonts.p1Medium(),
                      )
                          : Text("Send OTP", style: ThemeFonts.p1Medium()),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Text("Powered By", style: ThemeFonts.c2(textColor: Colors.white),),
                  SizedBox(
                    height: 35,
                    width: 185,
                    child: Image.asset(
                      "assets/images/logo_white.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: FloatingActionButton(
                            heroTag: "btn1",
                            onPressed: () {
                           var facebookUrl = Uri.parse("https://www.facebook.com/frontiza.in/");
                              CommonUtils.launchURL(facebookUrl);
                            },
                            backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                            child: Image.asset(
                              "assets/images/facebook.png",
                              height: 30,
                              width: 30,
                            )),
                      ),
                     /* Padding(
                        padding: const EdgeInsets.all(15),
                        child: FloatingActionButton(
                            heroTag: "btn2",
                            onPressed: () {},
                            backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                            child: Image.asset(
                              "assets/images/instagram.png",
                              height: 30,
                              width: 30,
                            )),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: FloatingActionButton(
                            heroTag: "btn3",
                            onPressed: () {
                              var twitterUrl = Uri.parse("https://twitter.com/Frontiza2");
                              CommonUtils.launchURL(twitterUrl);
                            },
                            backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                            child: Image.asset(
                              "assets/images/twitter.png",
                              height: 30,
                              width: 30,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          /*Column(
              children: [

             /*   Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: HexColor.getColor(PRIMARY_COLOR_HEX), borderRadius: const BorderRadius.only(topRight: Radius.circular(50))),
                  height: Get.height * 0.15,
                  width: double.maxFinite,
                  child: const Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(40),
                    )),
                    color: Colors.white,
                    margin: EdgeInsets.zero,
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.zero,
                  height: Get.height * 0.7,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: HexColor.getColor(PRIMARY_COLOR_HEX),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(80), bottomRight: Radius.circular(80))),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "PARIWAR",
                          style: ThemeFonts.h1Bold(textColor: Colors.white),
                        ),
                      ),
                      Container(
                        height: Get.height * 0.17,
                        width: Get.width * 0.9,
                        padding: const EdgeInsets.only(bottom: 10, top: 50, left: 50, right: 50),
                        child: LoginController.to.loginView.value == LoginView.OTP
                            ? OtpTextField(
                                fillColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                                filled: true,
                                styles: const [
                                  TextStyle(color: Colors.white),
                                  TextStyle(color: Colors.white),
                                  TextStyle(color: Colors.white),
                                  TextStyle(color: Colors.white),
                                ],
                                enabledBorderColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                                focusedBorderColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                                onSubmit: (val) {
                                  LoginController.to.otpCode.value = val;
                                },
                              )
                            : TextField(
                                onChanged: (text) {
                                  LoginController.to.phoneError.value = "";
                                  LoginController.to.validatePhone(context, false);
                                },
                                controller: LoginController.to.mobileController,
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX), width: 0.0),
                                      borderRadius: BorderRadius.circular(50)),
                                  contentPadding: const EdgeInsets.only(left: 30),
                                  hintText: "Mobile No.",
                                  hintStyle: const TextStyle(color: Colors.white),
                                  fillColor: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: HexColor.getColor(PRIMARY_COLOR_LIGHT_HEX), width: 0.0),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                      ),
                      if (CommonUtils.checkIfNotNull(LoginController.to.phoneError.value))
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 5, 5),
                            child: Text(LoginController.to.phoneError.value,
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: FONT_REGULAR)),
                          ),
                        ),
                      LoginController.to.loginView.value == LoginView.OTP
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                !LoginController.to.enableResend.value
                                    ? Text("after ${LoginController.to.secondsRemaining} seconds",
                                        style: ThemeFonts.p1Regular(textColor: Colors.white))
                                    : const SizedBox(),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      minimumSize: const Size(50, 30),
                                    ),
                                    onPressed: LoginController.to.enableResend.value
                                        ? () {
                                            LoginProvider().resendOtpToServer((p0) {
                                              if (p0) {
                                                LoginController.to.resendCode();
                                              }
                                            });
                                          }
                                        : null,
                                    child: Text(
                                      "Resend OTP",
                                      style: ThemeFonts.p3Medium(
                                        textColor: LoginController.to.enableResend.value ? Colors.white : Colors.grey,
                                      ),
                                    ))
                              ],
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: HexColor.getColor(BUTTON_COLOR_HEX).withOpacity(0.7),
                              backgroundColor: HexColor.getColor(BUTTON_COLOR_HEX),
                              minimumSize: const Size(180, 40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                          onPressed: LoginController.to.phoneError.isEmpty
                              ? () {
                                  if (LoginController.to.loginView.value == LoginView.NUMBER) {
                                    LoginProvider().giveDataToServer((status) {
                                      if (status) {
                                        LoginController.to.loginView.value = LoginView.OTP;
                                        LoginController.to.startCode();
                                      }
                                    });
                                  }
                                  if (LoginController.to.loginView.value == LoginView.OTP) {
                                    LoginProvider().verifyOtpToServer();
                                  }
                                }
                              : null,
                          child: LoginController.to.loginView.value == LoginView.OTP
                              ? Text(
                                  "Submit",
                                  style: ThemeFonts.p1Medium(),
                                )
                              : Text("Send OTP", style: ThemeFonts.p1Medium()),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: Image.asset(
                          "assets/images/logo_white.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: HexColor.getColor(PRIMARY_COLOR_HEX), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50))),
                  height: Get.height * 0.15,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      topLeft: Radius.circular(50),
                    )),
                    color: Colors.white,
                    margin: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: FloatingActionButton(
                              heroTag: "btn1",
                              onPressed: () {},
                              backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                              child: Image.asset(
                                "assets/images/facebook.png",
                                height: 30,
                                width: 30,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: () {},
                              backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                              child: Image.asset(
                                "assets/images/instagram.png",
                                height: 30,
                                width: 30,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: FloatingActionButton(
                              heroTag: "btn3",
                              onPressed: () {},
                              backgroundColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                              child: Image.asset(
                                "assets/images/twitter.png",
                                height: 30,
                                width: 30,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),*/
        ),),
        onWillPop: () {
          if (LoginController.to.loginView.value == LoginView.OTP) {
            LoginController.to.loginView.value = LoginView.NUMBER;
            LoginController.to.enableResend.value = false;
            LoginController.to.secondsRemaining.value = 60;
            LoginController.to.timer.cancel();
            return Future.value(false);
          } else {

            return Future.value(true);
          }
        });
  }
}
