import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppTextField({Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure=false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        obscureText: isObscure?true:false,
        controller: textController,
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary,),
            border: OutlineInputBorder(),
          labelText: hintText
        ),
      ),
    );
  }
}
