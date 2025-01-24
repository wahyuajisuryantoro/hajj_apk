import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final StorageService _storage = StorageService();

  final isPasswordVisible = false.obs;

  Future<void> login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('https://hajj.web.id/api/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email-username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final mitraData = data['user'];

        await _storage.saveMitraData(mitraData);
        Get.snackbar(
          'Success',
          data['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offNamed(Routes.DASHBOARD);
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['error'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> logout() async {
    try {
      await _storage.clearMitraData();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
