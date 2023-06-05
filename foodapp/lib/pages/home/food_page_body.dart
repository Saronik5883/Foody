import 'dart:ffi' as da;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/controllers/breakfast_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/utils/AppColors.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/icon_and_text_widget.dart';
import 'package:foodapp/widgets/small_text.dart';
import '../../controllers/cart_controller.dart';
import '../../models/products_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/bold_text.dart';



class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue=0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer/2;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;

      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Column(

      children: [
        SizedBox(height: Dimensions.height20,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Popular", style: TextStyle(
                fontFamily: 'Roboto-Serif-Black',
                fontSize: Dimensions.font26,
              ),),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: SmallText(text: "Right Now",),
              )

            ],
          ),
        ),
        SizedBox(height: Dimensions.height30,),
        //slider section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return popularProducts.isLoaded?Container(
            //color: Colors.redAccent,
            height: 260,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (contest, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),

          ):CircularProgressIndicator();
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: Theme.of(context).colorScheme.primary,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius5)),
            ),
          );
        }),
        //Popular text
        SizedBox(height: Dimensions.height20,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Recommended", style: TextStyle(
                  fontFamily: 'Roboto-Serif-Black',
                  fontSize: Dimensions.font26
              ),),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: SmallText(text: "Food Pairing",),
              )

            ],
          ),
        ),
        //recommended food
        //list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
            padding: EdgeInsets.only(top: 20),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.only(top: Dimensions.height10),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                          child: SizedBox(
                            width: Dimensions.width30*12,
                            height: Dimensions.height30*6.5,
                            child: Column(
                              children: [
                                //image section
                                Container(
                                  width: Dimensions.width30*12,
                                  height: Dimensions.listViewImgSize,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(Dimensions.radius20),
                                          topRight: Radius.circular(Dimensions.radius20),

                                      ),
                                      // color: Colors.white38,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                          )
                                      )
                                  ),
                                ),
                                //text container
                                Expanded(
                                  child: 
                                    ListTile(
                                      title: Text(recommendedProduct.recommendedProductList[index].name!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.font20
                                      ),
                                      ),
                                      subtitle: Text("\$ ${recommendedProduct.recommendedProductList[index].price!}",
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Serif',
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimensions.font16
                                        ),
                                      )
                                    )
                                )
                              ],
                            ),
                          ),

                      ),
                    ),
                  ),
                );
              }):CircularProgressIndicator();
        }),
        SizedBox(height: Dimensions.height30,),

      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();

    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);


    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              height: 250,
              child: InkWell(
              onTap: (){
                Get.toNamed(RouteHelper.getPopularFood(index, "home"));
              },
                child: Column(
                  children: [
                    Container(
                      height: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius5*2),
                            topRight: Radius.circular(Dimensions.radius5*2)
                        ),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                                )
                              )
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                      child: AppColumn(text: popularProduct.name!, price: popularProduct.price!,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
