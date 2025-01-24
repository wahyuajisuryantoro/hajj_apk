import 'dart:convert';

import 'package:get/get.dart';
import 'package:hajj/app/data/models/Berita.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BeritaDetailController extends GetxController {
  final newsId = 0.obs;
  final news = Rx<Berita?>(null);
  final isLoading = true.obs;
  final isContentExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    newsId.value = Get.arguments as int;
    fetchNewsDetail();
  }

  Future<void> fetchNewsDetail() async {
    isLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse('https://hajj.web.id/api/news/${newsId.value}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        news.value = Berita.fromJson(data);
      } else {
        print(
            'Failed to fetch news detail. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  void toggleContentExpansion() {
    isContentExpanded.toggle();
  }

  String getDisplayContent() {
    if (news.value?.content == null) return '';
    if (isContentExpanded.value) {
      return news.value!.content!;
    } else {
      return news.value!.content!.length > 200
          ? '${news.value!.content!.substring(0, 200)}...'
          : news.value!.content!;
    }
  }
}
