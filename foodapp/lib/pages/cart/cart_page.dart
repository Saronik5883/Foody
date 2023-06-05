import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/models/place_order_model.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/AppColors.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/bold_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../models/order_model.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../payment/dummy_payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double? scrolledUnderElevation;
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: (){
                  Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text("Your Cart"),
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor: Theme.of(context).colorScheme.shadow,
            actions: <Widget>[
              GetBuilder<PopularProductController>(builder: (controller){
                return IconButton(
                  icon: Icon(Icons.home_outlined),
                  onPressed: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                );
              },)
            ],
          ),
          SliverToBoxAdapter(
            child: GetBuilder<CartController>(builder: (_cartController){
              return _cartController.getItems.length>0?Column(
                children: [
                  Container(
                      child: Container(
                        width: Dimensions.screenWidth-32,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(builder: (cartController){
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: _cartList.length,
                                itemBuilder: (_, index){
                                  return Card(child: SizedBox(
                                    child: Container(

                                      margin: EdgeInsets.only(top: Dimensions.height15),
                                      height: Dimensions.height20*5,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              var popularIndex = Get.find<PopularProductController>().
                                              popularProductList.
                                              indexOf(_cartList[index].product!);
                                              if(popularIndex>=0){
                                                Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartPage"));
                                              }else{
                                                var recommendedIndex = Get.find<RecommendedProductController>().
                                                recommendedProductList.
                                                indexOf(_cartList[index].product!);
                                                if(recommendedIndex<0){
                                                  Get.snackbar("Product History", "Product review is not avaliable for history products",);
                                                }else{
                                                  Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartPage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.height20*5,
                                              height: Dimensions.height20*6,
                                              margin: EdgeInsets.only(bottom: Dimensions.height10, left: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!,
                                                    )
                                                ),
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10,),
                                          Expanded(child: SizedBox(

                                            height: Dimensions.height20*5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                                SmallText(text: "Spicy"),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    BigText(text: "\$ ${cartController.getItems[index].price}", color: Theme.of(context).colorScheme.error,),
                                                    Container(
                                                      padding: EdgeInsets.only(top: Dimensions.height10,
                                                          bottom: Dimensions.height20/8,
                                                          left: Dimensions.width10, right: Dimensions.width10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: (){
                                                                cartController.addItem(_cartList[index].product!, -1);
                                                                // popularProduct.setQuantity(false);
                                                              },
                                                              icon: const Icon(Icons.remove_circle_outline,)
                                                          ),
                                                          SizedBox(width: Dimensions.width10/2,),
                                                          BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                          SizedBox(width: Dimensions.width10/2,),
                                                          IconButton(
                                                              onPressed: (){
                                                                cartController.addItem(_cartList[index].product!, 1);
                                                                // popularProduct.setQuantity(true);
                                                              },
                                                              icon: const Icon(Icons.add_circle_outline))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ));

                                });
                          },),
                        ),

                      ))
                ],
              ):const NoDataPage(text: "Your cart is empty");
            })
          ),


        ],
      ),
        bottomNavigationBar: BottomAppBar(
            child: GetBuilder<CartController>(builder: (cartController){
              return Row(

                children: [

                  cartController.getItems.length>0?Row(
                    children: [
                      BoldText(text: "Total : \$${cartController.totalAmount}"),
                      SizedBox(width: Dimensions.width30*3,),
                      Row(
                        children: [
                          FloatingActionButton.extended(
                            label: Text("Checkout", style: TextStyle(fontSize: Dimensions.font16),),
                            onPressed: (){
                              if(Get.find<AuthController>().userLoggedIn()){
                                //print("USER ID IS ==========="+Get.find<UserController>().userModel!.id.toString());
                                if(Get.find<LocationController>().addressList.isEmpty){
                                  Get.toNamed(RouteHelper.getAddressPage());
                                }else{
                                  Get.to(DummyPaymentPage());
                                  // Get.find<CartController>().clear();
                                  // Get.find<CartController>().removeCartSharedPreference();
                                  Get.find<CartController>().addToHistory();
                                }
                              }else{
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            icon: const Icon(Icons.shopping_cart_checkout_sharp),
                          ),
                        ],
                      )
                    ],
                  ):Container(
                    color: Theme.of(context).colorScheme.surface,
                  ),


                ],
              );
            })
        )
    );
  }

  void _callBack(bool isSuccess, String message, String orderID){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      //Get.toNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
      Get.toNamed(RouteHelper.getPaymentPage("100023", 30));
    }else{
      Get.snackbar("Order", message);
    }
  }
}
