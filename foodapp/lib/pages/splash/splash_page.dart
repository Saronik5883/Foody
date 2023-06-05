import 'dart:async';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/data/repository/cart_repo.dart';
import 'package:foodapp/data/repository/user_repo.dart';
import 'package:foodapp/models/response_model.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/routes/route_helper.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../controllers/user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    var product= Get.find<PopularProductController>().popularProductList[0];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
  }

  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 1))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 2),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
              child: Center(child: Image.asset("assets/image/logo1.png", width: Dimensions.splashImg,))),
        ],
      )
    );
  }
}
