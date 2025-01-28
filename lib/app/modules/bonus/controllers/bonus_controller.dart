import 'dart:convert';

import 'package:get/get.dart';
import 'package:hajj/app/data/services/storage_services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BonusController extends GetxController {
  final _storage = StorageService();
  RxBool isLoading = false.obs;
  RxString saldoBonus = 'Rp 0'.obs;
  RxString totalBonus = 'Rp 0'.obs;
  RxList<Map<String, dynamic>> mutasiList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBonusData();
  }

  Future<void> fetchBonusData() async {
    try {
      isLoading.value = true;
      final String? mitraCode = _storage.getMitraCode();

      if (mitraCode == null) {
        Get.snackbar('Error', 'Mitra code tidak ditemukan');
        return;
      }

      final response = await http.get(
        Uri.parse('https://hajj.web.id/api/ujroh'),
        headers: {
          'code_mitra': mitraCode,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        totalBonus.value = formatCurrency(data['data']['total_bonus'] ?? 0);
        saldoBonus.value = formatCurrency(data['data']['saldo_bonus'] ?? 0);

        if (data['data']['mutasi'] != null) {
          List<Map<String, dynamic>> formattedMutasi = [];

          for (var item in data['data']['mutasi']) {
            formattedMutasi.add({
              'code': item['code']?.toString() ?? '',
              'category_name': item['category_name']?.toString() ?? 'Unknown',
              'value': item['value'] ?? 0,
              'status': item['status']?.toString() ?? '',
              'desc': item['desc']?.toString() ?? '',
              'tanggal_transaksi': item['tanggal_transaksi']?.toString() ?? ''
            });
          }

          mutasiList.assignAll(formattedMutasi);
        }
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Gagal memuat data');
    } finally {
      isLoading.value = false;
    }
  }

  String formatCurrency(dynamic value) {
    if (value == null) return 'Rp 0';
    final number = int.tryParse(value.toString()) ?? 0;
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(number);
  }
}
