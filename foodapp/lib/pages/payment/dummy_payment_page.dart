import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dummy_payment_success..dart';
class DummyPaymentPage extends StatefulWidget {
  const DummyPaymentPage({Key? key}) : super(key: key);

  @override
  State<DummyPaymentPage> createState() => _DummyPaymentPageState();
}


class _DummyPaymentPageState extends State<DummyPaymentPage> {
  final String email = 'test@example.com'; // Pre-defined email
  final String password = 'password'; // Pre-defined password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPal Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/Paypal-logo.png', // Replace with the actual path to your PayPal logo image
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (emailController.text == email && passwordController.text == password) {
                  // Credentials match
                  Get.snackbar('Success', 'Sign in successful');
                  Get.to(DummySuccessPage());
                } else {
                  // Credentials do not match
                  Get.snackbar('Error', 'Sign in failed');
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
