import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        title: Text(
          'Bantuan',
          style: AppText.heading4(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              color: AppColors.primary,
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Frequently Asked Questions',
                style: AppText.body1(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            
            // FAQ Items
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildFAQItem(
                'Bagaimana cara menghapus akun?',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Untuk menghapus akun Anda, silakan ikuti langkah-langkah berikut:',
                      style: AppText.body2(color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '1. Hubungi admin melalui WhatsApp di nomor:',
                      style: AppText.body2(color: Colors.black87),
                    ),
                    SelectableText(
                      '0821-3709-5847',
                      style: AppText.body2(color: AppColors.primary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '2. Dalam pesan WhatsApp, sertakan informasi berikut:',
                      style: AppText.body2(color: Colors.black87),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• Username Anda',
                            style: AppText.body2(color: Colors.black87),
                          ),
                          Text(
                            '• Nama lengkap',
                            style: AppText.body2(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '3. Admin akan memproses permintaan penghapusan akun Anda dalam waktu 1-3 hari kerja',
                      style: AppText.body2(color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '4. Anda akan menerima konfirmasi setelah akun berhasil dihapus',
                      style: AppText.body2(color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.softOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, 
                               color: AppColors.primary,
                               size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Penghapusan akun bersifat permanen dan tidak dapat dibatalkan. Semua data terkait akun Anda akan dihapus dari sistem kami.',
                              style: AppText.body3(color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, Widget answer) {
    return GetBuilder<FaqController>(
      builder: (controller) => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Theme(
          data: Theme.of(Get.context!).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              question,
              style: AppText.body2(color: AppColors.primary),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: answer,
              ),
            ],
            trailing: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
