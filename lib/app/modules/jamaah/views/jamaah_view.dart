import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hajj/app/components/bottom_navbar/widget_bottom_navbar.dart';

import '../controllers/jamaah_controller.dart';

class JamaahView extends GetView<JamaahController> {
  const JamaahView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JamaahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JamaahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
