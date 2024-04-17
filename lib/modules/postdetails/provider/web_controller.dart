import 'package:connect/database/entity/post_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebController extends GetxController {
  static WebController get to => Get.find();
  Rxn<PostDetailsEntity> postDetails = Rxn<PostDetailsEntity>();

}
