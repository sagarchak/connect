import 'dart:async';
import 'dart:convert';

import 'package:connect/enums/MethodType.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:connect/controller/general_controller.dart';
import 'package:connect/enums/HttpMethod.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../utils/SharedPrefer.dart';

class CommonHttpClient {
  Map<String, String> headers = <String, String>{};
  Map<String, dynamic>? body = <String, String>{};
  String url = '';
  HttpMethod method = HttpMethod.Post;
  bool showLoading = false;
  int repeatCount = 0;

  CommonHttpClient(this.url, {this.body, this.method = HttpMethod.Post, this.showLoading = false});

  initHeaders() async {
    String? token = await SharedPrefer.getString(SharedPrefer.TOKEN);
    headers = <String, String>{
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  initBody() {
    body ??= <String, String>{};
  }

  Future<bool> checkInternet() async {
    GeneralController.to.isConnected.value = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      GeneralController.to.isConnected.value = true;
      return true;
    }
    return false;
  }

  Future<Response?> getResponse({String? key, List<String>? imagePathList, List<XFile>? imageAssetList}) async {
    Response? response;
    if (await checkInternet()) {
      //API Request TimeoutStream
      var apiData = <int>[];
      StreamController<List<int>> apiStream = StreamController();
      apiData.add(API_ERROR_CODE);
      apiStream.add(apiData);

      //Location Request TimeoutStream
      var locationData = <int>[];
      StreamController<List<int>> locationStream = StreamController();
      locationData.add(API_TIMEOUT_CODE);
      locationStream.add(apiData);

      await initHeaders();
      initBody();
      if (CommonUtils.checkIfNotNull(url) && body != null) {
        CommonUtils.showProgressDialog(showLoading);
        try {
          if (kDebugMode) {
            debugPrint('Request Headers: $headers');
            debugPrint('Request Body: $body');
            debugPrint('Request URL: $url');
          }
          switch (method) {
            case HttpMethod.Get:
              var request = MultipartRequest(MethodType.GET, Uri.parse(url));
              request.headers.addAll(headers);
              response = await http.Response.fromStream(await request.send()).timeout(const Duration(seconds: API_REQUEST_TIMEOUT), onTimeout: () {
                getx.Get.showSnackbar(
                  const getx.GetSnackBar(
                    title: TIMEOUT_ERROR_TITLE,
                    message: TIMEOUT_ERROR_BODY,
                    duration: Duration(seconds: 1),
                  ),
                );
                return Response(API_ERROR, API_ERROR_CODE);
              }).onError((error, stackTrace) {
                return Response(API_TIMEOUT, API_TIMEOUT_CODE);
              });
              break;
            case HttpMethod.Put:
              var request = MultipartRequest(MethodType.PUT, Uri.parse(url));
              if (body != null) {
                request.fields.addAll(CommonUtils.getBodyMap(body));
              }
              request.headers.addAll(headers);
              response = await http.Response.fromStream(await request.send()).timeout(const Duration(seconds: API_REQUEST_TIMEOUT), onTimeout: () {
                getx.Get.showSnackbar(
                  const getx.GetSnackBar(
                    title: TIMEOUT_ERROR_TITLE,
                    message: TIMEOUT_ERROR_BODY,
                    duration: Duration(seconds: 1),
                  ),
                );
                return Response(API_ERROR, API_ERROR_CODE);
              }).onError((error, stackTrace) {
                return Response(API_TIMEOUT, API_TIMEOUT_CODE);
              });
              break;
            case HttpMethod.Delete:
              var request = MultipartRequest(MethodType.DELETE, Uri.parse(url));
              if (body != null) {
                request.fields.addAll(CommonUtils.getBodyMap(body));
              }
              request.headers.addAll(headers);

              response = await http.Response.fromStream(await request.send()).timeout(const Duration(seconds: API_REQUEST_TIMEOUT), onTimeout: () {
                getx.Get.showSnackbar(
                  const getx.GetSnackBar(
                    title: TIMEOUT_ERROR_TITLE,
                    message: TIMEOUT_ERROR_BODY,
                    duration: Duration(seconds: 1),
                  ),
                );
                return Response(API_ERROR, API_ERROR_CODE);
              }).onError((error, stackTrace) {
                return Response(API_TIMEOUT, API_TIMEOUT_CODE);
              });
              break;
            default:
              var request = MultipartRequest(MethodType.POST, Uri.parse(url));
              if (body != null) {
                request.fields.addAll(CommonUtils.getBodyMap(body));
              }
              request.headers.addAll(headers);

              if (CommonUtils.checkIfNotNull(key)) {
                List<MultipartFile> mFiles = await CommonUtils.getMultipartFiles(key!, imagePathList: imagePathList, imageAssetList: imageAssetList);
                if (mFiles.isNotEmpty) {
                  request.files.addAll(mFiles);
                }
              }

              response = await http.Response.fromStream(await request.send()).timeout(const Duration(seconds: API_REQUEST_TIMEOUT), onTimeout: () {
                getx.Get.showSnackbar(
                  const getx.GetSnackBar(
                    title: TIMEOUT_ERROR_TITLE,
                    message: TIMEOUT_ERROR_BODY,
                    duration: Duration(seconds: 1),
                  ),
                );
                return Response(API_ERROR, API_ERROR_CODE);
              }).onError((error, stackTrace) {
                return Response(API_TIMEOUT, API_TIMEOUT_CODE);
              });
              break;
          }

          if (response.statusCode == 401) {
            //todo logout
          }
          if (kDebugMode) {
            debugPrint('ImagesPaths: ${imagePathList != null ? imagePathList.length.toString() : '0'}');
            debugPrint('ImagesAssets: ${imageAssetList != null ? imageAssetList.length.toString() : '0'}');
            debugPrint('Headers: $headers');
            debugPrint('Body: $body');
            debugPrint('URL: $url');
            debugPrint('Response Code: ${response.statusCode}');
            if (CommonUtils.checkIfNotNull(response.body)) {
              debugPrint('Response: ${response.body}');
            }
          }
        } catch (e) {}
      }
      CommonUtils.hideProgressDialog();
      return response;
    } else {
      getx.Get.showSnackbar(
        const getx.GetSnackBar(
          title: 'No Internet',
          message: NO_INTERNET,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
