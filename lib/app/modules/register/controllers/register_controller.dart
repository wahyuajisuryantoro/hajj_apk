import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  // Controllers for the input fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Sex selection
  var selectedSex = 'L'.obs;
  var isLoading = false.obs;
  var agreedToTerms = false.obs;

  // Method for registration
  Future<void> register() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    

    if (username.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty) {
      Get.snackbar(
        'Error',
        'Mohon isi semua field',
        backgroundColor: AppColors.softOrange,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
      );
      return;
    }
 
     if (!agreedToTerms.value) {
      Get.snackbar(
        'Error',
        'Mohon baca dan setujui syarat dan ketentuan layanan',
        backgroundColor: AppColors.softOrange,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('http://hajj.web.id/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'name': name,
          'sex': selectedSex.value,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Get.snackbar(
          'Berhasil',
          data['message'],
          backgroundColor: AppColors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(20),
          borderRadius: 10,
          duration: const Duration(seconds: 2),
        );
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          'Error',
          'Registrasi gagal',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(20),
          borderRadius: 10,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
      );
    }
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Masukkan username';
    }

    final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9._]{5,19}$');
    if (!regex.hasMatch(value)) {
      return 'Format username tidak valid';
    }

    return null;
  }

  TextEditingController getController(String label) {
    switch (label) {
      case 'Username':
        return usernameController;
      case 'Password':
        return passwordController;
      case 'Nama Panjang':
        return nameController;
      case 'Phone':
        return phoneController;
      default:
        return TextEditingController();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
