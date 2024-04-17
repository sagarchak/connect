import 'package:connect/enums/profileview.dart';
import 'package:connect/modules/home/provider/edit_provider.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../database/entity/user_entity.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<ProfileView> profileView = ProfileView.SAVE.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  Rxn<UserEntity> mUser = Rxn<UserEntity>();

  final List<GlobalKey> key = List.generate(6, (index) => GlobalKey());

  RxString panError = ''.obs;
  RxString emailError = ''.obs;
  RxString imageUrlError = ''.obs;
  RxString aadhaarError = ''.obs;
  RxString addressError = ''.obs;
  RxString dobError = ''.obs;
  RxString aboutMeError = ''.obs;

  void resetErrors() {
    panError.value = '';
    emailError.value = '';
    imageUrlError.value = '';
    aadhaarError.value = '';
    addressError.value = '';
    aboutMeError.value = "";
    dobError.value = "";
  }

  RxBool readOnly = false.obs;

  Rxn<XFile> imageFile = Rxn<XFile>();
  final ImagePicker picker = ImagePicker();

  pickedDate(BuildContext context) async {
    DateTime endDate = DateTime(DateTime.now().year - 13);
    DateTime? pickedDate = await showDatePicker(context: context, initialDate: endDate, firstDate: DateTime(1950), lastDate: endDate);
    if (pickedDate != null) {
      HomeController.to.dobController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
    }
  }

  showAPIErrors(Map<String, dynamic>? resMap) {
    if (resMap != null) {
      var position = 0;
      if (resMap['errors'] != null) {
        if (CommonUtils.checkIfNotNull(resMap['errors']['pan'] as String?)) {
          panError.value = (resMap['errors']['pan'] as String?) ?? '';
          readOnly.value = false;
          position = 4;
        }

        if (CommonUtils.checkIfNotNull(resMap['errors']['aboutMe'] as String?)) {
          aboutMeError.value = (resMap['errors']['aboutMe'] as String?) ?? '';
          readOnly.value = false;
          position = 5;
        }
        if (CommonUtils.checkIfNotNull(resMap['errors']['email'] as String?)) {
          emailError.value = (resMap['errors']['email'] as String?) ?? '';
          readOnly.value = false;
          position = 1;
        }


        if (CommonUtils.checkIfNotNull(resMap['errors']['image'] as String?)) {
          imageUrlError.value = (resMap['errors']['image'] as String?) ?? '';

        }

        if (CommonUtils.checkIfNotNull(resMap['errors']['aadhaar'] as String?)) {
          aadhaarError.value = (resMap['errors']['aadhaar'] as String?) ?? '';
          readOnly.value = false;
          position = 3;
        }


        if (CommonUtils.checkIfNotNull(resMap['errors']['address'] as String?)) {
          addressError.value = (resMap['errors']['address'] as String?) ?? '';
          readOnly.value = false;
          position = 2;
        }

        if (CommonUtils.checkIfNotNull(resMap['errors']['dob'] as String?)) {
          dobError.value = (resMap['errors']['dob'] as String?) ?? '';
          readOnly.value = false;
          position = 0;
        }
      }
      if (key[position].currentContext != null) {

        Scrollable.ensureVisible(key[position].currentContext!, duration: const Duration(milliseconds: 200), curve: Curves.ease);
      }
    }
  }

  profileImageUploadAPI() async {
    if (imageFile != null && CommonUtils.checkIfNotNull(imageFile.value!.path)) {
      List<XFile> imageAssetList = [];
      imageAssetList.add(imageFile.value!);
      await EditProvider().profileImageUploadAPI(imageAssetList: imageAssetList);
    } else {
      CommonUtils.showCommonDialog('Profile Image Change', 'Please select an image for profile image');
    }
  }

  Future<void> openCamera() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile != null && CommonUtils.checkIfNotNull(pickedFile.path)) {
        imageFile.value = pickedFile;

        await profileImageUploadAPI();
      }
    } catch (e) {}
  }

  Future<void> loadGallery() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null && CommonUtils.checkIfNotNull(pickedFile.path)) {
        imageFile.value = pickedFile;
        await profileImageUploadAPI();
      }
    } catch (e) {}
  }

  chooseImageDialog() {
    Get.defaultDialog(
      title: 'Profile Image Upload',
      middleText: "Please choose an image to set as your profile picture",
      textCancel: "Gallery",
      onCancel: () {
        //Get.back();
        loadGallery();
      },
      textConfirm: "Camera",
      onConfirm: () {
        Get.back();
        openCamera();
      },
      titlePadding: const EdgeInsets.all(15),
      contentPadding: const EdgeInsets.all(15),
    );
  }
}
