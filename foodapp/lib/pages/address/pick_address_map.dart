import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_button.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key, required this.fromSignUp, required this.fromAddress, this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(37.42796133580664, -122.085749655962);
      _cameraPosition = CameraPosition(
        target: _initialPosition,
        zoom: 14.4746,
      );
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition=LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 14.4746);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.4746,
                    ),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition){
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: (){
                        Get.find<LocationController>().updatePosition(_cameraPosition, false);
                      },
                      onMapCreated: (GoogleMapController mapController){
                        _mapController = mapController;
                        if(!widget.fromAddress){
                          Get.find<LocationController>().updatePosition(_cameraPosition, true);
                        }
                      },
                      myLocationButtonEnabled: true,
                    ),
                    Center(
                      child: !locationController.loading?
                      Image.asset("assets/image/pick_marker.png", height: 50, width: 50,)
                          :const CircularProgressIndicator(),
                    ),
                    Positioned(
                        top: Dimensions.height10,
                        left: Dimensions.height20,
                        right: Dimensions.height20,
                        child: InkWell(
                          onTap: ()=>Get.dialog(LocationDialogue(mapController: _mapController)),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).colorScheme.shadow,
                                      offset: const Offset(0, 2),
                                      blurRadius: 5
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(Icons.location_on, color: Theme.of(context).primaryColor,),
                                ),
                                Expanded(
                                    child: Text('${locationController.pickPlacemark.name??''}',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(Icons.search, color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                    Positioned(
                      bottom: 30,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: locationController.isLoading?Center(child: CircularProgressIndicator()):CustomButton(
                          buttonText: locationController.inZone?widget.fromAddress?"Add Address":"Pick Location":"Out of Service Zone",
                          onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                            if(locationController.pickPosition.latitude!=0.0 &&
                                locationController.pickPlacemark.name!=null){
                              if(widget.fromAddress){
                                if(widget.googleMapController!=null){
                                  print("Now you clicked on this");
                                  widget.googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                          target: LatLng(locationController.pickPosition.latitude,
                                              locationController.pickPosition.longitude),
                                          zoom: 14.4746
                                      )
                                  ));
                                  locationController.setAddAddressData();
                                }
                                Get.toNamed(RouteHelper.getAddressPage());
                              }
                            }
                          },
                          width: 250,
                          height: 50,
                          radius: 10,
                          fontSize: 16,
                          icon: Icons.location_on,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    });
  }
}


