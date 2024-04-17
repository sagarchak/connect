

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/modules/home/provider/homecontroller.dart';
import 'package:connect/modules/postdetails/provider/web_controller.dart';
import 'package:connect/modules/postdetails/provider/webview_provider.dart';
import 'package:connect/utils/HexColor.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:connect/utils/theme_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api_manager/constant/endpoints.dart';

class PostDetails extends StatefulWidget {
  PostDetails(this.url, {super.key});

  String url;

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<PostDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        WebController.to.postDetails.value = null;
        WebProvider().getPostFromServer(widget.url, (postDetails) {
          WebController.to.postDetails.value = postDetails;
        });
      }
    });
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
                        child: Text(WebController.to.postDetails.value?.title ?? "",
                            overflow: TextOverflow.ellipsis, maxLines: 1, style: ThemeFonts.h3Medium(textColor: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Obx(() => SizedBox(
                          width: Get.width * .8,
                          height: Get.height * .3,
                          child: CommonUtils.checkIfNotNull(WebController.to.postDetails.value?.image)
                              ? Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: Colors.white),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
                                    child: InkWell(
                                      onTap: (){
                                        if( CommonUtils.checkIfNotNull(WebController.to.postDetails.value?.videoUrl))
                                        {
                                          final url = Uri.parse("${WebController.to.postDetails.value?.videoUrl ?? ""}");
                                          CommonUtils.launchURL(url);
                                        }
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        fit: StackFit.expand,
                                        children: [

                                          CachedNetworkImage(
                                            imageUrl: "${Endpoints.baseUrl}/${WebController.to.postDetails.value?.image}",
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
                                              child: Image.asset('assets/images/icon.png'),
                                            ),
                                          ),
                                          CommonUtils.checkIfNotNull(  WebController.to.postDetails.value?.videoUrl)?
                                          const Icon(Icons.play_circle_outline , size: 70,):
                                              const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: SizedBox(
                                      height: Get.height * .18,
                                      width: Get.height * .18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
                                      ),
                                    ),
                                  ),
                                ))),
                    ),
                    SizedBox(
                      height: Get.height * 0.4,
                      width: Get.width * 0.9,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.all(10),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Obx(() => Column(children: [
                                (CommonUtils.checkIfNotNull(WebController.to.postDetails.value?.content))
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Html(
                                            data: WebController.to.postDetails.value?.content,
                                            onLinkTap: (url, _, __, ___) async {
                                              CommonUtils.launchURL(Uri.parse(url!));
                                            }))
                                    : Center(
                                        child: SizedBox(
                                          height: Get.height * .18,
                                          width: Get.height * .18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
                                          ),
                                        ),
                                      ),
                              ])),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(boxShadow: const [
                        BoxShadow(
                          offset: Offset(3.0, 3.0),
                          blurStyle: BlurStyle.inner,
                          color: Colors.black,
                          blurRadius: 20.0,
                        ),
                      ], gradient: LinearGradient(colors: [HexColor.getColor("9d78e4"), HexColor.getColor("3c3167")])),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 70), backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                          onPressed: () {
                            final url = Uri.parse(WebController.to.postDetails.value?.webUrl?? "");
                            CommonUtils.launchURL(url);
                          },
                          child: Text(
                            "Invest Now",
                            style: ThemeFonts.h3Bold(),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
