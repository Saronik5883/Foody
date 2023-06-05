import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/show_custom_snackbar.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/models/signup_body_model.dart';
import 'package:foodapp/pages/auth/sign_in_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';

import '../../base/custom_loader.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackbar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackbar("Type in your phone number", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackbar("Type in your email address", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackbar("Type in a vaild email", title: "Invalid Email Address");
      }else if(password.isEmpty){
        showCustomSnackbar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackbar("Password length can not be less than 6 characters", title: "Password");
      }else{
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            showCustomSnackbar("Sign Up Successful", title: "Success");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackbar(status.message);
          }
        });
      }
    }
    return Scaffold(
      body:GetBuilder<AuthController>(builder: (_authController){
        return  _authController.isLoading?const CustomLoader():SingleChildScrollView(
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
              //email
              AppTextField(
                  textController: emailController,
                  hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(
                  textController: passwordController,
                  hintText: "Password", icon: Icons.password, isObscure:true),
              SizedBox(height: Dimensions.height20,),
              //name
              AppTextField(
                  textController: nameController,
                  hintText: "Name", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone", icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),
              //sign up button
              FilledButton(
                  onPressed: (){
                    _registration(_authController);
                  },
                  style: FilledButton.styleFrom(
                      fixedSize: Size(Dimensions.screenWidth/2, Dimensions.screenWidth/6)
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: Dimensions.font20),)),
              SizedBox(height: Dimensions.height10,),
              //already have an account?
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>SignInPage(),
                      text:"Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: Dimensions.font16+4
                      )
                  )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //or use one of the following
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text:"Or use one of the following ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: Dimensions.font16
                      )
                  )
              ),
              Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                          "assets/image/${signUpImages[index]}"
                      ),
                    ),
                  ))
              )
            ],
          ),
        );
      })
    );


  }
}
