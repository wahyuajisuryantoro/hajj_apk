import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/controller_bottom_navbar.dart';
import 'package:hajj/app/data/services/storage_services.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(BottomNavigationController());
  Get.put(StorageService());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
