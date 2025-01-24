import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/program_detail_controller.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';

class ProgramDetailView extends GetView<ProgramDetailController> {
  const ProgramDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Program', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.program.value == null) {
          return Center(child: Text('Program tidak ditemukan'));
        } else {
          final program = controller.program.value!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  program.picture ?? '',
                  height: AppResponsive.height(context, 30),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: AppResponsive.height(context, 30),
                    color: Colors.grey[300],
                    child: Icon(Icons.error, size: 50),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(program.name, style: AppText.heading2()),
                      SizedBox(height: 8),
                      Text(controller.formatPrice(program.price), 
                           style: AppText.body1(color: AppColors.primary)),
                      SizedBox(height: 16),
                      _buildInfoRow('Tanggal Berangkat', controller.formatDate(program.tanggalBerangkat)),
                      _buildInfoRow('Sisa Kuota', '${program.sisaKursi} Orang'),
                      SizedBox(height: 16),
                      Text('Deskripsi Program', style: AppText.body1(color: AppColors.primary)),
                      SizedBox(height: 8),
                      Text(program.desc ?? 'Tidak ada deskripsi', style: AppText.body2()),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppText.body2()),
          Text(value, style: AppText.body2(color: AppColors.primary)),
        ],
      ),
    );
  }
}