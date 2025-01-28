import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';

import '../controllers/jamaah_list_controller.dart';

class JamaahListView extends GetView<JamaahListController> {
  const JamaahListView({super.key});
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        elevation: 0,
        title: Text('Daftar Jamaah', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : _buildJamaahList()),
          ),
        ],
      ),
    );
  }

  
Widget _buildJamaahList() {
  return RefreshIndicator(
    color: AppColors.primary,
    onRefresh: () => controller.fetchJamaahData(),
    child: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredJamaahList.length,
      itemBuilder: (context, index) {
        final jamaah = controller.filteredJamaahList[index];
        return _buildJamaahCard(jamaah);
      },
    )
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
        onChanged: controller.filterJamaah,
        decoration: InputDecoration(
          hintText: 'Cari jamaah...',
          hintStyle: AppText.body3(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: AppColors.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildJamaahCard(Map<String, dynamic> jamaah) {
    return InkWell(
       onTap: () => controller.showJamaahDetails(jamaah),
      child: Container(
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildProfileImage(jamaah['picture_profile']),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(jamaah['name'] ?? '',
                          style: AppText.body1(color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text(jamaah['email'] ?? '',
                          style: AppText.body3(color: Colors.black54)),
                      const SizedBox(height: 4),
                      Text(jamaah['phone'] ?? '',
                          style: AppText.body3(color: Colors.black54)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildPaymentBadge(jamaah['status_payment']),
                    const SizedBox(height: 8),
                    _buildStatusBadge(jamaah['status']),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

Widget _buildStatusBadge(String? status) {
  final isActive = status?.toLowerCase() == 'active';
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
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


  Widget _buildPaymentBadge(String? status) {
    Color badgeColor;
    String text = status ?? 'Unknown';
    
    switch(status?.toLowerCase()) {
      case 'lunas':
        badgeColor = AppColors.green;
        break;
      case 'dp':
        badgeColor = AppColors.orange200;
        break;
      case 'angsuran':
        badgeColor = AppColors.purple;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppText.caption(color: badgeColor),
      ),
    );
  }
}
