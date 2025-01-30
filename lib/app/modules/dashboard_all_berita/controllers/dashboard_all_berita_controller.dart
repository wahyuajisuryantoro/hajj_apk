import 'dart:convert';

import 'package:get/get.dart';
import 'package:hajj/app/data/models/Berita.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DashboardAllBeritaController extends GetxController {
 final beritaList = <Berita>[].obs;
  final isLoading = true.obs;
  final searchQuery = ''.obs;
  final errorMessage = ''.obs;
  final currentPage = 1.obs;
  final lastPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBerita();
  }

  Future<void> fetchBerita({int page = 1, bool resetList = false}) async {
    if (page == 1) {
      isLoading.value = true;
    }
    errorMessage.value = '';
    try {
      final queryParameters = {
        'page': page.toString(),
        if (searchQuery.isNotEmpty) 'search': searchQuery.value,
      };
      final uri = Uri.https('hajj.web.id', '/api/all-news', queryParameters);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData.containsKey('news') && responseData['news'] is Map) {
          final newsData = responseData['news'];
          if (newsData.containsKey('data') && newsData['data'] is List) {
            final List<dynamic> data = newsData['data'];
            final newBerita = data.map((json) => Berita.fromJson(json)).toList();
            
            if (page == 1 || resetList) {
              beritaList.assignAll(newBerita);
            } else {
              beritaList.addAll(newBerita);
            }
            
            currentPage.value = newsData['current_page'] ?? 1;
            lastPage.value = newsData['last_page'] ?? 1;
          } else {
            errorMessage.value = 'Format data berita tidak valid';
          }
        } else {
          errorMessage.value = 'Struktur respons tidak valid';
        }
      } else {
        errorMessage.value = 'Gagal mengambil berita. Status code: ${response.statusCode}';
      }
    } catch (e) {
      print('Error details: $e');
      errorMessage.value = 'Error mengambil berita: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void searchBerita(String query) {
    searchQuery.value = query;
    fetchBerita(page: 1, resetList: true);
  }

  void loadMoreBerita() {
    if (currentPage.value < lastPage.value) {
      fetchBerita(page: currentPage.value + 1);
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }
}
