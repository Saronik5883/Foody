import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/big_text.dart';

import 'app_icon.dart';

class AccountWidget extends StatelessWidget {
  Icon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width10,
          top: Dimensions.width10,
          bottom: Dimensions.width10
      ),
      child: Row(
        children: [
          IconButton.filledTonal(onPressed: (){}, icon: appIcon),
          SizedBox(width: Dimensions.width20,),
          bigText,
        ],
      ),
    );
  }
}
