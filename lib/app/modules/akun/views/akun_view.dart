import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/widget_bottom_navbar.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/akun_controller.dart';

class AkunView extends GetView<AkunController> {
  const AkunView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildMenuSection(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: AppResponsive.height(context, 20),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: AppResponsive.height(context, 15),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Profile Saya',
                style: AppText.heading4(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 20,
            right: 20,
            child: Card(
              color: AppColors.softWhite,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Obx(() => CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.softOrange,
                          child: controller
                                      .mitraData.value['picture_profile'] !=
                                  null
                              ? ClipOval(
                                  child: Image.network(
                                    controller
                                        .mitraData.value['picture_profile'],
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    errorBuilder:
                                        (context, error, stackTrace) => Text(
                                      controller.getInitials(
                                          controller.mitraData.value['name'] ??
                                              ''),
                                      style: AppText.heading3(
                                          color: AppColors.primary),
                                    ),
                                  ),
                                )
                              : Text(
                                  controller.getInitials(
                                      controller.mitraData.value['name'] ?? ''),
                                  style: AppText.heading3(
                                      color: AppColors.primary),
                                ),
                        )),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.mitraData.value['name'] ??
                                    'Loading...',
                                style: AppText.body1(color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller.mitraData.value['code'] ??
                                        'Loading...',
                                    style: AppText.body3(color: Colors.grey),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.copy,
                                        size: 16, color: Colors.grey),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: controller
                                                  .mitraData.value['code'] ??
                                              ''));
                                      Get.snackbar(
                                        'Success',
                                        'Kode mitra berhasil disalin',
                                        backgroundColor: AppColors.green,
                                        colorText: Colors.white,
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(minWidth: 24),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.AKUN_PROFILE_EDIT, arguments: {
                          'name': controller.mitraData.value['name'],
                          'phone': controller.mitraData.value['phone'],
                          'email': controller.mitraData.value['email'],
                          'birth_place':
                              controller.mitraData.value['birth_place'],
                          'birth_date':
                              controller.mitraData.value['birth_date'],
                          'address': controller.mitraData.value['address'],
                          'picture_profile':
                              controller.mitraData.value['picture_profile']
                        });
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/edit.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pengaturan Akun',
              style: AppText.body1(color: AppColors.primary)),
          const SizedBox(height: 16),
          _buildMenuCard(
            svgIconPath: 'assets/icons/password-setting.svg',
            title: 'Password Settings',
            onTap: () {
              Get.toNamed(Routes.AKUN_PASSWORD_EDIT);
            },
          ),
          _buildMenuCard(
            svgIconPath: 'assets/icons/jamaah.svg',
            title: 'List Jamaah',
            onTap: () {
              Get.toNamed(Routes.JAMAAH_LIST);
            },
          ),
          _buildMenuCard(
            svgIconPath: 'assets/icons/kebijakan.svg',
            title: 'Kebijakan dan Privasi',
            onTap: () {
              Get.toNamed(Routes.KEBIJAKAN_PRIVASI);
            },
          ),
          _buildMenuCard(
            svgIconPath: 'assets/icons/terms.svg',
            title: 'Syarat dan Ketentuan',
            onTap: () {
              Get.toNamed(Routes.SYARAT_KETENTUAN);
            },
          ),
          const SizedBox(height: 24),
          _buildActionButton(
            title: 'Logout',
            color: AppColors.orange200,
            onTap: () {
              controller.logout();
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            title: 'Hapus Akun',
            color: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required String svgIconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.softWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          svgIconPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
        title: Text(
          title,
          style: AppText.body2(),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        label: Text(
          title,
          style: AppText.body2(),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
