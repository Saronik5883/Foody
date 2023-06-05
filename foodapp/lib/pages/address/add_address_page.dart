import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/pages/address/pick_address_map.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../models/address_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
    45.52563, -122.677433
  ), zoom: 17);
  late LatLng _initialPosition = const LatLng(
      45.52563, -122.677433
  );

  @override
  void initState(){
    super.initState();
    _isLogged=Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition=LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            title: const Text("Manage Address", style: TextStyle(fontWeight: FontWeight.w500),),
            centerTitle: true,
            pinned: true,
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            shadowColor: Theme.of(context).colorScheme.shadow,
          ),
          SliverToBoxAdapter(
            child: GetBuilder<UserController>(builder: (userController){
              if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
                _contactPersonName.text = '${userController.userModel?.name}';
                _contactPersonNumber.text = '${userController.userModel?.phone}';
                if(Get.find<LocationController>().addressList.isNotEmpty){
                  _addressController.text = Get.find<LocationController>().getUserAddress().address;
                }
              }
              return GetBuilder<LocationController>(builder: (locationController){
                _addressController.text='${locationController.placemark.name??'1000 SW Kingston Dr, '}'
                    '${locationController.placemark.locality??'Portland, '}'
                    '${locationController.placemark.postalCode??'OR 97205, '}'
                    '${locationController.placemark.country??'USA'}';
                print("address in my view is "+_addressController.text);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2, color: Theme.of(context).primaryColor
                            )
                        ),
                        child: Stack(
                          children: [
                            GoogleMap(
                                initialCameraPosition:
                                CameraPosition(target: _initialPosition, zoom:17),
                                onTap: (latLng){
                                  Get.toNamed(RouteHelper.getPickAddressPage(),
                                      arguments: PickAddressMap(fromSignUp: false, fromAddress: true,
                                          googleMapController: locationController.mapController,
                                      )
                                  );
                                  locationController.updatePosition(CameraPosition(target: latLng), false);
                                },
                                zoomControlsEnabled: false,
                                compassEnabled: false,
                                indoorViewEnabled: true,
                                mapToolbarEnabled: false,
                                myLocationEnabled: true,
                                onCameraIdle: (){
                                  locationController.updatePosition(_cameraPosition, true);
                                },
                                onCameraMove: ((position)=>_cameraPosition=position),
                                onMapCreated: (GoogleMapController controller) {
                                  locationController.setMapController(controller);
                                }
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(height: 50, child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locationController.addressTypeList.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                                  margin: EdgeInsets.only(right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius5),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        index==0?Icons.home:index==1?Icons.work:Icons.location_on,
                                        color: locationController.addressTypeIndex==index?
                                        Theme.of(context).colorScheme.primary:Theme.of(context).disabledColor,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Delivery Address"),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Contact Name"),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: AppTextField(textController: _contactPersonName, hintText: "Your name", icon: Icons.person),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Contact Number"),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: AppTextField(textController: _contactPersonNumber, hintText: "Your number", icon: Icons.phone),
                      ),
                    ],
                  ),
                );
              });
            }),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),

              child: ElevatedButton.icon(
                label: Text("Save Address", style: TextStyle(fontSize: Dimensions.font16),),
                onPressed: (){
                  AddressModel _addressModel = AddressModel(
                    addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                    contactPersonName: _contactPersonName.text,
                    contactPersonNumber: _contactPersonNumber.text,
                    address: _addressController.text,
                    latitude: locationController.position.latitude.toString(),
                    longitude: locationController.position.longitude.toString()
                  );
                  locationController.addAddress(_addressModel).then((response){
                    if(response.isSuccess){
                      Get.toNamed(RouteHelper.getInitial());
                      Get.snackbar("Address", "Added Successfully");
                    }else{
                      Get.snackbar("Address", "Couldn't Save Address");
                    }
                  });
                },
                icon: const Icon(Icons.location_on),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(Dimensions.width30*8, Dimensions.height30*2)
                ),
              ),
            ),
          ],
        );
      })
      );
  }
}
