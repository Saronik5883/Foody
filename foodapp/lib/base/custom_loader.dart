import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2)
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
