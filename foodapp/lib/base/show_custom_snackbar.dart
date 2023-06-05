
import 'package:get/get.dart';

void showCustomSnackbar(String message, {bool isError=true, String title="Error"}){
  Get.snackbar(title, message);
}