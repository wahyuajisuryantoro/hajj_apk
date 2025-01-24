import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/controller_bottom_navbar.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';

class CustomBottomNavigationBar extends GetView<BottomNavigationController> {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 1),
      height: 65,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            controller.indexToRoute.length,
            (index) => _buildNavItem(
              context,
              index: index,
              route: controller.indexToRoute[index],
              label: controller.pageNames[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String route,
    required String label,
  }) {
    // Tentukan icon berdasarkan route
    IconData getIcon(String route) {
      switch (route) {
        case Routes.DASHBOARD:
          return Icons.home;
        case Routes.MITRA:
          return Icons.business_center;
        case Routes.CUSTOMER:
          return Icons.people;
        case Routes.JAMAAH:
          return Icons.group;
        case Routes.AKUN:
          return Icons.person;
        default:
          return Icons.circle;
      }
    }

    final isSelected = controller.selectedIndex.value == index;

    return InkWell(
      onTap: () => controller.changePage(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(context, 4),
          vertical: AppResponsive.height(context, 1),
        ),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          children: [
            Icon(
              getIcon(route),
              size: 24,
              color: isSelected ? AppColors.primary : Colors.white,
            ),
            SizedBox(width: AppResponsive.width(context, 1)),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}