import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/akun_password_edit_controller.dart';

class AkunPasswordEditView extends GetView<AkunPasswordEditController> {
  const AkunPasswordEditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(
              'Password Lama',
              controller: controller.currentPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            
            _buildTextField(
              'Password Baru',
              controller: controller.newPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 15),

            _buildTextField(
              'Konfirmasi Password',
              controller: controller.confirmPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value 
                    ? null 
                    : controller.updatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Update Password', 
                        style: AppText.body1(color: Colors.white)),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppText.body1(color: Colors.black),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppText.body2(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}