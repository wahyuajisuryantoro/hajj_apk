import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/widget_bottom_navbar.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import '../controllers/mitra_controller.dart';

class MitraView extends GetView<MitraController> {
  const MitraView({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        elevation: 0,
        title:
            Text('Daftar Mitra', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : _buildMitraList()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.MITRA_ADD),
        child: const Icon(
          Icons.add,
          color: AppColors.softWhite,
        ),
        backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20), bottomStart: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        onChanged: controller.filterMitra,
        decoration: InputDecoration(
          hintText: 'Cari mitra...',
          hintStyle: AppText.body3(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: AppColors.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildMitraList() {
    return RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => controller.fetchMitraData(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.filteredMitraList.length,
          itemBuilder: (context, index) {
            final mitra = controller.filteredMitraList[index];
            return _buildMitraCard(mitra);
          },
        ));
  }

  Widget _buildMitraCard(Map<String, dynamic> mitra) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              offset: const Offset(-1, -1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Card(
          color: AppColors.softWhite,
          margin: EdgeInsets.zero,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () => controller.showMitraDetails(mitra),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildProfileImage(mitra['picture_profile']),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mitra['name'] ?? '',
                            style: AppText.body1(color: Colors.black87)),
                        const SizedBox(height: 4),
                        Text(mitra['email'] ?? '',
                            style: AppText.body3(color: Colors.black54)),
                        const SizedBox(height: 4),
                        Text(mitra['phone'] ?? '',
                            style: AppText.body3(color: Colors.black54)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildLevelBadge(mitra['level']),
                      const SizedBox(height: 8),
                      _buildStatusBadge(mitra['status']),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildProfileImage(String? imageUrl) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondary,
        image: imageUrl != null && imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null || imageUrl.isEmpty
          ? Icon(Icons.person, color: Colors.grey[400], size: 30)
          : null,
    );
  }

  Widget _buildLevelBadge(String? level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level ?? '',
        style: AppText.caption(color: AppColors.purple),
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    final isActive = status?.toLowerCase() == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Nonactive',
        style: AppText.caption(
          color: isActive ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
