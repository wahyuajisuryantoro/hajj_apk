import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/widget_bottom_navbar.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_text.dart';
import 'package:intl/intl.dart';

import '../controllers/bonus_controller.dart';

class BonusView extends GetView<BonusController> {
  const BonusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Bonus', style: AppText.heading4(color: Colors.white)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchBonusData(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => _buildInfoCard(
                            'Saldo Bonus',
                            controller.saldoBonus.value,
                            Icons.account_balance_wallet,
                            AppColors.orange200,
                          )),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => _buildInfoCard(
                            'Total Bonus',
                            controller.totalBonus.value,
                            Icons.payments,
                            AppColors.purple,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Riwayat Mutasi', style: AppText.body1()),
                SizedBox(height: 12),
                Obx(() => ListView.builder(
 shrinkWrap: true, 
 physics: NeverScrollableScrollPhysics(),
 itemCount: controller.mutasiList.length,
 itemBuilder: (context, index) {
   final mutasi = controller.mutasiList[index];
   return Container(
     margin: EdgeInsets.only(bottom: 12),
     padding: const EdgeInsets.all(16),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(16),
       boxShadow: [BoxShadow(
         color: Colors.black.withOpacity(0.05),
         blurRadius: 10,
         offset: const Offset(0, 4),
       )],
     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               DateFormat('EEEE, d MMMM y', 'id_ID')
                 .format(DateTime.parse(mutasi['tanggal_transaksi'])),
               style: AppText.caption()
             ),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
               decoration: BoxDecoration(
                 color: mutasi['status'] == 'debit' 
                   ? AppColors.green.withOpacity(0.1)
                   : AppColors.red.withOpacity(0.1),
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Text(
                 mutasi['status'] == 'debit' ? 'Masuk' : 'Keluar',
                 style: AppText.caption(
                   color: mutasi['status'] == 'debit' 
                     ? AppColors.green 
                     : AppColors.red
                 ),
               ),
             ),
           ],
         ),
         SizedBox(height: 8),
         Row(
           children: [
             Container(
               padding: const EdgeInsets.all(10),
               decoration: BoxDecoration(
                 color: mutasi['status'] == 'debit'
                   ? AppColors.green.withOpacity(0.1)
                   : AppColors.red.withOpacity(0.1),
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Icon(
                 mutasi['status'] == 'debit'
                   ? Icons.arrow_upward
                   : Icons.arrow_downward,
                 color: mutasi['status'] == 'debit'
                   ? AppColors.green
                   : AppColors.red
               ),
             ),
             SizedBox(width: 16),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(mutasi['category_name'], style: AppText.body2()),
                   Text(mutasi['desc'], style: AppText.caption(color: Colors.black54)),
                 ],
               ),
             ),
             Text(
               NumberFormat.currency(
                 locale: 'id',
                 symbol: 'Rp ',
                 decimalDigits: 0
               ).format(int.parse(mutasi['value'].toString())),
               style: AppText.body2(
                 color: mutasi['status'] == 'debit'
                   ? AppColors.green
                   : AppColors.red
               ),
             ),
           ],
         ),
       ],
     ),
   );
 },
))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildInfoCard(
      String title, String amount, IconData icon, Color color) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(height: 12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(amount,
                style:
                    amount.length > 15 ? AppText.body1() : AppText.heading4()),
          ),
          Text(title, style: AppText.body3(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildMutasiItem(String title, String subtitle, String amount,
      IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.body2()),
                Text(subtitle, style: AppText.caption(color: Colors.black54)),
              ],
            ),
          ),
          Text(
            'Rp $amount',
            style: AppText.body2(color: color),
          ),
        ],
      ),
    );
  }
}
