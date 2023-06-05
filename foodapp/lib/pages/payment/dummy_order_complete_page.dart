import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';

class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Order Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your order has been added.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.find<CartController>().clear();
                Get.find<CartController>().removeCartSharedPreference();
                Get.find<CartController>().addToHistory();
                Navigator.of(context).pop();
                Get.toNamed(RouteHelper.getInitial());
              },
              child: Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
