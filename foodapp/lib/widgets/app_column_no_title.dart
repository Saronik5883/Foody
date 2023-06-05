import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../utils/AppColors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumnNoTitle extends StatelessWidget {
  final price;
  const AppColumnNoTitle({Key? key, required this.price}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1,),
        //comments section
        Row(
          children: [
            // Wrap(
            //   children: List.generate(5, (index) => Icon(Icons.star, color:AppColors.mainColor, size: 15,)),
            // ),
            // SizedBox(width: 10,),
            // SmallText(text: "4.5"),
            // SizedBox(width: 10,),
            // SmallText(text: "1287"),
            // SizedBox(width: 10,),
            // SmallText(text: "Comments")
            Text("\$ $price",
              style: TextStyle(
                  fontFamily: 'Roboto-Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font26
              ),
            )
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        //time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*ElevatedButton.icon(
              icon: Icon(Icons.local_fire_department_outlined),
                onPressed: (){},
                label: Text("Normal")),*/
            Container(
              height: 60,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius5),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, right: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [IconButton.filledTonal(
                          icon: Icon(Icons.local_fire_department_outlined, ),
                          onPressed: (){},
                        ),],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Normal"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimensions.width20,),
            Container(
              height: 60,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius5),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, right: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [IconButton.filledTonal(
                          icon: Icon(Icons.access_time_rounded, ),
                          onPressed: (){},
                        ),],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("37 mins"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Text("Description", style: TextStyle(fontSize: Dimensions.font16*1.2, fontWeight: FontWeight.w600),),
        SizedBox(height: Dimensions.height20,),
      ],
    );
  }
}
