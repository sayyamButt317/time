import 'package:get/get.dart';

class Controller extends GetxController {
  var isprofileloading = false.obs;

  void setIsProfileLoading(bool isLoading) {
    isprofileloading.value = isLoading;
  }
}
