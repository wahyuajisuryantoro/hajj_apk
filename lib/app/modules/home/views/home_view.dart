import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Image.asset(
          'assets/images/logoapp.png',
          height: 40,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                'Login Mitra',
                style: AppText.body3(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchPrograms();
          await controller.fetchNews();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: AppResponsive.height(context, 25),
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      controller.onPageChanged(index);
                    },
                  ),
                  items: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/slider${index + 1}.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Dot Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Obx(() {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage.value == index
                                  ? AppColors.primary
                                  : Colors.grey[300],
                            ),
                          );
                        })),
              ),

              // Program Section
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(context, 5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Program',
                        style: AppText.body1(),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.PROGRAM_ALL);
                        },
                        child: Text(
                          'Lihat Semua Program',
                          style: AppText.body3(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Program List
              Obx(() {
                if (controller.isLoadingPrograms.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: AppResponsive.height(context, 35),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.programs.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.width(context, 5),
                    ),
                    itemBuilder: (context, index) {
                      final program = controller.programs[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.PROGRAM_DETAIL,
                              arguments: program.code);
                        },
                        child: Container(
                          width: AppResponsive.width(context, 60),
                          margin: const EdgeInsets.only(right: 16),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                                child: Image.network(
                                  '${program.picture}',
                                  height: AppResponsive.height(context, 15),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: AppResponsive.height(context, 15),
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      program.name,
                                      style: AppText.body1(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.formatPrice(program.price),
                                      style: AppText.body2(
                                          color: AppColors.primary),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Berangkat: ${controller.formatDate(program.tanggalBerangkat)}',
                                      style: AppText.body3(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Sisa Kuota: ${program.sisaKursi}',
                                      style: AppText.body3(color: Colors.grey),
                                    ),
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
              }),

              // News Section Header
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(context, 5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Berita Terkini',
                        style: AppText.body1(),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.BERITA_ALL);
                        },
                        child: Text(
                          'Lihat Semua Berita',
                          style: AppText.body3(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // News List
              Obx(() {
                if (controller.isLoadingNews.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(context, 5),
                  ),
                  itemCount:
                      controller.news.length > 3 ? 3 : controller.news.length,
                  itemBuilder: (context, index) {
                    final news = controller.news[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.BERITA_DETAIL, arguments: news.id);
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
                                  borderRadius: const BorderRadius.horizontal(
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
                                          style: AppText.body1(),
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
              // Bottom Padding
              SizedBox(height: AppResponsive.height(context, 5)),
            ],
          ),
        ),
      ),
    );
  }
}
