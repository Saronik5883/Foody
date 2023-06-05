import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/AppColors.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/widgets/app_column_no_title.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/expandable_text_widget.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/bold_text.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    double? scrollUnderElevation;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: (){
                if(page=="cartPage"){
                  Get.toNamed(RouteHelper.getCartPage());
                }else{
                  Get.toNamed(RouteHelper.getInitial());
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(product.name!, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto-Serif'),),
            scrolledUnderElevation: scrollUnderElevation,
            shadowColor: Theme.of(context).colorScheme.shadow,
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
          ),
          SliverToBoxAdapter(
            child: Column(

              children: [
                Container(
                  height: Dimensions.height30*10,
                  width: Dimensions.screenWidth-15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img)
                      )
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10),
                    child: AppColumnNoTitle(price: product.price!)),
                Container(
                  child: SmallText(text: product.description!,size: Dimensions.font16, color: Theme.of(context).colorScheme.onSurfaceVariant,),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                ),

              ],
            ),

          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: GetBuilder<PopularProductController>(builder: (controller){
            return Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            controller.setQuantity(false);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        TextButton(
                            onPressed: (){},
                            child: Text("${controller.inCartItems} ", style: TextStyle(fontSize: Dimensions.font26),),
                            style: TextButton.styleFrom(
                              fixedSize: Size(5, 60),
                            )
                        ),
                        IconButton(
                          onPressed: (){
                            controller.setQuantity(true);
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                    SizedBox(width: Dimensions.width10,),
                    Row(
                      children: [
                        FilledButton.icon(
                          label: Text("Add to cart", style: TextStyle(fontSize: Dimensions.font16),),
                          onPressed: (){
                            controller.addItem(product);
                          },
                          icon: const Icon(Icons.shopping_cart),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(Dimensions.width30*6.5, Dimensions.height30)
                          ),
                        ),
                      ],
                    )
                  ],
                ),


              ],
            );
          })
      ),

    );
  }
}
