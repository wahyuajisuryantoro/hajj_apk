import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_add_controller.dart';

class CustomerAddView extends GetView<CustomerAddController> {
  const CustomerAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomerAddView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CustomerAddView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
