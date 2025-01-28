import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/kebijakan_privasi_controller.dart';

class KebijakanPrivasiView extends GetView<KebijakanPrivasiController> {
  const KebijakanPrivasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        title: Text(
          'Kebijakan Privasi',
          style: AppText.heading4(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.width(context, 5),
              vertical: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logoapp.png', // Make sure to add this asset
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Kebijakan Privasi',
                      style: AppText.heading3(color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.privacyContent.value,
                      style: AppText.body2(color: Colors.black87),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
