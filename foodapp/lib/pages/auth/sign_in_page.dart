import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/pages/auth/sign_up_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    void _login(AuthController authController){

      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if(phone.isEmpty){
        showCustomSnackbar("Type in your phone number", title: "Phone number");
      }else if(password.isEmpty){
        showCustomSnackbar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackbar("Password length can not be less than 6 characters", title: "Password");
      }else{
        authController.login(email,phone, password).then((status){
          if(status.isSuccess){
            showCustomSnackbar("Sign Up Successful", title: "Success");
            Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo1.png"
                    ),
                  ),
                ),

              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("Sign into your account", style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: Dimensions.font16+4
                    ))
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone", icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(
                textController: passwordController,
                hintText: "Password", icon: Icons.password, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              //sign up button
              FilledButton(
                  onPressed: (){
                    _login(authController);
                  },
                  style: FilledButton.styleFrom(
                      fixedSize: Size(Dimensions.screenWidth/2, Dimensions.screenWidth/6)
                  ),
                  child: Text("Sign In", style: TextStyle(fontSize: Dimensions.font20),)),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //Dont have an account?
              RichText(
                  text: TextSpan(
                      text:"Don't have an account? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: Dimensions.font16+4
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                          text:"Create",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: Dimensions.font16+4,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                  )
              ),
            ],
          ),
        ):const CustomLoader();
      })
    );
  }
}
