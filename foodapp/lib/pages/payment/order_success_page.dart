import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_button.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({Key? key, required this.orderID, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(status==0){
      Future.delayed(Duration(seconds: 1), (){
        //Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(

      body: Center(child: SizedBox(width: Dimensions.screenWidth, child:
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(status==1?'assets/images/checked.png':
        'assets/images/warning.png', width: 100, height: 100,),
        SizedBox(height: Dimensions.height45,),
        Text(status==1?'Order Placed Successfully!':'Order Failed!', style: TextStyle(
            fontSize: Dimensions.font26, fontWeight: FontWeight.bold),),
        SizedBox(height: Dimensions.height20,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(status==1?'Your order has been placed successfully.':'Your order has failed. Please try again later.',
            textAlign: TextAlign.center, style: TextStyle(
              fontSize: Dimensions.font16, fontWeight: FontWeight.w500),),
        ),
        SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
            buttonText: 'Continue Shopping',
            onPressed: (){
              Get.offAllNamed(RouteHelper.getInitial());
            },
          )
        ),

      ],)
        ,),),
    );
  }
}
