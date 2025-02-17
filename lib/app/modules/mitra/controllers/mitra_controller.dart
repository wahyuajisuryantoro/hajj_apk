import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:http/http.dart' as http;

class MitraController extends GetxController {
  final StorageService _storage = StorageService();
  final RxList<Map<String, dynamic>> mitraList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredMitraList =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchMitraData();
  }

  void filterMitra(String query) {
    if (query.isEmpty) {
      filteredMitraList.assignAll(mitraList);
      return;
    }

    final filtered = mitraList.where((mitra) {
      final name = mitra['name']?.toString().toLowerCase() ?? '';
      final email = mitra['email']?.toString().toLowerCase() ?? '';
      final phone = mitra['phone']?.toString().toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) ||
          email.contains(searchLower) ||
          phone.contains(searchLower);
    }).toList();

    filteredMitraList.assignAll(filtered);
  }

 Future<void> fetchMitraData() async {
  final client = http.Client();
  try {
    isLoading.value = true;
    final response = await client.get(
      Uri.parse('https://hajj.web.id/api/mitra'),
      headers: {
        'code_mitra': _storage.getMitraCode() ?? '',
        'Accept': 'application/json',
      },
    ).timeout(Duration(seconds: 30));

    final data = jsonDecode(response.body);
    print('Full Response: $data');
    if (response.statusCode == 200) {
      mitraList.assignAll(List<Map<String, dynamic>>.from(data['data']));
      filteredMitraList.assignAll(mitraList);
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
    isLoading.value = false;
  }
}

  void showMitraDetails(Map<String, dynamic> mitra) {
    Get.bottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              'Detail Mitra',
              style: AppText.heading4(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDetailSection(mitra),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildDetailSection(Map<String, dynamic> mitra) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informasi Akun'),
        _buildDetailItem('Kode Mitra', mitra['code']),
        _buildDetailItem('Username', mitra['username']),
        _buildDetailItem('Kode Referral', mitra['referral_code']),
        _buildDetailItem('Level', mitra['level']),
        _buildDetailItem('Status', mitra['status']),
        
        const SizedBox(height: 20),
        _buildSectionTitle('Informasi Pribadi'),
        _buildDetailItem('Nama Lengkap', mitra['name']),
        _buildDetailItem('NIK', mitra['NIK']),
        _buildDetailItem('Jenis Kelamin', mitra['sex']),
        _buildDetailItem('Tempat Lahir', mitra['birth_place']),
        _buildDetailItem('Tanggal Lahir', mitra['birth_date']),
        _buildDetailItem('Email', mitra['email']),
        _buildDetailItem('No. Telepon', mitra['phone']),
        
        const SizedBox(height: 20),
        _buildSectionTitle('Alamat'),
        _buildDetailItem('Alamat Lengkap', mitra['address']),
        _buildDetailItem('Kota', mitra['code_city']),
        _buildDetailItem('Provinsi', mitra['code_province']),
        
        const SizedBox(height: 20),
        _buildSectionTitle('Informasi Bank'),
        _buildDetailItem('Nama Bank', mitra['bank']),
        _buildDetailItem('No. Rekening', mitra['bank_number']),
        _buildDetailItem('Atas Nama', mitra['bank_name']),
        
        const SizedBox(height: 20),
        _buildSectionTitle('Dokumen'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KTP', style: AppText.body3(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secondary,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: mitra['picture_ktp'] != null && mitra['picture_ktp'].toString().isNotEmpty
                ? GestureDetector(
                    onTap: () => _showImageFullscreen(mitra['picture_ktp']),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        mitra['picture_ktp'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                  ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        _buildSectionTitle('Informasi Cabang'),
        _buildDetailItem('Kode Kategori', mitra['code_category']),
        _buildDetailItem('Kode Cabang', mitra['code_cabang']),
      ],
    );
  }

  void _showImageFullscreen(String imageUrl) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.white, size: 40),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, 
        style: AppText.body1(color: AppColors.primary)
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
              style: AppText.body3(color: Colors.grey),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value ?? '-',
              style: AppText.body2(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}