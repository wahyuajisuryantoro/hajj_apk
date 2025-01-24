import 'dart:convert';
import 'package:get/get.dart';
import 'package:hajj/app/data/models/Program.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProgramAllController extends GetxController {
  final programs = <Program>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final currentPage = 1.obs;
  final lastPage = 1.obs;
  final perPage = 10.obs;
  final total = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrograms();
  }

  Future<void> fetchPrograms({int page = 1}) async {
    if (page == 1) {
      isLoading.value = true;
    }
    errorMessage.value = '';
    try {

      final response = await http.get(Uri.parse('https://hajj.web.id/api/programs?page=$page'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);  
        if (responseData['status'] == 'success' && responseData['data'] != null) {
          final List<dynamic> data = responseData['data'];
          final newPrograms = data.map((json) => Program.fromJson(json)).toList();
          
          if (page == 1) {
            programs.assignAll(newPrograms);
          } else {
            programs.addAll(newPrograms);
          }
          
          final meta = responseData['meta'];
          currentPage.value = meta['current_page'];
          lastPage.value = meta['last_page'];
          perPage.value = meta['per_page'];
          total.value = meta['total'];
          
        } else {
          errorMessage.value = 'Format data program tidak valid';
        }
      } else {
        errorMessage.value = 'Gagal mengambil daftar program. Status code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void loadMorePrograms() {
    print('loadMorePrograms called'); 
    if (currentPage.value < lastPage.value) {
      fetchPrograms(page: currentPage.value + 1);
    } else {
      print('No more pages to load'); 
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