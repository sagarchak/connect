import 'package:connect/modules/refer_&_win/provider/refer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../database/entity/add_refer_entity.dart';
import '../../../utils/common_utils.dart';

class ReferController extends GetxController {
  static ReferController get to => Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController productController = TextEditingController();
  RxList<AddReferEntity> addList = <AddReferEntity>[].obs;

  final List<GlobalKey> key = List.generate(2, (index) => GlobalKey());

  RxString nameError = ''.obs;
  RxString mobileError = ''.obs;
  RxString productError = ''.obs;

  submitReferAPI() async {
    await ReferProvider().postReferToServer((List<AddReferEntity>? addReferList) async {
      addList.clear();
      if (addReferList != null) {
        addList.value = addReferList;
      }
    });
  }

  getReferAPI() async {
    await ReferProvider().getReferToServer((List<AddReferEntity>? addReferList) async {
      addList.clear();
      if (addReferList != null) {
        addList.value = addReferList;
      }
    });
  }

  showAPIErrors(Map<String, dynamic>? resMap) {
    if (resMap != null) {
      print(resMap);
      var position = 0;
      if (resMap['errors'] != null) {
        if (CommonUtils.checkIfNotNull(resMap['errors']['name'] as String?)) {
          nameError.value = (resMap['errors']['name'] as String?) ?? '';
          print(nameError);
          position = 0;
        }

        if (CommonUtils.checkIfNotNull(resMap['errors']['mobile'] as String?)) {
          mobileError.value = (resMap['errors']['mobile'] as String?) ?? '';

          position = 1;
        }
        if (CommonUtils.checkIfNotNull(resMap['errors']['product'] as String?)) {
          productError.value = (resMap['errors']['product'] as String?) ?? '';
          position = 2;
        }




      }
      if (key[position].currentContext != null) {
        Scrollable.ensureVisible(key[position].currentContext!, duration: const Duration(milliseconds: 200), curve: Curves.ease);
      }
    }
  }
}
