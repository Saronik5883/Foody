import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/utils/AppColors.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/dimensions.dart';
import 'food_page_body.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Cloud ", style: TextStyle(fontWeight: FontWeight.w400),),
                Text("Bytes", style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary),)
              ],
            ),
            leading: IconButton(
                onPressed: null,
                icon: Icon(Icons.location_pin, color: Theme.of(context).colorScheme.primary)),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined, color: Theme.of(context).colorScheme.primary,)),
            ],
          ),
          SliverToBoxAdapter(
            child: Center(
              child: RefreshIndicator(
                  onRefresh: _loadResource,
                  child: Column(
                    children: [
                      //showing the body
                      const SingleChildScrollView(
                        physics:ScrollPhysics(),
                        child: FoodPageBody(),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}


