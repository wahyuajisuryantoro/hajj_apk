import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MitraAddController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _storage = StorageService();
  final loading = false.obs;
  final isProcessingImage = false.obs;

  final codeMitraController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final nikController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final codeCityController = TextEditingController();
  final codeProvinceController = TextEditingController();
  final phoneController = TextEditingController();
  final bankController = TextEditingController();
  final bankNumberController = TextEditingController();
  final bankNameController = TextEditingController();

  String selectedSex = 'L';
  final profilePicturePath = ''.obs;
  final ktpPicturePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCodeMitra();
  }

  void fetchCodeMitra() {
    String codeMitra = _storage.getMitraCode() ?? '';
    codeMitraController.text = codeMitra;
  }

  Future<void> pickProfilePicture() async {
    try {
      if (Platform.isAndroid && await Permission.storage.isPermanentlyDenied) {
        openAppSettings();
        return;
      }
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted) {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          profilePicturePath.value = pickedFile.path;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih foto',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickKtpPicture() async {
    try {
      isProcessingImage.value = true;
      if (Platform.isAndroid) {
        if (await Permission.photos.request().isGranted) {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            ktpPicturePath.value = pickedFile.path;
          }
        } else {
          openAppSettings();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih foto', backgroundColor: Colors.red);
    } finally {
      isProcessingImage.value = false;
    }
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    loading.value = true;
    try {
      final mitraData = _storage.getMitraData();

      if (mitraData == null) {
        Get.snackbar('Error', 'Mitra data not found, please login again.',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final uri = Uri.parse('https://hajj.web.id/api/mitra/store');
      final request = http.MultipartRequest('POST', uri);
      String codeMitra = codeMitraController.text.trim();
      request.headers.addAll({
        'Accept': 'application/json',
      });
      request.fields.addAll({
        'code_mitra': codeMitra,
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'name': nameController.text.trim(),
        'NIK': nikController.text.trim(),
        'sex': selectedSex,
        'birth_place': birthPlaceController.text.trim(),
        'birth_date': birthDateController.text.trim(),
        'address': addressController.text.trim(),
        'code_city': codeCityController.text.trim(),
        'code_province': codeProvinceController.text.trim(),
        'phone': phoneController.text.trim(),
        'bank': bankController.text.trim(),
        'bank_number': bankNumberController.text.trim(),
        'bank_name': bankNameController.text.trim(),
      });

      // Add profile picture if exists
      if (profilePicturePath.value.isNotEmpty) {
        final file = await http.MultipartFile.fromPath(
          'picture_profile',
          profilePicturePath.value,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      // Add KTP picture if exists
      if (ktpPicturePath.value.isNotEmpty) {
        final file = await http.MultipartFile.fromPath(
          'picture_ktp',
          ktpPicturePath.value,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('Response Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');
      // Check response status
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Get.snackbar(
          'Sukses',
          responseData['message'] ?? 'Data mitra berhasil ditambahkan',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        await Future.delayed(const Duration(seconds: 2));
        Get.offNamed(Routes.MITRA);
      } else {
        final responseData = json.decode(response.body);
        Get.snackbar(
          'Gagal',
          responseData['message'] ?? 'Terjadi kesalahan',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan pada sistem',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } finally {
      loading.value = false;
    }
  }

  void showImageOptions(bool isKtp) {
    Get.dialog(
      AlertDialog(
        title: Text('Opsi Foto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Ganti Foto'),
              onTap: () {
                Get.back();
                if (isKtp) {
                  pickKtpPicture();
                } else {
                  pickProfilePicture();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text('Hapus Foto'),
              onTap: () {
                Get.back();
                if (isKtp) {
                  ktpPicturePath.value = '';
                } else {
                  profilePicturePath.value = '';
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    nikController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    codeCityController.dispose();
    codeProvinceController.dispose();
    phoneController.dispose();
    bankController.dispose();
    bankNumberController.dispose();
    bankNameController.dispose();
    super.onClose();
  }
}
