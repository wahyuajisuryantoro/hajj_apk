import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bonus_controller.dart';

class BonusView extends GetView<BonusController> {
  const BonusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BonusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BonusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
