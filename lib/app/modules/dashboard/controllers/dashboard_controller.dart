import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/data/models/Berita.dart';
import 'package:hajj/app/data/models/Program.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  final StorageService _storage = StorageService();
  final Rx<String> greeting = ''.obs;
  final Rx<Map<String, dynamic>> mitraData = Rx<Map<String, dynamic>>({});
  final RxBool isLoading = false.obs;

  RxInt totalMitra = 0.obs;
  RxInt totalJamaah = 0.obs;
  RxInt totalCustomer = 0.obs;
  RxString totalBonus = 'Rp 0'.obs;
  RxString saldoBonus = 'Rp 0'.obs;

  final programs = <Program>[].obs;
  final news = <Berita>[].obs;
  final isLoadingPrograms = false.obs;
  final isLoadingNews = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMitraData();
    fetchDashboardData();
    fetchPrograms();
    fetchNews();
    refreshData();
    updateGreeting();
  }

  Future<void> loadMitraData() async {
    try {
      final data = _storage.getMitraData();
      if (data != null) {
        mitraData.value = data;
      }
    } catch (e) {
      print('Error loading mitra data: $e');
    }
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      final String? mitraCode = _storage.getMitraCode();
      if (mitraCode == null) {
        Get.snackbar('Error', 'Mitra code tidak ditemukan',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final response = await http.get(
        Uri.parse('https://hajj.web.id/api/dashboard'),
        headers: {
          'Accept': 'application/json',
          'code_mitra': mitraCode,
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        totalMitra.value = data['data']['total_mitra'] ?? 0;
        totalJamaah.value = data['data']['total_jamaah'] ?? 0;
        totalCustomer.value = data['data']['total_customer'] ?? 0;
        totalBonus.value =
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(int.parse(data['data']['total_bonus'].toString()));
        saldoBonus.value =
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(int.parse(data['data']['saldo_bonus'].toString()));
      } else {
        Get.snackbar(
            'Error', data['message'] ?? 'Terjadi kesalahan saat mengambil data',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Terjadi kesalahan, coba lagi nanti',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPrograms() async {
    try {
      isLoadingPrograms.value = true;
      final response = await http.get(
        Uri.parse('https://hajj.web.id/api/programs?limit=5'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          programs.assignAll((data['data'] as List)
              .map((json) => Program.fromJson(json))
              .toList());
        }
      }
    } catch (e) {
      print('Error fetching programs: $e');
    } finally {
      isLoadingPrograms.value = false;
    }
  }

  Future<void> fetchNews() async {
    try {
      isLoadingNews.value = true;
      final response =
          await http.get(Uri.parse('https://hajj.web.id/api/all-news'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['news']['data'];
        news.assignAll(data.map((json) => Berita.fromJson(json)).toList());
      } else {
        print('Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isLoadingNews.value = false;
    }
  }

  Future<void> refreshData() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('https://hajj.web.id/api/mitra'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == true && responseData['data'] != null) {
          final List<dynamic> mitraList = responseData['data'];
          final String? savedCode = _storage.getMitraCode();

          if (savedCode != null) {
            final mitraDynamic = mitraList.firstWhere(
              (mitra) => mitra['code'] == savedCode,
              orElse: () => null,
            );

            if (mitraDynamic != null) {
              final Map<String, dynamic> newData =
                  Map<String, dynamic>.from(mitraDynamic);
              await _storage.saveMitraData(newData);
              mitraData.value = newData;
            }
          }
        }
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error refreshing data: $e');
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          'Error',
          'Gagal memperbarui data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void updateGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Selamat Pagi';
    } else if (hour < 15) {
      greeting.value = 'Selamat Siang';
    } else if (hour < 18) {
      greeting.value = 'Selamat Sore';
    } else {
      greeting.value = 'Selamat Malam';
    }
  }

  String getInitials(String? name) {
    if (name == null || name.isEmpty) return '';
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  void onClose() {
    super.onClose();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy', 'id').format(date);
  }
}
