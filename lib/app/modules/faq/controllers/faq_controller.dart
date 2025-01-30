import 'package:get/get.dart';

class FaqController extends GetxController {
final RxBool isExpanded = false.obs;

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}
