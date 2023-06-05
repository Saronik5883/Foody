import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  RxString selectedPaymentMethod = ''.obs;

  void setSelectedPaymentMethod(String value) {
    selectedPaymentMethod.value = value;
  }
}
