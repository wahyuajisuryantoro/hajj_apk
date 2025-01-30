import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/controller_bottom_navbar.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

class AkunController extends GetxController {
  final StorageService _storage = StorageService();
  final Rx<Map<String, dynamic>> mitraData = Rx<Map<String, dynamic>>({});
  final count = 0.obs;
  final name = 'John Doe'.obs;
  final userId = '123456789'.obs;

  @override
  void onInit() {
    super.onInit();
    loadMitraData();
  }

  Future<void> loadMitraData() async {
    try {
      final data = _storage.getMitraData();
      if (data != null) {
        mitraData.value = data;
      }
    } catch (e) {
      print('Error loading mitra data: $e');
    }
  }

  Future<void> logout() async {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppColors.softWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Konfirmasi Logout',
        style: AppText.heading4(color: AppColors.primary),
      ),
      content: Text(
        'Apakah Anda yakin ingin keluar?',
        style: AppText.body1(color: Colors.black),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); 
          },
          child: Text(
            'Batal',
            style: AppText.body1(color: AppColors.purple),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await _storage.clearMitraData();
              final bottomNavController = Get.find<BottomNavigationController>();
              bottomNavController.selectedIndex.value = 0;
              Get.offAllNamed(Routes.LOGIN);
            } catch (e) {
              print('Error during logout: $e');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Logout',
            style: AppText.body1(color: Colors.white),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}


  String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    return nameParts.length > 1
        ? '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase()
        : nameParts[0].substring(0, min(2, nameParts[0].length)).toUpperCase();
  }

  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
