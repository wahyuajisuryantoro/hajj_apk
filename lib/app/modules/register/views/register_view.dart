import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppResponsive.isMobile(context) ? 16 : 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppResponsive.height(context, 4),),
                Text(
                  'Pendaftaran Mitra',
                  style: AppText.heading3(color: AppColors.primary),
                ),
                SizedBox(height: AppResponsive.height(context, 2)),
                Card(
                  color: AppColors.softWhite,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildTextField('Username'),
                        SizedBox(height: AppResponsive.height(context, 2)),
                        _buildTextField('Nama Panjang'),
                        SizedBox(height: AppResponsive.height(context, 2)),
                        _buildGenderDropdown(),
                        SizedBox(height: AppResponsive.height(context, 2)),
                        _buildTextField('Phone',
                            keyboardType: TextInputType.phone),
                        SizedBox(height: AppResponsive.height(context, 2)),
                        _buildTextField('Password', obscureText: true),
                        SizedBox(height: AppResponsive.height(context, 2)),
                        _buildTextField('Confirm Password', obscureText: true),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppResponsive.height(context, 2)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(value: true, onChanged: (bool? value) {}),
                    Expanded(
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: AppText.body3(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppResponsive.height(context, 3)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppResponsive.width(context, 10),
                        vertical: AppResponsive.height(context, 2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: AppText.body1(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildTextField(
  String label, {
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        controller: controller.getController(label),
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
        validator: (value) {
          if (label == 'Username') {
            return controller.validateUsername(value!);
          }
          return null;
        },
      ),
      if (label == 'Username') 
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '• Panjang: 6-20 karakter\n'
            '• Karakter: Huruf, angka, garis bawah, titik\n'
            '• Huruf pertama: Tidak boleh angka/simbol\n'
            '• Kombinasi: Gabungan huruf & angka disarankan\n'
            '• Unik: Tidak mirip username lain\n'
            '• Tidak mengandung: Kata tidak pantas, informasi pribadi, atau karakter khusus selain "_" dan "."',
            style: AppText.caption(color: Colors.grey),
          ),
        ),
    ],
  );
}

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: controller.selectedSex.value,
      onChanged: (newValue) {
        controller.selectedSex.value = newValue!;
      },
      items: [
        DropdownMenuItem(
          value: 'L',
          child: Text('Laki-laki', style: AppText.body3(color: Colors.black)),
        ),
        DropdownMenuItem(
          value: 'P',
          child: Text(
            'Perempuan',
            style: AppText.body3(color: Colors.black),
          ),
        ),
      ],
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
