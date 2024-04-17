import 'package:connect/modules/login/login.dart';
import 'package:connect/modules/login/provider/logincontroller.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/theme_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/loginview.dart';




class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
         mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:[

              Container(
              color: HexColor.getColor('2f47ae'),
              height: Get.height * 0.47,
              width: double.maxFinite,),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset('assets/images/bank.png', height: 300, width: 250, alignment: Alignment.bottomCenter,),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 130),
                child: Image.asset('assets/images/bag.png', height: 200, width: 150, alignment: Alignment.bottomRight,),
              ),
          ]),

      
      SizedBox(height: Get.height * 0.06,),

         Padding(
           padding: const EdgeInsets.only(left: 25, ),
           child: Text("FRONTIZA", style: ThemeFonts.semiBold(textColor: HexColor.getColor("7e7d9a")),),
         ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(

                "PARIWAR", style: ThemeFonts.bold2(40, HexColor.getColor("4943d8")),textAlign: TextAlign.start,
              ),
          ),

          Container(
            width: Get.width * 0.6,
            padding: const EdgeInsets.only(left: 25, ),
            child: Text(
              "Frontiza is one of the Fastest Growing Financial Products Distribution Company. We promote long-term relations based on trust, transparency, and quality.",
              style: ThemeFonts.p3Regular(textColor: HexColor.getColor("7e7d9a")),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: ElevatedButton(onPressed:() {
              LoginController.to.loginView.value =  LoginView.NUMBER;
              Get.to(Login());
            }, style: ElevatedButton.styleFrom(backgroundColor: HexColor.getColor('febe06')),
              child: const Text("GET STARTED", style: TextStyle(color: Colors.black),),),
          )
       ],
      ),
    );
  }
}

