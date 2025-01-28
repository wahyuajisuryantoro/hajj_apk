import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:intl/intl.dart';

import '../controllers/akun_profile_edit_controller.dart';

class AkunProfileEditView extends GetView<AkunProfileEditController> {
  const AkunProfileEditView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AkunProfileEditController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Image Section
            Center(child: _buildProfileImage(controller)),
            const SizedBox(height: 30),

            // Form Fields
            _buildTextField('Nama Lengkap', controller: controller.nameController),
            const SizedBox(height: 15),

            _buildTextField('No. Telepon',
                controller: controller.phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 15),

            _buildTextField('Email',
                controller: controller.emailController, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 15),

            _buildTextField('Tempat Lahir', controller: controller.birthPlaceController),
            const SizedBox(height: 15),

            _buildTextField('Tanggal Lahir',
                controller: controller.birthDateController,
                readOnly: true,
                suffixIcon: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    controller.birthDateController.text = formattedDate;
                  }
                }),
            const SizedBox(height: 15),

            _buildTextField('Alamat', controller: controller.addressController, maxLines: 3),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('Update Profile', style: AppText.body1(color: Colors.white)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {TextEditingController? controller,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      bool readOnly = false,
      VoidCallback? onTap,
      Widget? suffixIcon,
      int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines ?? 1,
          style: AppText.body1(color: Colors.black),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppText.body2(color: Colors.grey),
            suffixIcon: suffixIcon,
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

  Widget _buildProfileImage(AkunProfileEditController controller) {
    return Stack(
      children: [
        Obx(() => CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.softOrange,
              backgroundImage: controller.selectedImagePath.isNotEmpty
                  ? FileImage(File(controller.selectedImagePath.value))
                  : controller.currentImage.isNotEmpty
                      ? NetworkImage(controller.currentImage.value) as ImageProvider
                      : null,
              child: controller.selectedImagePath.isEmpty && controller.currentImage.isEmpty
                  ? Icon(Icons.person, size: 50, color: AppColors.primary)
                  : null,
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 18,
            child: IconButton(
              icon: Icon(Icons.camera_alt, size: 18, color: Colors.white),
              onPressed: controller.selectImage,
            ),
          ),
        ),
      ],
    );
  }
}
