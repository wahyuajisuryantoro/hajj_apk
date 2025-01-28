import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:intl/intl.dart';

import '../../../data/services/storage_services.dart';
import 'package:http/http.dart' as http;

class JamaahListController extends GetxController {
  final StorageService _storage = StorageService();
  final RxList<Map<String, dynamic>> jamaahList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredJamaahList =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJamaahData();
  }

  void filterJamaah(String query) {
    if (query.isEmpty) {
      filteredJamaahList.assignAll(jamaahList);
      return;
    }

    final filtered = jamaahList.where((jamaah) {
      final name = jamaah['name']?.toString().toLowerCase() ?? '';
      final email = jamaah['email']?.toString().toLowerCase() ?? '';
      final phone = jamaah['phone']?.toString().toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) ||
          email.contains(searchLower) ||
          phone.contains(searchLower);
    }).toList();

    filteredJamaahList.assignAll(filtered);
  }

  Future<void> fetchJamaahData() async {
    final client = http.Client();
    try {
      isLoading.value = true;
      final response = await client.get(
        Uri.parse('https://hajj.web.id/api/jamaah'),
        headers: {
          'code_mitra': _storage.getMitraCode() ?? '',
          'Accept': 'application/json',
        },
      ).timeout(Duration(seconds: 30));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        jamaahList.assignAll(List<Map<String, dynamic>>.from(data['data']));
        filteredJamaahList.assignAll(jamaahList);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
      isLoading.value = false;
    }
  }

  void showJamaahDetails(Map<String, dynamic> jamaah) {
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
              'Detail Jamaah',
              style: AppText.heading4(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [_buildDetailSection(jamaah)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(Map<String, dynamic> jamaah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informasi Jamaah'),
        _buildDetailItem('Kode Jamaah', jamaah['code']),
        _buildDetailItem('Nama Lengkap', jamaah['name']),
        _buildDetailItem('Email', jamaah['email']),
        _buildDetailItem('No. Telepon', jamaah['phone']),
        _buildDetailItem('Pekerjaan', jamaah['job']),
        const SizedBox(height: 20),
        _buildSectionTitle('Informasi Program'),
        _buildDetailItem('Kota Program', jamaah['city_program']),
        _buildDetailItem('Tanggal Program', jamaah['date_program']),
        _buildDetailItem('Program', jamaah['program']?['name'] ?? '-'),
        const SizedBox(height: 20),
        _buildSectionTitle('Status & Pembayaran'),
        _buildDetailItem('Status Pembayaran', jamaah['status_payment']),
        _buildDetailItem('Status Keberangkatan', jamaah['status_berangkat']),
        _buildDetailItem('Nilai Program', formatCurrency(jamaah['value'])),
        _buildDetailItem(
            'Total Pembayaran', formatCurrency(jamaah['total_payment'])),
        const SizedBox(height: 20),
        _buildSectionTitle('Alamat'),
        _buildDetailItem('Kota', jamaah['city']?['name'] ?? '-'),
        _buildDetailItem('Provinsi', jamaah['province']?['name'] ?? '-'),
        _buildDetailItem('Cabang', jamaah['cabang']?['name'] ?? '-'),
        const SizedBox(height: 20),
        _buildSectionTitle('Dokumen'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KTP', style: AppText.body3(color: Colors.grey)),
            const SizedBox(height: 8),
            _buildImageContainer(jamaah['picture_ktp']),
            const SizedBox(height: 12),
            Text('Foto Profil', style: AppText.body3(color: Colors.grey)),
            const SizedBox(height: 8),
            _buildImageContainer(jamaah['picture_profile']),
          ],
        ),
      ],
    );
  }

  Widget _buildImageContainer(String? imageUrl) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondary,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? GestureDetector(
              onTap: () => _showImageFullscreen(imageUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.image_not_supported,
                        color: Colors.grey, size: 40),
                  ),
                ),
              ),
            )
          : const Center(
              child:
                  Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
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

   Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title,
        style: AppText.body1(color: AppColors.primary),
      ),
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

  String formatCurrency(dynamic value) {
    if (value == null) return '-';
    return 'Rp ${NumberFormat('#,##0', 'id_ID').format(value)}';
  }
}
