import 'package:flutter/material.dart';
import 'package:foodapp/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? radius;
  final IconData? icon;
  const CustomButton({Key? key,
    this.onPressed,
    required this.buttonText,
    this.transparent=false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius,
    this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:transparent?Colors.transparent:Theme.of(context).primaryColor,
      minimumSize: Size(width!=null?Dimensions.screenWidth:width!, height!=null?height!:50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!=null?radius!:10),
      ),
    );
    return Center(
      child: SizedBox(
        width: width??Dimensions.screenWidth,
        height: height??50,
        child: TextButton(
          style: _flatButton,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null?Padding(
                padding: EdgeInsets.only(left: Dimensions.width10/2),
                child: Icon(icon, color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,),
              ):const SizedBox(),
              icon!=null?const SizedBox(width: 10,):const SizedBox(),
              Text(buttonText, style: TextStyle(color: transparent?Theme.of(context).primaryColor:Colors.white, fontSize: fontSize!=null?fontSize!:16),),
            ],
          ),
        ),
      )
    );
  }
}
