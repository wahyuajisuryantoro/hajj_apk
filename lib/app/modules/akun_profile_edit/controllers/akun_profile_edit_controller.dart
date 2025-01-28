import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AkunProfileEditController extends GetxController {
  final StorageService _storage = StorageService();
  var isLoading = false.obs;
  var currentImage = ''.obs;
  var selectedImagePath = ''.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    nameController.text = args['name'] ?? '';
    phoneController.text = args['phone'] ?? '';
    emailController.text = args['email'] ?? '';
    birthPlaceController.text = args['birth_place'] ?? '';
    birthDateController.text = args['birth_date'] ?? '';
    addressController.text = args['address'] ?? '';
    currentImage.value = args['picture_profile'] ?? '';
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  Future<void> updateProfile() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('https://hajj.web.id/api/update-profile'));

      request.fields['code_mitra'] = _storage.getMitraCode() ?? '';
      request.fields['name'] = nameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['email'] = emailController.text;
      request.fields['birth_place'] = birthPlaceController.text;
      request.fields['birth_date'] = birthDateController.text;
      request.fields['address'] = addressController.text;

      if (selectedImagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'picture_profile', selectedImagePath.value));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        await _storage.saveMitraData(responseData['data']);
        Get.back();
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar(
            'Error', responseData['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      print('Update profile error: $e');
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
