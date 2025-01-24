import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hajj/app/data/models/Berita.dart';
import 'package:hajj/app/data/models/Program.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  final pageController = PageController(initialPage: 0);
  final currentPage = 0.obs;
  final programs = <Program>[].obs;
  final news = <Berita>[].obs;
  final isLoadingPrograms = false.obs;
  final isLoadingNews = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null).then((_) {
      fetchPrograms();
      fetchNews();
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
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
