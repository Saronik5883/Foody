import 'package:foodapp/models/order_model.dart';
import 'package:foodapp/pages/address/add_address_page.dart';
import 'package:foodapp/pages/address/pick_address_map.dart';
import 'package:foodapp/pages/auth/sign_in_page.dart';
import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/pages/food/recommended_food_detail.dart';
import 'package:foodapp/pages/home/home_page.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/payment/payment_page.dart';
import 'package:foodapp/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/payment/order_success_page.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String homePage = "/food-page-body";
  
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";

  static const String payment = "/payment";
  static const String orderSuccess = "/order-success";

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getHomePage()=>'$homePage';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';
  static String getPaymentPage(String id, int userId)=>'$payment?id=$id&user_id=$userId';
  static String getOrderSuccessPage(String orderID, String status)=>'$orderSuccess?id=$orderID&status=$status';



  static List<GetPage> routes =[
    GetPage(name: splashPage, page: ()=>SplashScreen()),

    GetPage(name: initial, page: (){
      return HomePage();
    }, transition: Transition.fade),

    GetPage(name: signIn, page: (){
      return SignInPage();
    },
        transition: Transition.cupertino),

    GetPage(name: popularFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page:page!);
    },
    transition: Transition.cupertino),

    GetPage(name: recommendedFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page:page!);
    },
        transition: Transition.cupertino),

    GetPage(name: cartPage, page: (){
      var pageId=Get.parameters['pageId'];
      return CartPage();
    },
        transition: Transition.cupertino),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    },
        transition: Transition.cupertino),
    
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddressMap = Get.arguments;
      return _pickAddressMap;
    }),

    GetPage(name: payment, page: (){
      return PaymentPage(orderModel: OrderModel(
        userId: int.parse(Get.parameters['user_id']!),
        id : int.parse(Get.parameters['id']!)
      ));
    },
        transition: Transition.cupertino),

    GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
      orderID: Get.parameters['id']!,
      status: Get.parameters['status']!.toString().contains("success")?1:0,
    )),
  ];
}