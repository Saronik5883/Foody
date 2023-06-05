import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/breakfast_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold),),
            actions: <Widget>[
              GetBuilder<PopularProductController>(builder: (controller){
                return TextButton.icon(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: (){
                    if(controller.totalItems>=1) {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.snackbar("Cart Empty", "Add items to the cart to view it");
                    }

                  },
                  label: Stack(
                    children: [
                      controller.totalItems>=1?Text(Get.find<PopularProductController>().totalItems.toString()): Container(),
                    ],
                  ),

                );
              },)
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: "Popular",),
                Tab(text: "Recommended",),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GetBuilder<PopularProductController>(builder: (popularProduct){
                return popularProduct.isLoaded?ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popularProduct.popularProductList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: Dimensions.height10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.getPopularFood(index, "home"));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            child: SizedBox(
                              width: Dimensions.width30 * 12,
                              height: Dimensions.height30 * 4,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: Dimensions.listViewImgSize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +
                                                  popularProduct
                                                      .popularProductList[index].img!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              popularProduct.popularProductList[index]
                                                  .name!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Dimensions.font20,
                                              ),
                                            ),
                                            Text(
                                              "\$ ${popularProduct.popularProductList[index].price!}",
                                              style: TextStyle(
                                                fontFamily: 'Roboto-Serif',
                                                fontWeight: FontWeight.bold,
                                                fontSize: Dimensions.font16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                    :CircularProgressIndicator();
              }),
              GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
                return recommendedProduct.isLoaded?ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: Dimensions.height10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            child: SizedBox(
                              width: Dimensions.width30 * 12,
                              height: Dimensions.height30 * 4,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: Dimensions.listViewImgSize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +
                                                  recommendedProduct
                                                      .recommendedProductList[index].img!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recommendedProduct.recommendedProductList[index]
                                                  .name!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Dimensions.font20,
                                              ),
                                            ),
                                            Text(
                                              "\$ ${recommendedProduct.recommendedProductList[index].price!}",
                                              style: TextStyle(
                                                fontFamily: 'Roboto-Serif',
                                                fontWeight: FontWeight.bold,
                                                fontSize: Dimensions.font16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                    :CircularProgressIndicator();
              }),
            ],
          ),
        )
    );
  }
}
