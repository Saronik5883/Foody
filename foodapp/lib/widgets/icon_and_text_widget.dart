import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/widgets/small_text.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text, color: Theme.of(context).colorScheme.onSecondaryContainer,),
      ],
    );
  }
}
