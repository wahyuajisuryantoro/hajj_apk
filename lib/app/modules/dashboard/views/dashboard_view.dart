import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/controller_bottom_navbar.dart';
import 'package:hajj/app/components/bottom_navbar/widget_bottom_navbar.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:intl/intl.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Atur supaya anak-anak Row terpusat
                    children: [
                      // Avatar di kiri
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
                      SizedBox(
                        width: AppResponsive.width(context, 0.1),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/logoapp.png',
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppResponsive.width(context, 0.1),
                      ),
                      InkWell(
                        onTap: () {
                          BottomNavigationController.to
                              .navigateToRoute(Routes.AKUN);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.softOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.settings_outlined,
                              color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                                  onPressed: () {
                                    Get.toNamed(Routes.BONUS);
                                  },
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
                            'Total Customer',
                            controller.totalCustomer.value.toString(),
                            Icons.group_outlined,
                            AppColors.green,
                            'Customer',
                            controller.isLoading.value,
                          )),
                      Obx(() => _buildInfoCard(
                            'Saldo Bonus',
                            controller.saldoBonus.value.toString(),
                            Icons.credit_card_outlined,
                            AppColors.orange200,
                            'Bonus',
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
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/program.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Program Terbaru',
                        style: AppText.body1(color: Colors.black87),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.DASHBOARD_ALL_PROGRAM);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: Text(
                          'Lihat Semua',
                          style: AppText.caption(color: AppColors.softWhite),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Obx(() => controller.isLoadingPrograms.value
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: AppResponsive.height(context, 25),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.programs.length,
                            itemBuilder: (context, index) {
                              final program = controller.programs[index];
                              return Container(
                                width: 280,
                                margin: EdgeInsets.only(right: 16),
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
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.DASHBOARD_DETAIL_PROGRAM,
                                        arguments: program.code);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                        child: Image.network(
                                          program.picture ??
                                              'https://via.placeholder.com/280x120',
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              program.name,
                                              style: AppText.body2(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp ',
                                                      decimalDigits: 0)
                                                  .format(program.price),
                                              style: AppText.body3(
                                                  color: AppColors.primary),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Sisa Kursi: ${program.sisaKursi}',
                                              style: AppText.caption(
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                  SizedBox(height: AppResponsive.height(context, 3)),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/berita.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Berita',
                        style: AppText.body1(color: Colors.black87),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.DASHBOARD_ALL_BERITA);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: Text(
                          'Lihat Semua',
                          style: AppText.caption(color: AppColors.softWhite),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppResponsive.height(context, 2),
                  ),
                  Obx(() {
                    if (controller.isLoadingNews.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppResponsive.width(context, 1),
                      ),
                      itemCount: controller.news.length > 3
                          ? 3
                          : controller.news.length,
                      itemBuilder: (context, index) {
                        final news = controller.news[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DASHBOARD_DETAIL_BERITA,
                                arguments: news.id);
                          },
                          child: Hero(
                            tag: 'news-${news.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        left: Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        '${news.picture}',
                                        height: 110,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              news.name,
                                              style: AppText.body2(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              controller
                                                  .formatDate(news.createdAt!),
                                              style: AppText.caption(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
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
      height: 140,
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
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 24, color: color),
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        amount,
                        style: amount.length > 15
                            ? AppText.heading4(color: Colors.black87)
                            : amount.length > 12
                                ? AppText.heading3(color: Colors.black87)
                                : AppText.heading2(color: Colors.black87),
                      ),
                    ),
                  ),
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
