import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/widget_bottom_navbar.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 20,
                            backgroundImage:
                                controller.mitraData.value['picture_profile'] !=
                                        null
                                    ? NetworkImage(controller
                                        .mitraData.value['picture_profile'])
                                    : null,
                            child: controller
                                        .mitraData.value['picture_profile'] ==
                                    null
                                ? Text(
                                    controller.getInitials(
                                        controller.mitraData.value['name'] ??
                                            ''),
                                    style: AppText.body2(color: Colors.white),
                                  )
                                : null,
                          )),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.softOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.notifications_outlined,
                                color: AppColors.primary),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.softOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.settings_outlined,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Balance Card dengan gradien orange
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.orange200,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              '${controller.greeting.value},',
                              style: AppText.body2(color: Colors.white),
                            )),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                              controller.mitraData.value['name'] ?? 'Mitra',
                              style: AppText.heading4(color: Colors.white),
                            )),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.link_rounded,
                                            size: 14,
                                            color: Colors.white70,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Kode Referral',
                                            style: AppText.caption(
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Obx(() => SelectableText(
                                            controller.mitraData
                                                    .value['referral_code'] ??
                                                '-',
                                            style: AppText.body2(
                                                color: Colors.white),
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: controller
                                                              .mitraData.value[
                                                          'referral_code'] ??
                                                      ''));
                                              Get.snackbar(
                                                'Berhasil',
                                                'Kode referral berhasil disalin',
                                                backgroundColor: Colors.white,
                                                colorText: Colors.black87,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                              );
                                            },
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Detail Bonus',
                                        style:
                                            AppText.body3(color: Colors.white),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Grid Cards Section
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      Obx(() => _buildInfoCard(
                            'Total Mitra',
                            controller.totalMitra.value.toString(),
                            Icons.people_outline,
                            AppColors.primary,
                            'Mitra',
                            controller.isLoading.value,
                          )),
                      Obx(() => _buildInfoCard(
                            'Total Jamaah',
                            controller.totalJamaah.value.toString(),
                            Icons.mosque_outlined,
                            AppColors.orange200,
                            'Jamaah',
                            controller.isLoading.value,
                          )),
                      Obx(() => _buildInfoCard(
                            'Total Customer',
                            controller.totalCustomer.value.toString(),
                            Icons.group_outlined,
                            AppColors.green,
                            'Customer',
                            controller.isLoading.value,
                          )),
                      Obx(() => _buildInfoCard(
                            'Total Bonus',
                            controller.totalBonus.value,
                            Icons.account_balance_wallet_outlined,
                            AppColors.purple,
                            'Bonus',
                            controller.isLoading.value,
                          )),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Recent Transactions
                  Text('Today', style: AppText.body1(color: Colors.black87)),
                  const SizedBox(height: 12),
                  _buildTransactionItem(
                    'Apple Store',
                    'Payment at the store',
                    '-85',
                    Icons.shopping_bag_outlined,
                    AppColors.primary,
                  ),
                  const SizedBox(height: 12),
                  _buildTransactionItem(
                    'Bonus',
                    'Commission received',
                    '+185',
                    Icons.account_balance_wallet_outlined,
                    AppColors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildInfoCard(String title, String amount, IconData icon, Color color,
      String label, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, size: 24, color: color),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  amount,
                  style: AppText.heading4(color: Colors.black87),
                ),
                Text(
                  title,
                  style: AppText.body3(color: Colors.black54),
                ),
              ],
            ),
    );
  }

  Widget _buildTransactionItem(String title, String subtitle, String amount,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.body2(color: Colors.black87)),
                Text(subtitle, style: AppText.caption(color: Colors.black54)),
              ],
            ),
          ),
          Text(
            amount,
            style: AppText.body2(
              color: amount.startsWith('+') ? AppColors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
