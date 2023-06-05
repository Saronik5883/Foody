import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/account_widget.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    double? scrolledUnderElevation;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: const Text("Your Profile", style: TextStyle(fontWeight: FontWeight.w500),),
            centerTitle: true,
            pinned: true,
            leading: null,
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor: Theme.of(context).colorScheme.shadow,
            actions: null
          ),
          SliverToBoxAdapter(
            child:  GetBuilder<UserController>(builder: (userController){
              return _userLoggedIn?(userController.isLoading?SingleChildScrollView(
                child: Column(
                  children: [
                    //profile icon
                    Icon(CupertinoIcons.profile_circled,
                      size: Dimensions.height15*12, color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //name
                    Container(
                      height: 90,
                      child: AccountWidget(
                          appIcon: Icon(Icons.person,
                            size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.primary,
                          ),
                          bigText: BigText(text: userController.userModel!.name,)
                      ),
                    ),
                    //phone
                    Container(
                      height: 90,
                      child: AccountWidget(
                          appIcon: Icon(Icons.phone,
                            size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.primary,
                          ),
                          bigText: BigText(text: "+91 ${userController.userModel!.phone}")
                      ),
                    ),
                    //email
                    Container(
                      height: 90,
                      child: AccountWidget(
                          appIcon: Icon(Icons.email,
                            size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.primary,
                          ),
                          bigText: BigText(text: userController.userModel!.email,)
                      ),
                    ),
                    //address
                    Container(
                      height: 90,
                      child: GetBuilder<LocationController>(builder: (locationController){
                        if(_userLoggedIn && locationController.addressList.isEmpty){
                          return InkWell(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                              },
                            child: AccountWidget(
                                appIcon: Icon(Icons.location_on,
                                  size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.primary,
                                ),
                                bigText: BigText(text: "Add an Address",)
                            ),
                          );
                        }else{
                          return InkWell(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                appIcon: Icon(Icons.location_on,
                                  size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.primary,
                                ),
                                bigText: BigText(text: "Manage Addresses",)
                            ),
                          );
                        }
                      })
                    ),
                    //messages
                    Container(
                      height: 90,
                      child: AccountWidget(
                          appIcon: Icon(Icons.message,
                            size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.primary,
                          ),
                          bigText: BigText(text: "View Messages",)
                      ),
                    ),
                    //logout
                    InkWell(
                      onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()) {
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.find<LocationController>().clearAddressList();
                          Get.offNamed(RouteHelper.getSignInPage());
                        }else{
                          print("You logged out");
                        }
                      },
                      child: Container(
                        height: 90,
                        child: AccountWidget(
                            appIcon: Icon(Icons.logout,
                              size: Dimensions.height10*5/2, color: Theme.of(context).colorScheme.error,
                            ),
                            bigText: BigText(text: "Logout",)
                        ),
                      ),
                    )

                  ],
                ),
              ):
              const CustomLoader()):
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.height20*9),
                  SizedBox(
                      height: Dimensions.height30*10,
                      child: const Center(
                          child: NoDataPage(text: "You must login", imgPath: "assets/image/signintocontinue.png",)
                      )
                  ),
                  FilledButton(
                      onPressed: (){
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      style: FilledButton.styleFrom(
                          fixedSize: Size(Dimensions.screenWidth/2, Dimensions.screenWidth/6)
                      ),
                      child: Text("Sign In", style: TextStyle(fontSize: Dimensions.font20),)
                  )
                ],
              );
            })
          ),
        ],
      ),
    );
  }
}
