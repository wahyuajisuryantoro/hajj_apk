import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';


import '../controllers/dashboard_detail_berita_controller.dart';

class DashboardDetailBeritaView
    extends GetView<DashboardDetailBeritaController> {
  const DashboardDetailBeritaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              controller.news.value?.name ?? 'Detail Berita',
              style: AppText.body2(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            )),
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.news.value == null) {
          return Center(
              child: Text('Berita tidak ditemukan', style: AppText.body1()));
        } else {
          final news = controller.news.value!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news.picture != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      news.picture!,
                      width: double.infinity,
                      height: AppResponsive.isMobile(context)
                          ? AppResponsive.height(context, 30)
                          : AppResponsive.height(context, 40),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: AppResponsive.height(context, 30),
                        color: Colors.grey[300],
                        child: Icon(Icons.error, size: 50),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(AppResponsive.width(
                      context, AppResponsive.isMobile(context) ? 5 : 10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.name,
                        style: AppResponsive.isMobile(context)
                            ? AppText.heading3()
                            : AppText.heading2(),
                      ),
                      SizedBox(height: 8),
                      if (news.createdAt != null)
                        Text(
                          'Dipublikasikan pada ${controller.formatDate(news.createdAt)}',
                          style: AppText.caption(color: Colors.grey),
                        ),
                      SizedBox(height: 16),
                      Obx(() => Text(
                            controller.getDisplayContent(),
                            style: AppResponsive.isMobile(context)
                                ? AppText.body3()
                                : AppText.body2(),
                          )),
                      if (news.content != null && news.content!.length > 1500)
                        TextButton(
                          onPressed: controller.toggleContentExpansion,
                          child: Text(
                            controller.isContentExpanded.value
                                ? 'Baca lebih sedikit'
                                : 'Baca selengkapnya',
                            style: AppText.body3(color: AppColors.primary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
