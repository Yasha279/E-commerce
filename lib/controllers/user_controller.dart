import 'package:get/get.dart';

class UserController extends GetxController {
  var username = 'Guest'.obs;
  void loginUser({required String newUsername}) {
    username.value = newUsername;
  }
}
