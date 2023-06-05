import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:get/get.dart';
import '../../controllers/payment_method_controller.dart';
import '../../controllers/cart_controller.dart';
import 'dummy_order_complete_page.dart';

class DummySuccessPage extends StatefulWidget {
  const DummySuccessPage({Key? key}) : super(key: key);

  @override
  State<DummySuccessPage> createState() => _DummySuccessPageState();
}

class _DummySuccessPageState extends State<DummySuccessPage> {
  bool isPaymentInProgress = false;
  bool isPaymentCompleted = false;
  final paymentMethodController = Get.put(PaymentMethodController());


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Review'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(16),
            child: Image.asset(
              'assets/image/Paypal-logo.png', // Replace with the actual path to your PayPal logo image
              width: 100,
              height: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Order Amount: \$${cartController.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Payment Methods'),
            subtitle: Text(
                'Select a payment method'),
          ),
          RadioListTile(
            title: Text('PayPal Wallet'),
            value: 'PayPal',
            groupValue: paymentMethodController.selectedPaymentMethod.value,
            onChanged: (value) {
              paymentMethodController.setSelectedPaymentMethod(value!);
            },
          ),
          RadioListTile(
            title: Text('Credit Card'),
            value: 'Credit Card',
            groupValue: paymentMethodController.selectedPaymentMethod.value,
            onChanged: null,
            tileColor: Colors.grey,
          ),
          RadioListTile(
            title: Text('Net Banking'),
            value: 'Net Banking',
            groupValue: paymentMethodController.selectedPaymentMethod.value,
            onChanged: null,
            tileColor: Colors.grey,
          ),
          SizedBox(height: 20),
          LinearProgressIndicator(),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Payment Status: ${isPaymentCompleted ? 'Completed' : 'Pending'}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isPaymentInProgress
              ? null
              : () {
            setState(() {
              isPaymentInProgress = true;
            });

            // Simulating payment processing
            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                isPaymentInProgress = false;
                isPaymentCompleted = true;
              });

              // Displaying success dialog after 3 seconds
              Future.delayed(Duration(seconds: 3), () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text('Order Successful'),
                        ],
                      ),
                      content: Text('Payment has been done.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<CartController>().clear();
                            Get.find<CartController>().removeCartSharedPreference();
                            Get.find<CartController>().addToHistory();
                            Navigator.of(context).pop();
                            Get.off(() => OrderSuccessPage());
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              });
            });
          },
          child: isPaymentInProgress
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
          )
              : Text('Pay'),
        ),
      ),
    );
  }
}
