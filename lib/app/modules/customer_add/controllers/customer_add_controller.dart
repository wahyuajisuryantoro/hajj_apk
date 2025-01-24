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

class CustomerAddController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _storage = StorageService();
  final loading = false.obs;
  final isProcessingImage = false.obs;

  final codeMitraController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final jobController = TextEditingController();
  final codeCategoryController = TextEditingController();
  final codeCabangController = TextEditingController();
  final codeCityController = TextEditingController();
  final codeProvinceController = TextEditingController();
  final noteController = TextEditingController();
  final addressController = TextEditingController();
  final codeProgramController = TextEditingController();
  final nikController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final birthDateController = TextEditingController();

  String selectedSex = 'L';
  final profilePicturePath = ''.obs;
  final ktpPicturePath = ''.obs;

  RxList<dynamic> cabangList = <dynamic>[].obs;
  RxList<dynamic> cityList = <dynamic>[].obs;
  RxList<dynamic> provinceList = <dynamic>[].obs;
  RxList<dynamic> categoryList = <dynamic>[].obs;
  RxList<dynamic> programList = <dynamic>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCodeMitra();
    fetchRelationalData();
  }

  void fetchCodeMitra() {
    String codeMitra = _storage.getMitraCode() ?? '';
    codeMitraController.text = codeMitra;
  }

  Future<void> fetchRelationalData() async {
    try {
      final uri = Uri.parse('https://hajj.web.id/api/customer/relation');
      final response =
          await http.get(uri, headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        cabangList.assignAll(data['cabang']);
        cityList.assignAll(data['city']);
        provinceList.assignAll(data['province']);
        categoryList.assignAll(data['category']);
        programList.assignAll(data['program']);
      } else {
        Get.snackbar('Error', 'Failed to load relational data',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load relational data',
          backgroundColor: Colors.red);
    }
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    loading.value = true;
    try {
      final uri = Uri.parse('https://hajj.web.id/api/customer/store');
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll({'Accept': 'application/json'});

      request.fields.addAll({
        'code_mitra': codeMitraController.text.trim(),
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'job': jobController.text.trim(),
        'code_category': codeCategoryController.text.trim(),
        'code_cabang': codeCabangController.text.trim(),
        'code_city': codeCityController.text.trim(),
        'code_province': codeProvinceController.text.trim(),
        'note': noteController.text.trim(),
        'address': addressController.text.trim(),
        'code_program': codeProgramController.text.trim(),
        'NIK': nikController.text.trim(),
        'birth_place': birthPlaceController.text.trim(),
        'birth_date': birthDateController.text.trim(),
      });


      if (ktpPicturePath.value.isNotEmpty) {
        final file = await http.MultipartFile.fromPath(
          'picture_ktp',
          ktpPicturePath.value,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Get.snackbar('Sukses',
            responseData['message'] ?? 'Customer berhasil ditambahkan',
            backgroundColor: Colors.green);
        Get.offNamed(Routes.CUSTOMER);
      } else {
        final responseData = json.decode(response.body);
        Get.snackbar('Gagal', responseData['message'] ?? 'Terjadi kesalahan',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Terjadi kesalahan pada sistem',
          backgroundColor: Colors.red);
    } finally {
      loading.value = false;
    }
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
    phoneController.dispose();
    jobController.dispose();
    codeCategoryController.dispose();
    codeCabangController.dispose();
    codeCityController.dispose();
    codeProvinceController.dispose();
    noteController.dispose();
    addressController.dispose();
    codeProgramController.dispose();
    nikController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    super.onClose();
  }
}
