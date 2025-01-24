import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  // Controllers for the input fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Sex selection
  var selectedSex = 'L'.obs;

  // Method for registration
  Future<void> register() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (username.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty) {
      Get.snackbar('Error', 'Mohon isi semua field');
      return;
    }
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
        Get.snackbar('Berhasil', data['message']);
      } else {
        Get.snackbar('Error', 'Registrasi gagal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
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

  // Get controller for different fields dynamically
  TextEditingController getController(String label) {
    switch (label.toLowerCase()) {
      case 'username':
        return usernameController;
      case 'password':
        return passwordController;
      case 'full name':
        return nameController;
      case 'phone':
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
