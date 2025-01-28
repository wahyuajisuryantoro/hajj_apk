import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:http/http.dart' as http;

class AkunPasswordEditController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;
  final StorageService _storage = Get.find<StorageService>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> updatePassword() async {
    if (isLoading.value) return;

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Konfirmasi password tidak sesuai',
        backgroundColor: AppColors.red,
        colorText: Colors.white,
        titleText: Text('Gagal', style: AppText.body1(color: Colors.white)),
        messageText: Text('Konfirmasi password tidak sesuai',
            style: AppText.body2(color: Colors.white)),
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('https://hajj.web.id/api/update-password'),
        body: {
          'code_mitra': _storage.getMitraCode() ?? '',
          'current_password': currentPasswordController.text,
          'new_password': newPasswordController.text,
          'confirm_password': confirmPasswordController.text,
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 422) {
        Get.snackbar(
          'Gagal',
          'Password saat ini tidak sesuai',
          backgroundColor: AppColors.red,
          colorText: Colors.white,
          titleText: Text('Gagal', style: AppText.body1(color: Colors.white)),
          messageText: Text('Password saat ini tidak sesuai',
              style: AppText.body2(color: Colors.white)),
        );
        return;
      }

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Password berhasil diperbarui',
          backgroundColor: AppColors.green,
          colorText: Colors.white,
          titleText:
              Text('Berhasil', style: AppText.body1(color: Colors.white)),
          messageText: Text('Password berhasil diperbarui',
              style: AppText.body2(color: Colors.white)),
        );
      } else {
        Get.snackbar(
          'Gagal',
          responseData['message'] ?? 'Gagal memperbarui password',
          backgroundColor: AppColors.red,
          colorText: Colors.white,
          titleText: Text('Gagal', style: AppText.body1(color: Colors.white)),
          messageText: Text(
              responseData['message'] ?? 'Gagal memperbarui password',
              style: AppText.body2(color: Colors.white)),
        );
      }
    } catch (e) {
      print('Update password error: $e');
      Get.snackbar(
        'Gagal',
        'Gagal memperbarui password: $e',
        backgroundColor: AppColors.red,
        colorText: Colors.white,
        titleText: Text('Gagal', style: AppText.body1(color: Colors.white)),
        messageText: Text('Gagal memperbarui password: $e',
            style: AppText.body2(color: Colors.white)),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
