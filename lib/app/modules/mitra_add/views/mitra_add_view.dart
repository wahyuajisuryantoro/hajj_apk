import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/mitra_add_controller.dart';

class MitraAddView extends GetView<MitraAddController> {
  const MitraAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text('Tambah Mitra', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  _buildImagePicker(
                      'Foto Profil',
                      controller.profilePicturePath,
                      false // isKtp = false for profile picture
                      ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     _buildSectionTitle('Code Mitra'),
                    _buildTextField(
                      controller: controller.codeMitraController,
                      label: 'Code Mitra',
                      prefixIcon: Icons.code_outlined,
                      readOnly: true,
                    ),
                    _buildSectionTitle('Informasi Akun'),
                    _buildTextField(
                      controller: controller.usernameController,
                      label: 'Username',
                      prefixIcon: Icons.person_outline,
                      validator: (value) {
                        if (value?.isEmpty ?? true)
                          return 'Username wajib diisi';
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: controller.emailController,
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!GetUtils.isEmail(value ?? ''))
                          return 'Email tidak valid';
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: controller.passwordController,
                      label: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if ((value?.length ?? 0) < 6)
                          return 'Password minimal 6 karakter';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Informasi Pribadi'),
                    _buildTextField(
                      controller: controller.nameController,
                      label: 'Nama Lengkap',
                      prefixIcon: Icons.badge_outlined,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Nama wajib diisi';
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: controller.nikController,
                      label: 'NIK',
                      prefixIcon: Icons.credit_card_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    _buildDropdown(
                      value: controller.selectedSex,
                      label: 'Jenis Kelamin',
                      prefixIcon: Icons.people_outline,
                      items: const [
                        DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                        DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                      ],
                      onChanged: (value) => controller.selectedSex = value!,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: controller.birthPlaceController,
                            label: 'Tempat Lahir',
                            prefixIcon: Icons.location_city_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: controller.birthDateController,
                            label: 'Tanggal Lahir',
                            prefixIcon: Icons.calendar_today_outlined,
                            onTap: () => _showDatePicker(context),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Alamat'),
                    _buildTextField(
                      controller: controller.addressController,
                      label: 'Alamat Lengkap',
                      prefixIcon: Icons.home_outlined,
                      maxLines: 3,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: controller.codeCityController,
                            label: 'Kota',
                            prefixIcon: Icons.location_city_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: controller.codeProvinceController,
                            label: 'Provinsi',
                            prefixIcon: Icons.map_outlined,
                          ),
                        ),
                      ],
                    ),
                    _buildTextField(
                      controller: controller.phoneController,
                      label: 'Nomor Telepon',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value?.isEmpty ?? true)
                          return 'Nomor telepon wajib diisi';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Informasi Bank'),
                    _buildTextField(
                      controller: controller.bankController,
                      label: 'Nama Bank',
                      prefixIcon: Icons.account_balance_outlined,
                    ),
                    _buildTextField(
                      controller: controller.bankNumberController,
                      label: 'Nomor Rekening',
                      prefixIcon: Icons.credit_card_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    _buildTextField(
                      controller: controller.bankNameController,
                      label: 'Nama Pemilik Rekening',
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Dokumen'),
                    _buildImagePicker('Foto KTP', controller.ktpPicturePath,
                        true // isKtp = true for KTP picture
                        ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.loading.value
                            ? null
                            : controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Obx(
                          () => controller.loading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Daftar'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: AppText.body1(color: AppColors.primary)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    bool readOnly = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon, color: Colors.grey),
          filled: true,
          fillColor: AppColors.softWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required IconData prefixIcon,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon, color: Colors.grey),
          filled: true,
          fillColor: AppColors.softWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(String label, RxString imagePath, bool isKtp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.body2(color: Colors.grey)),
        const SizedBox(height: 8),
        Obx(() => GestureDetector(
              onTap: imagePath.value.isEmpty
                  ? () => isKtp
                      ? controller.pickKtpPicture()
                      : controller.pickProfilePicture()
                  : () => controller.showImageOptions(isKtp),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.softWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Obx(() {
                  if (controller.isProcessingImage.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primary));
                  }

                  if (imagePath.value.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isKtp ? Icons.credit_card : Icons.person,
                            size: 48, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text('Tap untuk memilih foto',
                            style: AppText.body3(color: Colors.grey)),
                      ],
                    );
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imagePath.value),
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            )),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      controller.birthDateController.text =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }
}
