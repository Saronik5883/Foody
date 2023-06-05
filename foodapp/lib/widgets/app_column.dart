import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/widgets/bold_text.dart';
import 'package:foodapp/widgets/small_text.dart';

import '../utils/AppColors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'package:get/get.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final price;
  const AppColumn({Key? key, required this.text, required this.price}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.height10,),
        BoldText(text: text, size: Dimensions.font20,),
        SizedBox(height: Dimensions.height10,),
        //comments section
        Row(
          children: [
            Text("\$ $price",
            style: TextStyle(
              fontFamily: 'Roboto-Serif',
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.font16
            ),
            )
          ],
        ),
        SizedBox(height: Dimensions.height10,),
        //time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconAndTextWidget(icon: Icons.local_fire_department_outlined,
                text: "Normal",
                ),
            SizedBox(width: 20,),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "32min",
                ),
          ],
        )
      ],
    );
  }
}
