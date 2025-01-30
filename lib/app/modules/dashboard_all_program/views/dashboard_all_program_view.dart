import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/dashboard_all_program_controller.dart';

class DashboardAllProgramView extends GetView<DashboardAllProgramController> {
  const DashboardAllProgramView({super.key});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Program Umroh', style: AppText.heading4(color: Colors.white)),
            centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.currentPage.value == 1) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.programs.isEmpty) {
          return Center(child: Text('Tidak ada program tersedia'));
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                controller.loadMorePrograms();
              }
              return true;
            },
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: controller.programs.length +
                  (controller.currentPage.value < controller.lastPage.value
                      ? 1
                      : 0),
              itemBuilder: (context, index) {
                if (index == controller.programs.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final program = controller.programs[index];
                return GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.DASHBOARD_DETAIL_PROGRAM, arguments: program.code),
                  child: Card(
                    color: AppColors.softWhite,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            program.picture ?? '',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              height: 120,
                              color: Colors.grey[300],
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(program.name,
                                  style: AppText.body2(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(height: 4),
                              Text(controller.formatPrice(program.price),
                                  style:
                                      AppText.body3(color: AppColors.primary)),
                              SizedBox(height: 4),
                              Text(
                                  'Berangkat: ${controller.formatDate(program.tanggalBerangkat)}',
                                  style: AppText.caption()),
                            ],
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
      }),
    );
  }
}
