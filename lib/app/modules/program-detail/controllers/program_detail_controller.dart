import 'dart:convert';

import 'package:get/get.dart';
import 'package:hajj/app/data/models/Program.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProgramDetailController extends GetxController {
  final program = Rx<Program?>(null);
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final String code = Get.arguments as String;
    fetchProgramDetail(code);
  }

  Future<void> fetchProgramDetail(String code) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(Uri.parse('https://hajj.web.id/api/programs/$code'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          program.value = Program.fromJson(data['data']);
        } else {
          errorMessage.value = 'Data program tidak valid';
        }
      } else {
        errorMessage.value = 'Gagal mengambil detail program. Status code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  String formatPrice(int price) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(price);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy', 'id').format(date);
  }
}
