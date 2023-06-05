import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/data/repository/cart_repo.dart';
import 'package:foodapp/data/repository/location_repo.dart';
import 'package:foodapp/data/repository/popular_products_repo.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/order_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../data/repository/user_repo.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiCLient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiCLient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

}