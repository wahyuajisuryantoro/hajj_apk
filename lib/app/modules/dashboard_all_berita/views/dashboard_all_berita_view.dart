import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/dashboard_all_berita_controller.dart';

class DashboardAllBeritaView extends GetView<DashboardAllBeritaController> {
  const DashboardAllBeritaView({super.key});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Berita', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.currentPage.value == 1) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.errorMessage.value, style: AppText.body1()),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => controller.fetchBerita(page: 1, resetList: true),
                        child: Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              } else if (controller.beritaList.isEmpty) {
                return Center(child: Text('Tidak ada berita ditemukan', style: AppText.body1()));
              } else {
                return _buildNewsList();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          controller.searchBerita(value);
        },
        decoration: InputDecoration(
          hintText: 'Cari berita...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          controller.loadMoreBerita();
        }
        return true;
      },
      child: ListView.builder(
        itemCount: controller.beritaList.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.beritaList.length) {
            return Obx(() {
              if (controller.currentPage.value < controller.lastPage.value) {
                return Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ));
              } else {
                return SizedBox.shrink();
              }
            });
          }
          
          final berita = controller.beritaList[index];
          return Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.DASHBOARD_DETAIL_BERITA, arguments: berita.id),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      berita.picture ?? '',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[300],
                        child: Icon(Icons.error, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            berita.name,
                            style: AppText.body1(color: Colors.black87),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Text(
                            controller.formatDate(berita.createdAt),
                            style: AppText.caption(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
