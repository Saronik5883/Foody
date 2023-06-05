import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/bold_text.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PopularProductController>();

    double? scrolledUnderElevation;

    Map<String, int> cartItemsPerOrder = Map();

    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=>++value);
      }
      cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=>1);
    }


    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter =0;
    int i=0;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-mm-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM.dd.yy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: "Order number ${itemsPerOrder.length-i++}"),
          Text(outputDate)
        ],
      );
    }
    return Scaffold(
      
        body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Cart ", style: TextStyle(fontWeight: FontWeight.w500),),
                Text("History", style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
            leading: TextButton(
              child: Text(""),
              onPressed: (){},
            ),
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor: Theme.of(context).colorScheme.shadow,
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.shopping_cart_outlined, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                onPressed: (){
                  if(controller.totalItems>=1) {
                    Get.toNamed(RouteHelper.getCartPage());
                  } else {
                    Get.snackbar("Cart Empty", "Add items to the cart to view it");
                  }
                },
                label: Stack(
                  children: [
                    controller.totalItems>=1?Text(Get.find<PopularProductController>().totalItems.toString()): Container()
                  ],
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: GetBuilder<CartController>(builder: (_cartController){
              return _cartController.getCartHistoryList().length>0? Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width15/2,
                      right: Dimensions.width15/2,
                    ),
                    child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            for(int i=0;i<itemsPerOrder.length;i++)
                              Card(
                                child: SizedBox(
                                  child: Container(
                                    padding: EdgeInsets.only(top: Dimensions.height10,
                                        bottom: Dimensions.height20/8,
                                        left: Dimensions.width10, right: Dimensions.width10),
                                    height: Dimensions.height15*11+10,
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    child: Column(
                                      crossAxisAlignment : CrossAxisAlignment.start,
                                      children: [
                                        timeWidget(listCounter),
                                        SizedBox(height: Dimensions.height10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                                direction: Axis.horizontal,
                                                children: List.generate(itemsPerOrder[i], (index){
                                                  if(listCounter<getCartHistoryList.length){
                                                    listCounter++;
                                                  }
                                                  return index<=1?Container(
                                                    margin: EdgeInsets.only(right: Dimensions.width10/2),
                                                    height: Dimensions.height20*4,
                                                    width: Dimensions.height20*4,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                                            )
                                                        )
                                                    ),
                                                  ):Container();
                                                })
                                            ),
                                            Container(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  SmallText(text: "Total", color: Theme.of(context).colorScheme.onSecondaryContainer,),
                                                  BigText(text: "${itemsPerOrder[i]} Items", color: Theme.of(context).colorScheme.onSecondaryContainer,),
                                                  OutlinedButton(onPressed: (){
                                                    var orderTime = cartOrderTimeToList();
                                                    Map<int, CartModel> moreOrder ={};
                                                    for(int j=0;j<getCartHistoryList.length;j++){
                                                      if(getCartHistoryList[i].time==orderTime[i]){
                                                        moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                            CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>().setItems = moreOrder;
                                                    Get.find<CartController>().addToCartList();
                                                    Get.toNamed(RouteHelper.getCartPage());
                                                  },
                                                      child: Text("Order Again")
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        )),
                  ),
                ],
              ):
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.height20*9),
                  Container(
                      height: MediaQuery.of(context).size.height/1.5,
                      child: const Center(
                          child: NoDataPage(text: "No Orders Yet", imgPath: "assets/image/empty_box.png",)
                      )
                  ),
                ],
              );
            }),
          )
            ],


          )
      );
  }
}
